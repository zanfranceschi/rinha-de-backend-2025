CREATE TABLE IF NOT EXISTS payments (
    payment_id UUID PRIMARY KEY,
    amount DECIMAL(10, 2) NOT NULL,
    status INT NOT NULL,
    correlation_id UUID NOT NULL,
    requested_at TIMESTAMP NOT NULL, 
    processor INT
);

CREATE INDEX IF NOT EXISTS idx_payments_correlation_id ON payments(correlation_id);
CREATE INDEX IF NOT EXISTS idx_payments_status ON payments(status);
CREATE INDEX IF NOT EXISTS idx_payments_requested_at ON payments(requested_at);
CREATE INDEX IF NOT EXISTS idx_payments_created_processor ON payments(requested_at, processor);