CREATE UNLOGGED TABLE payments (
    correlation_id VARCHAR PRIMARY KEY,
    amount DECIMAL NOT NULL,
    requested_at TIMESTAMP NOT NULL,
    processor VARCHAR NOT NULL
);

CREATE INDEX payments_requested_at ON payments (requested_at);