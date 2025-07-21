# Rinha de Backend 2025 - C#

> Implementação da **Rinha de Backend 2025** em **C#** com foco em alta performance, uso eficiente de recursos e arquitetura assíncrona resiliente.

---

## Tecnologias Utilizadas

- **C#** - Linguagem
- **Redis** – como fila e cache
- **PostgreSQL** – persistência dos pagamentos
- **NGINX** – balanceador de carga
- **Docker Compose** – orquestração dos serviços

---

## Rodando o projeto localmente

### Pré-requisitos

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- Repositório clonado:
  
```bash
git clone https://github.com/leonardotomascostadasilva/rinha-de-backend-2025.git
cd rinha-de-backend-2025
```

### Subir os containers
```bash
docker compose up -d
```

> Isso irá levantar os seguintes serviços:
> PostgreSQL na porta 5432
> Redis na porta 6379
> NGINX na porta 9999
> rinhabackend01 na porta 8088
> rinhabackend02 na porta 8089


### Sobre a Arquitetura

- O projeto utiliza Redis como fila para envio e retry de pagamentos.

- Os pagamentos são salvos no PostgreSQL, e antes de inserir, é verificado via Redis se o correlationId já foi processado.
- Há dois workers:
    - Um para processamento inicial
    - Outro para retry de pagamentos com falha temporária

- Caso o processamento falhe com o provider principal, o sistema tenta automaticamente com o provider de fallback.

- O NGINX atua como balanceador entre duas instâncias do backend, garantindo distribuição de carga.

### Variáveis de Ambiente
As variáveis principais já estão configuradas no docker-compose.yml, incluindo:

- postgres-connection-string
- redis-connection-string
- payment-processor-default
- payment-processor-fallback

### Repositório do código
O código da aplicação backend em C# está disponível em:

- https://github.com/leonardotomascostadasilva/rinha-de-backend-2025-csharp