
Repo https://github.com/Wanderson98/Rinha-2025

## Tecnologias Utilizadas

* **Linguagem/Framework:** .NET 9 (C# 13)
    * ASP.NET Core Minimal APIs para o frontend (API)
    * .NET Generic Host para o backend (Worker)
* **Base de Dados:** PostgreSQL 16
* **Acesso à Base de Dados:** Dapper
* **Cache / Fila de Mensagens:** Redis
* **Load Balancer:** Nginx
* **Containerização:** Docker 

## Arquitetura

A arquitetura foi desenhada para ser altamente performática e resiliente, desacoplando o recebimento das requisições do seu processamento.

O fluxo de uma transação é o seguinte:

`Cliente -> Nginx -> (API 1 ou API 2) -> Fila (Redis) -> (Worker 1 ou Worker 2) -> Processadores de Pagamento & Base de Dados (PostgreSQL)`

1.  **Nginx:** Atua como Load Balancer, a distribuir as requisições HTTP entre duas instâncias da API na porta `9999`.
2.  **API (.NET Minimal API):** Uma API extremamente leve e rápida. A sua única responsabilidade é validar a requisição, colocá-la numa fila no Redis e retornar `200 OK` o mais rápido possível.
3.  **Redis:** Atua como um message broker. A fila `pagamentos` garante que nenhuma requisição seja perdida, mesmo que os workers estejam ocupados.
4.  **Worker (.NET Background Service):** Duas instâncias de workers consomem a fila do Redis em paralelo para processar os pagamentos. É aqui que toda a lógica de negócio complexa reside.
5.  **PostgreSQL:** Armazena o resultado de cada transação processada. Foi otimizado com flags de "modo benchmark" para máxima performance de escrita.

