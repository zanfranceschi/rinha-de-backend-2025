-- Create payments table with optimized structure for write performance
CREATE UNLOGGED TABLE IF NOT EXISTS payments (
    correlation_id UUID PRIMARY KEY,
    amount DECIMAL(10,2) NOT NULL,
    requested_at TIMESTAMPTZ NOT NULL,
    processor_type VARCHAR(10) NOT NULL
);

-- Create indexes for optimal query performance
-- This composite index perfectly supports the getPaymentSummary query:
-- - FILTER clauses on processor_type 
-- - WHERE clauses on requested_at
CREATE INDEX IF NOT EXISTS idx_payments_processor_type_requested_at ON payments (processor_type, requested_at);
