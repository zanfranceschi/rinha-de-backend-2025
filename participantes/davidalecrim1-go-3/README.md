# Rinha de Backend 2025 - Submissão

## Tecnologias utilizadas
- **Linguagem:** Go
- **Armazenamento/Fila:** Redis
- **Balanceador:** Nginx
- **Orquestração:** Docker Compose

## Como rodar
1. Suba o docker-compose dos Payment Processors primeiro (conforme instruções do repositório oficial).
2. Depois, suba este compose:
   ```sh
   docker compose up --build
   ```
3. O backend ficará disponível na porta **9999**.

## Sobre a solução
O backend foi desenvolvido em Go usando o web framework Fiber com Sonic para encoding/decoding de JSON com ultra velocidade. Ele realiza o processamento de cada requisição de forma assincrona em uma Goroutine. Caso o tempo de resposta esteja alto ou as APIs do Processor estejam indisponíveis, coloca para uma fila (Channel) de retry após um periodo apóx X milisegundos. O Redis é utilizado para armazenar/consultar o estado do último Health Check feito por uma Goroutine independente. Além de armazenar todas as transações que foram processadas pelo backend. No repositório abaixo tem mais detalhes da estratégia adotada.

Essa versão tem um algoritmo distinto das demais que realiza processamento apenas no endpoint default.

## Repositório
[https://github.com/davidalecrim1/rinha-with-go-2025/tree/feature/redis-only-default](https://github.com/davidalecrim1/rinha-with-go-2025/tree/feature/redis-only-default)