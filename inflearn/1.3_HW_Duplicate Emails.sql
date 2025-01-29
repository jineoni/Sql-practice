/*
https://leetcode.com/problems/duplicate-emails/ 

Table: Person 
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.

Write an SQL query to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.
Return the result table in any order.

Example:
Input: 
Person table:
+----+---------+
| id | email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
+----+---------+
Output: 
+---------+
| Email   |
+---------+
| a@b.com |
+---------+
Explanation: a@b.com is repeated two times.
*/

# [SETTING]
USE practice;
DROP TABLE Person;
CREATE TABLE Person (id INT, email VARCHAR(255));
INSERT INTO
  Person (id, email)
VALUES
  ('1', 'a@b.com'),
  ('2', 'c@d.com'),
  ('3', 'a@b.com');
SELECT *
FROM Person;

# [MYSQL]
SELECT email
FROM Person
GROUP BY email
HAVING COUNT(email) > 1;