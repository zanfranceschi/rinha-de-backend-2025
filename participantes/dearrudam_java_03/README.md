<p align="center">
    <img src="https://quarkus.io/assets/images/brand/quarkus_logo_vertical_450px_default.png" alt="Quarkus" style="margin: 30px" width="200"/>
    <img src="http://www.jnosql.org/images/home_logo.png" alt="JNoSQL" style="margin: 30px" width="200"/>
</p>
<h1 align="center">Rinha de Backend 2025 - Submissão 03 - Maximillian Arruda</h1>

<div align="center">

  <img src="https://img.shields.io/badge/java-21-blue" alt="Java version" />

<!-- ci -->

  <a href="https://github.com/dearrudam/rinha-de-backend-2025-quarkus-jnosql-mongodb/actions/workflows/ci.yml">
    <img src="https://github.com/dearrudam/rinha-de-backend-2025-quarkus-jnosql-mongodb/actions/workflows/ci.yml/badge.svg" alt="ci" />
  </a>

<!-- cd -->

  <a href="https://github.com/dearrudam/rinha-de-backend-2025-quarkus-jnosql-mongodb/actions/workflows/cd.yml">
    <img src="https://github.com/dearrudam/rinha-de-backend-2025-quarkus-jnosql-mongodb/actions/workflows/cd.yml/badge.svg" alt="docker builds" />
  </a>

</div>

### Sobre essa implementação

Essa implementação utiliza o framework Quarkus, que é otimizado para Java e oferece suporte a desenvolvimento reativo, tornando-o ideal para aplicações de alta performance.

Como o intuito desse desafio foi de aprender e praticar o uso do Quarkus, essa implementação não utiliza apenas o modo reativo que o framework’ oferece, mas também utiliza **Virtual Threads** nos processamento, permitindo que a implementação siga um padrão imperativo, o que é mais natural para programadores Java, o que facilita na leitura e a execução de debug do código caso necessário.

Além disso, essa implementação utiliza o [Eclipse JNoSQL](https://github.com/eclipse-jnosql/jnosql), uma implementação referência da nova especificação Jakarta NoSQL - que está prevista pra entrar no [Jakarta EE 12](https://projects.eclipse.org/projects/ee4j.jakartaee-platform/releases/12/plan) - com o driver MongoDB para persistência dos dados em um banco NoSQL, o que facilita a escalabilidade e a flexibilidade do modelo de dados.

### Tecnologias Utilizadas

- **Language:** Java
- **Framework:** Quarkus / Eclipse JNoSQL
- **Database/Queue:** MongoDB
- **Load Balancer:** Nginx

### Source Code Repository

[https://github.com/dearrudam/rinha-de-backend-2025-quarkus-jnosql-mongodb](https://github.com/dearrudam/rinha-de-backend-2025-quarkus-jnosql-mongodb)