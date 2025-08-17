
CREATE TABLE IF NOT EXISTS payments (
	id serial primary key,
	correlation_id varchar(200) unique not null,
	amount numeric(12, 2) not null,
	requested_at timestamp default current_timestamp,
	status varchar(100) not null default 'QUEUED',
	processed_at timestamp,
	processor varchar(50)
);

CREATE INDEX IF NOT EXISTS idx_payments_status_requested_at
ON payments (status, requested_at ASC);

