CREATE UNLOGGED TABLE payments (
    correlation_id UUID PRIMARY KEY,
    amount        DECIMAL NOT NULL,
    requested_at   TIMESTAMP NOT NULL,
    status        SMALLINT NOT NULL,
    processor     SMALLINT
);

CREATE INDEX requested_at_idx ON payments (requested_at);
CREATE INDEX status_idx ON payments (status);