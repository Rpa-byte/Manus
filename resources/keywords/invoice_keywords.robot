*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Library     ../../libraries/utils/file_utils.py
Resource    ../locators/sageX3_locators.robot
Resource    ../variables/dev_variables.robot

*** Variables ***
# Lien fixe de la page factures (à remplacer)
${SAGE_FACTURE_URL}           https://REPLACE_WITH_FIXED_LINK

${FACTURES_DIR}               ${EXECDIR}/results/Factures
${TMP_DOWNLOAD}               ${EXECDIR}/results/downloads_tmp

*** Keywords ***
Prepare Invoice Folder
    ${base}=      Normalize Path    ${FACTURES_DIR}
    ${folder}=    Get Invoice Folder    ${base}
    Set Suite Variable    ${INVOICE_FOLDER}    ${folder}
    Log To Console    Invoice folder: ${folder}

Open Invoice Page
    Go To    ${SAGE_FACTURE_URL}
    Wait Until Element Is Visible    xpath=${SAGE_FACTURE_FILTRE_NUMERO_PIECE}    timeout=${TIMEOUT}

Filter By Invoice Number
    [Arguments]    ${numero_piece}
    Clear Element Text    xpath=${SAGE_FACTURE_FILTRE_NUMERO_PIECE}
    Input Text            xpath=${SAGE_FACTURE_FILTRE_NUMERO_PIECE}    ${numero_piece}
    Press Keys            xpath=${SAGE_FACTURE_FILTRE_NUMERO_PIECE}    ENTER

Select First Invoice
    Wait Until Element Is Visible    xpath=${SAGE_FACTURE_PREMIERE_LIGNE}    timeout=${TIMEOUT}
    Click Element                    xpath=${SAGE_FACTURE_PREMIERE_LIGNE}

Download Invoice
    [Arguments]    ${invoice_number}
    ${tmp}=    Normalize Path    ${TMP_DOWNLOAD}
    Clear Folder    ${tmp}
    Wait Until Element Is Visible    xpath=${SAGE_FACTURE_BOUTON_IMPRIMER}    timeout=${TIMEOUT}
    Click Element                    xpath=${SAGE_FACTURE_BOUTON_IMPRIMER}
    ${path}=    Save Invoice    ${tmp}    ${INVOICE_FOLDER}    ${invoice_number}
    Log To Console    Saved: ${path}

Process Invoice
    [Arguments]    ${numero_piece}
    Open Invoice Page
    Filter By Invoice Number    ${numero_piece}
    Select First Invoice
    Download Invoice    ${numero_piece}