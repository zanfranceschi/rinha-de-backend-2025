create unlogged table payments (
    correlation_id char(36) unique,
    amount decimal not null,
    payment_processor int not null,
    inserted_at timestamp not null
);

create index idx_payments_inserted_at on payments(inserted_at);

create unlogged table payment_processor_priority (
    payment_processor int not null,
    updated_at timestamp not null
);