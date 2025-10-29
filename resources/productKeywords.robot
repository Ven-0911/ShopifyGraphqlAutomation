*** Settings ***
Resource    ../resources/variables.robot
Library    RequestsLibrary
Library    JSONLibrary
Library    AllureLibrary
Library    Collections

*** Keywords ***
Create Product
    [Documentation]    Create a new product for the store

    ${query}=    Set Variable    mutation { productCreate(input: { title: "${PRODUCT_TITLE}" }) { product { id title } } }
    ${payload}=    Create Dictionary    query=${query}
    ${response}=       POST On Session    shopify    url=${graphql_endpoint}    json=${payload}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=           To Json    ${response.content}
    ${product_id}=     Get Value From Json    ${json}    $.data.productCreate.product.id
    ${prod}=    set variable    ${product_id[0]}
    Log To Console     Product created with ID: ${prod}
    set suite variable    ${PRODUCT_ID}    ${prod}

Get Inventory Item ID
    [Documentation]    Fetch inventoryItemId for the created product

    ${query}=    Set Variable    { product(id: "${PRODUCT_ID}") { variants(first: 1) { edges { node { inventoryItem { id } } } } } }
    ${payload}=    Create Dictionary    query=${query}

    ${response}=    POST On Session    shopify    url=${graphql_endpoint}    json=${payload}    headers=${headers}
    ${json}=    To Json    ${response.content}
    ${inventory_id}=    Get Value From Json    ${json}    $.data.product.variants.edges[0].node.inventoryItem.id
    Log To Console    Inventory Item ID: ${inventory_id[0]}
    set global variable    ${INVENTORY_ID}      ${inventory_id[0]}

Get Product Variant ID
    [Documentation]    Fetch the product variant id for the created product
    ${query}=    Catenate   query {
...    product(id: "${PRODUCT_ID}") {
...    variants(first: 1) {
...    edges {
...    node  {
...    id
...    }
...    }
...    }
...    }
...    }
    ${payload}=    Create Dictionary    query=${query}

    ${response}=    POST On Session    shopify    url=${graphql_endpoint}    json=${payload}    headers=${headers}
    ${json}=    To Json    ${response.content}
    ${variant_id}=    Get Value From Json    ${json}    $.data.product.variants.edges[0].node.id
    Log To Console    Product Variant Item ID: ${variant_id[0]}
    set global variable    ${PRODUCTVARIANT_ID}      ${variant_id[0]}