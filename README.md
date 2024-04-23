# Automação BFF Shell Box

## Requisitos

### Passo 1: Clonando o repositório

- Abra o terminal e digite `git clone https://gitportoprd.portoseguro.brasil/expcliente/QA/porto-automation-api-integracoes-shellbox`

- Em seguida, dentro do VS Code abra a pasta do projeto clonado e siga os próximos passos.

⚠ OBS: Alinhar com o Tech Lead e com outro QE (se houver) sobre as branches que serão criadas para não haver conflito.

### Passo 2: Criação e ativação de um ambiente virtual

- Antes de executar os testes, crie um ambiente virtual (.venv). [Veja aqui](https://code.visualstudio.com/docs/python/environments) como criar um;

- Caso não seja inicializado de imediato o ambiente virtual, inicialize-o. A seguir, como inicializar para várias plataformas <sup>[1]</sup>:

    Um ambiente virtual pode ser “ativado” usando um script em seu diretório binário (`bin`  no POSIX;  `Scripts`  no Windows). Isso precederá esse diretório ao seu  `PATH`, de modo que a execução de  **python**  invoque o interpretador Python do ambiente e você possa executar os scripts instalados sem precisar usar o caminho completo. A invocação do script de ativação é específica da plataforma (`<venv>`  deve ser substituído pelo caminho para o diretório que contém o ambiente virtual):

| Plataforma | Shell | Comando para ativar o ambiente virtual |
|--|--|--|
| **POSIX** | bash/zsh | `$  source <venv>/bin/activate` |
|| fish | `$  source  <venv>/bin/activate.fish` |
|| csh/tcsh | `$  source <venv>/bin/activate.csh` |
|| PowerShell | `$  source <venv>/bin/activate.ps1` |
| **Windows** | cmd.exe | `C:\>  <venv>\Scripts\activate.bat` |
|| PowerShell | `PS C:\>  <venv>\Scripts\Activate.ps1` |

<sup> [1] </sup>Fonte: [Documentação Python](https://docs.python.org/pt-br/dev/library/venv.html)

### Passo 3: Instalação de bibliotecas necessárias

Instalar o arquivo Requirements.txt com todas as bibliotecas necessárias (`pip install -r requirements.txt`)

## Massas de testes

O arquivo de massas para realização dos testes é um arquivo YAML que pode ser encontrado [clicando aqui](https://portoseguro.atlassian.net/wiki/x/i4BMTg).
