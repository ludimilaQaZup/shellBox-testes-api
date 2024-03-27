*** Settings ***
Documentation    Realiza a autorização do abastecimento
Library          RequestsLibrary
Library          String
Library          Collections
Library          JSONLibrary
Library          Process
Library          OperatingSystem
Library          ../resources/API/factories/abastecimento.py
Resource         ../resources/API/factories/login_aws_hml.robot

*** Keywords ***
Criar sessão para autorizar o abastecimento
    Autenticar na AWS
    ${headers}    Create Dictionary    
    ...    Content-Type=application/json    
    ...    Authorization=Bearer ${TOKEN_AUTH_HML}
    Create Session   
    ...    alias=autorizarAbastecimento
    ...    url=https://apihml.digitalportoseguro.com.br
    ...    headers=${headers}
    
Inserir um fuellingID válido
    ${body}        Create Dictionary    
    ...    fuellingId=${FUELLING_ID}   
    ...    produtoTelemetria='true'

    Criar sessão para autorizar o abastecimento
    
    ${resposta}    POST On Session
    ...    alias=validarCodigoBomba
    ...    url=/cliente/v1/abastecimento/shellbox/autorizar/abastecimento
    ...    json=${body}

    Log    ${resposta.json()}    
    Status Should Be    204