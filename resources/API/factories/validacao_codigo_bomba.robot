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
Resource         ../resources/API/commons.robot

Variables        ../resources/API/factories/abastecimento.py

*** Keywords ***
Criar sessão para validar o código da bomba
    Autenticar na AWS
    Reutilizar Token    alias=validarCodigoBomba
    # ${headers}    Create Dictionary    
    # ...    Content-Type=application/json    
    # ...    Authorization=Bearer ${TOKEN_AUTH_HML}
    # Create Session   
    # ...    alias=validarCodigoBomba   
    # ...    url=https://apihml.digitalportoseguro.com.br
    # ...    headers=${headers}

Pegar Cartão válido
    Verifica Arquivo Dados Cartao
    Reutilizar Token    alias=pegarCartaoValido
    # ${headers}    Create Dictionary    
    # ...    Content-Type=application/json    
    # ...    Authorization=Bearer ${TOKEN_AUTH_HML}
    # Create Session
    # ...    alias=pegarCartaoValido
    # ...    url=https://apihml.digitalportoseguro.com.br
    # ...    headers=${headers}

    ${resposta}    GET On Session
    ...    alias=pegarCartaoValido
    ...    url=/cliente/v3/cartoes/home
    Log    ${resposta}    #Remover esta linha depois
    Escrever no JSON    
    ...    file_name=dados_cartao    key=flagTitular    value=${resposta.json()}[dados][cartoes][0][flag_titular]
    Escrever no JSON    
    ...    file_name=dados_cartao    key=bin    value=${resposta.json()}[dados][cartoes][0][bin]
    Escrever no JSON    
    ...    file_name=dados_cartao    key=finalCartao    value=${resposta.json()}[dados][cartoes][0][final_cartao]
    Escrever no JSON    
    ...    file_name=dados_cartao    key=statusBloqueio    value=${resposta.json()}[dados][cartoes][0][status_bloqueio]


Inserir um código de abastecimento válido
    Pegar Cartão válido
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
    Remove File    path= ${EXECDIR}/${diretorio_arquivo}/${arquivo_json}