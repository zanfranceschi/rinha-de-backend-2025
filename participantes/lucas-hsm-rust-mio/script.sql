CREATE UNLOGGED TABLE Transactions (
time TIMESTAMP NOT NULL,
id UUID PRIMARY KEY,
amount DOUBLE PRECISION NOT NULL,
db TEXT NOT NULL
);

CREATE INDEX transaction_requested_at ON Transactions (time);
