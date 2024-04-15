*** Settings ***
Documentation    Esta suíte possui os comandos que todas as outras dependem ou executam em comum

Library    RequestsLibrary
Library    OperatingSystem
Library    JSONLibrary

Resource    ../resources/login_aws_hml.robot
Variables        ../config.yaml

*** Keywords ***  

Escrever no JSON    [Arguments]    ${file_name}    ${key}    ${value}
    ${json}    Load Json From File    file_name=${EXECDIR}/data/${file_name}   encoding=UTF-8
    ${json_updated}    Update Value To Json    ${json}    $..${key}    ${value}
    Dump Json To File    ${EXECDIR}/data/${file_name}   ${json_updated}    encoding=UTF-8

Pegar Valor JSON        [Arguments]    ${file_name}
    ${file}    Get File    path=${EXECDIR}/data/${file_name}    encoding=UTF-8
    ${json}    Evaluate    json.loads($file)    json
    [return]    ${json}


Usar Token    [Arguments]    ${alias}
    ${headers}    Create Dictionary    
    ...    Content-Type=application/json    
    ...    Authorization=Bearer ${TOKEN_AUTH_HML}
    Create Session
    ...    alias=${alias}
    ...    url=${CONFIGS.dominios.bff}
    ...    headers=${headers}