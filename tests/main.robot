*** Settings ***
Documentation    Test de connexion à Sage X3
Resource         ../resources/keywords/login_keywords.robot
Resource         ../resources/keywords/db_keywords.robot
Resource         ../resources/keywords/invoice_keywords.robot
Resource         ../resources/variables/dev_variables.robot
Suite Setup      Connect To Database
Suite Teardown   Run Keywords    Close All Browsers    AND    Disconnect From Database

*** Test Cases ***
Print Invoices From Database
    Open Sage Login Page
    Login With Credentials    ${USERNAME}    ${PASSWORD}
    Login Should Succeed
    Prepare Invoice Folder
    ${factures}=    Fetch Recent Invoices
    Should Not Be Empty    ${factures}
    FOR    ${facture}    IN    @{factures}
        ${numero_piece}=    Set Variable    ${facture}[0]
        Process Invoice    ${numero_piece}
    END