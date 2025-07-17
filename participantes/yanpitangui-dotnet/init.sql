CREATE UNLOGGED TABLE payments (
                          correlation_id UUID PRIMARY KEY,
                          amount DECIMAL NOT NULL,
                          processor TEXT NOT NULL,
                          requested_at TIMESTAMPTZ NOT NULL
);

create index CONCURRENTLY idx_requested_at_processor ON payments(requested_at, processor);