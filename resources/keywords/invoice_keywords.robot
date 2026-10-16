*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    ../../libraries/utils/file_utils.py

*** Variables ***
${FACTURES_DIR}    ${EXECDIR}/results/Factures
${TMP_DOWNLOAD}    ${EXECDIR}/results/downloads_tmp

*** Keywords ***
Prepare Invoice Folder
    ${base}=      Normalize Path    ${FACTURES_DIR}
    ${folder}=    Get Invoice Folder    ${base}
    Set Suite Variable    ${INVOICE_FOLDER}    ${folder}
    Log To Console    Invoice folder: ${folder}

Download Invoice
    [Arguments]    ${invoice_number}
    ${tmp}=    Normalize Path    ${TMP_DOWNLOAD}
    Clear Folder    ${tmp}
    Click Element    xpath=REPLACE_WITH_DOWNLOAD_BUTTON_LOCATOR
    ${path}=    Save Invoice    ${tmp}    ${INVOICE_FOLDER}    ${invoice_number}
    Log To Console    Saved: ${path}