CREATE UNLOGGED TABLE payments
(
    id             SERIAL PRIMARY KEY,
    correlation_id UUID UNIQUE NOT NULL,
    amount         DECIMAL     NOT NULL,
    requested_at   TIMESTAMP   NOT NULL DEFAULT NOW(),
    processor      SMALLINT    NOT NULL CHECK (processor IN (0, 1))
);

CREATE INDEX payments_processor_requested_at_idx ON payments (processor, requested_at);