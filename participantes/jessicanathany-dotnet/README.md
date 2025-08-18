# 🥊 Rinha de Backend 2025 - Submissão

Aplicação desenvolvida para participar da [*Rinha de Backend 2025*](https://github.com/zanfranceschi/rinha-de-backend-2025).

## Tecnologias Utilizadas

•⁠  ⁠*.NET* – Backend da aplicação (.NET 8)
•⁠  ⁠*PostgreSQL* – Banco de dados relacional
•⁠  ⁠*Nginx* – Balanceamento de carga e proxy reverso
•⁠  ⁠*Docker & Docker Compose* – Orquestração de containers

## ⚙️ Como executar aplicação

1.⁠ ⁠Clone este repositório:
   
⁠ bash
git https://github.com/JessicaNathany/rinha-de-backend-2025
 ⁠

2.⁠ ⁠Execute o docker compose oara rodar os serviços externos (payment-processor-default e payment-processor-default) caso não esteja inicializados:
  
⁠ bash
   cd external services
   docker compose up 
 ⁠   

3.⁠ ⁠Execute o docker-compose da aplicação, volte para raíz do projeto e execute o comando:

⁠ bash
   docker compose up 