CREATE TABLE IF NOT EXISTS payments (
			id SERIAL PRIMARY KEY,
			correlation_id UUID NOT NULL,
			amount NUMERIC(12, 2) NOT NULL,
			processor TEXT NOT NULL CHECK (processor IN ('default', 'fallback')),
			created_at TIMESTAMPTZ DEFAULT NOW()
		);
CREATE INDEX IF NOT EXISTS idx_payments_created_at ON payments(created_at);
CREATE INDEX IF NOT EXISTS idx_payments_processor ON payments(processor);