# Rinha de Backend 2025 - Submissão

## Tecnologias utilizadas
- **Linguagem:** Go
- **Armazenamento/Fila:** Redis
- **Balanceador:** Nginx
- **Orquestração:** Docker Compose, Docker

## Como rodar
1. Suba o docker-compose dos Payment Processors primeiro (conforme instruções do repositório oficial).
2. Depois, suba este compose:
   ```sh
   docker compose up --build
   ```
3. O backend ficará disponível na porta **9999**.

## Sobre a solução
Meu backend foi desenvolvido completamente em Go, utilizando o standard library para lidar com o HTTP. Criei uma worker pool que consome os pagamentos que são acessados via uma fila do redis. Ao fazer o dequeue do pagamento, o worker envia para o processor que está saúdavel, que foi verificado por um CRON que roda a cada 5 segundos procurando entender o estado dos processors. Ao confirmar que o payment foi recebido pelo processor. salvamos num HSET do redis, e o payment é considerado concluído, evitando inconsistencias.

Aprendi muito sobre worker pools, concorrencia e a importancia de filas para lidar com tarefas assíncronas. A solução é escalável, pois novos workers podem ser adicionados facilmente, e o sistema é resiliente a falhas de processors, já que os pagamentos são reprocessados também.

## Repositório
[https://github.com/artschur/rinha-de-backend-source-code](https://github.com/artschur/rinha-de-backend-source-code)
