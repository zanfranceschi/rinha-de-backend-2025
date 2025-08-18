-- Initialize database schema for payments application
-- This script runs automatically when the PostgreSQL container starts

-- Create tables
CREATE TABLE IF NOT EXISTS payments (
    id SERIAL PRIMARY KEY,
    correlation_id VARCHAR(100) NOT NULL,
    channel VARCHAR(50) NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- Create indexes for efficient queries
CREATE INDEX IF NOT EXISTS idx_payments_created_at ON payments(created_at);
CREATE INDEX IF NOT EXISTS idx_payments_channel ON payments(channel);
CREATE INDEX IF NOT EXISTS idx_payments_correlation_id ON payments(correlation_id);

-- Grant permissions
GRANT ALL PRIVILEGES ON TABLE payments TO postgres;
GRANT USAGE, SELECT ON SEQUENCE payments_id_seq TO postgres;

-- Create test data (optional, comment out in production)
-- INSERT INTO payments (correlation_id, channel, amount, created_at) 
-- VALUES 
--     ('test-uuid-001', 'default', 100.50, NOW() - INTERVAL '1 hour'),
--     ('test-uuid-002', 'default', 200.75, NOW() - INTERVAL '30 minutes'),
--     ('test-uuid-003', 'fallback', 50.25, NOW() - INTERVAL '15 minutes');

-- Log completion
\echo 'Payment schema initialization completed successfully'
