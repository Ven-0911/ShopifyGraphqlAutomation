*** Settings ***
Resource    ../resources/variables.robot
Library    RequestsLibrary
Library    JSONLibrary
Library    AllureLibrary
Library    Collections
Library    OperatingSystem

*** Keywords ***
Update Customer Webhooks
    [Documentation]    Update the customer information using webhooks
    ${mutation}=    catenate    mutation {
...    webhookSubscriptionCreate(
...    topic: CUSTOMERS_UPDATE
...    webhookSubscription: {callbackUrl: "${callbackUrl}", format: ${format}}
...    ) {
...    webhookSubscription {
...    id
...    }
...    userErrors {
...    field
...    message
...    }
...    }
...    }
    ${payload}=    Create Dictionary    query=${mutation}
    ${response}=       POST On Session    shopify    url=${graphql_endpoint}    json=${payload}    headers=${headers}
    ${json}=    to json    ${response.content}
    Should Be Equal As Strings    ${response.status_code}    200
    ${error}=   get value from json    ${json}      $.data.webhookSubscriptionCreate.userErrors
    log to console    ${error}

Validate Webhook Payload
    ${payload}=    Get File    ../testdata/webhook_payload.json
    ${json}=       To Json    ${payload}
    Log    ${json}
    Should Contain    ${json}    "email"
    Should Be Equal As Strings    ${json["email"]}    nila+webhooktest@example.com



