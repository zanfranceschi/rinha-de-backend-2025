Node.js com Typescript

- Foi usado uma instancia como memorydb (sqlite in-memory) (com http module);
- API usando http module com Unix Socket; 
- Pub/Sub com zeromq via ipc unix socket (baixo overhead); 
- HAProxy como lb se comunicando via unix socket com os dois backend;

Link do repo: https://github.com/Chr1s0Blood/rinha-de-backend-2025-node (http-module branch)