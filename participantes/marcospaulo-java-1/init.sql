CREATE UNLOGGED TABLE payments (
    correlation_id UUID PRIMARY KEY,
    amount DECIMAL NOT NULL,
    requested_at TIMESTAMP NOT NULL,
    processed_at_default BOOLEAN NOT NULL DEFAULT true
);

CREATE INDEX payments_requested_at_processed_default ON payments (requested_at, processed_at_default);
