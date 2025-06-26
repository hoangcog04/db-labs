# MySQL

<https://dev.mysql.com/doc/refman/8.4/en/innodb-transaction-isolation-levels.html>

**Mục đích**: Demo hiệu ứng của **isolation level** và **index** trên locking behavior trong MySQL.

- **REPEATABLE READ (mặc định)**:
  - Không có index → lock toàn bảng (do gap locking).
  - Có index → chỉ lock hàng thỏa điều kiện.
- **READ COMMITTED**:
  - Luôn chỉ lock hàng được update, dù không có index.
  - Hàng bị lock không cần thiết sẽ được giải phóng sau khi MySQL đánh giá điều kiện WHERE
