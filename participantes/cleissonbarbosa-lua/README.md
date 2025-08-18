# Rinha de Backend 2025 - Payment Gateway

## Overview

This project is a backend system for the "Rinha de Backend 2025" competition, built with **Lua**, OpenResty/nginx, and **Redis**. It acts as a payment gateway that intermediates payment requests to external payment processing services. The system must handle two payment processors - a primary service with lower fees and a fallback service with higher fees but better availability. The challenge involves maximizing profit by using the most cost-effective processor while maintaining system reliability and performance.

Key features:

- Payment processing intermediation with fee management
- Fallback mechanism for service resilience
- Payment summary reporting for auditing
- Health check monitoring for external services
- Performance optimization for competitive scoring

## Quick Start with Docker

### Prerequisites

- Docker
- Docker Compose

### Running the Application

1. Clone the repository:

```bash
git clone <repository-url>
cd rinha-backend-lua
```

2. Start all services:

```bash
docker-compose up --build
```

3. The application will be available at:

- **Main API**: http://localhost:9999
- **Health Check**: http://localhost:9999/health

### Available Endpoints

- `POST /payments` - Process payment requests
- `GET /payments-summary` - Get payment summary
- `POST /purge-payments` - Clear payment data
- `GET /health` - Health check

### Quick Build Script

For convenience, you can use the build script:

```bash
./build.sh
```

### Build & Deployment Options

#### Interactive Build Script

The build script provides multiple deployment options:

- Build Docker images locally
- Push to Docker Hub
- Push to GitHub Container Registry (ghcr.io)
- Start services locally with health validation
- Skip push for local development

#### Production Deployment

For production with pre-built images:

```bash
docker-compose -f docker-compose.production.yml up -d
```

#### Load Testing

Run comprehensive load tests with the provided script:

```bash
./load_test.sh
```

The load test includes:

- 350 concurrent payment requests across 3 phases
- Performance metrics (P95, P99 response times)
- Success rate analysis
- Redis queue monitoring
- Automatic statistics calculation

### System Requirements

- **Resource Limits**: Optimized for Rinha competition constraints
  - Total CPU: 1.5 cores (nginx: 0.1, app instances: 0.6 each, redis: 0.2)
  - Total Memory: 350MB (nginx: 20MB, app instances: 150MB each, redis: 30MB)
- **Networks**: Requires external `payment-processor` network for integration

## Configuration

### Environment Variables

The application supports the following environment variables:

- `REDIS_HOST`: Redis server hostname (default: "redis")
- `REDIS_PORT`: Redis server port (default: 6379)
- `INSTANCE_ID`: Application instance identifier (default: "app1")

### Redis Configuration

- **Memory Limit**: 25MB with LRU eviction policy
- **Persistence**: Disabled for performance (save "", appendonly no)
- **Connection Pool**: Optimized for high-throughput scenarios
- **Networking**: Configured for container environments

### Performance Tuning

- **nginx worker_connections**: 1024 per worker with epoll
- **Upstream keepalive**: 8 connections to payment processors, 32 for load balancer
- **Timeouts**: Optimized for sub-second response times
- **Memory optimization**: Hash and list configurations for minimal memory usage

## User Preferences

Preferred communication style: Simple, everyday language.

## System Architecture

### Technical Stack

- **OpenResty/nginx**: High-performance web server with Lua scripting
- **Lua**: Application logic and business rules
- **Redis**: In-memory data store for queues and caching
- **Docker**: Containerization and orchestration

### Service Components

- **Load Balancer (nginx)**: Routes requests to app instances using least_conn algorithm
- **Application Instances**: Dual instances (app1, app2) for high availability
- **Redis Server**: Centralized data store with optimized memory configuration
- **Health Monitor**: Background workers for service health monitoring
- **Payment Processor**: Asynchronous payment processing with queue management

### Core Design Pattern

The system implements a **Circuit Breaker and Fallback Pattern** to handle external service instabilities:

**Problem**: External payment processors experience instability and downtime, requiring robust error handling
**Solution**: Primary-fallback architecture with health monitoring and automatic failover
**Benefits**: Maintains service availability while optimizing costs through intelligent routing

### Service Layer Architecture

- **Payment Gateway Service**: Main orchestrator handling payment requests
- **Health Monitor Service**: Tracks availability of external payment processors
- **Fee Calculator Service**: Manages fee calculations for different processors
- **Summary Service**: Aggregates payment data for reporting

### Data Flow Strategy

1. **Payment Request Processing**:

   - Validate incoming payment requests
   - Check primary processor health
   - Route to appropriate processor based on availability and cost
   - Handle failures with fallback mechanisms

2. **Health Monitoring**:
   - Periodic health checks on external services
   - Circuit breaker state management
   - Intelligent routing decisions based on service status

### Error Handling Strategy

- **Retry Logic**: Exponential backoff for transient failures
- **Circuit Breaker**: Automatic failover when services become unreliable
- **Graceful Degradation**: Fallback to higher-cost processor when primary fails

### Performance Optimization

**Target**: Achieve sub-11ms p99 response times for performance bonus
**Approach**:

- Asynchronous processing where possible
- Connection pooling for external services
- Minimal serialization overhead
- Efficient data structures for summary calculations

## External Dependencies

### Payment Processors

- **Primary Payment Processor**: Lower fee rates, prone to instability
- **Fallback Payment Processor**: Higher fee rates, more reliable
- Both services provide:
  - `POST /payments` - Process payment requests
  - `GET /payments/service-health` - Health check endpoint

### Required Integrations

- **HTTP Client**: For communication with external payment processors
- **Health Monitoring**: Regular polling of service health endpoints
- **Error Tracking**: Monitor and log external service failures
- **Metrics Collection**: Track response times and success rates for performance optimization

### Data Storage

- **In-Memory Storage**: For payment summaries and health status caching
- **Persistent Storage**: May be required for audit trails and payment history (implementation dependent)

### API Endpoints to Implement

- `POST /payments` - Process payment requests with intelligent routing
- `GET /payments-summary` - Return aggregated payment data for auditing

## Development & Monitoring

### Health Checks

- **Application Health**: Built-in Docker health checks every 30s
- **Service Health**: Automatic monitoring of payment processor availability
- **Redis Monitoring**: Queue size and connection status tracking

### Logging & Debugging

- **nginx Access Logs**: Disabled for performance (access_log off)
- **Error Logs**: Warning level and above sent to stderr
- **Application Logs**: Lua-based logging for payment processing events

### Code Structure

```
app/lua/
├── init.lua              # Application initialization and configuration
├── payment_handler.lua   # Main payment processing endpoint
├── payment_processor.lua # Business logic for payment routing
├── health_monitor.lua    # Background health monitoring
├── summary_handler.lua   # Payment summary aggregation
├── purge_handler.lua     # Data cleanup operations
├── queue_manager.lua     # Redis queue management
└── utils.lua            # Utility functions
```

### Development Workflow

1. Modify Lua files in `app/lua/` directory
2. Rebuild with `./build.sh` or `docker-compose up --build`
3. Test with provided load testing script
4. Monitor performance with payment summary endpoint
5. Use purge endpoint to reset state during testing
