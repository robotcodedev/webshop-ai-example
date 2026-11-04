*** Settings ***
Documentation    Logging in to the shop and out again.
Metadata         Owner    Team Accounts

Resource         shop.resource

Test Tags        login


*** Test Cases ***
Login Works
    [Documentation]    A user who logs in is greeted by name.
    [Metadata]    Requirement    SHOP-101
    [Tags]    smoke
    Open Shop As    alice
    Welcome Message Should Be    Welcome back, Alice!

Logout Works
    [Documentation]    A user who logs out is no longer logged in.
    [Metadata]    Requirement    SHOP-102
    [Tags]    smoke
    Open Shop As    bob
    Log Out
    User Should Be Logged Out

Login With A Wrong Password Fails
    [Documentation]    The shop refuses a wrong password.
    [Metadata]    Requirement    SHOP-103
    [Metadata]    Risk    high
    Run Keyword And Expect Error    Wrong password for alice    Open Shop As    alice    password=guess
