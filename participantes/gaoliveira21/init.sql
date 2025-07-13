CREATE UNLOGGED TABLE payments_default (
  correlation_id UUID PRIMARY KEY,
  amount DECIMAL NOT NULL,
  requested_at TIMESTAMP NOT NULL
);

CREATE INDEX payments_default_requested_at ON payments_default (requested_at);

CREATE UNLOGGED TABLE payments_fallback (
  correlation_id UUID PRIMARY KEY,
  amount DECIMAL NOT NULL,
  requested_at TIMESTAMP NOT NULL
);

CREATE INDEX payments_fallback_requested_at ON payments_fallback (requested_at);

CREATE UNLOGGED TABLE failed_payments_queue (
  correlation_id UUID PRIMARY KEY,
  amount DECIMAL NOT NULL,
  requested_at TIMESTAMP NOT NULL
);
