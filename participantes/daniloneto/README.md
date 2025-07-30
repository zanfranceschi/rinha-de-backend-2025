# Rinha de Backend 2025

Este projeto é uma implementação para a competição Rinha de Backend 2025 ( https://github.com/daniloneto/rinha-net-9 ).

Focado em obter performance implementando banco de dados próprio.

## Estrutura do Projeto

- **database/**: Serviço de banco de dados, implementado em .NET.
- **gateway/**: Serviço de gateway, responsável por orquestrar as requisições e comunicação entre serviços.
- **nginx.conf**: Configuração do proxy reverso NGINX.
- **docker-compose.yml**: Orquestração dos serviços via Docker Compose.

## Como Executar

```sh
docker-compose up --build
```

## Serviços

- **Gateway**: Recebe e processa as requisições HTTP, encaminhando para o serviço de banco de dados.
- **Database**: Gerencia o armazenamento e consulta dos dados.
- **NGINX**: Proxy reverso para balanceamento de carga e roteamento.

## Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

