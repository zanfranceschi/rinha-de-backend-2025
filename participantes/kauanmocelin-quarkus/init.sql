CREATE TABLE IF NOT EXISTS payments (
    correlation_id UUID NOT NULL,
    amount NUMERIC(19, 2) NOT NULL,
    requested_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    payment_processor_type VARCHAR(50),
    PRIMARY KEY (correlation_id)
    );

CREATE INDEX IF NOT EXISTS idx_payments_requested_at
    ON payments (requested_at);
