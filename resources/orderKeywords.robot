*** Settings ***
Resource    ../resources/variables.robot
Library    RequestsLibrary
Library    JSONLibrary
Library    AllureLibrary
Library    Collections

*** Keywords ***
Draft Order Create

    [Documentation]    Create a draft order from the store

    ${mutation}=    catenate    mutation {
...    draftOrderCreate(input:{email:"${email}", lineItems:[{variantId:"${PRODUCTVARIANT_ID}",quantity:${quantity}}]})
...    { draftOrder{
...    email
...    id
...    name
...    }
...    }
...    }

    ${payload}=     create dictionary    query=${mutation}
    ${response}=    POST On Session    shopify      url=${graphql_endpoint}     json=${payload}     headers=${headers}
    ${json}=    to json    ${response.content}
    ${draftOrderCreate_id}=    get value from json    ${json}   $.data.draftOrderCreate.draftOrder.id
    Log To Console    Draft Order Create ID is: ${draftOrderCreate_id[0]}
    set global variable    ${DRAFTORDERCREATE_ID}       ${draftOrderCreate_id[0]}

Draft Order Complete

    [Documentation]    Complete the draft order for the store
    ${mutation}=    catenate    mutation {
...    draftOrderComplete(id:"${DRAFTORDERCREATE_ID}")
...    { draftOrder{
...    email
...     id
...    name
...    status
...    }
...    }
...    }
    ${payload}=     create dictionary    query=${mutation}
    ${response}=    POST On Session    shopify      url=${graphql_endpoint}     json=${payload}     headers=${headers}
    ${json}=        to json    ${response.content}
    ${draftordercomplete_id}=      Get Value From JSON      ${json}     $.data.draftOrderComplete.draftOrder.id
    ${ordername}=      get value from json    ${json}       $.data.draftOrderComplete.draftOrder.name
    log to console    Draft order complete id: ${draftordercomplete_id[0]}
    log to console    Order name is generated:  ${ordername[0]}
    set global variable    ${DRAFTORDERCOMPLETE_ID}     ${draftordercomplete_id[0]}

Query Order

    [Documentation]    Query the order from the shop that was completed
    sleep       5s
    ${query}=    catenate    query {
...    orders(first:5, query:"${email}")
...    {
...    edges{
...    node{
...    id
...    name
...    }
...    }
...    }
...    }
    ${payload}=     create dictionary    query=${query}
    ${response}=    POST On Session    shopify      url=${graphql_endpoint}     json=${payload}     headers=${headers}
    ${json}=        to json    ${response.content}
    ${name}=      Get Value From JSON      ${json}     $.data.orders.edges[0].node.name
    ${order_id}=    get value from json    ${json}      $.data.orders.edges[0].node.id
    log to console    order name : ${name[0]}
    log to console    order id : ${order_id[0]}
    set global variable    ${ORDER_ID}      ${order_id[0]}


Cancel Order

    [Documentation]    Cancel the order placed by id
    ${mutation}=    catenate    mutation {
...    orderCancel(orderId: "${ORDER_ID}",
...    reason: ${reason},
...    restock:${restock},
...    refundMethod: {
...    originalPaymentMethodsRefund: ${originalPaymentMethodsRefund} })
...    { orderCancelUserErrors
...    { field
...    message
...    code
...    }
...    }
...    }
    ${payload}=     create dictionary    query=${mutation}
    ${response}=    POST On Session    shopify      url=${graphql_endpoint}     json=${payload}     headers=${headers}
    ${json}=        to json    ${response.content}
    ${error}=      Get Value From JSON      ${json}     $.data.orderCancel.orderCancelUserErrors
    log to console    order message : ${error}
    should be empty    ${error}
