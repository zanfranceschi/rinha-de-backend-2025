CREATE TABLE tb_payments (
    correlationId UUID PRIMARY KEY,
    amount DECIMAL NOT NULL ,
    requested_at TIMESTAMP WITH TIME ZONE NOT NULL,
    processor INT
);

CREATE INDEX idx_requested_at ON tb_payments (requested_at);
CREATE INDEX idx_processor ON tb_payments(processor);