# Rinha de Backend 2025 - PHP

PHP puro. Antes de tentar me aventurar em qualquer linguagem mais performática, procurei desenvolver uma solução com a linguagem que utilizo no dia-a-dia e sem utilizar frameworks ou muitas bibliotecas.

[Aqui](https://github.com/flads/rinha25-php) você pode acessar o código fonte do projeto.

#### Tecnologias utilizadas:

* [PHP](https://www.php.net/releases/8.4/en.php) - Linguagem de programação.
* [Redis](https://redis.io/) - Banco de dados em memória.
* [Nginx](https://nginx.org/) - Servidor web HTTP e load balancer.

#### Solução

A infraestrutura foi definida com **Docker Compose**, tendo à disposição **1,5 CPU** e **350MB de memória** para distribuir entre os serviços.  
A tabela abaixo mostra como os recursos foram alocados:

| Serviço   | CPU  | Memória |
|-----------|------|---------|
| **api-1** | 0.25 | 50MB    |
| **api-2** | 0.25 | 50MB    |
| **worker**| 0.55 | 205MB   |
| **nginx** | 0.15 | 15MB    |
| **redis** | 0.30 | 30MB    |
| **Total** | 1.50 | 350MB   |

#### Arquitetura dos Serviços

- **Nginx**: Responsável por receber as requisições HTTP e atuar como **load balancer**, distribuindo as solicitações entre as duas instâncias da API.
- **APIs (api-1 e api-2)**: Gerenciam as requisições de pagamento, enviando os dados para uma fila ordenada no Redis.
- **Worker**: Executa continuamente, consumindo a fila do Redis e processando os pagamentos, enviando requisições aos servidores externos de processamento.
- **Redis**: Banco de dados em memória utilizado como fila de mensagens para gerenciar os pagamentos de forma ordenada e eficiente.