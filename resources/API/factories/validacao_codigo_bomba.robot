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

*** Keywords ***
Criar sessão para validar o código da bomba
    Autenticar na AWS
    ${headers}    Create Dictionary    
    ...    Content-Type=application/json    
    ...    Authorization=Bearer ${TOKEN_AUTH_HML}
    Create Session   
    ...    alias=validarCodigoBomba   
    ...    url=https://apihml.digitalportoseguro.com.br
    ...    headers=${headers}
    
Inserir um código de abastecimento válido
    ${body}    Factory Abastecimento Validacao Token

    Criar sessão para validar o código da bomba
    
    ${resposta}    POST On Session
    ...    alias=validarCodigoBomba
    ...    url=/cliente/v1/abastecimento/shellbox/validar/abastecimento
    ...    json=${body}

    Set Global Variable    ${FUELLING_ID}
    ...    ${resposta.json()['dados']['fuellingId']}

    Log    ${resposta.json()}    
    Status Should Be    200