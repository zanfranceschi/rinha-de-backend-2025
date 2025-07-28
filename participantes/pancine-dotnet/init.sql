CREATE UNLOGGED TABLE purchase (
    id char(36) PRIMARY KEY,
    requested_at TIMESTAMP WITH TIME ZONE NOT NULL,
    payment_gateway_used INT NOT NULL,
    amount DECIMAL NOT NULL
);

CREATE INDEX purchase_rapgu_idx ON purchase (requested_at, payment_gateway_used);
