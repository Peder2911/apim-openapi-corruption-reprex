
# APIM OpenAPI Corruption

This repository allows you to reproduce an issue with APIM, where a valid OpenAPI specification is provided, but an invalid specification by APIM as a result. The issue is that APIM converts the following parameter:

```
# Input (in .parameters and referenced by Path).

parameters:
  testBadParam:
    name: badParam
    in: query
    description: Makes APIM emit an invalid OpenAPI specification. 
    style: form
    explode: false
    schema:
      type: array
      items:
        type: string

# Returned by APIM (on Path operation)

parameters:
 - testBadParam:
   name: badParam
   in: query
   description: Makes APIM emit an invalid OpenAPI specification. 
   type: array

```

To reproduce this issue, apply the Terraform module in this repository. The resulting APIM resource will emit a bad OpenAPI specification when queried in the developer portal.

Please continue the discussion in the Issues tab on this repository to resolve.
