-- init.sql

CREATE TABLE IF NOT EXISTS payments_to_send (
    id           TEXT PRIMARY KEY,
    amount       DOUBLE PRECISION NOT NULL,
    requested_at TIMESTAMP WITH TIME ZONE NOT NULL,
    is_default   BOOLEAN NOT NULL DEFAULT false
);

CREATE INDEX IF NOT EXISTS idx_payments_to_send_requested_at ON payments_to_send (requested_at);


DELETE FROM payments_to_send;