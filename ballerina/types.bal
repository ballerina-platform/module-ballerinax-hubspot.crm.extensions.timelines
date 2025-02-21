// AUTO-GENERATED FILE. DO NOT MODIFY.
// This file is auto-generated by the Ballerina OpenAPI tool.

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

public type TimelineEventIFrame record {
    # The text displaying the link that will display the iframe.
    string linkLabel;
    # The label of the modal window that displays the iframe contents.
    string headerLabel;
    # The width of the modal window in pixels.
    int:Signed32 width;
    # The URI of the iframe contents.
    string url;
    # The height of the modal window in pixels.
    int:Signed32 height;
};

# The state of the timeline event.
public type TimelineEvent record {
    # The event template ID.
    string eventTemplateId;
    # Additional event-specific data that can be interpreted by the template's markdown.
    record {} extraData?;
    TimelineEventIFrame timelineIFrame?;
    # The event domain (often paired with utk).
    string domain?;
    # A collection of token keys and values associated with the template tokens.
    record {|string...;|} tokens;
    # Identifier for the event. This is optional, and we recommend you do not pass this in. We will create one for you if you omit this. You can also use `{{uuid}}` anywhere in the ID to generate a unique string, guaranteeing uniqueness.
    string id?;
    # Use the `utk` parameter to associate an event with a contact by `usertoken`. This is recommended if you don't know a user's email, but have an identifying user token in your cookie.
    string utk?;
    # The email address used for contact-specific events. This can be used to identify existing contacts, create new ones, or change the email for an existing contact (if paired with the `objectId`).
    string email?;
    # The CRM object identifier. This is required for every event other than contacts (where utk or email can be used).
    string objectId?;
    # The time the event occurred. If not passed in, the curren time will be assumed. This is used to determine where an event is shown on a CRM object's timeline.
    string timestamp?;
};

public type StandardError record {
    record {} subCategory?;
    record {|string[]...;|} context;
    record {|string...;|} links;
    string id?;
    string category;
    string message;
    ErrorDetail[] errors;
    string status;
};

# State of the template definition being updated.
public type TimelineEventTemplateUpdateRequest record {
    # This uses Markdown syntax with Handlebars and event-specific data to render HTML on a timeline when you expand the details.
    string detailTemplate?;
    # The template name.
    string name;
    # A collection of tokens that can be used as custom properties on the event and to create fully fledged CRM objects.
    TimelineEventTemplateToken[] tokens;
    # The template ID.
    string id;
    # This uses Markdown syntax with Handlebars and event-specific data to render HTML on a timeline as a header.
    string headerTemplate?;
};

# The details Markdown rendered as HTML.
public type EventDetail record {
    # The details Markdown rendered as HTML.
    string details;
};

# State of the template definition being created.
public type TimelineEventTemplateCreateRequest record {
    # This uses Markdown syntax with Handlebars and event-specific data to render HTML on a timeline when you expand the details.
    string detailTemplate?;
    # The template name.
    string name;
    # A collection of tokens that can be used as custom properties on the event and to create fully fledged CRM objects.
    TimelineEventTemplateToken[] tokens;
    # This uses Markdown syntax with Handlebars and event-specific data to render HTML on a timeline as a header.
    string headerTemplate?;
    # The type of CRM object this template is for. [Contacts, companies, tickets, and deals] are supported.
    string objectType;
};

# Proxy server configurations to be used with the HTTP client endpoint.
public type ProxyConfig record {|
    # Host name of the proxy server
    string host = "";
    # Proxy server port
    int port = 0;
    # Proxy server username
    string userName = "";
    # Proxy server password
    @display {label: "", kind: "password"}
    string password = "";
|};

public type CollectionResponseTimelineEventTemplateNoPaging record {
    TimelineEventTemplate[] results;
};

# Represents the Queries record for the operation: get-/events/{eventTemplateId}/{eventId}/render_getRenderById
public type GetEventsEventTemplateIdEventIdRenderGetRenderByIdQueries record {
    # Set to 'true', we want to render the `detailTemplate` instead of the `headerTemplate`.
    boolean detail?;
};

public type ErrorDetail record {
    # A specific category that contains more specific detail about the error
    string subCategory?;
    # The status code associated with the error detail
    string code?;
    # The name of the field or parameter in which the error was found.
    string 'in?;
    # Context about the error condition
    record {|string[]...;|} context?;
    # A human readable message describing the error along with remediation steps where appropriate
    string message;
};

# The state of the batch event request.
public type BatchResponseTimelineEventResponse record {
    # The time the request was completed.
    string completedAt;
    # The time the request occurred.
    string requestedAt?;
    # The time the request began processing.
    string startedAt;
    record {|string...;|} links?;
    # Successfully created events.
    TimelineEventResponse[] results;
    # The status of the batch response. Should always be COMPLETED if processed.
    "PENDING"|"PROCESSING"|"CANCELED"|"COMPLETE" status;
};

# Used to create timeline events in batches.
public type BatchInputTimelineEvent record {
    # A collection of timeline events we want to create.
    TimelineEvent[] inputs;
};

# Provides settings related to HTTP/1.x protocol.
public type ClientHttp1Settings record {|
    # Specifies whether to reuse a connection for multiple requests
    http:KeepAlive keepAlive = http:KEEPALIVE_AUTO;
    # The chunking behaviour of the request
    http:Chunking chunking = http:CHUNKING_AUTO;
    # Proxy server related options
    ProxyConfig proxy?;
|};

