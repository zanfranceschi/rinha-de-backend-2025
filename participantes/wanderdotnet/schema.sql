-- Criação da tabela de pagamentos
CREATE TABLE payments (
    id BIGSERIAL PRIMARY KEY,
    correlation_id UUID NOT NULL UNIQUE,
    amount NUMERIC(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    processed_by_processor VARCHAR(20) NOT NULL,
    requested_at TIMESTAMPTZ NOT NULL,
    processed_at TIMESTAMPTZ NOT NULL
);

-- ---- INÍCIO DA MUDANÇA ----
-- Índice antigo (pode ser removido ou mantido se houver outras consultas)
-- DROP INDEX IF EXISTS idx_payments_processed_at;

-- Índice CORRETO para otimizar a consulta do endpoint GET /payments-summary
CREATE INDEX idx_payments_requested_at ON payments (requested_at);
-- ---- FIM DA MUDANÇA ----