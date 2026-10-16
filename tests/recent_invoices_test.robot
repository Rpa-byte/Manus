*** Settings ***
Resource            ../resources/variables/dev_variables.robot
Resource            ../resources/keywords/db_keywords.robot
Suite Setup         Connect To Database
Suite Teardown      Disconnect From Database

*** Test Cases ***
Fetch Invoices From Last 30 Days
    ${invoices}=    Fetch Recent Invoices
    ${count}=       Get Length    ${invoices}
    Log To Console    Invoices found: ${count}
    Should Not Be Empty    ${invoices}
    Log To Console    First invoice: ${invoices}[0]