-------------------------------------------
CREATE TABLE payments
(
  correlationId UUID PRIMARY KEY,
  amount        BIGINT,
  requestedAt   TIMESTAMP,
  fallback      BOOLEAN
);
-------------------------------------------
