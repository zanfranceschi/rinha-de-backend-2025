CREATE TYPE service_type AS ENUM('default', 'fallback');

CREATE TABLE IF NOT EXISTS payments (
    id SERIAL PRIMARY KEY,
    amount DECIMAL(10, 2) NOT NULL,
    requested_at TIMESTAMPTZ NOT NULL,
    service_used service_type NOT NULL,
    correlation_id UUID NOT NULL
);

CREATE INDEX CONCURRENTLY idx_payments_requested_at_service_used ON payments(requested_at, service_used);
CREATE UNIQUE INDEX CONCURRENTLY uq_correlation_id ON payments(correlation_id);
