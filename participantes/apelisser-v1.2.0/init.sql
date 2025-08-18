set statement_timeout = 0;
set lock_timeout = 0;
set idle_in_transaction_session_timeout = 5000;

SET session_replication_role = 'replica';
SET TIME ZONE 'UTC';

-- TABLES
CREATE TABLE payment (
    correlation_id UUID PRIMARY KEY,
    amount NUMERIC(15, 2) NOT NULL,
    requested_at TIMESTAMPTZ NOT NULL,
    default_processor boolean NOT NULL
);

CREATE TABLE scheduler_locks (
    lock_name VARCHAR(255) PRIMARY KEY,
    last_execution TIMESTAMPTZ NOT NULL
);

CREATE TABLE health_check_status (
    default_processor BOOLEAN PRIMARY KEY,
    is_failing BOOLEAN NOT NULL,
    min_response_time BIGINT NOT NULL,
    last_checked TIMESTAMPTZ NOT NULL
);

-- INSERTS
INSERT INTO scheduler_locks (lock_name, last_execution)
VALUES ('health_check_leader', NOW() - INTERVAL '1 minute');

INSERT INTO health_check_status (default_processor, is_failing, min_response_time, last_checked)
VALUES (true, true, 0, NOW()),
       (false, true, 0, NOW());

SET session_replication_role = 'origin';

-- INDEXES
CREATE INDEX idx_payments_summary ON payment (default_processor, requested_at);

