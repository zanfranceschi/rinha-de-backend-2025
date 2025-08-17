-- Initialize the payments database with a simple schema
-- Create the payments table to store basic payment records
CREATE TABLE IF NOT EXISTS payments (
  correlation_id VARCHAR(100) PRIMARY KEY,
  amount FLOAT NOT NULL,
  requested_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  gateway VARCHAR(50) NOT NULL
);