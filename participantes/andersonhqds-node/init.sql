CREATE UNLOGGED TABLE IF NOT EXISTS payments (
    correlation_id uuid PRIMARY KEY,
    amount decimal(10, 2) NOT NULL,
    created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    payment_processor VARCHAR(10) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_payment_processor ON payments (payment_processor);
CREATE INDEX IF NOT EXISTS idx_created_at ON payments (created_at);