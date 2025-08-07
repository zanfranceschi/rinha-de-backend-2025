CREATE UNLOGGED TABLE payments (
    correlationId UUID PRIMARY KEY,
    amount DECIMAL NOT NULL,
    requested_at TIMESTAMP NOT NULL,
    processor VARCHAR(11)
);

CREATE INDEX payments_requested_at ON payments(requested_at)