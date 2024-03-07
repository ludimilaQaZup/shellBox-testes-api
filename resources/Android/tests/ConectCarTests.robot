*** Settings ***
Resource    baseMobile.robot
Resource    PageView/HomeView.robot
Resource    PageView/LoginProcessView.robot
Resource    PageView/ConectCarMenuView.robot
Resource    PageView/ConectCarPedidoDeTagView.robot

Test Setup    Abrir App
Test Teardown    Fechar App

*** Variables ***
${cpf}  14346812201  #26754455098  #48757485070  
${senha}  senha123
${placa}    HFG 4U74


*** Test Cases ***

Teste ConectCar
    Given o usuario faz login e acessa o ConectCar    ${cpf}    ${senha}
    And entra no fluxo de pedido de tag
    When realiza o pedido de tag com um endereco ja cadastrado    ${placa}
    Then deve ser exibida a confirmacao do pedido de tag
