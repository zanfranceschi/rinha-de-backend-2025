CREATE TABLE payments (
    "correlationid" UUID PRIMARY KEY,
    "amount" DECIMAL(18, 2) NOT NULL,
    "requestedat" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    "typeid" INT NOT NULL
);