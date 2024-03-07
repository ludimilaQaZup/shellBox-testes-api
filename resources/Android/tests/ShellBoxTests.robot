*** Settings ***
Resource    baseMobile.robot
Resource    baseWeb.robot
Resource    PageView/HomeView.robot
Resource    PageView/ShellBoxView.robot
Resource    PageView/LoginProcessView.robot
Resource    PageObject/BombaShellBoxWebPage.robot

Test Setup    Abrir App
Test Teardown    Fechar App

*** Variables ***
${cpf}  13307669702  #26754455098  #48757485070  
${senha}  senha123
${IBM}    767676
${codigoAbastecimento}  766601  #858585
${codigoBombaDesativada}    111111
${codigoErroGenerico}    999999
${codigoInvalido}    123456


*** Test Cases ***

Abastecimento ShellBox com Sucesso
    Given o usuario faz login e acessa o ShellBox    ${cpf}    ${senha}
    When o usuario realiza o abastecimento com ShellBox    ${codigoAbastecimento}
    And o usuario abre o chrome
    And o usuario navega até o site da bomba do shell box e realiza o abastecimento    ${IBM}
    Then deve ser exibida a mensagem de pagamento realizado

Abastecimento ShellBox Continuacao
    Given o usuario faz login e acessa o ShellBox    ${cpf}    ${senha}
    When o usuario realiza o abastecimento com ShellBox    ${codigoAbastecimento}
    And o usuario volta para o menu
    And o usuario acessa o ShellBox
    Then deve ser retomado o abastecimento em andamento

Abastecimento ShellBox Erro Pagamento
    Given o usuario faz login e acessa o ShellBox   ${cpf}    ${senha}
    When o usuario realiza o abastecimento com ShellBox    ${codigoAbastecimento}
    Then deve ser exibida a tela de erro no pagamento

Abastecimento ShellBox Bomba Desativada
    Given o usuario faz login e acessa o ShellBox    ${cpf}    ${senha}
    When o usuario realiza o abastecimento com ShellBox    ${codigoBombaDesativada}
    Then deve ser exibida a mensagem de bomba desativada

Abastecimento ShellBox Codigo Invalido
    Given o usuario faz login e acessa o ShellBox    ${cpf}    ${senha}
    When o usuario realiza o abastecimento com ShellBox    ${codigoInvalido}
    Then deve ser exibida a mensagem de codigo invalido

Abastecimento ShellBox Erro Generico
    Given o usuario faz login e acessa o ShellBox    ${cpf}    ${senha}
    When o usuario realiza o abastecimento com ShellBox    ${codigoErroGenerico}
    Then deve ser exibido o modal de erro genérico

