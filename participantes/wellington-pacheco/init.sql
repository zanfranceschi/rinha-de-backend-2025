CREATE TABLE IF NOT EXISTS payment_services (
    name TEXT PRIMARY KEY,
    failing BOOLEAN,
    delay INTEGER
);

DELETE FROM payment_services;

INSERT INTO payment_services (name, failing, delay)
VALUES
    ('default', FALSE, 0),
    ('fallback', FALSE, 0);

CREATE TABLE IF NOT EXISTS payments (
    correlation_id UUID PRIMARY KEY,
    amount DECIMAL,
    service_name TEXT,
    inserted_at TIMESTAMP WITH TIME ZONE
);

DELETE FROM payments;