_Author_:  Thinuriw \
_Created_: 2025/02/14 \
_Updated_: 2025/02/14 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from HubSpot CRM Timelines. 
The OpenAPI specification is obtained from (TODO: Add source link).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.


1. Change the `url` property of the servers object

**Original**: `https://api.hubspot.com`

**Updated**: `https://api.hubapi.com/integrators/timeline/v3`

**Reason**: This change of adding the common prefix `integrators/timeline/v3` to the base url, makes it easier to access endpoints using the client.

2. Update the API Paths

**Original**: Paths included common prefix above in each endpoint. (eg: `/integrators/timeline/v3`)

**Updated**: Common prefix is now removed from the endpoints as it is included in the base URL.

**Reason**: This change simplifies the API paths, making them shorter and more readable.

3. Update the `date-time` into datetime to make it compatible with the ballerina type conversions

**Original**: `format: date-time`

**Updated**: `format: datetime`

**Reason**: The `date-time` format is not compatible with the OpenAPI tool. Therefore, it is updated to `datetime` to make it compatible with the tool.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/openapi.json --mode client --license docs/license.txt -o ballerina
```
Note: The license year is hardcoded to 2025, change if necessary.
