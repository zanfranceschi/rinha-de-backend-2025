# Rinha de Backend 2025

O projeto foi desenvolvido em Go para simular um sistema de processamento de pagamentos de alta performance. Ele é conteinerizado usando Docker e Docker Compose, com Nginx atuando como um balanceador de carga para múltiplas instâncias da API e o gobreaker para gerenciar o circuit breaker.

- [rinha-de-backend-2025](https://github.com/franklaercio/rinha-de-backend-2025)

- [LinkedIn](https://www.linkedin.com/in/frank-laercio/)

## Tecnologias utilizadas

- **Linguagem de Programação**: Go
- **Balanceador de Carga**: Nginx
- **Banco de Dados**: PostgreSQL
- **Fila**: Redis
- **Docker**: Para conteinerização
- **Docker Compose**: Para orquestração de múltiplos containers
- **Resiliência**: Implementa um circuit breaker utilizando github.com/sony/gobreaker para chamadas a APIs externas.