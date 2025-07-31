set max_parallel_workers_per_gather = 4;

CREATE UNLOGGED TABLE payments (
    correlation_id uuid primary key ,
    amount DECIMAL,
    processor int,
    requested_at TIMESTAMPTZ
);

CREATE INDEX payments_requested_at ON payments (requested_at);
