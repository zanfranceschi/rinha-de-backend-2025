# Rinha de Backend 2025 - Submissão

## Tecnologias utilizadas
- **Linguagem:** Go
- **Armazenamento/Fila:** Redis
- **Balanceador:** Nginx
- **Orquestração:** Docker Compose

## Sobre a solução
Essa versão foi adaptada para:
- Usar Unix Sockets entre o Nginx e as APIs de backend.
- A API salva os bytes numa fila do Redis.
- Um Worker processa as mensagens da memoria para uma fila in memory (channel).
- O processamento é realizado no endpoint default somente caso esteja disponível.
- Os retries voltam para a fila in memory.
- A comunicação com Redis também está usando Unix Sockets.

## Repositório
[https://github.com/davidalecrim1/rinha-with-go-2025/tree/release/unix-sockets](https://github.com/davidalecrim1/rinha-with-go-2025/tree/release/unix-sockets)