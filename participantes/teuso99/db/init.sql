CREATE TABLE Payment (
    CorrelationId UUID PRIMARY KEY,
    Amount DECIMAL NOT NULL,
    RequestedAt TIMESTAMP NOT NULL,
    ProcessorName VARCHAR(50) NOT NULL
);

CREATE INDEX payment_requested_at ON Payment (RequestedAt, ProcessorName);