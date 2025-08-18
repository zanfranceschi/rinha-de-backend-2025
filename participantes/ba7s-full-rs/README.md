# Rinha de Backend 2025
Submissão feita por [Matheus Baptistella](www.linkedin.com/in/matheus-baptistella-458786226) em Rust. [Link](https://github.com/matheusbaptistella/backend-showdown-2025) para o código fonte.

# Features
- Server HTTP implementado em Rust.
    - Utiliza Tokio Async Runtime para spawnar tasks que ffazem o processamento das requisições.
    - Axum para receber as requiições HTTP.
    - Serde para (de)serializar os dados.
    - Reqwest para interagir com os payment processors.

- Custom in-memory database para cada instância do backend.
    - Incrementa o [mini-redis](https://github.com/tokio-rs/mini-redis) da Tokio para o use case da rinha.
    - Sync é feito apenas em get requests.
