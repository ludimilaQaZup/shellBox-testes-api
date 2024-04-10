*** Settings ***
Documentation    Autenticação na AWS no ambiente de homologação
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary

*** Variables ***
${URL_API}    http://localhost:3000/signin
${USER}       47564734825
${PASSWORD}    senha123
${ENV}    hml

*** Keywords ***
#Antes deve-se iniciar projeto no amplify (npm run start-hml)
Autenticar na AWS
    Create Session    
    ...    alias=auth_api    
    ...    url=${URL_API}

    ${response}    GET On Session    
    ...    alias=auth_api    
    ...    url=?password=${PASSWORD}&environment=${ENV}&username=${USER}    
    ...    expected_status=200

    Set Global Variable    ${TOKEN_AUTH_HML}    
    ...                    ${response.json()['signInUserSession']['accessToken']['jwtToken']}

    Delete All Sessions
