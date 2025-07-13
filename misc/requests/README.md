# Ferramentas de Teste para APIs

Arquivos de apoio para facilitar a configuração de ferramentas de teste para as APIs. Eles permitem testar endpoints rapidamente usando o Insomnia ou o VSCode com a extensão REST Client.

## Arquivos incluídos

### 1. `insomnia.yml`

Arquivo de exportação do [Insomnia](https://insomnia.rest/), contendo coleções pré-configuradas com requisições organizadas para testar a API e os processadores de pagamentos.

**Detalhes da exportação:**

- Version: Insomnia 11.3.0
- Build date: 10/07/2025
- OS: Windows_NT x64 10.0.19045
- Electron: 35.1.5
- Node: 22.14.0

### 2. `backend.http`

Arquivo compatível com [VSCode REST Client](https://marketplace.visualstudio.com/items?itemName=humao.rest-client). Contém requisições HTTP para testar os endpoints da API.

### 3. `payment-processor.http`

Também compatível com o REST Client. Contém requisições de um dos processador de pagamentos.

## Como usar

### Usando o Insomnia

1. Abra o Insomnia.
2. Vá em **Application > Preferences > Data > Import Data**.
3. Selecione o arquivo `insomnia.yml`.

### Usando o REST Client no VSCode

1. Instale a extensão “REST Client” no VSCode.
2. Abra os arquivos `.http`.
3. Clique em “Send Request” acima das requisições desejadas.
