CREATE UNLOGGED TABLE payments (
	id SERIAL PRIMARY KEY,
    correlationId UUID UNIQUE NOT NULL,
    amount DECIMAL NOT NULL,
    requested_at TIMESTAMP NOT NULL DEFAULT NOW(),
    service VARCHAR(8) NOT NULL
);

CREATE INDEX payments_service ON payments (service);
CREATE INDEX payments_requested_at ON payments (requested_at);