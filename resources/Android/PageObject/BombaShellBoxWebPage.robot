*** Settings ***
Resource    baseWeb.robot

*** Variables ***
${txtInputIBM}    id=ibm-input
${btnEnviarIBM}    id=ibm-send-button
${btnSalvarToken}    id=token-save-button
${btnIniciarAbastecimento}    id=start-button
${btnPararAbastecimento}    id=stop-button


*** Keywords ***
o usuario navega até o site da bomba do shell box e realiza o abastecimento
    [Arguments]    ${IBM}
    Go To    https://fuelpump.hml.appshellbox.com/
    Click Web Element    ${txtInputIBM}
    Input Text Web Element    ${txtInputIBM}    ${IBM}
    Click Web Element    ${btnEnviarIBM}
    Click Web Element    ${btnSalvarToken}
    Click Web Element    ${btnIniciarAbastecimento}
    Sleep     10
    Click Web Element    ${btnPararAbastecimento}
    Sleep     10

