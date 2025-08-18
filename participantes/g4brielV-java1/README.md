# 🐓 Rinha de Backend 2025 - Java (Spring Boot) - Gabriel Vinícius

## 📌 Descrição

- **Fluxo 1 (sincrono)**: Recebe a requisição via `POST /payments` e enfileira como uma entidade.
- **Fluxo 2 (assíncrono)**: Processa a fila, tentando enviar o pagamento primeiro ao **Payment Processor Default**. Se falhar, tenta o **Payment Processor Fallback**. Após o sucesso, persiste a transação no banco PostgreSQL.

## ⚙️ Tecnologias Utilizadas
- Java 21
- Spring Boot
- JPA/Hibernate
- Flyway
- PostgreSQL 16
- Docker
- Nginx
- Maven

## 🚦 Recusos

| Serviço  | CPU | Memória |
| -------- | --- | ------- |
| nginx    | 0.1 | 10MB    |
| api1     | 0.5 | 150MB   |
| api2     | 0.5 | 150MB   |
| postgres | 0.4 | 40MB    |

## ▶️ Código fonte

https://github.com/G4brielV/Impl_Java_RinhaBackend2025




