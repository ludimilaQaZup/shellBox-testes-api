*** Settings ***
Documentation    Realiza a validação do código da bomba antes de autorizar o abastecimento

Library          RequestsLibrary
Library          String
Library          Collections
Library          JSONLibrary
Library          Process
Library          OperatingSystem
Library          ../resources/API/factories/abastecimento.py

Resource         ../resources/API/factories/login_aws_hml.robot
Resource         ../resources/commons.robot

Variables        ../resources/API/factories/abastecimento.py

*** Keywords ***
Criar sessão para validar o código da bomba
    Autenticar na AWS
    Usar Token    alias=validarCodigoBomba

Pegar Cartão válido    #Get na Nova Home para obter os dados necessários do cartão
    Verifica Arquivo Dados Cartao
    Usar Token    alias=pegarCartaoValido

    ${resposta}    GET On Session
    ...    alias=pegarCartaoValido
    ...    url=${CONFIGS.paths.buscar_cartao}
    Log    ${resposta}    #Remover esta linha depois

    Escrever no JSON    
    ...    file_name=${arquivo_json}    key=bin    value=${resposta.json()}[dados][cartoes][0][bin]
    Escrever no JSON    
    ...    file_name=${arquivo_json}    key=finalCartao    value=${resposta.json()}[dados][cartoes][0][final_cartao]
    Escrever no JSON    
    ...    file_name=${arquivo_json}    key=flagTitular    value=${resposta.json()}[dados][cartoes][0][flag_titular]
    Escrever no JSON    
    ...    file_name=${arquivo_json}    key=statusBloqueio    value=${resposta.json()}[dados][cartoes][0][status_bloqueio]


Inserir um código de abastecimento válido
    Pegar Cartão válido
    ${body}    Factory Abastecimento Validacao Token

    Criar sessão para validar o código da bomba
    ${url_validar_codigo_bomba}    Catenate    SEPARATOR=    
    ...    ${CONFIGS.paths.geral}    
    ...    ${CONFIGS.paths.validar_codigo}
    
    ${resposta}    POST On Session
    ...    alias=validarCodigoBomba
    ...    url=${url_validar_codigo_bomba}
    ...    json=${body}

    # Set Global Variable    ${FUELLING_ID}
    # ...    ${resposta.json()['dados']['fuellingId']}
    Escrever no JSON    
    ...    file_name=${arquivo_json}    key=fuellingId    value=${resposta.json()}[dados][fuellingId]
    
    Log    ${resposta.json()}    
    Status Should Be    200
