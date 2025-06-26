-- session 2: thử query cái mà k active
-- sẽ bị block dù k phải là active
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;
UPDATE no_index
SET name = 'Blocked'
WHERE status = 'inactive';
# WHERE id = 4;
ROLLBACK;

-- thử update hàng inactive
-- không bị block
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;
UPDATE with_index
SET name = 'Not Blocked'
WHERE status = 'inactive';
# WHERE id = 3;
# WHERE id = 4;
ROLLBACK;
