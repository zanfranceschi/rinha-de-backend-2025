ALTER DATABASE rinha SET TIME ZONE 'UTC';
ALTER SYSTEM SET fsync = 'off';
ALTER SYSTEM SET synchronous_commit = 'off';
ALTER SYSTEM SET full_page_writes = 'off';
ALTER SYSTEM SET logging_collector = 'off';
ALTER SYSTEM SET log_statement = 'none';
ALTER SYSTEM SET max_connections = 200;

CREATE UNLOGGED TABLE public.payments (
    correlation_id UUID PRIMARY KEY,
    amount DECIMAL NOT NULL,
    handler varchar NOT NULL,
    created_at timestamp NOT NULL
);

CREATE UNLOGGED TABLE public.cache (
    processor varchar PRIMARY KEY,
    failing BOOLEAN NOT NULL,
    min_response_time INTEGER NOT NULL,
    last_update timestamp NOT NULL
);

INSERT INTO public.cache (processor, failing, min_response_time, last_update) VALUES('default', false, 0, now()),
                                                               ('fallback', false, 0, now());

CREATE INDEX payments_created_at ON public.payments (created_at);