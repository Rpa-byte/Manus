*** Settings ***
Documentation    Test de connexion à Sage X3
Resource         ../../resources/keywords/login_keywords.robot
Resource         ../../resources/variables/dev_variables.robot
Suite Teardown   Close All Browsers

*** Test Cases ***
Login With Valid Credentials
    Open Sage Login Page
    Login With Credentials    ${USERNAME}    ${PASSWORD}
    Login Should Succeed