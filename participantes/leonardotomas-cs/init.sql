
CREATE TABLE payments (
    correlationId UUID PRIMARY KEY,
    amount DECIMAL NOT NULL,
    processor VARCHAR(50) NOT NULL,
    requested_at TIMESTAMP NOT NULL
);

CREATE INDEX idx_payments_requested_at_processor ON payments (requested_at, processor);
