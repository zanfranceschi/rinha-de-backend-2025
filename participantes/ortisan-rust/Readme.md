# Rinha de Backend 2025

A high-performance payment processing API built with Rust for the "Rinha de Backend 2025" challenge.

## Project Overview

This project implements a payment processing API using Rust with Actix Web framework, PostgreSQL for data storage, and Dragonfly (Redis-compatible) for caching. The application is containerized using Docker and can be deployed using Docker Compose.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/)
- [Rust](https://www.rust-lang.org/tools/install) (for local development)
- libpq (PostgreSQL client library)

## Installation

### Installing libpq

#### macOS

```bash
# Install libpq using Homebrew
brew install libpq

# Force link the libraries to make them available to the Rust compiler
brew link --force libpq
```

#### Ubuntu/Debian

```bash
# Install libpq development libraries
sudo apt-get update
sudo apt-get install -y libpq-dev
```

#### Windows

For Windows, it's recommended to use the PostgreSQL installer which includes libpq:
1. Download and install PostgreSQL from [postgresql.org](https://www.postgresql.org/download/windows/)
2. Make sure to add the PostgreSQL bin directory to your PATH

## Running the Application

### Using Docker Compose

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd rinha-de-backend-2025/participantes/ortisan-rust/payments_api
   ```

2. Start the services using Docker Compose:
   ```bash
   docker-compose up -d
   ```

   This will start:
   - PostgreSQL database
   - Dragonfly (Redis-compatible) cache
   - The API service (when uncommented in docker-compose.yml)
   - Nginx load balancer (when uncommented in docker-compose.yml)

3. Check if the services are running:
   ```bash
   docker-compose ps
   ```

4. Test if PostgreSQL is accessible:
   ```bash
   timeout 1 bash -c '</dev/tcp/localhost/5432 && echo PORT OPEN || echo PORT CLOSED'
   ```

### Running Locally (Development)

1. Set up the environment variables:
   ```bash
   export DATABASE_URL=postgres://postgres:postgres@localhost:5432/payments
   export RUST_LOG=debug
   ```

2. Start PostgreSQL and Dragonfly using Docker Compose:
   ```bash
   docker-compose up -d postgres dragonfly
   ```

3. Run the application:
   ```bash
   cargo run
   ```

## API Endpoints

### Create Payment

```
POST /payments/
```

Request body:
```json
{
    "correlationId": "2d7b3ed5-d08c-46b0-a063-c91a83dfadaa",
    "amount": 100.1
}
```

Response: HTTP 200 OK

## Testing

### Running the Stress Test

The project includes a k6 stress test script to evaluate the API's performance under load.

1. Install k6:
   ```bash
   # macOS
   brew install k6

   # Ubuntu/Debian
   sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D69
   echo "deb https://dl.k6.io/deb stable main" | sudo tee /etc/apt/sources.list.d/k6.list
   sudo apt-get update
   sudo apt-get install k6
   ```

2. Run the stress test:
   ```bash
   k6 run k6-stress-test.js
   ```

For more details about the stress test, see [k6-stress-test-README.md](k6-stress-test-README.md).

## Project Structure

- `src/` - Application source code
  - `application/` - Business logic and domain models
  - `infrastructure/` - Database and external service connections
  - `presentation/` - API endpoints and request/response handling
- `sql/` - SQL scripts for database initialization
- `docker-compose.yml` - Docker Compose configuration
- `Dockerfile` - Docker configuration for the API service

## Troubleshooting

### PostgreSQL Connection Issues

If you encounter issues connecting to PostgreSQL, check:
1. The PostgreSQL service is running: `docker-compose ps postgres`
2. The DATABASE_URL environment variable is correctly set
3. The libpq libraries are properly installed and linked

### Docker Compose Issues

If Docker Compose fails to start the services:
1. Check Docker logs: `docker-compose logs`
2. Ensure ports 5432 (PostgreSQL) and 6379 (Dragonfly) are not already in use
3. Try rebuilding the containers: `docker-compose up -d --build`