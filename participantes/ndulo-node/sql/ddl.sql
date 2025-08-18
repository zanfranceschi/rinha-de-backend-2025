-- Criar extensão se necessário
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Tabela principal de payments (UNLOGGED para performance)
CREATE UNLOGGED TABLE payments (
    correlationId UUID PRIMARY KEY,
    processor VARCHAR(20) NOT NULL CHECK (processor IN ('default', 'fallback', 'unprocessed')),
    amount DECIMAL(12,2) NOT NULL CHECK (amount > 0),
    requested_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- Índices otimizados para consultas de summary
CREATE INDEX IF NOT EXISTS idx_payments_processor ON payments (processor);
CREATE INDEX IF NOT EXISTS idx_payments_requested_at ON payments (requested_at);
CREATE INDEX IF NOT EXISTS idx_payments_processor_time ON payments (processor, requested_at);
CREATE INDEX IF NOT EXISTS idx_payments_summary 
    ON payments (processor, requested_at) 
    INCLUDE (amount);

-- Tabela para estatísticas rápidas
CREATE UNLOGGED TABLE payment_stats (
    processor VARCHAR(20) PRIMARY KEY,
    total_requests BIGINT DEFAULT 0,
    total_amount DECIMAL(15,2) DEFAULT 0,
    last_updated TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Inserir estatísticas iniciais
INSERT INTO payment_stats (processor, total_requests, total_amount) 
VALUES 
    ('default', 0, 0),
    ('fallback', 0, 0),
    ('unprocessed', 0, 0)
ON CONFLICT (processor) DO NOTHING;
