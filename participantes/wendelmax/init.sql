-- Tabela principal de pagamentos
CREATE TABLE IF NOT EXISTS "Payments" (
    "Id" SERIAL PRIMARY KEY,
    "CorrelationId" VARCHAR(255) NOT NULL,
    "Amount" DECIMAL(10, 2) NOT NULL,
    "AmountAfterFees" DECIMAL(10, 2) NOT NULL,
    "RequestedAt" TIMESTAMP WITH TIME ZONE NOT NULL,
    "Processor" TEXT,
    "Status" TEXT NOT NULL,
    "CreatedAt" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Índice para melhorar queries por data
CREATE INDEX IF NOT EXISTS idx_payments_requested_at ON "Payments"("RequestedAt");
