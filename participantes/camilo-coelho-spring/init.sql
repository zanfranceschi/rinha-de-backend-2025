CREATE UNLOGGED TABLE payments (
    id SERIAL PRIMARY KEY,
    correlationid UUID NOT NULL,
    amount DECIMAL NOT NULL,
    requested_at TIMESTAMP NOT NULL,
    payment_service VARCHAR(1) NOT NULL
);

CREATE UNLOGGED TABLE payment_queue (
    id SERIAL PRIMARY KEY,
    stored_data JSONB NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    queue_status VARCHAR(1) NOT NULL DEFAULT 'Q'
);


CREATE INDEX payments_requested_at ON payments (requested_at);
CREATE INDEX payments_payment_service ON payments (payment_service);
CREATE INDEX payment_queue_queue_status ON payment_queue (queue_status);
CREATE INDEX payments_correlationid ON payments (correlationid);
CREATE INDEX payment_queue_updated_at ON payment_queue (updated_at);