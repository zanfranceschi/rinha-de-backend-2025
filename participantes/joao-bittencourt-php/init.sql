DROP TABLE IF EXISTS payments;

CREATE TABLE IF NOT EXISTS payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    correlation_id CHAR(36) UNIQUE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    processor VARCHAR(10) NOT NULL,
    requested_at TIMESTAMP(6) NOT NULL,
    processed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_requested_at_processor ON payments (requested_at, processor);

CREATE INDEX idx_processor ON payments (processor);