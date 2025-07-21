CREATE UNLOGGED TABLE "Transactions" (
    "Id" BIGSERIAL PRIMARY KEY,
    "CorrelationId" UUID NOT NULL UNIQUE,
    "Amount" DECIMAL NOT NULL,
    "requestedAt" TIMESTAMP NOT NULL,
    "Gateway" SMALLINT NOT NULL,
    "Status" SMALLINT NOT NULL DEFAULT 0
);

CREATE INDEX IX_Transactions_Summary_Optimal
ON "Transactions" ("Gateway", "requestedAt")
INCLUDE ("Amount")
WHERE "Status" = 1;    

CREATE INDEX IX_Transactions_CorrelationId ON "Transactions" ("CorrelationId");