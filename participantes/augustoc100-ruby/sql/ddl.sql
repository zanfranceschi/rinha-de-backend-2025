CREATE TABLE IF NOT EXISTS payments (
  id SERIAL PRIMARY KEY,
  correlation_id VARCHAR UNIQUE NOT NULL,
  amount FLOAT NOT NULL,
  processed_by VARCHAR NOT NULL,
  requested_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_indexes WHERE tablename = 'payments' AND indexname = 'idx_payments_requested_at_processed_by'
  ) THEN
    CREATE INDEX idx_payments_requested_at_processed_by ON payments (requested_at DESC, processed_by);
  END IF;
END$$;