/*
https://leetcode.com/problems/find-customer-referee/

Table: Customer
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| referee_id  | int     |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the id of a customer, their name, and the id of the customer who referred them.

Write an SQL query to report the names of the customer that are not referred by the customer with id = 2.
Return the result table in any order.

Example:
Input: 
Customer table:
+----+------+------------+
| id | name | referee_id |
+----+------+------------+
| 1  | Will | null       |
| 2  | Jane | null       |
| 3  | Alex | 2          |
| 4  | Bill | null       |
| 5  | Zack | 1          |
| 6  | Mark | 2          |
+----+------+------------+
Output: 
+------+
| name |
+------+
| Will |
| Jane |
| Bill |
| Zack |
+------+
*/

# [SETTING]
USE practice;
DROP TABLE Customer;
CREATE TABLE Customer (id INT, name VARCHAR(255), referee_id INT);
INSERT INTO
  Customer (id, name, referee_id)
VALUES
  ('1', 'Will', NULL),
  ('2', 'Jane', NULL),
  ('3', 'Alex', '2'),
  ('4', 'Bill', NULL),
  ('5', 'Zack', '1'),
  ('6', 'Mark', '2');
SELECT *
FROM Customer;

# [KEY]
# 'that are NOT referred by the Customer with id = 2': 여집합의 NOT IN고려

# [WRONG]
# NULL 값은 포함하지 않는다.
SELECT
    name
FROM Customer
WHERE referee_id != 2; 

# [MYSQL1]
# 하지만 추가 예외 사항(referee_id가 NULL일 때)를 따로 고려해야되서, 비추
SELECT
    name
FROM Customer
WHERE referee_id != 2 OR referee_id IS NULL; 

# [PRACTICE]
SELECT
	id,
	name
FROM Customer
WHERE referee_id = 2;

# [MYSQL2]
# 방법1보다 명확
SELECT
    name
FROM Customer
WHERE id NOT IN (
	SELECT
		id
	FROM Customer
	WHERE referee_id = 2
); 

# [WRONG]
# 같은 이름을 가진 두 Customer가 각각 referred by 2, not referred by 2라면 둘다 포함하지 않음
SELECT
    name
FROM Customer
WHERE name NOT IN (
	SELECT
		name
	FROM Customer
	WHERE referee_id = 2
); 