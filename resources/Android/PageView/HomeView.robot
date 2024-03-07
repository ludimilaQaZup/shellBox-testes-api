*** Settings ***
Resource    baseMobile.robot

*** Variables ***
${btnJaSouCliente}  id=button_enter_showcase
${inputTxtCpf}  id=user_cpf
${btnContinuar}   id=button
${btnLogin}   id=loginButton
${inputTxtSenha}    id=user_password
${btnContinuarSemBiometria}   id=biometric_login_cancel

${btnAtalhos}   xpath=//android.widget.Button[@content-desc="Ouvir mais opções de atalhos"]
${btnShellBox}    xpath=//android.widget.Button[@content-desc="Shell Box"]
${btnConectCar}    xpath=//android.widget.Button[@content-desc="ConectCar"]
${btnSetaVoltar}    id=back_button
${btnContinuar}   id=button
${btnContinuarSemBiometria}   id=biometric_login_cancel
${HomePageBtnAtalhos}    xpath=//android.widget.Button[@content-desc='Ouvir mais opções de atalhos']

*** Keywords ***
o usuario realiza o login
    [Arguments]    ${cpf}    ${senha}
    Click Mobile Element    ${btnJaSouCliente}   
    Input Text Mobile Element  ${inputTxtCpf}   ${cpf}
    Click Mobile Element   ${btnContinuar}
    Input Text Mobile Element  ${inputTxtSenha}   ${senha}
    Click Mobile Element   ${btnLogin}

o usuario acessa os atalhos
    Click Mobile Element    ${btnContinuarSemBiometria}
    Click Mobile Element    ${btnContinuar}
    Click Mobile Element    ${HomePageBtnAtalhos}

o usuario acessa o ShellBox
    Click Mobile Element    ${btnShellBox}

o usuario acessa o ConectCar
    Click Mobile Element    ${btnConectCar}

o usuario faz login e acessa o ShellBox
    [Arguments]    ${cpf}    ${senha}
    o usuario realiza o login    ${cpf}    ${senha}
    o usuario acessa os atalhos
    Wait Until Mobile Element Is Visible    ${btnSetaVoltar}    
    Swipe By Percent    50    80    50    30
    o usuario acessa o ShellBox

o usuario faz login e acessa o ConectCar
    [Arguments]    ${cpf}    ${senha}
    o usuario realiza o login    ${cpf}    ${senha}
    o usuario acessa os atalhos
    Wait Until Mobile Element Is Visible    ${btnSetaVoltar}    
    Swipe By Percent    50    80    50    30
    o usuario acessa o ConectCar
    