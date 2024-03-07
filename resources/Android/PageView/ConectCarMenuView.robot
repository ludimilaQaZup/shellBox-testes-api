*** Settings ***
Resource    baseMobile.robot

*** Variables ***
${tagAtivacaoPendente}  xpath=(//android.widget.TextView[@resource-id="br.com.portoseguro.experienciacliente.mundoporto.hml:id/tag_status" and @text="Ativação pendente"])[1]
${btnVerMinhasTags}    id=see_my_tags_text
${btnFecharListaTags}    id=close_button
${btnPedirTag}    xpath=(//android.widget.TextView[@resource-id='br.com.portoseguro.experienciacliente.mundoporto.hml:id/tag_option_icon'])[1]
${btnAtivarTag}    xpath=(//android.widget.TextView[@resource-id='br.com.portoseguro.experienciacliente.mundoporto.hml:id/tag_option_icon'])[2]
${btnTrazerTagParaPorto}    xpath=(//android.widget.TextView[@resource-id='br.com.portoseguro.experienciacliente.mundoporto.hml:id/tag_option_icon'])[3]


${inputPlacaVeiculo}    id=edit_text
${lblTermosDeUso}    id=terms_link
${btnContinuar}    id=button


*** Keywords ***
seleciona uma tag com status Ativacao Pendente
    Click Mobile Element    ${tagAtivacaoPendente}

entra no fluxo de pedido de tag
    seleciona uma tag com status Ativacao Pendente
    Click Mobile Element    ${btnPedirTag}
