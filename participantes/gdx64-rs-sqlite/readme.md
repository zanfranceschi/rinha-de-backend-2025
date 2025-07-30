## Rust + SQLite + HAProxy

Usei o HAProxy como load balancer distribuindo para dois serviços. Os serviços atendem as requests e enviam para um channel, onde uma tokio task consome as mensagens, tenta enviar para a API de procesamento e, caso tenha sucesso, spawna uma nova task para persistir no banco de dados SQLite in memory em um terceiro serviço.

Em princípio eu estava usando o nginx, mas no meu windows a performance era muito ruim no docker. Ele acabava introduzindo mais de 500ms de latência no teste. Com o HAProxy consegui em cerca de 7ms o p99. Talvez seja melhor em um linux nativo.

Código disponível em https://github.com/GDX64/rinha-de-backend-2025.