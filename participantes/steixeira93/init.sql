-- Criar tabela de pagamentos
CREATE TABLE IF NOT EXISTS payments (
    id UUID PRIMARY KEY,
    correlation_id UUID NOT NULL UNIQUE,
    amount DECIMAL(10, 2) NOT NULL,
    requested_at TIMESTAMP NOT NULL,
    processed_at TIMESTAMP,
    processor VARCHAR(50),
    status VARCHAR(20) NOT NULL,
    fee DECIMAL(10, 2)
);

-- Criar índices para performance
CREATE INDEX IF NOT EXISTS idx_payments_correlation_id ON payments(correlation_id);
CREATE INDEX IF NOT EXISTS idx_payments_status ON payments(status);
CREATE INDEX IF NOT EXISTS idx_payments_requested_at ON payments(requested_at);
CREATE INDEX IF NOT EXISTS idx_payments_processor ON payments(processor);
CREATE INDEX IF NOT EXISTS idx_payments_processor_status ON payments(processor, status);
