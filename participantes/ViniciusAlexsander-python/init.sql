CREATE TABLE IF NOT EXISTS payments (
    correlation_id UUID NOT NULL,
    amount NUMERIC NOT NULL,
    requested_at TIMESTAMPTZ NOT NULL,
    processor_type VARCHAR NOT NULL
);