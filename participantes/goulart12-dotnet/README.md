# Rinha de Backend 2025

## Estratégia

Utilizei uma arquitetura assíncrona aonde o /payments adiciona o processo de pagamento na fila e esse processo verifica a integridade dos processadores, utiliza o que estiver saudável e insere os dados no banco feito com Redis.

## Tecnologias

- **C#**
- **.NET 9**
- **Redis**
- **Nginx**

## Repositório

[GitHub](https://github.com/Goulart12/Rinha2025)