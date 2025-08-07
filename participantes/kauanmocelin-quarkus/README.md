# Rinha de Backend 2025 - Quarkus + MongoDB

Implementação do desafio [Rinha de Backend 2025](https://github.com/zanfranceschi/rinha-de-backend-2025) utilizando [Quarkus](https://quarkus.io/), compilação
nativa com GraalVM, Java 21 e MongoDB.

## 🔧 Tecnologias

- Java 21
- Quarkus 3
- MongoDB
- GraalVM (compilação nativa)
- Docker

## 🚀 Executar localmente

### Pré-requisitos

- Docker + Docker Compose
- Java 21
- `mvn` ou `./mvnw`

### Rodar com Quarkus em modo dev

```bash
./mvnw quarkus:dev
```

### ⚙️ Build Nativo

Para compilar a aplicação como binário nativo:

```bash
./mvnw clean package -Dnative -Dquarkus.native.container-build=true -DskipTests
```

