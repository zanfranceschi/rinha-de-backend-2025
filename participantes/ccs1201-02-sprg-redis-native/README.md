# Rinha de Backend 2025 - CCS1201

## Tecnologias utilizadas

- **Java 24**
- **Spring-boot 3.5.3**
- **Redis**
- **Nginx**
- **Docker**

## Como rodar

1. Suba o docker-compose dos Payment Processors primeiro (conforme instruções do repositório oficial).
2. Depois, suba este compose:
   ```sh
   docker compose up
   ```
3. O backend ficará disponível na porta **9999**.

## Como foi implementado

Receba o maior número de requisições possível e depois se vira maluco...

Brincadeiras a parte foi utilizada uma estratégia de envio para uma fila no PaymentProcessorClient
que conta com uma quantidade de workers configuráveis, após a resposta dos processadores o pagamento é adicionado
a uma fila para persistência no Redis que igualmente conta com uma quantidade de workers configurável, tentando com isso
manter todo o processo assíncrono e o mais eficiente possível.

## Repositório do código-fonte

[GitHub /ccs1201](https://github.com/ccs1201/rinha-backend-2025-spring-redis)