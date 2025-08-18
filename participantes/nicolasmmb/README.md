# Rinha de Backend 2025 -  Go(Lang)

A submissão para a edição de 2025 da Rinha de Backend, desenvolvida em Go.

## Autor

-   **Nome:** pedreiro.de.software / Nicolas
-   **Social:**
    -   GitHub: [@nicolasmmb](https://github.com/nicolasmmb)
    -   LinkedIn: [nicolasmmb](https://www.linkedin.com/in/nicolasmmb)
-   **Repositório:** [nicolasmmb/go-rinha-backend-2025](https://github.com/nicolasmmb/go-rinha-backend-2025)

-   **Música tema:** [Descubra Clicando Aqui](https://www.youtube.com/watch?v=uAE6Il6OTcs&t=242s&ab_channel=AliceInChainsVEVO)

![Rooster in Chains](https://github.com/nicolasmmb/go-rinha-backend-2025/blob/main/docs/img.png?raw=true "Rooster in Chains")
---


## 🚀 Tecnologias Utilizadas

-   **Linguagem Principal:** Go
-   **Base de Dados:** Valkey (um fork do Redis)
-   **Balanceador de Carga:** HAProxy
-   **Outras Tecnologias:**
    -   "Gambiarra Otimizada" 😉

---

## 🏗️ Arquitetura

-   **`api-1` & `api-2`**: Duas instâncias da aplicação em Go executando em paralelo para garantir alta disponibilidade.
-   **`haproxy`**: Um balanceador de carga que distribui o tráfego de entrada entre as duas instâncias da API, utilizando uma estratégia de `roundrobin`.
-   **`mem-db`**: Uma instância do Valkey que atua como a nossa base de dados em memória, garantindo operações de leitura e escrita extremamente rápidas para os dados de pagamento.

A aplicação adota um padrão assíncrono. As requisições de pagamento são recebidas pela API, enfileiradas e processadas por um conjunto de *workers*. Enviando para processador principal (`default`) ou para o secundário (`fallback`), em busca de salvar os pagamentos da melhor forma possível.

---

## ⚙️ Endpoints da API

A API expõe os seguintes endpoints, acessíveis através do balanceador de carga na porta `9999`:

| Verbo  | Rota                  | Descrição                                                                                               |
| :----- | :-------------------- | :------------------------------------------------------------------------------------------------------ |
| `POST` | `/payments`           | Regista um novo pagamento. O corpo da requisição deve ser um JSON com `correlationId` (UUID) e `amount`. |
| `GET`  | `/payments-summary`   | Obtém um resumo dos pagamentos num intervalo de tempo. Requer os parâmetros de consulta `from` e `to` no formato RFC3339. |
| `GET`  | `/health`             | Verifica o estado de saúde da aplicação.                                                                |
| `GET`  | `/reset`              | **(Apenas para desenvolvimento)** Limpa todos os dados de pagamentos da base de dados.                   |


A API estará disponível em `http://localhost:9999`.

---

## 🔧 Configuração

A aplicação é configurada através de variáveis de ambiente. Um ficheiro de exemplo `.env.example` é fornecido no repositório.

| Variável                             | Descrição                                         |
| :----------------------------------- | :------------------------------------------------ |
| `SERVER_ADDR`                        | O endereço onde o servidor da API irá escutar.      |
| `SERVER_PORT`                        | A porta onde o servidor da API irá escutar.         |
| `REDIS_ADDR`                         | O endereço da instância do Valkey/Redis.          |
| `PAYMENT_PROCESSOR_URL_DEFAULT`      | A URL do serviço de processamento de pagamentos principal. |
| `PAYMENT_PROCESSOR_URL_FALLBACK`     | A URL do serviço de processamento de pagamentos de recurso. |
| `WORKER_POOL`                        | O número de *goroutines* a processar pagamentos.  |
| `PAYMENT_CHAN_SIZE`                  | O tamanho do *buffer* do canal para a fila de pagamentos. |
