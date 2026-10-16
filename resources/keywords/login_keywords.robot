*** Settings ***
Library    SeleniumLibrary
Resource   ../variables/dev_variables.robot

*** Keywords ***
Open Sage Login Page
    Set Screenshot Directory    ${OUTPUT_DIR}/screenshots
    Open Browser    ${SAGE_URL}    ${BROWSER}
    Set Selenium Timeout    ${TIMEOUT}
    Maximize Browser Window

Login With Credentials
    [Arguments]    ${user}    ${pass}
    Input Text      id=login    ${user}
    Input Password  id=password    ${pass}
    Click Element     id=go-basic

Login Should Succeed
    Wait Until Page Contains Element    id=homeMenu    timeout=${TIMEOUT}