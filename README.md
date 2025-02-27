# Ballerina HubSpot CRM Timelines connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.extensions.timelines/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.extensions.timelines/actions/workflows/ci.yml)
[![Trivy](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.extensions.timelines/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.extensions.timelines/actions/workflows/trivy-scan.yml)
[![GraalVM Check](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.extensions.timelines/actions/workflows/build-with-bal-test-graalvm.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.extensions.timelines/actions/workflows/build-with-bal-test-graalvm.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-hubspot.crm.extensions.timelines.svg)](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.extensions.timelines/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/hubspot.crm.extensions.timelines.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%hubspot.crm.extensions.timelines)

## Overview

[HubSpot](https://www.hubspot.com/) is an AI-powered customer relationship management (CRM) platform.

The `ballerinax/module-ballerinax-hubspot.crm.extensions.timelines` connector offers APIs to connect and interact with the [ HubSpot CRM Timelines API](https://developers.hubspot.com/docs/reference/api/crm/extensions/timeline), specifically based on the [HubSpot REST API](https://developers.hubspot.com/docs/reference/api/overview).

## Setup guide

To use the HubSpot CRM Timelines API, you must have access to the HubSpot API through a HubSpot developer account and a HubSpot app under it. Therefore, you need to register for a developer account at HubSpot if you don't have one already.

### Step 1: Create/login to a HubSpot developer account

If you don't have a HubSpot Developer account you can sign up to a free account [here](https://developers.hubspot.com/get-started)

If you have an account already, go to the [HubSpot developer portal](https://app.hubspot.com/)

### Step 2: Create a developer test account (Optional)

Within app developer accounts, you can create [developer test accounts](https://developers.hubspot.com/beta-docs/getting-started/account-types#developer-test-accounts) to test apps and integrations without affecting any real HubSpot data.

> **Note:** These accounts are only for development and testing purposes. In production you should not use developer test accounts.

1. Go to test account section from the left sidebar.
   ![Hubspot developer portal](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.extensions.timelines/main/docs/resources/test_acc_1.png)

2. Click create developer test account.
   ![Hubspot developer testacc](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.extensions.timelines/main/docs/resources/test_acc_2.png)

3. In the dialogue box, give a name to your test account and click create.
   ![Hubspot developer testacc3](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.extensions.timelines/main/docs/resources/test_acc_3.png)

### Step 3: Create a HubSpot app under your account

1. In your developer account, navigate to the "Apps" section. Click on "Create App"
   ![Hubspot app creation 1](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.extensions.timelines/main/docs/resources/create_app_1.png)

2. Provide the necessary details, including the app name and description.

### Step 4: Configure the authentication flow

1. Move to the "Auth" Tab.
   ![Hubspot app creation 2](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.extensions.timelines/main/docs/resources/create_app_2.png)

2. In the "Scopes" section, add necessary scopes for your app using the "Add new scope" button.
   ![Hubspot set scope](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.extensions.timelines/main/docs/resources/set_scope.png)

3. Add your redirect URI in the relevant section. You can also use localhost addresses for local development purposes. Click create app.
   ![Hubspot create app final](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.extensions.timelines/main/docs/resources/create_app_final.png)

### Step 5: Get your client ID and client Secret

Navigate to the auth section of your app. Make sure to save the provided client ID and client Secret.
  ![Hubspot get credentials](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.extensions.timelines/main/docs/resources/get_credentials.png)

### Step 6: Setup authentication flow

Before proceeding with the quickstart, ensure you have obtained the necessary authentication credentials.

#### Method 1: OAuth 2.0 authentication (access token)

Some APIs require an access token for authentication. Follow these steps to obtain one:

1. Create an authorization URL using the following format:

   ```markdown
   https://app.hubspot.com/oauth/authorize?client_id=<YOUR_CLIENT_ID>&scope=<YOUR_SCOPES>&redirect_uri=<YOUR_REDIRECT_URI>
   ```

   Replace the `<YOUR_CLIENT_ID>`, `<YOUR_REDIRECT_URI>`, and `<YOUR_SCOPES>` with your specific value.

2. Paste it in the browser and select your developer test account to install the app when prompted.
3. A code will be displayed in the browser. Copy the code.
4. Run the following curl command. Replace the `<YOUR_CLIENT_ID>`, `<YOUR_REDIRECT_URI>`, and `<YOUR_CLIENT_SECRET>` with your specific value. Use the code you received in the above step 3 as the `<CODE>`.

   - Linux/macOS

     ```bash
     curl --request POST \
     --url https://api.hubapi.com/oauth/v1/token \
     --header 'content-type: application/x-www-form-urlencoded' \
     --data 'grant_type=authorization_code&code=<CODE>&redirect_uri=<YOUR_REDIRECT_URI>&client_id=<YOUR_CLIENT_ID>&client_secret=<YOUR_CLIENT_SECRET>'
     ```

   - Windows

     ```bash
     curl --request POST ^
     --url https://api.hubapi.com/oauth/v1/token ^
     --header 'content-type: application/x-www-form-urlencoded' ^
     --data 'grant_type=authorization_code&code=<CODE>&redirect_uri=<YOUR_REDIRECT_URI>&client_id=<YOUR_CLIENT_ID>&client_secret=<YOUR_CLIENT_SECRET>'
     ```

   This command will return the access token necessary for API calls.

   ```json
   {
     "token_type": "bearer",
     "refresh_token": "<Refresh Token>",
     "access_token": "<Access Token>",
     "expires_in": 1800
   }
   ```

5. Store the access token securely for use in your application.

#### Method 2: Developer API key authentication

Some APIs use a developer API key as a query parameter for authentication.

1. In your developer account, navigate to Keys -> Developer API key. It will list down the active API key that you can copy.

![Hubspot get credentials](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.extensions.timelines/main/docs/resources/developer_key.png)

2. Use the key by appending it to API requests as a query parameter:

```text
https://api.hubapi.com/crm/v3/timeline/events?hapikey=<YOUR_DEVELOPER_API_KEY>
```

No OAuth flow is required for this authentication method.

## Quickstart

To use the `HubSpot CRM Timelines` in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

Import the `hubspot.crm.extensions.timelines` module and `oauth2` module.

```ballerina
import ballerina/oauth2;
import ballerinax/hubspot.crm.extensions.timelines as hstimeline;
```

### Step 2: Instantiate a new connector

1. Instantiate a `hstimeline:OAuth2RefreshTokenGrantConfig` or `ApiKeysConfig` with the obtained credentials and initialize the connector with it.
Since different APIs use varying authentication mechanisms, initialize two separate clients to handle both OAuth 2.0 and developer API key authentication.

    ```ballerina
    configurable string clientId = ?;
    configurable string clientSecret = ?;
    configurable string refreshToken = ?;
    configurable string hapikey = ?;
    configurable int appId = ?;


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

   final hstimeline:Client hubSpotTimelineOAuth2 = check new({auth: accessToken});
   final hstimeline:Client hubSpotTimelineApiKey = check new ({auth: apikeys});

    ```

2. Create a `Config.toml` file and, configure the obtained credentials in the above steps as follows:

   ```toml
   clientId = <Client Id>
   clientSecret = <Client Secret>
   refreshToken = <Refresh Token>
   hapikey = <Developer API Key>
   appId = <App Id>

   ```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations. A sample use case is shown below.

#### Get all event templates

```ballerina
public function main() returns error? {
    hstimeline:CollectionResponseTimelineEventTemplateNoPaging response = check hubSpotTimelineApiKey->/[appIdSigned32]/event\-templates.get();
    io:println("Event Templates: ", response); 
}
```

#### Run the Ballerina application

```bash
bal run
```

## Examples

The `HubSpot CRM Timelines` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.extensions.timelines/tree/main/examples/), covering the following use cases:

1. [Event Creation](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.extensions.timelines/tree/main/examples/create-event): This example demonstrates how to create a timeline event template, retrieving existing events, and creating an event using the template with their details in a structured format.

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    - [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    - [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

- For more information go to the [`hubspot.crm.extensions.timelines` package](https://central.ballerina.io/ballerinax/hubspot.crm.extensions.timelines/latest).
- For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
- Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
- Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
