# Rinha de Backend 2025 - Sistema de Intermediação de Pagamentos

**Autor:** Ricássio Costa
**Data:** Julho 2025  
**Versão:** 1.0

## Visão Geral

Este projeto implementa um backend para o desafio "Rinha de Backend 2025". O projeto foi desenvolvido em Python, utilizando práticas modernas de desenvolvimento assíncrono e integração com gateways de pagamento.

## Descrição

O sistema é responsável por processar pagamentos de forma resiliente, utilizando múltiplos gateways e realizando fallback automático em caso de falha.

## Arquitetura

![architecture](./docs/architecture.png)

## Recursos Alocados (docker-compose)

| Serviço       | CPUs | Memória |
| ------------- | ---- | ------- |
| nginx         | 0.1  | 16MB    |
| backend-api-1 | 0.1  | 64MB    |
| backend-api-2 | 0.1  | 64MB    |
| worker-light  | 0.3  | 48MB    |
| worker-heavy  | 0.7  | 80MB    |
| health-worker | 0.1  | 14MB    |
| redis         | 0.1  | 64MB    |
| **Total**     | 1.5  | 350MB   |

## Estrutura do Projeto

```
├── app/
│   ├── __init__.py
│   ├── config.py         # Configurações do sistema
│   ├── health_check.py   # Worker de healthcheck dos gateways
│   ├── main.py           # Ponto de entrada da API
│   ├── models.py         # Modelos de dados
│   ├── processor.py      # Processamento e envio de pagamentos
│   ├── queue.py          # Gerenciamento de filas
│   ├── storage.py        # Persistência de dados
│   └── worker.py         # Worker assíncrono para processamento
├── requirements.txt      # Dependências do projeto
├── Dockerfile            # Dockerização da aplicação
├── docker-compose.yml    # Orquestração de containers
├── nginx.conf            # Configuração do Nginx
└── LICENSE
```

## Como rodar o projeto

1. **Clone o repositório:**

   ```bash
   git clone <url-do-repositorio>
   cd backend-para-rinha-2025
   ```

2. **Configure as variáveis de ambiente:**

   - Edite o arquivo `.env` (se necessário) ou ajuste as variáveis diretamente no `docker-compose.yml`.

3. **Suba os containers:**

   ```bash
   docker-compose up --build
   ```

4. **Acesse a aplicação:**
   - Os endpoints estarão disponíveis conforme configurado no `docker-compose.yml`.

## Principais Funcionalidades

- Processamento resiliente de pagamentos
- Fallback automático entre gateways
- Healthcheck dos serviços integrados
- Estrutura modular e fácil de manter

## Tecnologias Utilizadas

- Python 3.12+
- httpx (requisições assíncronas)
- Docker & Docker Compose

## Scripts Úteis

- `docker-compose up --build` — Sobe a aplicação e dependências
- `docker-compose down` — Para e remove os containers

## Licença

Este projeto está licenciado sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

---

Desenvolvido para o desafio Rinha de Backend 2025 🚀
