# Rinha de Backend 2025 - Submissão

🔗 **Repositório:** [github.com/gabrielluizsf/rinha-backend-2025](https://github.com/gabrielluizsf/rinha-backend-2025)

## 🛠 Tecnologias Utilizadas

* **Linguagem & Framework:** [Go](https://go.dev/dl/) + [Fiber](https://github.com/gofiber/fiber)
* **Banco de Dados:** [Redis](https://redis.io/)
* **Balanceador de Carga:** [Nginx](https://nginx.org/)


## 🚀 Como Executar os Testes

1. **Suba os serviços** definidos no `docker-compose.yml` (para sistemas `amd64`) ou `docker-compose-arm64.yml` (para sistemas `arm64`), ambos localizados na pasta `payment-processor`. Siga as instruções da documentação oficial do repositório.

2. **Execute o backend** com o comando:

   ```sh
   docker compose up --build
   ```

   * A aplicação estará disponível na porta `9999`.

3. **Execute os testes de carga** utilizando o [K6](https://grafana.com/docs/k6/latest/set-up/install-k6/).

4. **Parar containers**:
    ```sh
    docker stop $(docker ps -q) 
    ```


