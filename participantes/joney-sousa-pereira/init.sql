-- Script de inicialização do banco de dados PostgreSQL

-- Criar tabela de pagamentos
CREATE TABLE IF NOT EXISTS payments (
    id VARCHAR(255) PRIMARY KEY,
    amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) NOT NULL,
    processor VARCHAR(50) NOT NULL,
    timestamp TIMESTAMP NOT NULL,
    description TEXT
);

-- Criar índices para melhor performance
CREATE INDEX IF NOT EXISTS idx_payments_processor ON payments(processor);
CREATE INDEX IF NOT EXISTS idx_payments_status ON payments(status);
CREATE INDEX IF NOT EXISTS idx_payments_timestamp ON payments(timestamp);

-- Criar tabela de auditoria
CREATE TABLE IF NOT EXISTS payment_audit (
    id SERIAL PRIMARY KEY,
    payment_id VARCHAR(255) NOT NULL,
    action VARCHAR(50) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    details JSONB
);

-- Criar índice para auditoria
CREATE INDEX IF NOT EXISTS idx_payment_audit_payment_id ON payment_audit(payment_id);
CREATE INDEX IF NOT EXISTS idx_payment_audit_timestamp ON payment_audit(timestamp); 