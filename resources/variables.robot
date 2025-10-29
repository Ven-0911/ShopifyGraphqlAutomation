*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    AllureLibrary
Library    Collections

*** Variables ***
${access_token}     *** Enter Your access token ***
${graphql_endpoint}     https://graphqldemotesting.myshopify.com/admin/api/2023-10/graphql.json
${PRODUCT_TITLE}    Shoes
${VENDOR}   S_Exports
${header}=    Create Dictionary    X-Shopify-Access-Token=${ACCESS_TOKEN}    Content-Type=application/json
${headers}    ${header}
${email}=   Breevandecamp@gmail.com
${firstNameCreate}=   Bree
${lastNameCreate}=    Vandecamp
${localeCreate}=    en
${address1}=        First Street
${city}=        NYC
${company}=     MAANG
${quantity}=    1
${reason}=      CUSTOMER
${restock}=     true
${originalPaymentMethodsRefund}=     true
${firstNameUpdate}=     Cust
${lastNameUpdate}=      Update
${callbackUrl}=     https://fledgiest-coordinately-kane.ngrok-free.dev/webhook-customer
${format}=         JSON