# Rinha

Projeto da rinha 2025: https://github.com/zanfranceschi/rinha-de-backend-2025

Repo: https://github.com/ogabriel/rinha-de-backend-2025-elixir/tree/plug

## Ideia do projeto

Usar o mínimo de dependências externas a não ser que elas tenham performance melhor que a que já existe em elixir

E também tentei fazer do jeito mais simples e com menos dor de cabeça possível

No final ficou isso, coisas nativas do elixir:
- `JSON` encoder e decoder
- `ETS` para armazenamento e cache
- `Task.Supervisor` para processamento assincrono das tasks que chamam o processor e
- `erpc` para conseguir dados do outro node
- `GensServer` para bater em cada um dos processor e definir qual deles é melhor naquele momento

Externas:
- `Finch` HTTP client com pool de conexões
- `Bandit` HTTP server mais rápido do elixir
- `Plugs` padrão de conexões

Também fiz manualmente benchmarks para quase todas essas tecnologias (perdi tempo demais nisso :sad:): https://github.com/ogabriel/benchmark-elixir/

## Versão alternativa

Essa é versão alternativa de outra implementação minha, a diferença é que essa é pão dura
