CREATE TABLE IF NOT EXISTS payments (
    correlation_id VARCHAR(255) PRIMARY KEY,
    amount NUMERIC(10, 2) NOT NULL,
    processed_by VARCHAR(20),
    processed_at TIMESTAMP
);