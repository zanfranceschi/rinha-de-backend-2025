DROP TABLE IF EXISTS payments;

CREATE TABLE IF NOT EXISTS payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    amount DECIMAL(10,2) NOT NULL,
    processor VARCHAR(10) NOT NULL,
    requested_at TIMESTAMP(6) NOT NULL
);

CREATE INDEX idx_requested_at_processor ON payments (requested_at, processor);

CREATE INDEX idx_processor ON payments (processor);