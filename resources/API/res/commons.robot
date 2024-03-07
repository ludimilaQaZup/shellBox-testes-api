*** Settings ***
Documentation    Esta suíte possui os comandos que todas as outras dependem ou executam em comum

Library    RequestsLibrary
Library    OperatingSystem
Library    JSONLibrary


Variables    ../resources/API/constants.py

*** Keywords ***

Get Json Value    [Arguments]    ${file_name}
    ${file}    Get File    path=${EXECDIR}/data/${file_name}.json    encoding=UTF-8
    ${json}    Evaluate    json.loads($file)    json
    [return]    ${json}
    

Set Json Value    [Arguments]    ${file_name}    ${key}    ${value}
    ${json}    Load Json From File    file_name=${EXECDIR}/data/${file_name}.json    encoding=UTF-8
    # ${string_value}=    Convert To String    ${value}
    ${json_updated}    Update Value To Json    ${json}    $..${key}    ${value}
    Dump Json To File    ${EXECDIR}/data/${file_name}.json    ${json_updated}    encoding=UTF-8