*** Settings ***
Documentation    Test de connexion à Sage X3
Resource         ../resources/keywords/login_keywords.robot
Resource         ../resources/keywords/db_keywords.robot
Resource         ../resources/variables/dev_variables.robot
Suite Setup      Connect To Database
Suite Teardown   Run Keywords    Close All Browsers    AND    Disconnect From Database

*** Test Cases ***
Login With Valid Credentials
    Open Sage Login Page
    Login With Credentials    ${USERNAME}    ${PASSWORD}
    Login Should Succeed
    ${invoices}=    Fetch Recent Invoices
    ${count}=       Get Length    ${invoices}
    Log To Console    Invoices found: ${count}
    Should Not Be Empty    ${invoices}