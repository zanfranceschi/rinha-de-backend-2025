
CREATE UNLOGGED TABLE payments (
    correlationId UUID PRIMARY KEY,
    amount DECIMAL NOT NULL,
    requestedAt TIMESTAMP NOT NULL,
    processor VARCHAR(10) NOT NULL
);

CREATE INDEX payments_requested_at ON payments (requestedAt);
