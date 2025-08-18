DROP TABLE IF EXISTS payments;

CREATE UNLOGGED TABLE payments (
    correlation_id UUID PRIMARY KEY,
    amount DECIMAL NOT NULL,
    processor VARCHAR(8) NOT NULL,
    requested_at TIMESTAMP NOT NULL
);

CREATE INDEX CONCURRENTLY payments_requested_at ON payments (requested_at, processor);
