## Rust + SQLite + Custom Load Balancer

Criei meu próprio loadbalancer distribuindo para dois serviços, os dois serviços praticamente não realizam trabalho nenhum, apenas repassam para o serviço onde está o banco de dados e o processamento das mensagens. Estou usando Unix Domain Sockets pra me comunicar entre os serviços diferentes.

Essa arquitetura não faz muito sentido em alguma aplicação real, fiz apenas para cumprir os requsitos do desafio e abaixar a latência o máximo possivel.

Código disponível em https://github.com/GDX64/rinha-de-backend2025-mine