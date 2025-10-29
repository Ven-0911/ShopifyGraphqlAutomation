*** Settings ***
Resource    ../resources/variables.robot
Library    RequestsLibrary
Library    JSONLibrary
Library    AllureLibrary
Library    Collections

*** Keywords ***
Customer Create
    [Documentation]    Create customer for the store
    ${mutation}=    catenate    mutation {
...  customerCreate(
...    input: {
...      firstName: "${firstNameCreate}",
...      lastName: "${lastNameCreate}",
...      email: "${email}",
...      locale: "${localeCreate}",
...      addresses: [{
...        address1: "${address1}",
...        city: "${city}",
...        company: "${company}"
...      }]
...    }
...  ) {
...    customer {
...      id
...    }
...    userErrors {
...      field
...      message
...    }
...  }
...  }
    ${payload}=     Create Dictionary    query=${mutation}

    ${response}=    POST On Session    shopify      url=${graphql_endpoint}    json=${payload}     headers=${headers}

    ${json}=    to json    ${response.content}

    ${customer_id}=    get value from json    ${json}   $.data.customerCreate.customer.id
    Log To Console    Customer ID is: ${customer_id}

    set global variable    ${CUSTOMER_ID}       ${customer_id[0]}

    ${errors}=    Get Value From Json    ${json}    $.data.customerCreate.userErrors
    Log To Console    Errors: ${errors}

Customer Update
    [Documentation]    Update the customer information
    ${mutation}=    catenate    mutation {
...  customerUpdate(
...    input: {
...      id: "${CUSTOMER_ID}",
...      firstName: "${firstNameUpdate}",
...      lastName: "${lastNameUpdate}",
...    }
...  ) {
...    customer {
...      id
...      firstName
...      lastName
...    }
...  }
...  }
    ${payload}=     Create Dictionary    query=${mutation}

    ${response}=    POST On Session    shopify      url=${graphql_endpoint}    json=${payload}     headers=${headers}

    ${json}=    to json    ${response.content}

    ${cust_id}=    get value from json    ${json}   $.data.customerUpdate.customer.id
    Log To Console    Updated customer ID is: ${cust_id[0]}
