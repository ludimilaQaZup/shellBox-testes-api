*** Settings ***
Resource    ../resources/API/factories/validacao_codigo_bomba.robot

*** Test Cases ***
Realizar a validação do código da bomba
    Criar sessão para validar o código da bomba
    Inserir um código de abastecimento válido


