CREATE TABLE IF NOT EXISTS payments (
    correlation_id TEXT NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,
    processor_id SMALLINT NOT NULL,
    created_at TIMESTAMP NOT NULL,
    PRIMARY KEY(correlation_id)
);
