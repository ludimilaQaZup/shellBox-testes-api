*** Settings ***
Resource    ../resources/autorizacao_abastecimento.robot

*** Test Cases ***
Realizar autorizacao do abastecimento
    Criar sessão para autorizar o abastecimento
    Inserir um fuellingID válido

