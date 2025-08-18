CREATE TABLE IF NOT EXISTS payments (
    id SERIAL PRIMARY KEY,
    processor TEXT NOT NULL,
    amount NUMERIC(12,2) NOT NULL,
    requested_at TIMESTAMP NOT NULL
);
