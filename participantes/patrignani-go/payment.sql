CREATE UNLOGGED TABLE entry_history (
	correlationId UUID PRIMARY KEY,
	amount DECIMAL NOT NULL,
	fallback BOOLEAN NOT NULL DEFAULT TRUE,
	created_at TIMESTAMP NOT NULL
);

CREATE INDEX _created_at_ ON entry_history (created_at);