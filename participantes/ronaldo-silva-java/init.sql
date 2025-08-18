CREATE UNLOGGED TABLE TB_METRICS(
	metric_id SERIAL PRIMARY KEY NOT NULL,
	correlation_id VARCHAR NOT NULL,
	amount DECIMAL NOT NULl,
	processor VARCHAR NOT null,
 	requested_at TIMESTAMP NOT NULl
);

CREATE INDEX tb_metrics_requested_at_idx ON tb_metrics (requested_at);