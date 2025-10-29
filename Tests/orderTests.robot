*** Settings ***
Resource    ../resources/orderKeywords.robot
Resource    ../resources/customerKeywords.robot
Resource    ../resources/productKeywords.robot
Resource    ../resources/inventoryKeywords.robot
Resource    ../resources/variables.robot
Resource    ../resources/shopify_setup.robot
Resource    ../resources/WebhooksKeywords.robot
Test Setup    Initialize Shopify Session
Library    RequestsLibrary
Library    JSONLibrary
Library    AllureLibrary
Library    Collections

*** Test Cases ***
End-to-End Order Flow
    Create Product
    Get Inventory Item ID
    Adjust Inventory
    Get Product Variant ID
    Customer Create
    Draft Order Create
    Draft Order Complete
    Query Order
    Cancel Order