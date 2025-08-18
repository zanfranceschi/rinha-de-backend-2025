# 🏆 Rinha de Backend 2025

# Intermediador de pagamento

## 🚀 Tecnologias Utilizadas

- **Linguagem:** .NET 10-preview
- **Framework:** Minimal API
- **Banco de Dados:** PostgreSql
- **Servidor Web:** Kestrel
- **Load Balancer:** Nginx
- **Compilação Nativa:** .NET Native AOT

## Funcionamento

- As requisições são feitas para o servidor Nginx rodando na porta 9999, que atua como load balancer para duas instâncias de uma API escrita em .NET Minimal API em .NET 10.
- Os endpoints recebem as requisições de pagamento e colocam em uma fila implementada com o Redis (Valkey).
- Um Background Worker em .NET consome as mensagens da fila e encaminha para um dos dois gateways de pagamento (Default ou Fallback).
- Uma vez lançado no em um dos gateways de pagamento, o pagamento é persistido no banco de dados PostgreSQL.

Link do código fonte: [https://github.com/gldmelo/rinha-de-backend-2025](https://github.com/gldmelo/rinha-de-backend-2025)
