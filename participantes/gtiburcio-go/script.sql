set timezone TO 'UTC';
set max_parallel_workers_per_gather = 4;

create type payment_type as ENUM ('default', 'fallback');

create unlogged table payment (
	correlation_id UUID primary key,
	amount DECIMAL not null,
	type payment_type not null,
	requested_at timestamp not null default NOW()
);

create index idx_requested_at on payment using btree (requested_at);
