*** Settings ***
Documentation    Finding products by their name.
Metadata         Owner    Team Catalog

Resource         ../resources/shop.resource

Test Template    Search Should Find


*** Test Cases ***    TEXT    PRODUCTS
Find Coffee           coff    coffee
Find Tea              tea     tea
Find Several          e       beans    coffee    tea
Find Nothing          xyz
