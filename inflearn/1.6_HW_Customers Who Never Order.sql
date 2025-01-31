/*
https://leetcode.com/problems/customers-who-never-order/ 

Table: Customers
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the ID and name of a customer.
 
Table: Orders
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| customerId  | int  |
+-------------+------+
id is the primary key column for this table.
customerId is a foreign key of the ID from the Customers table.
Each row of this table indicates the ID of an order and the ID of the customer who ordered it.

Write an SQL query to report all customers who never order anything.
Return the result table in any order.

Example:
Input: 
Customers table:
+----+-------+
| id | name  |
+----+-------+
| 1  | Joe   |
| 2  | Henry |
| 3  | Sam   |
| 4  | Max   |
+----+-------+
Orders table:
+----+------------+
| id | customerId |
+----+------------+
| 1  | 3          |
| 2  | 1          |
+----+------------+
Output: 
+-----------+
| Customers |
+-----------+
| Henry     |
| Max       |
+-----------+
*/

# [SETTING]
USE practice;
DROP TABLE Customers;
CREATE TABLE Customers (id INT, name VARCHAR(255));
INSERT INTO
  Customers (id, name)
VALUES
  ('1', 'Joe'),
  ('2', 'Henry'),
  ('3', 'Sam'),
  ('4', 'Max');
SELECT *
FROM Customers;

# [SETTING]
USE practice;
DROP TABLE Orders;
CREATE TABLE Orders (id INT, customerid INT);
INSERT INTO
  Orders (id, customerid)
VALUES
  ('1', '3'),
  ('2', '1');
SELECT *
FROM Orders;

# [KEY]
# 'all customers who NEVER order anything': 여집합의 NOT IN 고려

# [MYSQL]
SELECT
  name AS customers
FROM Customers
WHERE id NOT IN (
    SELECT
      customerid
    FROM Orders
);
