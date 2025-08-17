CREATE TABLE "tb_payment" (
    "correlation_id" VARCHAR(50) NOT NULL,
    "amount" decimal NOT NULL,
    "processor" INTEGER NOT NULL,
    "processor_at" timestamp NOT NULL
);

CREATE INDEX idx_tb_payment_processor_at_brin
ON tb_payment USING BRIN (processor_at);