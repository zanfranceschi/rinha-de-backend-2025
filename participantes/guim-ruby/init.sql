CREATE TYPE processor AS ENUM ('default', 'fallback');

CREATE UNLOGGED TABLE payments (
    correlationId UUID PRIMARY KEY,
    amount DECIMAL NOT NULL,
    requested_at TIMESTAMP NOT NULL,
    p processor NOT NULL
);

CREATE INDEX payments_requested_at ON payments (requested_at);