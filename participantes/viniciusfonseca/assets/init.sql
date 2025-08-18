CREATE TABLE payments_default (
    id SERIAL,
    amount DECIMAL NOT NULL,
    requested_at TIMESTAMPTZ
)
WITH (
    timescaledb.hypertable,
    timescaledb.partition_column = 'requested_at'
);

CREATE TABLE payments_fallback (
    id SERIAL,
    amount DECIMAL NOT NULL,
    requested_at TIMESTAMPTZ
)
WITH (
    timescaledb.hypertable,
    timescaledb.partition_column = 'requested_at'
);

CREATE UNIQUE INDEX ON payments_default (id, requested_at);
CREATE UNIQUE INDEX ON payments_fallback (id, requested_at);