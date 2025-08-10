## Arquitetura

Primeira thread:
Recebe chamadas http via IO não bloqueante, enfileira o pagamento e retorna o mais rápido possível.

Segunda thread:
Fica ouvindo a fila, faz as chamadas para o payment processor (e fallback) e armazena em disco os resultados.

Summary:
Le o mini-banco de ambas as instancias e devolve os resultados.