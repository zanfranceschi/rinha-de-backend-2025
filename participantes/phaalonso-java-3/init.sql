create unlogged table payment (
    correlationId uuid not null,
    amount decimal(15,2) not null,
    requestedAt timestamp not null
);

create index idx_payment_requested_at
    on payment (requestedAt) include (amount)
