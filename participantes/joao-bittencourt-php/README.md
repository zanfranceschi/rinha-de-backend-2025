---

# Rinha de Backend 2025 - Submissão

Este projeto apresenta uma solução para a Rinha de Backend 2025, utilizando um conjunto robusto de tecnologias para garantir desempenho e escalabilidade.

---

## 🛠️ Tecnologias Utilizadas

* **Linguagem**: **PHP**
* **Banco de Dados**: **MySQL 8.0.36**
* **Balanceador**: **Nginx**
* **Orquestração**: **Docker Compose**, **Docker**

---

## 🚀 Como Rodar

Para iniciar o projeto, siga os passos abaixo:

1.  **Suba o `docker-compose` dos Payment Processors primeiro** (conforme instruções do repositório oficial da Rinha de Backend 2025, caso aplicável para a sua configuração).
2.  **Em seguida, suba este compose**:

    ```bash
    docker compose up
    ```

O backend estará disponível na porta **`9999`**.

---

## 💡 Sobre a Solução

A solução foi desenvolvida utilizando **PHP** para as aplicações (`app1` e `app2`), que rodam de forma otimizada para lidar com um alto volume de requisições (foi imprementada a solução mais simples possivel). O **Nginx**  como um **proxy reverso e balanceador de carga**, distribuindo as requisições entre as duas instâncias da aplicação PHP.

O **MySQL** na versão `8.0.36` é utilizado como banco de dados principal.

---

## 🔗 Repositório

O código-fonte deste projeto pode ser encontrado em:

[https://github.com/joao-bittencourt/rinha-de-backend-2025-php](https://github.com/joao-bittencourt/rinha-de-backend-2025-php)