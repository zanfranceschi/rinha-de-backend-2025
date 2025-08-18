# Pit - Rinha de Backend 2025

A high-performance Elixir/Phoenix backend for the Rinha de Backend 2025 challenge, designed to process payments asynchronously with zero data inconsistencies and optimal resource usage.

## Technologies Used

- **Language**: Elixir 1.14
- **Framework**: Phoenix 1.7
- **Database**: PostgreSQL 17
- **In-Memory Storage**: ETS (Erlang Term Storage)
- **HTTP Client**: Finch
- **Load Balancer**: Nginx
- **Containerization**: Docker & Docker Compose
- **Process Management**: GenServer, DynamicSupervisor

## Architecture

- **Phoenix Framework**: Web framework for handling HTTP requests
- **PostgreSQL**: Primary database for payment storage and consistency
- **ETS**: In-memory storage for health check data (fast access)
- **GenServer Workers**: Asynchronous payment processing with retry logic
- **Nginx**: Load balancer with rate limiting and performance optimizations

## API Endpoints

### POST /payments

Accepts payment requests and queues them for processing.

**Request:**

```json
{
  "correlationId": "uuid-string",
  "amount": 102.5
}
```

**Response:** HTTP 202 (Accepted)

### GET /payments-summary

Returns payment summary with optional date filtering.

**Query Parameters:**

- `from`: ISO 8601 timestamp (optional)
- `to`: ISO 8601 timestamp (optional)

**Response:**

```json
{
  "default": {
    "totalRequests": 1000,
    "totalAmount": 100500.0
  },
  "fallback": {
    "totalRequests": 50,
    "totalAmount": 5025.0
  }
}
```

## Deployment

### Docker Compose

```bash
# With payment processors up by running this on payment processor dir
docker-compose up -d

# Start this backend
docker-compose up -d
```
