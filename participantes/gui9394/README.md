# Rinha de Backend 2025 Q3

## Stack

### API

#### [Spring](https://spring.io/)

O Spring possui vários módulos que permitem expandir seus recursos.  
E também utilizei a integração com [GraalVM](https://www.graalvm.org/) para gerar uma imagem nativa para
o [Docker](https://www.docker.com/) que executa a API com menos recursos e inicializa mais rápido que a JVM.

**[Repositório](https://github.com/gui9394/RinhaDeBackend_2025Q3_API)**

### Banco de dados

#### [PostgreSQL](https://www.postgresql.org/)

Nunca tinha utilizado o PostgreSQL e foi uma boa oportunidade para testar já que e um banco e leve e muito poderoso.  
Utilizando alguns recursos foi possível diminuir o tempo para realizar consultas e armazenar novas transações.

### Load Balance

<img src="https://upload.wikimedia.org/wikipedia/commons/c/c5/Nginx_logo.svg" alt="logo nginx" width="auto" height="50">

#### [Nginx](https://www.nginx.com/)

O Nginx e um servidor HTTP e load balance muito leve, necessitando de pouquíssimos recursos para conseguir atender as
requisições.  
Com ele foi possível alocar mais recurso para o banco de dados e API.

## Paulo "gui9394" Silva

- [X.com](https://twitter.com/gui9394)
- [Github](https://github.com/gui9394)
- [LinkedIn](https://www.linkedin.com/in/gui9394)
