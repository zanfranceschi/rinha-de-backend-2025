CREATE TABLE IF NOT EXISTS payments (
    id SERIAL PRIMARY KEY,
    correlation_id VARCHAR(36) UNIQUE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    processor VARCHAR(20) NOT NULL,
    processed_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_payments_processor ON payments(processor);
CREATE INDEX IF NOT EXISTS idx_payments_processed_at ON payments(processed_at);
CREATE INDEX IF NOT EXISTS idx_payments_correlation_id ON payments(correlation_id);

CREATE INDEX IF NOT EXISTS idx_payments_processor_processed_at ON payments(processor, processed_at);