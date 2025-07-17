DROP TABLE IF EXISTS payments;

CREATE TYPE processor AS ENUM ('default', 'fallback');

CREATE TABLE payments (
  id SERIAL PRIMARY KEY,
  correlation_id VARCHAR(255) NOT NULL,
  amount DOUBLE PRECISION NOT NULL,
  processed_at TIMESTAMP NOT NULL,
  processed_by processor NOT NULL
);

