CREATE TABLE payment (
    id SERIAL PRIMARY KEY,
    correlation_id UUID NOT NULL,
    amount FLOAT NOT NULL,
    processor_type INT,
    requested_at TIMESTAMP
);

CREATE INDEX idx_payment_requested_at ON payment (requested_at);
