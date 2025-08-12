CREATE UNLOGGED TABLE payments (
    correlationId UUID PRIMARY KEY,
    amount DECIMAL NOT NULL,
    payment_processor char(1) NOT NULL,
    requested_at TIMESTAMP NOT NULL
);

CREATE INDEX CONCURRENTLY payments_requested_by_processor ON payments (requested_at, payment_processor);
