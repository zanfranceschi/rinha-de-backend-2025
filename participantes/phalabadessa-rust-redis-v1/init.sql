GRANT ALL PRIVILEGES ON DATABASE rinha_2025_db TO postgres;

CREATE UNLOGGED TABLE transactions (
    correlation_id uuid DEFAULT gen_random_uuid(),
    processed_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    amount bigint NOT NULL,
    service varchar(10) NOT NULL,
    PRIMARY KEY (correlation_id)
);