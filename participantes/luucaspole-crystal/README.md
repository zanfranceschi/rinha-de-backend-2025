# Rinha 2025 - Crystal Version

A high-performance payment processing system built with Crystal, featuring circuit breaker pattern for resilient external API calls.

## Architecture

- **HTTP Server**: Handles payment creation and summary endpoints using Kemal
- **Consumer**: Listnes to LMQ and batch inserts into SQL
- **Circuit Breaker**: Shared State using pooling and fanout exchanges

## Dependencies

- **Kemal**: HTTP server framework
- **Cryomongo**: MongoDB driver for Crystal
- **Circuit Breaker**: Resilient external API calls
