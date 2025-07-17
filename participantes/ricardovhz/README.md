# 🐔 Rinha de Backend 2025

Implementação da Rinha de Backend 2025 utilizando **Go** com `fasthttp` e `duckdb` como storage.
Repositório do projeto: [https://github.com/ricardovhz/rinha-2025](https://github.com/ricardovhz/rinha-2025)

## 🔧 Tecnologias utilizadas

- **Linguagem**: Go 1.24
- **Servidor HTTP**: [fasthttp](https://github.com/valyala/fasthttp)
- **Persistência**: fasthttp server com embedded storage duckdb em memoria
- **Orquestração**: Docker + Docker Compose
- **Load Balancer**: NGINX

## 🧠 Estratégia

- Pool de workers para processamento paralelo (WORKERS_NUMBER ou 10 padrao)
- servidor HTTP para centralização da persistencia com duckdb
- Implementacao de backend seletor dos backends `default` e `fallback`, com
  watchdog a cada 5 segundos que verifica a saúde dos backends
