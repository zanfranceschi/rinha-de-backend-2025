create unlogged table payments (
    correlation_id varchar(36) primary key,
    amount decimal(15,2) not null,
    processed_at timestamp not null,
    default_processor boolean not null
);

create index idx_payments_def_proc_processed_at on payments(default_processor, processed_at);

