// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/oauth2;
import ballerina/test;
import ballerina/http;
import ballerina/lang.runtime;

final string serviceUrl = isLiveServer? "https://api.hubapi.com/integrators/timeline/v3": "http://localhost:9090";
configurable string clientId = "clientId";
configurable string clientSecret = "clientSecret";
configurable string refreshToken = "refreshToken";
configurable int appId = 12345;  
configurable string hapikey = "hapikey";
configurable boolean isLiveServer = false;
configurable decimal delay = 45.0;
final int:Signed32 appIdSigned32 = <int:Signed32> appId;

final Client hubSpotTimelineApiKey = check initApiKeyClient();
final Client hubSpotTimelineOAuth2 = check initOAuth2Client();
string globalEventTemplateId = "";
string eventTemplateId = "";
string globalEventId = "";
string eventId = "";

isolated function initApiKeyClient() returns Client|error {
    if hapikey == "" {
        return error("API Key is missing.");
    }
    ApiKeysConfig apiKeyConfig = {
        hapikey: hapikey,
        private\-app: "",
        private\-app\-legacy: ""
    };
    return check new ({auth: apiKeyConfig}, serviceUrl);
};

isolated function initOAuth2Client() returns Client|error {
    if (clientId == "" || clientSecret == "" || refreshToken == "") {
        return error("OAuth2 credentials are not available");
    }
    OAuth2RefreshTokenGrantConfig oauthConfig = {
        clientId: clientId,
        clientSecret: clientSecret,
        refreshToken: refreshToken,
        credentialBearer: oauth2:POST_BODY_BEARER
    };
    return check new ({auth: oauthConfig}, serviceUrl);
};


@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testCreateEventTemplate() returns error? {
    TimelineEventTemplateCreateRequest payload = {
        detailTemplate: "Registration occurred at {{#formatDate timestamp}}{{/formatDate}}\n\n#### Questions\n{{#each extraData.questions}}\n  **{{question}}**: {{answer}}\n{{/each}}",
        name: "PetSpot Registration",
        tokens: [
            {
                name: "petName",
                'type: "string",
                label: "Pet Name"
            },
            {
                name: "petAge",
                'type: "number",
                label: "Pet Age"
            },
            {
                name: "petColor",
                'type: "enumeration",
                label: "Pet Color",
                options: [
                    {label: "White", value: "white"},
                    {label: "Black", value: "black"},
                    {label: "Brown", value: "brown"},
                    {label: "Other", value: "other"}
                ]
            }
        ],
        headerTemplate: "Registered for [{{petName}}](https://my.petspot.com/pets/{{petName}})",
        objectType: "contacts"
    };      
    TimelineEventTemplate response = check hubSpotTimelineApiKey->/[appIdSigned32]/event\-templates.post(payload);
    lock {
        globalEventTemplateId = response.id;
    }
    runtime:sleep(delay);   // Pause execution for the set delay to allow template creation. 
    test:assertEquals(response.name, payload.name, msg = "Expected event template name to match");    
}

@test:Config {  
    groups: ["live_tests", "mock_tests"],
    dependsOn: [testCreateEventTemplate]
}
function testUpdateEventTemplate() returns error? {
    lock {  
        eventTemplateId = globalEventTemplateId; 
    }
    TimelineEventTemplateUpdateRequest payload ={
        detailTemplate: "Registration occurred at {{#formatDate timestamp}}{{/formatDate}}\n\n#### Questions\n{{#each extraData.questions}}\n  **{{question}}**: {{answer}}\n{{/each}}\n\nEDIT",
        name: "PetSpot Registration",
        tokens: [
            {
                name: "petName",
                'type: "string",
                label: "Pet Name",
                objectPropertyName: "firstname"
            },
            {
                name: "petAge",
                'type: "number",
                label: "Pet Age"
            },
            {
                name: "petColor",
                'type: "enumeration",
                label: "Pet Color",
                options: [
                    { label: "White", value: "white"},
                    { label: "Black", value: "black"},
                    { label: "Brown", value: "brown"},
                    { label: "Yellow", value: "yellow"},
                    { label: "Other", value: "other"}
                ]
            }
        ],
    id: eventTemplateId,
    headerTemplate: "Registered for [{{petName}}](https://my.petspot.com/pets/{{petName}})"
    } ;
    TimelineEventTemplate response = check hubSpotTimelineApiKey->/[appIdSigned32]/event\-templates/[eventTemplateId].put(payload);
    test:assertEquals(response.name, payload.name, msg = "Expected event template name to match");
};


@test:Config {
    groups: ["live_tests", "mock_tests"], dependsOn: [testUpdateEventTemplate]
}
function testGetAppEventTemplates() returns error? {
   CollectionResponseTimelineEventTemplateNoPaging response = check hubSpotTimelineApiKey->/[appIdSigned32]/event\-templates.get();
   test:assertEquals(response?.results[0].name, "PetSpot Registration", msg = "Expected event template name to match");
};

