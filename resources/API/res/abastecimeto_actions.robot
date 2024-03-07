*** Settings ***
Documentation    Este arquivo possui as keywords utilizadas para solicitar e autorizar abastecimento
Library    RequestsLibrary
Library    OperatingSystem
Library    JSONLibrary
Library    String

Resource    ../resources/API/res/commons.robot
Variables   ../resources/API/constants.py

*** Variables ***

${bff_host}
${solicitar_abastecimento}


${abastecimento_file}      ${EXECDIR}/data/shellbox.json
${users_file}         ${EXECDIR}/data/users.json
${RESPONSE}

*** Keywords ***

solicito abastecimento
    ${base_url_abastecimento}    Catenate    SEPARATOR=    ${bff_host}    ${solicitar_abastecimento}
#Pegar Token
    # ${users_json}    Load Json From File    ${users_file}
    ${json}    Get Json Value    file_name=users
    ${token}    Set Variable    ${json['jwtToken'][0]}
    Set Suite Variable    ${token}

#Solicitar abastecimento
    ${json_abastecimento}   Get Json Value    file_name=shellbox


# Criar um novo objeto JSON com os campos obrigatórios
    ${json_body}    Create Dictionary    
    ...    bin=${json_abastecimento['dadosAbastecimento']['bin']}    
    ...    flagTitular=${json_abastecimento['dadosAbastecimento']['flagTitular']}    
    ...    latitude=${json_abastecimento['dadosAbastecimento']['latitude']}    
    ...    boxCode=${json_abastecimento['dadosAbastecimento']['boxCode']}    
    ...    finalCartao=${json_abastecimento['dadosAbastecimento']['finalCartao']}    
    ...    longitude=${json_abastecimento['dadosAbastecimento']['longitude']}


    
    # Converter o dicionário para uma string JSON usando json.dumps
    ${json_body_dict}    Evaluate    json.dumps(${json_body})    json

    ${headers}    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}
    Create Session    alias=shellbox       url=${base_url_abastecimento}    headers=${headers}    disable_warnings=1
    ${response}    POST On Session    alias=shellbox  url=${base_url_abastecimento}    headers=${headers}    data=${json_body_dict}    expected_status=200
    Log    ${response}

    Set Test Variable    ${RESPONSE}    ${response}

a resposta for 200
    Should Be Equal As Strings    ${RESPONSE}   <Response [200]>

o campo fuellinId deverá vir preenchido
    ${response_json}    Convert String To Json    ${RESPONSE.content}
    ${fuellingId}    Get Value From Json    ${response_json}    $.dados.fuellingId
    Should Not Be Empty    ${fuellingId}
    Set Json Value  file_name=shellbox   key=fuellingId    value=${fuellingId}


#### AUTORIZAR ABASTECIMENTO #######
informo o fuellingId correto
#URL da request
    ${base_url_autorizacao}    Catenate    SEPARATOR=    ${bff_host}    ${autorizar_abastecimento}

#Pegar token
    ${json}    Get Json Value    file_name=users
    ${token}    Set Variable    ${json['jwtToken'][0]}
    Set Suite Variable    ${token}

#Autorizar abastecimento
    ${json_autorizar_abastecimento}   Get Json Value    file_name=shellbox

# Criar um novo objeto JSON com os campos obrigatórios
    ${json_body}    Create Dictionary    
    ...    fuellingId=${json_autorizar_abastecimento['dadosAutorizacao']['fuellingId'][0]}    
    ...    produtoTelemetria=${json_autorizar_abastecimento['dadosAutorizacao']['produtoTelemetria']}

    # Converter o dicionário para uma string JSON usando json.dumps
    ${json_body_dict}    Evaluate    json.dumps(${json_body})    json

    ${headers}    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}
    Create Session    alias=shellbox       url=${base_url_autorizacao}    headers=${headers}    disable_warnings=1
    ${response}    POST On Session    alias=shellbox  url=${base_url_autorizacao}    headers=${headers}    data=${json_body_dict}    expected_status=204
    Log    ${response}

    Set Test Variable    ${RESPONSE}    ${response}

a resposta for 204
    Should Be Equal As Strings    ${RESPONSE}   <Response [204]>

o abastecimento foi autorizado com sucesso
    Log    message=O abastecimento foi autorizado ${response}