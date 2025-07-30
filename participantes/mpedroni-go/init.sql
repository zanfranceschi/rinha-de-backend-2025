-- postgresql

CREATE UNLOGGED TABLE payments (
  correlation_id UUID PRIMARY KEY,
  amount INTEGER NOT NULL,
  status SMALLINT NOT NULL CHECK (status IN (0, 1, 2)), -- 0: pending, 1: paid, 2: failed
  processor SMALLINT NOT NULL CHECK (processor IN (0, 1)), -- 0: default, 1: fallback,
  received_at TIMESTAMP NOT NULL,
  paid_at TIMESTAMP
);