@test:Config {
    groups: ["live_tests", "mock_tests"], dependsOn: [testUpdateEventTemplate]
}
function testAddToken() returns error? {
    TimelineEventTemplateToken payload = {
        name: "petType",
        label: "Pet Type",
        'type: "enumeration",
        options: [
            {label: "Dog", value: "dog"},
            {label: "Cat", value: "cat"}
        ],
        objectPropertyName: "customPropertyPetType"
    };
    TimelineEventTemplateToken response = check hubSpotTimelineApiKey->/[appIdSigned32]/event\-templates/[eventTemplateId]/tokens.post(payload);
    test:assertEquals(response?.name, payload.name, msg = "Expected token name to match");
};

@test:Config {
    groups: ["live_tests", "mock_tests"], dependsOn: [testAddToken]
}
function testUpdateToken() returns error? {
    string tokenName = "petType";
    TimelineEventTemplateTokenUpdateRequest payload = {
        label: "Pet Type Updated",        
        options: [
            {label: "Dog", value: "dog"},
            {label: "Cat", value: "cat"},
            {label: "Bird", value: "bird"}
        ]
    };
    TimelineEventTemplateToken response = check hubSpotTimelineApiKey->/[appIdSigned32]/event\-templates/[eventTemplateId]/tokens/[tokenName].put(payload); 
    test:assertEquals(response?.label, payload.label, msg = "Expected token label to match");
};

@test:Config {
    groups: ["live_tests", "mock_tests"], dependsOn: [testUpdateToken]
}
function testDeleteToken() returns error? {
    string tokenName = "petType";
    http:Response response = check hubSpotTimelineApiKey->/[appIdSigned32]/event\-templates/[eventTemplateId]/tokens/[tokenName].delete();
    test:assertEquals(response.statusCode, 204, msg = "Expected status code to be 204");
};

@test:Config {
    groups: ["live_tests", "mock_tests"], dependsOn: [testPostEvents]
}
function testGetEventTemplateAsRendered() returns error? {
    EventDetail response = check hubSpotTimelineOAuth2->/events/[eventTemplateId]/[eventId]/detail.get();
    test:assertTrue(response?.details.length() > 0, msg = "Expected non-empty results for successful property group deletion");
};

@test:Config {
    groups: ["live_tests", "mock_tests"], dependsOn: [testGetEventTemplateAsRendered]
}
function testGetEventTimeline() returns error? {
    TimelineEventResponse response = check hubSpotTimelineOAuth2->/events/[eventTemplateId]/[eventId].get();
    test:assertEquals(response?.eventTemplateId, eventTemplateId, msg = "Expected event template ID to match");  
};

@test:Config {
    groups: ["live_tests", "mock_tests"], dependsOn:[testGetEventTimeline]
}
function testGetEventTimelineRender() returns error? {
    string response = check hubSpotTimelineOAuth2->/events/[eventTemplateId]/[eventId]/render.get();
    test:assertTrue(response.length() > 0, msg = "Expected non-empty rendered HTML");
};

@test:Config {
    groups: ["live_tests", "mock_tests"], dependsOn: [testGetAppEventTemplates]
}
function testGetEventTemplate() returns error? {
    TimelineEventTemplate response = check hubSpotTimelineApiKey->/[appIdSigned32]/event\-templates/[eventTemplateId].get();
    test:assertEquals(response?.id, eventTemplateId, msg = "Expected event template ID to match");  
};

@test:Config {
    groups: ["live_tests", "mock_tests"], dependsOn: [testUpdateEventTemplate]
}
function testPostEvents() returns error? {
    TimelineEvent payload = {
        eventTemplateId: globalEventTemplateId,
        domain: "string",
        id: "string",
        utk: "string",
        email: "art3mis-pup@petspot.com",
        timestamp: "2025-02-14T09:12:09.990Z",
        extraData: {
            "questions": [
                {
                    "answer": "Bark!",
                    "question": "Who's a good girl?"
                },
                {
                    "answer": "Woof!",
                    "question": "Do you wanna go on a walk?"
                }
            ]
        },
        timelineIFrame: {
            linkLabel: "View Art3mis",
            headerLabel: "Art3mis dog",
            width: 600,
            url: "https://my.petspot.com/pets/Art3mis",
            height: 400
        },
        tokens: {
            "petAge": "3",
            "petName": "Art3mis",
            "petColor": "black"
        }
    };
    TimelineEventResponse response = check hubSpotTimelineOAuth2->/events.post(payload);
    lock {
        globalEventId = response.id;
    }

    lock {  
        eventId = globalEventId;
    }   
    runtime:sleep(delay); // Pause execution for the set delay to allow event creation.
    test:assertEquals(response.email, payload.email, msg = "Email should match");
};

@test:Config {
    groups: ["live_tests", "mock_tests"], dependsOn: [testUpdateToken]
}
function testDeleteEventTemplate() returns error? {
    http:Response response = check hubSpotTimelineApiKey->/[appIdSigned32]/event\-templates/[eventTemplateId].delete();
    test:assertEquals(response.statusCode, 204, msg = "Expected status code to be 204");
};
