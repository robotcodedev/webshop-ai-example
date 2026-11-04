*** Settings ***
Documentation    Ordering from the demo shop.

Library          ShopLibrary


*** Keywords ***
Create Order
    [Documentation]    Creates an order for ``quantity`` items of ``product`` and returns its id.
    ...
    ...    Fails if the product is out of stock.
    [Arguments]    ${product}    ${quantity}=1    ${express}=${False}
    Log    Ordered ${quantity} x ${product} (express: ${express})
    ${id}=    Place Order    ${product}    ${quantity}    ${express}
    RETURN    ${id}

Order Status Should Be
    [Documentation]    Checks the status of ``order``: ``placed`` or ``express``.
    [Arguments]    ${order}    ${expected}
    ${status}=    Order Status    ${order}
    Should Be Equal    ${status}    ${expected}

Submit Order
    [Documentation]    Submits ``order`` for delivery.
    [Arguments]    ${order}
    Log    Submitted ${order}

Checkout
    [Documentation]    Checks ``order`` out and submits it.
    [Arguments]    ${order}
    Submit Ordr    ${order}
