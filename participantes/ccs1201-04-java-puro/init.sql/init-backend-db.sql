CREATE UNLOGGED TABLE IF NOT EXISTS payments
(
--     correlation_id UUID           NOT NULL,
    amount         DECIMAL(10, 2) NOT NULL,
    requested_at   BIGINT      NOT NULL,
    is_default     BOOLEAN        NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_payments_covering
    ON payments (requested_at)
    INCLUDE (is_default, amount);
