-- setup
DROP DATABASE IF EXISTS lock_demo;
CREATE DATABASE lock_demo;
USE lock_demo;

-- no index
CREATE TABLE no_index
(
    id     int PRIMARY KEY,
    name   varchar(100),
    status varchar(20)
) ENGINE = InnoDB;

-- index
CREATE TABLE with_index
(
    id     int PRIMARY KEY,
    name   varchar(100),
    status varchar(20),
    INDEX idx_status (status)
) ENGINE = InnoDB;

-- insert
INSERT INTO no_index
VALUES (1, 'Item 1', 'active'),
       (2, 'Item 2', 'inactive'),
       (3, 'Item 3', 'active'),
       (4, 'Item 4', 'inactive');

INSERT INTO with_index
SELECT *
FROM no_index;

-- DEMO LOCK SCOPE

-- record locks for non-matching rows are released in read committed
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- sẽ lock toàn bộ nếu dủng repeatable read
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;
UPDATE no_index
SET name = CONCAT(name, '*')
WHERE status = 'active';
ROLLBACK;

SELECT *
FROM performance_schema.data_locks
WHERE OBJECT_SCHEMA = 'lock_demo';

-- chỉ lock hàng 'active'
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;
UPDATE with_index
SET name = CONCAT(name, '*')
WHERE status = 'active';
ROLLBACK;

-- clean up
DROP DATABASE lock_demo;
