*** Settings ***
Resource    ../resources/API/factories/autorizacao_abastecimento.robot


*** Test Cases ***
Realizar autorizacao do abastecimento
    Criar sessão para autorizar o abastecimento
    Inserir um fuellingID válido
#Consultar token inválido

