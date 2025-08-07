# Rinha 2025 - Payment Processing System

A high-performance payment processing system built with Go, featuring asynchronous payment processing, health monitoring, and load balancing capabilities.

- [rinha-de-backend-2025](https://github.com/Fuerback/rinha-2025)

- [LinkedIn Felipe Fuerback](https://www.linkedin.com/in/felipefuerback/)

- [LinkedIn Miguel Fontes](https://www.linkedin.com/in/miguelmfontes/)

## Architecture

The system follows a microservices architecture with the following components:

### Core Components

- **Go Application (4 instances)**: Main payment processing service built with Fiber framework
- **PostgreSQL Database**: Persistent storage for payments and health check data
- **Nginx Load Balancer**: Distributes traffic across application instances
- **External Payment Processors**: Default and fallback payment processing services

### System Design

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Client    │───▶│    Nginx    │───▶│ App Instance│
└─────────────┘    │Load Balancer│    │   (1-4)     │
                   └─────────────┘    └─────────────┘
                                             │
                                             ▼
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│  Payment    │◀───│ Worker Pool │◀───│ PostgreSQL  │
│ Processors  │    │(Async Queue)│    │  Database   │
└─────────────┘    └─────────────┘    └─────────────┘
```

### Key Features

- **Asynchronous Processing**: Payment requests are queued and processed by worker pools
- **Health Monitoring**: Continuous health checks with automatic failover between payment processors
- **Connection Pooling**: Optimized database connections (60 max open, 20 idle)
- **Load Balancing**: Nginx distributes requests across 4 application instances
- **Fault Tolerance**: Retry mechanisms with exponential backoff
- **Resource Constraints**: CPU and memory limits for optimal performance

### Database Schema

- **payments**: Stores payment records with correlation IDs, amounts, and processor info
- **health_check**: Tracks preferred payment processor and response times

## API Endpoints

### POST /payments

Creates a new payment request.

**Request Body:**
```json
{
  "correlationId": "string (required)",
  "amount": "decimal (required, > 0)"
}
```

**Response:**
- **201 Created**: Payment request accepted
```json
{
  "message": "Payment created"
}
```

**Example:**
```bash
curl -X POST http://localhost:9999/payments \
  -H "Content-Type: application/json" \
  -d '{
    "correlationId": "550e8400-e29b-41d4-a716-446655440000",
    "amount": "100.50"
  }'
```

### GET /payments-summary

Retrieves payment summary for a specified date range.

**Query Parameters:**
- `from`: Start date in RFC3339 format (required)
- `to`: End date in RFC3339 format (required)

**Response:**
- **200 OK**: Payment summary
```json
{
  "default": {
    "totalRequests": 150,
    "totalAmount": "15750.25"
  },
  "fallback": {
    "totalRequests": 25,
    "totalAmount": "2500.00"
  }
}
```

**Example:**
```bash
curl "http://localhost:9999/payments-summary?from=2025-01-01T00:00:00Z&to=2025-01-31T23:59:59Z"
```

## Tools

### Development Tools

- **Go 1.21+**: Primary programming language
- **Fiber v3**: High-performance web framework
- **PostgreSQL 15**: Database with Alpine Linux image
- **Docker & Docker Compose**: Containerization and orchestration
- **Nginx**: Load balancer and reverse proxy

### Dependencies

- `github.com/gofiber/fiber/v3`: Web framework
- `github.com/lib/pq`: PostgreSQL driver
- `github.com/shopspring/decimal`: Precise decimal arithmetic
- `github.com/joho/godotenv`: Environment variable management

### Deployment

- **Docker Compose**: Multi-service orchestration
- **GitHub Actions**: CI/CD pipeline (`.github/workflows/on-push-to-main.yml`)
- **Resource Limits**: 
  - App instances: 0.2 CPU, 40MB RAM each
  - Nginx: 0.2 CPU, 15MB RAM
  - PostgreSQL: 0.3 CPU, 148MB RAM

### Configuration

**Environment Variables:**
- `DATABASE_URL`: PostgreSQL connection string
- `PROCESSOR_DEFAULT_URL`: Default payment processor endpoint
- `PROCESSOR_FALLBACK_URL`: Fallback payment processor endpoint
- `WORKERS`: Number of worker goroutines (default: 3)
- `CLIENT_TIMEOUT`: HTTP client timeout in milliseconds (default: 500)

### Monitoring

- Health checks run every 5 seconds for PostgreSQL
- Worker pool statistics logged every 30 seconds
- Request timeouts set to 10 seconds for payment summaries
- Connection pool monitoring with 2-hour max lifetime