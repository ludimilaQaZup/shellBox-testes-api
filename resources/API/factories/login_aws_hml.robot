*** Settings ***
Documentation    Autenticação na AWS no ambiente de homologação
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary

Variables    ../config.yaml

*** Variables ***
${URL_API}    ${CONFIGS.dominios.login}
${USER}       ${CONFIGS.usuarios.cpf}
${PASSWORD}   ${CONFIGS.usuarios.senha}
${ENV}        ${CONFIGS.environment}

*** Keywords ***
#Antes deve-se iniciar projeto no amplify (npm run start-hml)
Autenticar na AWS
    Create Session    
    ...    alias=auth_api    
    ...    url=${URL_API}

    ${response}    GET On Session    
    ...    alias=auth_api    
    ...    url=signin?password=${PASSWORD}&environment=${ENV}&username=${USER}    
    ...    expected_status=200

    Set Global Variable    ${TOKEN_AUTH_HML}    
    ...                    ${response.json()['signInUserSession']['accessToken']['jwtToken']}

    Delete All Sessions
