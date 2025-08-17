# Rinha Backend 2025 - Processador de Pagamentos

## Design
O projeto foi estruturado pensando em boas práticas de software aplicando conceitos de Clean Arch e alguns Design Patterns, pensando principalmente em criar um código legível, "plugável", com injeção de dependências e abstrações, no intuito de facilitar a troca de implementações e tecnologias externas entre as submissões para a rinha.

## Arquitetura e Performance
Nos quesitos arquitetura e performance, foi implementado "mensageria" in-memory por instância para processamento em lote e assíncrono dos pagamentos. para detalhes aprofundados da arquitetura, acesse o [repositório original](https://github.com/mauricio-cantu/rinha-backend-25).

## Tecnologias
Falando mais especificamente das tecnologias utilizadas, o servidor foi implementado em Node.js com Typescript. Demais tecnologias em destaque:
- NGINX: Porta de entrada da aplicação e load balancer para as instâncias da API.
- Redis: Armazenamento de baixa latência usado para cachear os health status dos processadores externos.
- Undici: Cliente HTTP baixo nível do próprio Node. Foi utilizado para criar um Pool de conexões HTTP usado ao longo da execução da aplicação, diminuindo o overhead de criar uma nova conexão a cada pagamento a ser processado.
- Docker: orquestração dos containers.

## Como rodar
`docker compose up --build` na raiz do projeto.
Projeto implementado especialmente para a rinha, então é necessário também seguir as [instruções](https://github.com/zanfranceschi/rinha-de-backend-2025/tree/main/rinha-test) da mesma.

## Repositório original
https://github.com/mauricio-cantu/rinha-backend-25
