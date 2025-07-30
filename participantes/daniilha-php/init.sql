
CREATE  TABLE payments (
    "correlationId" UUID PRIMARY KEY,
    amount DECIMAL NOT NULL,
    processor VARCHAR(20)  DEFAULT 'unset',
    requested_at TIMESTAMP  DEFAULT CURRENT_TIMESTAMP,
	operation VARCHAR(20) DEFAULT 'incoming',
	daemon VARCHAR(20) DEFAULT 'unset'
);

CREATE  TABLE completed_payments (
    "correlationId" UUID PRIMARY KEY,
    amount DECIMAL NOT NULL,
    processor VARCHAR(20)  DEFAULT 'unset',
    requested_at TIMESTAMP  DEFAULT CURRENT_TIMESTAMP
);

CREATE  TABLE services (
    ds VARCHAR(20) PRIMARY KEY,
    failing INTEGER,
    rs_delay INTEGER,
    last_update INTEGER,
	lock BOOLEAN 
);

CREATE INDEX payments_requested_at ON payments (requested_at);

create role web_anon nologin;

grant usage on schema public to web_anon;
grant all on public.payments to web_anon;


CREATE OR REPLACE VIEW public.busy
AS SELECT * FROM payments WHERE operation LIKE 'busy' OR operation LIKE 'failed';