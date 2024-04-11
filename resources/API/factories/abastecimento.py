# Função em python para não precisar criar JSON, código limpo e fácil de realizar manutenção
import os
import json


arquivo_json = "payload_abastecimento.json"
diretorio_arquivo = "data"

"""
verifica_arquivo_dados_cartao()
Função que verifica a existência do diretório data e do arquivo payload_abastecimento
"""


def verifica_arquivo_dados_cartao():
    # Caminho para o diretório onde o arquivo deve estar
    diretorio = diretorio_arquivo
    # Nome do arquivo a ser verificado
    nome_arquivo = arquivo_json
    # Caminho completo para o arquivo
    caminho_arquivo = os.path.join(diretorio, nome_arquivo)

    # Verifica se o diretório existe, caso contrário, cria
    if not os.path.exists(diretorio):
        os.makedirs(diretorio)

    # Verifica se o arquivo existe, caso contrário, cria um arquivo com um objeto JSON vazio
    if not os.path.isfile(caminho_arquivo):
        # Se o arquivo não existir, cria o arquivo com os campos especificados
        dados = {
            'bin': '',
            'finalCartao': '',
            'flagTitular': '',
            'telemetriaAtiva': False,
            'statusBloqueio': ''
        }
        with open(caminho_arquivo, 'w') as f:
            json.dump(dados, f, indent=4)
        print(f"Arquivo {nome_arquivo} criado no diretório {diretorio}.")
    else:
        factory_abastecimento_validacao_token()
        print(f"Arquivo {nome_arquivo} já existe no diretório {diretorio}.")


"""
ler_dados_cartao()
Função que pega os dados do cartão do usuario logado
"""


def ler_dados_cartao():
    diretorio = diretorio_arquivo
    arquivo = arquivo_json
    caminho_completo = os.path.join(diretorio, arquivo)

    with open(caminho_completo, "r") as f:
        dados = json.load(f)

    return dados


"""
factory_abastecimento_validacao_token()
Função que envia os dados para a request de validação da bomba
"""


def factory_abastecimento_validacao_token():
    payload_abastecimento = ler_dados_cartao()
    abastecimento = {
        "latitude": "-7.963273",
        "longitude": "-34.8458601",
        "boxCode": "766601",
        "bin": payload_abastecimento["bin"],
        "finalCartao": payload_abastecimento["finalCartao"],
        "flagTitular": payload_abastecimento["flagTitular"],
        "telemetriaAtiva": payload_abastecimento["telemetriaAtiva"],
    }
    return abastecimento
