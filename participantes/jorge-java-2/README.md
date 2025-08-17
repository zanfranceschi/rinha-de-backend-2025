# Rinha de Backend 2025

API da Rinha de Backend 2025 desenvolvida em **Java com Spring Boot**, empacotada como imagem nativa com **GraalVM 24**.

🔗 [Acesse o código-fonte no GitHub](https://github.com/JorgeEduardoZanin/RinhaBackend-Java-2025)


## 🚀 Tecnologias

- **Java 21**
- **Spring Boot**
- **GraalVM 24 Native Image**
- **Docker & Docker Compose**
- **HAProxy** (load balancer)

---

## 🎯 Descrição

Este projeto é uma API REST, preparada para alta performance e inicialização rápida usando GraalVM Native Image. Em ambiente de container, utiliza Docker Compose para orquestração e HAProxy como balanceador de carga.

---

## 📦 Pré-requisitos

- Docker
- Docker Compose

---

## 🐳 Executando com Docker Compose

1. Clone este repositório:
   ```bash
   git clone https://github.com/seu-usuario/rinha-backend.git
   cd rinha-backend
   ```
2. Iniciar com Docker compose:  
   ```bash
   docker-compose up -d
   ```
  
   - `docker-compose.yml`: serviços básicos da aplicação e dependências.
   - `docker-compose-rinha.yml`: configurações específicas da rinha (HAProxy, redes, volumes).

---

## ⚙️ HAProxy

O HAProxy faz balanceamento de carga entre instâncias da API:

- Configuração: `haproxy.cfg`
- Serviço: `haproxy` no Docker Compose

