*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections
Library    JSONLibrary

Resource    ../res/commons.robot

*** Variables ***

${users_file}      ${EXECDIR}/data/users.json
${RESPONSE}
${TOKEN_AWS}


*** Keywords ***

Efetuar login na AWS com CPF existente

    ${users_json}    Load Json From File   ${users_file}
    ${user}    Set Variable    ${users_json['users'][0]}  # Considerando que estamos usando o primeiro usuario da lista
    ${username}    Set Variable    ${user['username']}
    ${password}    Set Variable    ${user['password']}
    ${environment}    Set Variable    ${users_json['environment']}
    
    Criar Sessão na AWS

    ${response}    GET On Session
    ...    alias=AWS
    ...    url=/signin
    ...    params=password=${password}&environment=${environment}&username=${username}

    Log    ${response.json()}
    Set Test Variable    ${RESPONSE}    ${response.json()}
    

Criar Sessão na AWS
    Create Session    alias=AWS    url=http://localhost:3000

Salvar o token_aws em uma variável
    Log    ${RESPONSE}
    ${TOKEN_AWS}    Get Value From Json    ${RESPONSE}    $..signInUserSession.accessToken.jwtToken
    Log    ${TOKEN_AWS}
    Set Json Value  file_name=users   key=jwtToken    value=${TOKEN_AWS}    #Esta KeyWord foi criada em Commons para 'settar' valores no arquivo JSON
