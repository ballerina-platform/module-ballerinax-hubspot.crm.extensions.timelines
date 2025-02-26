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

import ballerina/io;
import ballerina/oauth2;
import ballerinax/hubspot.crm.extensions.timelines as hstimeline;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable int appId = ?;
configurable string hapikey = ?;
final int:Signed32 appIdSigned32 = <int:Signed32>appId;

hstimeline:OAuth2RefreshTokenGrantConfig accessToken = {
    clientId,
    clientSecret,
    refreshToken,
    credentialBearer: oauth2:POST_BODY_BEARER
};

hstimeline:ApiKeysConfig apikeys = {
    hapikey,
    private\-app: "",
    private\-app\-legacy: ""
};

final hstimeline:Client hubSpotTimelineOAuth2 = check new ({auth: accessToken});
final hstimeline:Client hubSpotTimelineApiKey = check new ({auth: apikeys});

public function main() returns error? {
    // Define a timeline event template
    hstimeline:TimelineEventTemplateCreateRequest eventTemplate = {
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
    // Create the template in HubSpot
    hstimeline:TimelineEventTemplate eventTimelineResponse = check hubSpotTimelineApiKey->/[appIdSigned32]/event\-templates.post(eventTemplate);
    io:println("Event Template Created: ", eventTimelineResponse.id);
    string eventTemplateId = eventTimelineResponse.id;

    //Get all event templates
    hstimeline:CollectionResponseTimelineEventTemplateNoPaging eventTemplatesResponse = check hubSpotTimelineApiKey->/[appIdSigned32]/event\-templates.get();
    io:println("Event Templates: ", eventTemplatesResponse);

    // Create an Event
    hstimeline:TimelineEvent event = {
        eventTemplateId,
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
    hstimeline:TimelineEventResponse eventResponse = check hubSpotTimelineOAuth2->/events.post(event);
    io:println("Event Created: ", eventResponse.id);
}
