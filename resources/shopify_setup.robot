*** Settings ***
Resource    ../resources/variables.robot
Library    RequestsLibrary
Library    JSONLibrary
Library    AllureLibrary
Library    Collections

*** Keywords ***
Initialize Shopify Session
    Create Session    shopify    ${GRAPHQL_ENDPOINT}
    ${headers}=    Create Dictionary    X-Shopify-Access-Token=${ACCESS_TOKEN}    Content-Type=application/json
    Set Suite Variable    ${HEADERS}    ${headers}