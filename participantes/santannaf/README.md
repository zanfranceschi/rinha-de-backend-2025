# 💸 Payments

Este projeto é um sistema de **pagamentos leves, resilientes e escaláveis**, construído com foco em performance e execução nativa com GraalVM. Ideal para ambientes com recursos limitados ou que exigem alto desempenho. 🧠⚡

---

## 🚀 Tecnologias Utilizadas

- ☕ **Java 24** — linguagem principal do backend
- 🧠 **GraalVM 24.0.1 Community** — compilação nativa com alta performance
- 🧊 **Redis** — persistência e cache
- 🌐 **Nginx** — balanceamento de carga entre instâncias
- 🐳 **Docker & Docker Compose** — para containerização e orquestração

---

## 🧱 Estrutura do Projeto
```
├── Dockerfile # Imagem com compilação nativa via GraalVM
├── build.gradle # Configuração Gradle com plugins do Spring e GraalVM
├── docker-compose.yml # Orquestração de serviços (API, Redis, NGINX)
├── nginx/
│ └── nginx.conf # Configuração do load balancer
└── src/
   └───main/
      └────java/santannaf/payments/...
```
---

## 🐳 Como subir o projeto com Docker

1. **Clone o repositório**:

```bash
git clone https://github.com/santannaf/payments.git
cd payments
```

2. **Suba todos os serviços com Docker Compose**:

```
docker compose up -d
```

Após subir:

NGINX estará acessível via http://localhost:9999
APIs rodam nas portas 30001 e 30002
Redis estará disponível localmente na porta 6379

## ⚙️ Compilação Nativa com GraalVM

O projeto usa GraalVM para gerar um binário nativo com alta desempenho e baixo consumo.

### 🧱 Dockerfile de build

```dockerfile
FROM ghcr.io/graalvm/graalvm-community:24 AS builder
WORKDIR /app

COPY . .

RUN chmod 777 ./gradlew && \
./gradlew clean build && \
./gradlew nativeCompile

FROM container-registry.oracle.com/os/oraclelinux:9-slim
COPY --from=builder /app/build/native/nativeCompile/payment /app/meuapp
RUN chmod 777 /app/meuapp
ENTRYPOINT ["/app/meuapp", "-Xmx148m"]
````

### ⚒️ build.gradle com GraalVM Native

```groovy 
plugins {
    id 'java'
    id 'org.springframework.boot' version '3.5.3'
    id 'io.spring.dependency-management' version '1.1.7'
    id 'org.graalvm.buildtools.native' version '0.10.6'
}

group = 'santannaf.payments'
version = '0.0.1'

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(24)
    }
}

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-data-redis'
    implementation 'redis.clients:jedis:6.0.0'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
    testRuntimeOnly 'org.junit.platform:junit-platform-launcher'
}

graalvmNative {
    binaries {
        main {
            imageName = "payment"
            mainClass = "santannaf.payments.payments.Application"
            configurationFileDirectories.from(file('src/main/resources/META-INF/native-image'))
            verbose = true
            debug = true
            buildArgs.addAll(
                    "-march=compatibility",
                    "--color=always",
                    "--enable-preview",
                    "--allow-incomplete-classpath",
                    "-J-Dfile.enconding=UTF-8"
            )
        }
    }
}
```

### 🧠 Redis
Utilizado para persistência leve e rápida. Está configurado com appendonly yes para garantir durabilidade.


### 🌐 NGINX como Load Balancer
Distribui as requisições entre as APIs api01 e api02 com limites de CPU/memória controlados:

api01: variável de ambiente DC_ENV=gt

api02: variável de ambiente DC_ENV=tb

Ambas se comunicam com Redis e têm configuração de fallback de processadores de pagamento.

### 📎 Link para o Código Fonte
🔗 Repositório completo:
https://github.com/santannaf/payments


### 👨‍💻 Autor
Thales Santanna
🔗 github.com/santannaf