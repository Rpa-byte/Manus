*** Settings ***
Resource            ../resources/variables/dev_variables.robot
Resource            ../resources/keywords/db_keywords.robot
Suite Setup         Connect To Database
Suite Teardown      Disconnect From Database

*** Test Cases ***
Database Connection Works
    ${rows}=    Query Database    SELECT TOP 1 NUM_0 FROM x3.BASE1.XLISTVENTER2
    Log    ${rows}
    Should Not Be Empty    ${rows}