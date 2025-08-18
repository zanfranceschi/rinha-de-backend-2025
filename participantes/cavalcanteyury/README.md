# Firebrand
<img width="256" height="256" alt="firebrand" src="https://github.com/user-attachments/assets/29b41d11-0401-4449-8659-60a2d8d4bdf0" />

Uma contribuição modesta e com objetivo de estudos para Rinha de Backend 2025 em Ruby.

[Código Fonte](https://github.com/cavalcanteyury/firebrand)

## Stack

* Ruby 3.4.4 (Rack & Puma)
* Redis
* Nginx
* Docker

## Setup

Na raíz do projeto...
```bash
# Sobe os processadores da rinha
make processors.up

# Sobe a API
make firebrand.up

# Roda os testes no K6
make rinha.test
```
