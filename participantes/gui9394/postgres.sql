ALTER SYSTEM SET max_connections = '300';
ALTER SYSTEM SET shared_buffers = '12800kB';
ALTER SYSTEM SET effective_cache_size = '38400kB';
ALTER SYSTEM SET maintenance_work_mem = '3200kB';
ALTER SYSTEM SET checkpoint_completion_target = '0.9';
ALTER SYSTEM SET wal_buffers = '384kB';
ALTER SYSTEM SET default_statistics_target = '100';
ALTER SYSTEM SET random_page_cost = '1.1';
ALTER SYSTEM SET effective_io_concurrency = '200';
ALTER SYSTEM SET work_mem = '64kB';
ALTER SYSTEM SET huge_pages = 'off';
ALTER SYSTEM SET min_wal_size = '2GB';
ALTER SYSTEM SET max_wal_size = '8GB';

CREATE TABLE payment (
	correlation_id    VARCHAR(36)       NOT NULL,
	amount            DOUBLE PRECISION  NOT NULL,
	requested_at      TIMESTAMPTZ,
	processor_id      VARCHAR(10),
	CONSTRAINT payment_pk  PRIMARY KEY (correlation_id)
);

CREATE INDEX CONCURRENTLY idx_summarize_payment ON payment (
    processor_id ASC,
    requested_at ASC
);
