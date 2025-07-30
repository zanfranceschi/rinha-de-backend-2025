CREATE TABLE payment_request
(
    Id            BIGSERIAL PRIMARY KEY,
    CorrelationId UUID UNIQUE    NOT NULL,
    Amount        NUMERIC(18, 2) NOT NULL,
    RequestedAt   TIMESTAMPTZ    NOT NULL,
    Source        VARCHAR(20)    NOT NULL
);