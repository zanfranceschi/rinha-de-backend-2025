# RUST + MIO

Submissão feita inteiramente em Rust sem frameworks web ou runtime async.
Nunca fiz algo parecido antes e comecei a mexer nisso em 2/3 dias então os resultados são muito ruins.
Mio permite gerenciar as streams TCP sem bloquear usando uma pool. Outras crates são usadas para ajudar com coisas como comunicação com banco de dados, channels para comunicação entre threads e formatação de datas.

- Para executar é bem simples:
```
git clone https://github.com/ZillaZ/rinha2025-rust
docker compose up
```

### Agora veja a API dar timeout em tempo real :D (isso se o payment-processor não crashar)