public type TimelineEventTemplateTokenOption record {
    string label;
    string value;
};

# The current state of the template definition.
public type TimelineEventTemplate record {
    # The date and time that the Event Template was created, as an ISO 8601 timestamp. Will be null if the template was created before Feb 18th, 2020.
    string createdAt?;
    # This uses Markdown syntax with Handlebars and event-specific data to render HTML on a timeline when you expand the details.
    string detailTemplate?;
    # The template name.
    string name;
    # A collection of tokens that can be used as custom properties on the event and to create fully fledged CRM objects.
    TimelineEventTemplateToken[] tokens;
    # The template ID.
    string id;
    # This uses Markdown syntax with Handlebars and event-specific data to render HTML on a timeline as a header.
    string headerTemplate?;
    # The type of CRM object this template is for. [Contacts, companies, tickets, and deals] are supported.
    string objectType;
    # The date and time that the Event Template was last updated, as an ISO 8601 timestamp. Will be null if the template was created before Feb 18th, 2020.
    string updatedAt?;
};

# OAuth2 Refresh Token Grant Configs
public type OAuth2RefreshTokenGrantConfig record {|
    *http:OAuth2RefreshTokenGrantConfig;
    # Refresh URL
    string refreshUrl = "https://api.hubapi.com/oauth/v1/token";
|};

# State of the token definition.
public type TimelineEventTemplateToken record {
    # The date and time that the Event Template Token was created, as an ISO 8601 timestamp. Will be null if the template was created before Feb 18th, 2020.
    string createdAt?;
    # If type is `enumeration`, we should have a list of options to choose from.
    TimelineEventTemplateTokenOption[] options?;
    # The name of the token referenced in the templates. This must be unique for the specific template. It may only contain alphanumeric characters, periods, dashes, or underscores (. - _).
    string name;
    # Used for list segmentation and reporting.
    string label;
    # The name of the CRM object property. This will populate the CRM object property associated with the event. With enough of these, you can fully build CRM objects via the Timeline API.
    string? objectPropertyName?;
    # The data type of the token. You can currently choose from [string, number, date, enumeration].
    "date"|"enumeration"|"number"|"string" 'type;
    # The date and time that the Event Template Token was last updated, as an ISO 8601 timestamp. Will be null if the template was created before Feb 18th, 2020.
    string updatedAt?;
};

# The current state of the timeline event.
public type TimelineEventResponse record {
    # The event template ID.
    string eventTemplateId;
    string? createdAt?;
    # Additional event-specific data that can be interpreted by the template's markdown.
    record {} extraData?;
    TimelineEventIFrame timelineIFrame?;
    # The event domain (often paired with utk).
    string domain?;
    # A collection of token keys and values associated with the template tokens.
    record {|string...;|} tokens;
    # Identifier for the event. This should be unique to the app and event template. If you use the same ID for different CRM objects, the last to be processed will win and the first will not have a record. You can also use `{{uuid}}` anywhere in the ID to generate a unique string, guaranteeing uniqueness.
    string id;
    # Use the `utk` parameter to associate an event with a contact by `usertoken`. This is recommended if you don't know a user's email, but have an identifying user token in your cookie.
    string utk?;
    # The email address used for contact-specific events. This can be used to identify existing contacts, create new ones, or change the email for an existing contact (if paired with the `objectId`).
    string email?;
    # The CRM object identifier. This is required for every event other than contacts (where utk or email can be used).
    string objectId?;
    # The time the event occurred. If not passed in, the curren time will be assumed. This is used to determine where an event is shown on a CRM object's timeline.
    string timestamp?;
    # The ObjectType associated with the EventTemplate.
    string objectType;
};

# State of the token definition for update requests.
public type TimelineEventTemplateTokenUpdateRequest record {
    # If type is `enumeration`, we should have a list of options to choose from.
    TimelineEventTemplateTokenOption[] options?;
    # Used for list segmentation and reporting.
    string label;
    # The name of the CRM object property. This will populate the CRM object property associated with the event. With enough of these, you can fully build CRM objects via the Timeline API.
    string objectPropertyName?;
};

# Provides API key configurations needed when communicating with a remote HTTP endpoint.
public type ApiKeysConfig record {|
    string hapikey;
    string? private\-app\-legacy;
    string? private\-app;
|};

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # Provides Auth configurations needed when communicating with a remote HTTP endpoint.
    http:BearerTokenConfig|OAuth2RefreshTokenGrantConfig|ApiKeysConfig auth;
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    ClientHttp1Settings http1Settings?;
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings?;
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 60;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache?;
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits?;
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
    # Enables relaxed data binding on the client side. When enabled, `nil` values are treated as optional, 
    # and absent fields are handled as `nilable` types. Enabled by default.
    boolean laxDataBinding = true;
|};

public type BatchResponseTimelineEventResponseWithErrors record {
    string completedAt;
    int:Signed32 numErrors?;
    string requestedAt?;
    string startedAt;
    record {|string...;|} links?;
    TimelineEventResponse[] results;
    StandardError[] errors?;
    "PENDING"|"PROCESSING"|"CANCELED"|"COMPLETE" status;
};
