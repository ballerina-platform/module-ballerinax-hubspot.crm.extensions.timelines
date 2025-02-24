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

import ballerina/http;

service on new http:Listener(9090) {

    # Deletes an event template for the app
    #
    # + eventTemplateId - The event template ID.
    # + appId - The ID of the target app.
    # + return - returns can be any of following types 
    # http:NoContent (No content)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function delete [int:Signed32 appId]/event\-templates/[string eventTemplateId]() returns http:NoContent|error {
        // Mock implementation for deleting an event template
        if appId == appId && eventTemplateId == globalEventTemplateId {
            return http:NO_CONTENT;
        } else {
            return error("Event template not found");
        }

    }

    # Removes a token from the event template
    #
    # + eventTemplateId - The event template ID.
    # + tokenName - The token name.
    # + appId - The ID of the target app.
    # + return - returns can be any of following types 
    # http:NoContent (No content)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function delete [int:Signed32 appId]/event\-templates/[string eventTemplateId]/tokens/[string tokenName]() returns http:NoContent|error {

        if appId == appId && eventTemplateId == globalEventTemplateId && tokenName == "petType" {
            return http:NO_CONTENT;
        } else {
            return error("Token not found");
        }
    }

    resource function get [int:Signed32 appId]/event\-templates() returns CollectionResponseTimelineEventTemplateNoPaging|error {
        // Mock implementation for getting all event templates
        if appId == appId {
            CollectionResponseTimelineEventTemplateNoPaging response = {
                results: [
                    {
                        id: "2975858", // Match the ID used in create template
                        name: "PetSpot Registration", // Match the name used in create template
                        objectType: "contacts",
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
                                    {label: "Black", value: "black"}
                                ]
                            }
                        ],
                        headerTemplate: "Registered for [{{petName}}](https://my.petspot.com/pets/{{petName}})"
                    }
                ]
            };
            return response;
        }
        return error("App not found");
    }

    # Gets a specific event template for your app
    #
    # + eventTemplateId - The event template ID.
    # + appId - The ID of the target app.
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function get [int:Signed32 appId]/event\-templates/[string eventTemplateId]() returns TimelineEventTemplate|error {
        // Mock implementation for getting a specific event template
        if appId == 8110991 && eventTemplateId == globalEventTemplateId {
            TimelineEventTemplate response = {
                id: "2975858",
                name: "Test Template",
                objectType: "contacts",
                tokens: []
            };
            return response;
        } else {
            return error("Event template not found");
        }
    }

    # Gets the event
    #
    # + eventTemplateId - The event template ID.
    # + eventId - The event ID.
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function get events/[string eventTemplateId]/[string eventId]() returns TimelineEventResponse|error {
        // Mock implementation for getting an event
        if eventTemplateId == globalEventTemplateId && eventId == globalEventId {
            TimelineEventResponse response = {
                eventTemplateId: eventTemplateId,
                id: eventId,
                objectType: "contacts",
                tokens: {}
            };
            return response;
        } else {
            return error("Event not found");
        }
    }

    # Gets the detailTemplate as rendered
    #
    # + eventTemplateId - The event template ID.
    # + eventId - The event ID.
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function get events/[string eventTemplateId]/[string eventId]/detail() returns EventDetail|error {
        // Mock implementation for getting the detailTemplate as rendered
        if eventTemplateId == globalEventTemplateId && eventId == globalEventId {
            EventDetail response = {
                details: "<p>Registration occurred at Jan 30, 2020, 1:13:25 PM</p><h4>Questions</h4><p><strong>Who's a good kitty?</strong>: Purr...</p><p><strong>Will you stop playing with that?</strong>: Meow!</p>"
            };
            return response;
        } else {
            return error("Event detail not found");
        }
    }

    # Renders the header or detail as HTML
    #
    # + eventTemplateId - The event template ID.
    # + eventId - The event ID.
    # + detail - Set to 'true', we want to render the `detailTemplate` instead of the `headerTemplate`.
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function get events/[string eventTemplateId]/[string eventId]/render(boolean? detail) returns string|error {
        // Mock implementation for rendering the header or detail as HTML
        if eventTemplateId == globalEventTemplateId && eventId == globalEventId {
            return "<p>Rendered HTML</p>";
        } else {
            return error("Event render not found");
        }
    }

    # Create an event template for your app
    #
    # + appId - The ID of the target app.
    # + headers - Headers to be sent with the request 
    # + payload - The updated event template definition. 
    # + return - successful operation 
    resource function post [int:Signed32 appId]/event\-templates(TimelineEventTemplateCreateRequest payload) returns TimelineEventTemplate|error {
        // Mock implementation for creating an event template
        TimelineEventTemplate response = {
            id: "2975858",
            name: payload.name,
            objectType: payload.objectType,
            tokens: payload.tokens
        };
        return response;
    }

    # Adds a token to an existing event template
    #
    # + eventTemplateId - The event template ID.
    # + appId - The ID of the target app.
    # + payload - The new token definition. 
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post [int:Signed32 appId]/event\-templates/[string eventTemplateId]/tokens(@http:Payload TimelineEventTemplateToken payload) returns TimelineEventTemplateToken|error {
        // Mock implementation for adding a token to an existing event template
        TimelineEventTemplateToken response = {
            name: payload.name,
            label: payload.label,
            'type: payload.'type,
            options: payload.options
        };
        return response;
    }

    # Create a single event
    #
    # + payload - The timeline event definition. 
    # + return - returns can be any of following types 
    # http:Created (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post events(@http:Payload TimelineEvent payload) returns TimelineEventResponse|error {
        // Mock implementation for creating a single event
        TimelineEventResponse response = {
            eventTemplateId: payload.eventTemplateId,
            id: "newEventId",
            email: payload.email,
            domain: payload.domain,
            utk: payload.utk,
            timestamp: payload.timestamp,
            objectType: "contacts",
            tokens: payload.tokens,
            extraData: payload.extraData,
            timelineIFrame: payload.timelineIFrame
        };
        return response;
    }

    # Creates multiple events
    #
    # + payload - The timeline event definition. 
    # + return - returns can be any of following types 
    # http:Created (successful operation)
    # http:MultiStatus (multiple statuses)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function post events/batch/create(@http:Payload BatchInputTimelineEvent payload) returns BatchResponseTimelineEventResponse|BatchResponseTimelineEventResponseWithErrors|json|error {
        // Mock implementation for creating multiple events
        BatchResponseTimelineEventResponse response = {
            results: payload.inputs.map(function(TimelineEvent event) returns TimelineEventResponse {
                return {
                    eventTemplateId: event.eventTemplateId,
                    id: "newEventId",
                    objectType: "contacts",
                    tokens: event.tokens
                };
            }),
            status: "COMPLETE",
            startedAt: "2020-01-30T18:13:24.974023Z",
            completedAt: "2020-01-30T18:13:26.227559Z"
        };
        return response;
    }

    # Update an existing event template
    #
    # + eventTemplateId - The event template ID.
    # + appId - The ID of the target app.
    # + payload - The updated event template definition. 
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function put [int:Signed32 appId]/event\-templates/[string eventTemplateId](@http:Payload TimelineEventTemplateUpdateRequest payload) returns TimelineEventTemplate|error {
        // Mock implementation for updating an existing event template
        TimelineEventTemplate response = {
            id: payload.id,
            name: payload.name,
            objectType: "contacts",
            tokens: payload.tokens
        };
        return response;
    }

    # Updates an existing token on an event template
    #
    # + eventTemplateId - The event template ID.
    # + tokenName - The token name.
    # + appId - The ID of the target app.
    # + payload - The updated token definition. 
    # + return - returns can be any of following types 
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function put [int:Signed32 appId]/event\-templates/[string eventTemplateId]/tokens/[string tokenName](@http:Payload TimelineEventTemplateTokenUpdateRequest payload) returns TimelineEventTemplateToken|error {
        // Mock implementation for updating an existing token on an event template
        TimelineEventTemplateToken response = {
            name: tokenName,
            label: payload.label,
            'type: "enumeration",
            options: payload.options
        };
        return response;
    }
}
