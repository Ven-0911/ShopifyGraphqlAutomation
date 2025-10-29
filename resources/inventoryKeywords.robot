*** Settings ***
Resource    ../resources/variables.robot
Library    RequestsLibrary
Library    JSONLibrary
Library    AllureLibrary
Library    Collections

*** Keywords ***
Adjust Inventory
    [Documentation]    Adjust inventory quantity for the product

    Create Session    shopify    ${graphql_endpoint}
    ${headers}=    Create Dictionary    X-Shopify-Access-Token=${access_token}    Content-Type=application/json
    ${mutation}=    Set Variable    mutation { inventoryAdjustQuantity(input:{inventoryItemId: "${INVENTORY_ID}", availableDelta: 10 }) { inventoryLevel { available } userErrors { field message } } }
    ${payload}=    Create Dictionary    query=${mutation}

    ${response}=    POST On Session    shopify    url=${graphql_endpoint}    json=${payload}    headers=${headers}
    ${json}=    To Json    ${response.content}
    ${available}=    Get Value From Json    ${json}    $.data.inventoryAdjustQuantity.inventoryLevel.available
    Log To Console    Inventory adjusted. Available quantity: ${available}