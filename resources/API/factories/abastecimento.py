
#Função em python para não precisar criar JSON, código limpo e fácil de realizar manutenção

def factory_abastecimento_validacao_token():
    abastecimento = {
        'latitude': '-7.963273',
        'longitude': '-34.8458601',
        'boxCode': '766601',
        'bin': '536537',
        'finalCartao': '4125',
        'flagTitular': 'S', 
        'telemetriaAtivo': 'false',
    }
    return abastecimento