*** Settings ***
Resource    baseMobile.robot

*** Variables ***
${btnJaSouCliente}  id=button_enter_showcase
${inputTxtCpf}  id=user_cpf
${btnContinuar}   id=button
${btnLogin}   id=loginButton
${inputTxtSenha}    id=user_password
${btnContinuarSemBiometria}   id=biometric_login_cancel

*** Keywords ***
o usuario realiza o login
    [Arguments]    ${cpf}    ${senha}
    Click Mobile Element    ${btnJaSouCliente}   
    Input Text Mobile Element  ${inputTxtCpf}   ${cpf}
    Click Mobile Element   ${btnContinuar}
    Input Text Mobile Element  ${inputTxtSenha}   ${senha}
    Click Mobile Element   ${btnLogin}

