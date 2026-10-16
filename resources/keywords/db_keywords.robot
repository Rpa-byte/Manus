*** Settings ***
Library    ../../libraries/database/db_connection.py

*** Keywords ***
Connect To Database
    ${conn}=    Connect To Sql Server
    ...    ${DB_DRIVER}    ${DB_SERVER}    ${DB_NAME}    ${DB_USER}    ${DB_PASSWORD}
    Set Suite Variable    ${DB_CONN}    ${conn}

Query Database
    [Arguments]    ${query}
    ${rows}=    Execute Query    ${DB_CONN}    ${query}
    RETURN    ${rows}

Disconnect From Database
    Close Connection    ${DB_CONN}

Fetch Recent Invoices
    ${rows}=    Execute Sql File    ${DB_CONN}    ${EXECDIR}/data/queries/recent_invoices.sql
    RETURN    ${rows}

