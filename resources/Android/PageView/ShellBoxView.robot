*** Settings ***
Resource    baseMobile.robot

*** Variables ***
${lblTituloPreAbastecimento}    id=page_title
${inputCodigoAbastecimento}    id=input_wrapper
${lblMensagemPosAbastecimento}    id=title
${lblDescricaoPosAbastecimento}    id=description
${lblHelpMessageBomba}    id=help_message
${imgIconeErroGenerico}    id=failed_icon
${btnFechar}    id=close_button

#tela de animação do abastecimento
${btnVoltar}     id=nav_back_button
${lblTituloAbastecimento}     id=fueling_status
${imgIconeAbastecimento}     id=fueling_animation
${lblDescricaoAbastecimento}     id=fueling_description

#modal
${btnFecharModal}    id=negative_button_action
${btnTentarNovamenteModal}    id=positive_button_action

#abastecimento com sucesso
${lblValorAbastecimento}    id=payment_value
${lblTextoValorDoAbastecimento}    id=payment_label
${lblValorDesconto}    id=discount_value
${lblTextoDesconto}    id=discount_label



*** Keywords ***
o usuario realiza o abastecimento com ShellBox
    [Arguments]    ${codigoAbastecimento}
    Input Text Mobile Element  ${inputCodigoAbastecimento}   ${codigoAbastecimento}

o usuario volta para o menu
    Wait Until Mobile Element Is Visible    ${lblTituloAbastecimento}
    Click Mobile Element    ${btnVoltar}
    Sleep    3
    Click Mobile Element    ${btnTentarNovamenteModal} 
    Sleep    3
    Click Mobile Element    ${btnVoltar}
    Click Mobile Element    ${btnFecharModal}

deve ser exibida a mensagem de pagamento realizado
    Wait Until Mobile Element Is Visible     ${lblValorDesconto}
    Mobile Element Text Should Be    ${lblMensagemPosAbastecimento}    Pagamento realizado!
    Mobile Screenshot
    Sleep     5
    Click Mobile Element   ${btnFechar}
    Wait Until Mobile Element Is Visible     ${inputCodigoAbastecimento}
    Mobile Element Text Should Be    ${lblTituloPreAbastecimento}    	Abastecendo com Shell Box

deve ser retomado o abastecimento em andamento
    Mobile Element Text Should Be    ${lblTituloAbastecimento}    Consultando abastecimento…
    Wait Until Mobile Element Is Visible With Timeout     ${imgIconeErroGenerico}    600
    Mobile Element Text Should Be    ${lblMensagemPosAbastecimento}    Não foi possível confirmar o pagamento
    Mobile Screenshot
    Click Mobile Element    ${btnFechar}
    Wait Until Mobile Element Is Visible     ${inputCodigoAbastecimento}
    Mobile Element Text Should Be    ${lblTituloPreAbastecimento}    	Abastecendo com Shell Box

deve ser exibida a tela de erro no pagamento
    Wait Until Mobile Element Is Visible With Timeout     ${imgIconeErroGenerico}    600
    Mobile Element Text Should Be    ${lblMensagemPosAbastecimento}    Não foi possível confirmar o pagamento
    Mobile Screenshot
    Click Mobile Element    ${btnFechar}
    Wait Until Mobile Element Is Visible     ${inputCodigoAbastecimento}
    Mobile Element Text Should Be    ${lblTituloPreAbastecimento}    	Abastecendo com Shell Box

deve ser exibida a mensagem de bomba desativada
    Sleep    20
    Mobile Element Text Should Be    ${lblHelpMessageBomba}    Esta bomba está desativada. Solicite alguma ativa para uso.
    Mobile Screenshot
    Wait Until Mobile Element Is Visible     ${inputCodigoAbastecimento}
    Mobile Element Text Should Be    ${lblTituloPreAbastecimento}    	Abastecendo com Shell Box

deve ser exibida a mensagem de codigo invalido
    Sleep    20
    Mobile Element Text Should Be    ${lblHelpMessageBomba}    Código inválido. Digite novamente.
    Mobile Screenshot
    Wait Until Mobile Element Is Visible     ${inputCodigoAbastecimento}
    Mobile Element Text Should Be    ${lblTituloPreAbastecimento}    	Abastecendo com Shell Box

deve ser exibido o modal de erro genérico
    Wait Until Mobile Element Is Visible With Timeout    ${btnFecharModal}    180
    Mobile Element Text Should Be    ${lblMensagemPosAbastecimento}    Não foi possível carregar as informações
    Mobile Screenshot
    Click Mobile Element    ${btnTentarNovamenteModal}
    Wait Until Mobile Element Is Visible With Timeout   ${btnFecharModal}    180
    Mobile Element Text Should Be    ${lblMensagemPosAbastecimento}    Não foi possível carregar as informações
    Mobile Screenshot
    Click Mobile Element    ${btnFecharModal}
    Wait Until Mobile Element Is Visible     ${inputCodigoAbastecimento}
    Mobile Element Text Should Be    ${lblTituloPreAbastecimento}    	Abastecendo com Shell Box
    