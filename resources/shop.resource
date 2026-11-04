*** Settings ***
Documentation    Logging in to the demo shop and finding products.

Library          Collections
Library          ShopLibrary


*** Keywords ***
Open Shop As
    [Documentation]    Opens the shop at ${BASE_URL} and logs in as the given user.
    [Arguments]    ${user}    ${password}=secret
    Log In    ${user}    ${password}
    Log    Opened ${BASE_URL} as ${user}

Welcome Message Should Be
    [Documentation]    Checks the greeting the shop shows the user who is logged in.
    [Arguments]    ${expected}
    ${greeting}=    Greeting
    Should Be Equal    ${greeting}    ${expected}

User Should Be Logged Out
    [Documentation]    Checks that nobody is logged in.
    ${user}=    Current User
    Should Be Equal    ${user}    ${None}

Search Should Find
    [Documentation]    Searches for ``text`` and checks that exactly the ``expected`` products are found.
    [Arguments]    ${text}    @{expected}
    ${found}=    Search Products    ${text}
    Lists Should Be Equal    ${found}    ${expected}
