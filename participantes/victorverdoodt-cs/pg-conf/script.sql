CREATE UNLOGGED TABLE "Transactions" (
    "Id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "Amout" NUMERIC(18,2) NOT NULL,
    "requestedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
    "Gateway" INT NOT NULL
);

CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_transactions_gateway_requestedat
ON "Transactions" ("Gateway", "requestedAt");