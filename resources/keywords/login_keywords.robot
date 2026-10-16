*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    ../../libraries/file_utils.py
Library    ../../libraries/utils/file_utils.py

*** Keywords ***
Open Sage Login Page
    Set Screenshot Directory    ${OUTPUT_DIR}/screenshots
    ${dl}=         Normalize Path    ${EXECDIR}/results/downloads_tmp
    ${options}=    Get Chrome Options    ${dl}
    Open Browser    ${SAGE_URL}    ${BROWSER}    options=${options}
    Set Selenium Timeout    ${TIMEOUT}
    Maximize Browser Window

Login With Credentials
    [Arguments]    ${user}    ${pass}
    Input Text      id=login    ${user}
    Input Password  id=password    ${pass}
    Click Element     id=go-basic

Login Should Succeed
    Wait Until Page Contains Element    id=homeMenu    timeout=${TIMEOUT}