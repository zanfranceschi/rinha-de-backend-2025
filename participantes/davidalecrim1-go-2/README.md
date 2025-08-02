# Rinha de Backend 2025 - Submissão

## Tecnologias utilizadas
- **Linguagem:** Go
- **Armazenamento/Fila:** Redis/MongoDB
- **Balanceador:** Nginx
- **Orquestração:** Docker Compose

## Sobre a solução
O backend foi desenvolvido em Go usando o web framework Fiber com Sonic para encoding/decoding de JSON com ultra velocidade. Ele realiza o processamento de cada requisição de forma assincrona em uma Goroutine. Caso o tempo de resposta esteja alto ou as APIs do Processor estejam indisponíveis, coloca para uma fila (Channel) de retry após um periodo apóx X milisegundos. O Redis é utilizado para armazenar/consultar o estado do último Health Check feito por uma Goroutine independente. Nessa versão as transações são armazenadas no MongoDB em vez do Redis. No repositório abaixo tem mais detalhes da estratégia adotada. 

## Repositório
[https://github.com/davidalecrim1/rinha-with-go-2025](https://github.com/davidalecrim1/rinha-with-go-2025)