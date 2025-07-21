CREATE UNLOGGED TABLE payments(
  id UUID PRIMARY KEY,
  amount NUMERIC(38, 2) NOT NULL,
  requested_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  processor INTEGER DEFAULT 0
);

CREATE INDEX payments_requested_at ON payments (requested_at);