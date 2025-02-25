// Copyright (c) 2025, WSO2 LLC.

import ballerina/io;
import ballerina/oauth2;
import ballerinax/hubspot.crm.extensions.timelines as hstimeline ;

// These values are configured externally (e.g., via Ballerina.toml).
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable int appId = ?;  
configurable string hapikey = ?;
final int:Signed32 appIdSigned32 = <int:Signed32> appId;

// Configure OAuth 2.0 refresh token grant details to connect to HubSpot.
hstimeline:OAuth2RefreshTokenGrantConfig accessToken = {
    clientId: clientId,
    clientSecret: clientSecret,
    refreshToken: refreshToken,
    credentialBearer: oauth2:POST_BODY_BEARER
};

hstimeline:ApiKeysConfig apikeys =
    { hapikey: hapikey,
        private\-app: "",
        private\-app\-legacy: "" };

// Create a new HubSpot timelines client using the OAuth config.
final hstimeline:Client hubSpotTimelineOAuth2 = check new({auth: accessToken});
final hstimeline:Client hubSpotTimelineApiKey = check new ({auth:apikeys});

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

    hstimeline:CollectionResponseTimelineEventTemplateNoPaging eventTemplatesResponse = check hubSpotTimelineApiKey->/[appIdSigned32]/event\-templates.get();
    io:println("Event Templates: ", eventTemplatesResponse); 

    // Create an Event
    hstimeline:TimelineEvent event = {
        eventTemplateId: eventTemplateId,
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
    return ();   
}
