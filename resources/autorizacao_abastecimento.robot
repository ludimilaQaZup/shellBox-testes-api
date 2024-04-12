*** Settings ***
Documentation    Realiza a autorização do abastecimento
Library          RequestsLibrary
Library          String
Library          Collections
Library          JSONLibrary
Library          Process
Library          OperatingSystem
Library          ../resources/factories/abastecimento.py
Resource         ../resources/login_aws_hml.robot
Resource         ../resources/commons.robot

Variables        ../resources/factories/abastecimento.py


*** Keywords ***
Criar sessão para autorizar o abastecimento
    Autenticar na AWS
    ${headers}    Create Dictionary    
    ...    Content-Type=application/json    
    ...    Authorization=Bearer ${TOKEN_AUTH_HML}
    Create Session   
    ...    alias=autorizarAbastecimento
    ...    url=${CONFIGS.dominios.bff}
    ...    headers=${headers}
    
Inserir um fuellingID válido
    ${json}    Pegar Valor JSON    file_name=${arquivo_json}
    ${body}    Create Dictionary    
    ...    fuellingId=${json['fuellingId']}   
    ...    produtoTelemetria=true

    Criar sessão para autorizar o abastecimento
    ${url_autorizar_abastecimento}    Catenate    SEPARATOR=    ${CONFIGS.paths.geral}    ${CONFIGS.paths.autorizar_abastecimento}
    ${resposta}    POST On Session
    ...    alias=autorizarAbastecimento
    ...    url=${url_autorizar_abastecimento}
    ...    json=${body}
       
    Status Should Be    204
    Remove File    path=${diretorio_arquivo}/${arquivo_json}