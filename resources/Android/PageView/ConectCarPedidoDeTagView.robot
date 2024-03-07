*** Settings ***
Resource    baseMobile.robot

*** Variables ***

${btnFechar}    id=close
${btnVoltar}    id=back_button
${inputPlacaVeiculo}    id=edit_text
${lblTermosDeUso}    id=terms_link
${btnContinuar}    id=button

#Tela de enderecos
${btnReceberNesseEndereco}    id=conectcar_address_tag_button_confirm
${btnInformarNovoEndereco}    id=conectcar_address_tag_button_new_address
${componenteEnderecoCadastrado}    id=conectcar_address_tag_card_view

#Tela de forma de pagamento
${lblTextoPagamento}    id=title_payment
${btnSelecionarPrimeiroCartao}    xpath=(//android.widget.RadioButton[@resource-id='br.com.portoseguro.experienciacliente.mundoporto.hml:id/selected_checkbox'])[1]
${btnContinuarPagamento}    id=btn_continue_payment

#Tela de revisao do pedido
${lblTextoRevisaoPedido}    id=title_page
${btnEditarEndereco}    id=conectcar_address_card_edit_button
${btnConfirmarPedido}    id=conectcar_tag_review_button_confirm

#Tela de pedido realizado
${lblTituloSolicitacaoConcluida}    id=conectcar_tag_order_confirm_title
${lblTextoSolicitacaoConcluida}    id=conectcar_tag_order_confirm_subtitle
${btnFecharSolicitacaoConcluida}    id=conectcar_tag_order_confirm_button

*** Keywords ***
informa a placa
    [Arguments]    ${placa}
    Click Mobile Element    ${lblTermosDeUso}
    Mobile Screenshot
    Click Mobile Element    ${btnFechar}
    Input Text Mobile Element    ${inputPlacaVeiculo}    ${placa}
    Click Mobile Element    ${btnContinuar}

clica em receber nesse endereco
    Wait Until Element Is Visible    ${componenteEnderecoCadastrado}
    Element Should Be Visible    ${componenteEnderecoCadastrado}
    Click Mobile Element    ${btnReceberNesseEndereco}

seleciona forma de pagamento
    Wait Until Element Is Visible    ${lblTextoPagamento}
    Element Text Should Be    ${lblTextoPagamento}    Confirme a forma de pagamento para o uso da tag
    Click Mobile Element    ${btnSelecionarPrimeiroCartao}
    Click Mobile Element    ${btnContinuarPagamento}

confirma o pedido da tag
    Wait Until Element Is Visible    ${componenteEnderecoCadastrado}
    Element Should Be Visible    ${componenteEnderecoCadastrado}
    Element Text Should Be    ${lblTextoRevisaoPedido}    Só falta revisar seu pedido
    Click Element    ${btnConfirmarPedido}
    
deve ser exibida a confirmacao do pedido de tag
    Wait Until Element Is Visible    ${lblTituloSolicitacaoConcluida}
    Element Text Should Be    ${lblTituloSolicitacaoConcluida}    Solicitação concluída!
    Mobile Screenshot
    Click Element    ${btnFechar}

realiza o pedido de tag com um endereco ja cadastrado 
    [Arguments]    ${placa}
    informa a placa    ${placa}
    clica em receber nesse endereco
    seleciona forma de pagamento
    confirma o pedido da tag

