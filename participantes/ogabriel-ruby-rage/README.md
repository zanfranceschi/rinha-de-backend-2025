# Rinha

Código fonte: https://github.com/ogabriel/rinha-de-backend-2025-ruby/tree/rage

Versão em ruby, eu sei q não ia sair perfeita, mas queria testar novas tecnologias

usa:
- `rage` como webserver que usa `iodine` e `fibers`
- `sequel` como interface com o database
- `sqlite` em memória para armazenamento de dados e o cache do cron
- cron manual escrito em ruby para ver a saude dos processors

O maior problema dessa minha implementação é q tem um bottleneck de CPU bem alto pq não tenho uma solução própria de worker, apenas usando `fibers`
