*** Settings ***
Resource    ../resources/variables.robot
Library    RequestsLibrary
Library    JSONLibrary
Library    AllureLibrary
Library    Collections

*** Keywords ***
Get Store Name
    [Documentation]    Query to get the store name
    ${query}=    Set Variable       query { shop { name } }
    ${payload}=    Create Dictionary    query=${query}
    ${response}=       POST On Session    shopify    url=${graphql_endpoint}    json=${payload}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=           To Json    ${response.content}
    ${store_name}=      get value from json    ${json}      $.data.shop.name
    log to console    Shop name is: ${store_name[0]}