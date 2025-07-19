CREATE TABLE IF NOT EXISTS payments (
    id SERIAL PRIMARY KEY,
    correlation_id UUID NOT NULL UNIQUE,
    amount NUMERIC(10, 2) NOT NULL,
    processor VARCHAR(10) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_payments_processor ON payments (processor);