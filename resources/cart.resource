*** Settings ***
Documentation    Working with the cart of the demo shop.

Library          Collections
Library          ShopLibrary


*** Keywords ***
Add To Cart
    [Documentation]    Adds ``quantity`` items of ``product`` to the cart.
    [Arguments]    ${product}    ${quantity}=1
    Put In Cart    ${product}    ${quantity}

Cart Should Contain
    [Documentation]    Checks that the cart holds ``quantity`` items of ``product``.
    [Arguments]    ${product}    ${quantity}=${1}
    ${items}=    Cart Items
    Dictionary Should Contain Item    ${items}    ${product}    ${quantity}

Cart Should Be Empty
    [Documentation]    Checks that the cart holds nothing.
    ${items}=    Cart Items
    Should Be Empty    ${items}

Cart Total Should Be
    [Documentation]    Checks the total price of the cart, in euros.
    [Arguments]    ${expected}
    ${total}=    Cart Total
    Should Be Equal As Numbers    ${total}    ${expected}

Empty Cart
    [Documentation]    Takes everything out of the cart.
    ${items}=    Cart Items
    FOR    ${product}    IN    @{items}
        Take From Cart    ${product}
    END
