*** Settings ***
Documentation    Filling and emptying the cart.
Metadata         Owner    Team Checkout

Resource         shop.resource
Resource         cart.resource

Test Setup       Open Shop As    alice
Test Teardown    Empty Cart

Test Tags        cart


*** Test Cases ***
Add Item To Cart
    [Documentation]    A product added to the cart is in the cart.
    [Metadata]    Requirement    SHOP-201
    [Tags]    smoke
    Add To Cart    coffee
    Cart Should Contain    coffee

Remove Item From Cart
    [Documentation]    A product taken out of the cart is gone.
    [Metadata]    Requirement    SHOP-202
    Add To Cart    tea
    Take From Cart    tea
    Cart Should Be Empty

Cart Total Adds Up
    [Documentation]    The total is the sum of the prices of everything in the cart.
    [Metadata]    Requirement    SHOP-203
    [Metadata]    Risk    high
    Add To Cart    coffee    quantity=2
    Add To Cart    mug
    Cart Total Should Be    21.00
