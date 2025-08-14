create table payment (
    correlationId uuid not null,
    amount decimal(15,2) not null,
    requestedAt timestamp not null
);

create index payment_requested_at on payment (requestedAt);
