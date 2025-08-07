CREATE TABLE payments (
    correlation_id UUID PRIMARY KEY,
    amount INTEGER NOT NULL,
    payment_processor SMALLINT NOT NULL,
    requested_at TIMESTAMP NOT NULL
);

CREATE INDEX idx_payments_requested_at ON payments (requested_at);
CREATE INDEX idx_payments_requested_at_processor ON payments (requested_at, payment_processor);


CREATE UNLOGGED TABLE health_check (
    preferred_processor SMALLINT NOT NULL DEFAULT 0,
    min_response_time INT NOT NULL DEFAULT 0,
    last_checked_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO health_check (preferred_processor) VALUES (0);