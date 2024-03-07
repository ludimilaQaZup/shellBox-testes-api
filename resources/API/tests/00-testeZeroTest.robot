Language: en

*** Settings ***
Documentation    Teste zero
Resource    ../resources/API/res/get_login_aws.resource
Resource    ../resources/API/res/abastecimeto_actions.robot

*** Test Cases ***

CT01- realizar login
    Given Efetuar login na AWS com CPF existente
    When Criar Sessão na AWS
    Then Salvar o token_aws em uma variável

CT02 - Solicitar abastecimento
    Given solicito abastecimento
    When a resposta for 200
    Then o campo fuellinId deverá vir preenchido

CT03 - Autorizar abastecimento
    Given informo o fuellingId correto
    When a resposta for 204
    Then o abastecimento foi autorizado com sucesso