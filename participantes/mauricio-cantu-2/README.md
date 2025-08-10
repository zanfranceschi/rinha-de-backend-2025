# Rinha Backend 2025 - Processador de Pagamentos

## Design
O projeto foi estruturado pensando em boas práticas de software aplicando conceitos de Clean Arch, SOLID e alguns Design Patterns, pensando principalmente em criar um código legível, "plugável", desacoplado das tecnologias, com injeção de dependências e abstrações. Não era requisito da rinha, mas quis fazer dessa forma para praticar alguns conceitos e também facilitar a troca de implementações entre as submissões a rinha.

## Arquitetura e Performance
Nos quesitos arquitetura e performance, foi implementado mensageria para processamento assíncrono dos pagamentos. Cada instância e serviço rodam em um container próprio para melhor visualização e gerenciamento dos recursos, como listado abaixo:

- NGINX: Porta de entrada da aplicação e load balancer para as instâncias da API.
- Payment API: API que recebe os pagamentos a serem processados e os enfileira.
- Payment Worker: Worker dedicado a consumir a fila e processar os pagamentos.
- Healthcheck Worker: Worker dedicado a verificar a disponibilidade dos processados externos (default e fallback) periodicamente.
- Redis: Armazenamento de baixa latência usado para gerenciar a fila e salvar os pagamentos processados.

## Tecnologias
Falando mais especificamente das tecnologias utilizadas, todos os serviços foram implementados em Node.js com Typescript. Tecnologias em destaque:
- BullMQ: Usado para o gerenciamento da fila e dos workers.
- Redis: Armazenamento de baixa latência usado para gerenciar a fila e salvar os pagamentos processados.
- Undici: Cliente HTTP baixo nível do próprio Node. Foi utilizado para criar um Pool de conexões HTTP usado ao longo da execução da aplicação, diminuindo o overhead de criar uma nova conexão a cada pagamento a ser processado.
- Docker: orquestração dos containers.

## Como rodar
`docker compose up --build` na raiz do projeto.
Projeto implementado especialmente para a rinha, então é necessário também seguir as [instruções](https://github.com/zanfranceschi/rinha-de-backend-2025/tree/main/rinha-test) da mesma.

## Repositório original
https://github.com/mauricio-cantu/rinha-backend-25
