*** Settings ***
Resource    ../resources/keywords/invoice_keywords.robot

*** Test Cases ***
Create Invoice Folder
    Prepare Invoice Folder
    Directory Should Exist    ${INVOICE_FOLDER}