*** Settings ***
Documentation    Placing orders.
Metadata         Owner    Team Checkout

Resource         shop.resource
Resource         orders.resource

Test Setup       Open Shop As    alice

Test Tags        orders


*** Test Cases ***
Order Coffee
    [Documentation]    An order for a product in stock is placed.
    [Metadata]    Requirement    SHOP-301
    [Tags]    smoke
    ${order}=    Create Order    coffee    quantity=2
    Order Status Should Be    ${order}    placed

Express Order
    [Documentation]    An express order is marked as such.
    [Metadata]    Requirement    SHOP-302
    ${order}=    Create Order    beans    express=${True}
    Order Status Should Be    ${order}    express

Sold Out Product Cannot Be Ordered
    [Documentation]    The shop refuses an order for a product that is sold out.
    [Metadata]    Requirement    SHOP-303
    [Metadata]    Risk    high
    Run Keyword And Expect Error    mug is out of stock    Create Order    mug
