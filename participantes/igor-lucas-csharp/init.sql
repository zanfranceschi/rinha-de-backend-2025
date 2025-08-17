CREATE UNLOGGED TABLE payments (
                          CorrelationId UUID PRIMARY KEY,
                          Amount DECIMAL NOT NULL,
                          IsDefault BOOLEAN NOT NULL,
                          RequestedAt TIMESTAMP NOT NULL
);

create index CONCURRENTLY idx_requested_at_processor ON payments(RequestedAt, IsDefault);