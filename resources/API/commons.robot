*** Settings ***
Documentation    Esta suíte possui os comandos que todas as outras dependem ou executam em comum

Library    RequestsLibrary
Library    OperatingSystem
Library    JSONLibrary

Resource    ../resources/API/factories/login_aws_hml.robot

Variables    ../config.yaml

*** Keywords ***  

Escrever no JSON    [Arguments]    ${file_name}    ${key}    ${value}
    ${json}    Load Json From File    file_name=${EXECDIR}/data/${file_name}.json    encoding=UTF-8
    # ${string_value}=    Convert To String    ${value}
    ${json_updated}    Update Value To Json    ${json}    $..${key}    ${value}
    Dump Json To File    ${EXECDIR}/data/${file_name}.json    ${json_updated}    encoding=UTF-8

Reutilizar Token    [Arguments]    ${alias}
       ${headers}    Create Dictionary    
    ...    Content-Type=application/json    
    ...    Authorization=Bearer ${TOKEN_AUTH_HML}
    Create Session
    ...    alias=${alias}
    ...    url=https://apihml.digitalportoseguro.com.br
    ...    headers=${headers}