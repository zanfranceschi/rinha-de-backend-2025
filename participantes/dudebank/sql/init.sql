DROP TABLE IF EXISTS payments;

CREATE TABLE IF NOT EXISTS payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  correlation_id UUID UNIQUE NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  processor VARCHAR(10) NOT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'pending',
  requested_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  processed_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()
);

DROP INDEX IF EXISTS idx_requested_at_processor;
CREATE INDEX IF NOT EXISTS idx_requested_at_processor ON payments(requested_at, processor);

DROP INDEX IF EXISTS idx_payments_summary_covering;
CREATE INDEX IF NOT EXISTS idx_payments_summary_covering ON payments(status, processor) 
INCLUDE (amount, requested_at) WHERE status = 'processed';