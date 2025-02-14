/*
https://leetcode.com/problems/delete-duplicate-emails/ 

Table: Person
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.

Write an SQL query to delete all the duplicate emails, keeping only one unique email with the smallest id.

Note that you are supposed to write a DELETE statement and not a SELECT one.
After running your script, the answer shown is the Person table.
The driver will first compile and run your piece of code and then show the Person table.
The final order of the Person table does not matter.

Example:
Input: 
Person table:
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Output: 
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+
Explanation: john@example.com is repeated two times. We keep the row with the smallest Id = 1.
*/

# [SETTING]
USE practice;
DROP TABLE Person;
CREATE TABLE Person (id INT, email VARCHAR(255));
INSERT INTO
  Person (id, email)
VALUES
  ('1', 'john@example.com'),
  ('2', 'bob@example.com'),
  ('3', 'john@example.com');
SELECT *
FROM Person;

# [WRONG]
# 'Error Code: 1093. You can't specify target table 'PERSON' for update in FROM clause
# => 내 테이블을 직접적으로 참조함과 동시에 지우려고 하니까 에러가 남
# => 그래서 별도로 임시 테이블 만든 후에, 지워야 한다 (그래서 아래 정답 쿼리 중 A 테이블을 만들었다)
DELETE FROM Person
WHERE id NOT IN (
    SELECT
      MIN(id) AS id
    FROM Person
    GROUP BY email
  );

# [MYSQL]
DELETE FROM Person
WHERE id NOT IN (
    SELECT id
    FROM (
        SELECT
          MIN(p.id) AS id
        FROM Person AS p
        GROUP BY p.email
	) AS a
);

# [MYSQL2]
DELETE p1
FROM Person p1
INNER JOIN Person p2 ON p1.email = p2.email
WHERE p1.id > p2.id 