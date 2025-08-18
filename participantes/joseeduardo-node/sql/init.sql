CREATE UNLOGGED TABLE payments (
    correlation_id UUID UNIQUE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_processor VARCHAR(10),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_payments_correlation_id ON payments (correlation_id);
