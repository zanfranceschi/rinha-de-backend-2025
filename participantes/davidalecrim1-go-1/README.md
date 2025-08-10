# Rinha de Backend 2025 - Submissão

## Tecnologias utilizadas
- **Linguagem:** Go
- **Armazenamento/Fila:** Redis
- **Balanceador:** Nginx
- **Orquestração:** Docker Compose

## Sobre a solução
O backend foi desenvolvido em Go usando o web framework Fiber com Sonic para encoding/decoding de JSON com ultra velocidade. Essa versão realiza apenas processamento no endpoint default para minimizar os custos do fallback. Caso o tempo de resposta esteja alto ou as API do Processor esteja indisponível, coloca para uma fila (Channel) de retry após um periodo apóx X milisegundos. O Redis é utilizado para armazenar/consultar o estado do último Health Check feito por uma Goroutine independente. Além de armazenar todas as transações que foram processadas pelo backend. No repositório abaixo tem mais detalhes da estratégia adotada.

## Repositório
[https://github.com/davidalecrim1/rinha-with-go-2025/tree/release/redis-default](https://github.com/davidalecrim1/rinha-with-go-2025/tree/release/redis-default)