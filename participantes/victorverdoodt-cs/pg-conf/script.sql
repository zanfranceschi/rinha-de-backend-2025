CREATE UNLOGGED TABLE "Transactions" (
    "Id" UUID PRIMARY KEY,
    "Amount" DECIMAL NOT NULL,
    "requestedAt" TIMESTAMP NOT NULL,
    "Gateway" SMALLINT NOT NULL,
    "Status" SMALLINT NOT NULL DEFAULT 0
);

CREATE INDEX IX_Transactions_Summary_Covering ON "Transactions" ("Status", "Gateway", "requestedAt") INCLUDE ("Amount");