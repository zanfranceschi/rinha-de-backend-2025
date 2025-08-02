CREATE TABLE payments (
  id SERIAL PRIMARY KEY,
  correlation_id TEXT NOT NULL,
  amount NUMERIC NOT NULL,
  origin INT NOT NULL,
  requested_at TIMESTAMPTZ NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_payments_requested_at_origin ON payments (requested_at, origin);