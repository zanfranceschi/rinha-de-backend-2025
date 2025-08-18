DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions (
    id UUID PRIMARY KEY,
    amount NUMERIC NOT NULL,
    requested_at TIMESTAMPTZ NOT NULL,
    processor_type TEXT CHECK (processor_type IN ('default', 'fallback'))
);