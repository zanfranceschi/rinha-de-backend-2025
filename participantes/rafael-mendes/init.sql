ALTER SYSTEM SET fsync = 'off';
ALTER SYSTEM SET synchronous_commit = 'off';
ALTER SYSTEM SET full_page_writes = 'off';
ALTER SYSTEM SET logging_collector = 'off';
ALTER SYSTEM SET log_statement = 'none';
ALTER SYSTEM SET max_connections = 200;

CREATE UNLOGGED TABLE payments (
    id SERIAL PRIMARY KEY,
    correlation_id VARCHAR(255) NOT NULL,
    amount INT NOT NULL,
    requested_at TIMESTAMPTZ NOT NULL,
    default_server BOOLEAN NOT NULL
);

CREATE INDEX idx_payments_requested_at ON payments(requested_at DESC);
