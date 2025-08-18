## Tecnologias utilizadas

- **Linguagem:** Go
- **Balanceador:** Nginx
- **Orquestração:** Docker Compose, Docker
- **Armazenamento:** Postgresql
- **Fila:** Postgresql

## Sobre a solução
Sim, você não leu errado, foi utilizado o postgres como fila e armazenamento nessa solução. É um pouco doido mas no fim deu certo. O pulo do gato para transformar o postgres em uma fila tipo o redis é utilizar as cláusulas 'FOR UPDATE' e 'SKIP LOCKED' nas queries.
- FOR UPDATE: Basicamente é um lock de registro. Assim que é encontrado um valor na query, o banco faz um lock nele, evitando que outros workers manipulem o dado.
- SKIP LOCKED: Caso a query ache um registro bloqueado por uma outra query, ela pula e vai para o próximo registro válido que não esteja bloqueado. Isso ajuda bastante na performance e evita que os workers fiquem esperando até o registro seja desbloqueado.

Se você achou bacana, recomendo esse [vídeo](https://youtu.be/WIRy1Ws47ic?si=cVpo0q1g2rwye6N5) que me deu a ideia de implementar essa solução no DB.

REPO: https://github.com/JulioTsutsui/rinha-backend-2025
