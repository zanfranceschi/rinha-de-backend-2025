CREATE UNLOGGED TABLE transactions (
    "correlationId" UUID PRIMARY KEY,
    amount NUMERIC(18,2) NOT NULL,
    "requestedAt" TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    gateway BOOLEAN NOT NULL DEFAULT TRUE,
    status BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE INDEX idx_transactions ON transactions ("correlationId");
--CREATE INDEX idx_transactions_search ON transactions ("Status", "Gateway", "RequestedAt");


CREATE OR REPLACE FUNCTION notify_trigger() 
RETURNS TRIGGER AS $trigger$
DECLARE
  channel_name TEXT;
BEGIN
  IF NEW.status = TRUE THEN
    RETURN NEW;
  END IF;

  channel_name := 'payment_transaction_primary';

  IF NEW.gateway = FALSE THEN
    channel_name := 'payment_transaction_fallback';
  END IF;

  PERFORM pg_notify(channel_name, row_to_json(NEW)::text);

  RETURN NEW;
END;
$trigger$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER transactions_notify_trigger
AFTER INSERT OR UPDATE ON public.transactions
FOR EACH ROW EXECUTE PROCEDURE notify_trigger();