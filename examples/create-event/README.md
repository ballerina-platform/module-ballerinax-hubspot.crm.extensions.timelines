# [Event Creation](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.extensions.timelines/tree/main/examples/)

This example demonstrates how to create a timeline event template, retrieving existing events, and creating an event using the template with their details in a structured format.

## Prerequisites

1. Generate HubSpot credentials to authenticate the connector as described in the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.extensions.timelines/blob/main/ballerina/Package.md#setup-guide).

2. For each example, create a `Config.toml` file the related configuration. Here's an example of how your `Config.toml` file should look:

    ```toml
    clientId = <Client Id>
    clientSecret = <Client Secret>
    refreshToken = <Refresh Token>
    hapikey = <Developer API Key>
    appId = <App Id>
    ```

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
