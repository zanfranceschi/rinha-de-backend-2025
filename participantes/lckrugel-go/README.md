# Rinha de backend 2025 - Go

## Tecnologias

- **Go** - Linguagem
- **Gin** - Framework web http
- **Redis** - Armazenamento e stream de processamento
- **Nginx** - Load balancer

## Estratégia

Responder o mais rápido possível às requisições de pagamento enfileirando os pagamentos para **processar de forma assíncrona**.

Fazer o processamento sem erros ou inconsistências **para evitar multas**.

Armazenar pagamentos processados em um **Set ordenado pela timestamp no Redis** para facilicar a busca para sumarizar.

## Repositório

[lckrugel/rinha-backend-25](https://github.com/lckrugel/rinha-backend-25)
