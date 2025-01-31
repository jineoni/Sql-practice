/*
https://leetcode.com/problems/list-the-products-ordered-in-a-period/ 

Table: Products
+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| product_id       | int     |
| product_name     | varchar |
| product_category | varchar |
+------------------+---------+
product_id is the primary key for this table.
This table contains data about the company's products.

Table: Orders
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| order_date    | date    |
| unit          | int     |
+---------------+---------+
There is no primary key for this table. It may have duplicate rows.
product_id is a foreign key to the Products table.
unit is the number of products ordered in order_date.

Write an SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount.
Return result table in any order.

Example:
Input: 
Products table:
+-------------+-----------------------+------------------+
| product_id  | product_name          | product_category |
+-------------+-----------------------+------------------+
| 1           | Leetcode Solutions    | Book             |
| 2           | Jewels of Stringology | Book             |
| 3           | HP                    | Laptop           |
| 4           | Lenovo                | Laptop           |
| 5           | Leetcode Kit          | T-shirt          |
+-------------+-----------------------+------------------+
Orders table:
+--------------+--------------+----------+
| product_id   | order_date   | unit     |
+--------------+--------------+----------+
| 1            | 2020-02-05   | 60       |
| 1            | 2020-02-10   | 70       |
| 2            | 2020-01-18   | 30       |
| 2            | 2020-02-11   | 80       |
| 3            | 2020-02-17   | 2        |
| 3            | 2020-02-24   | 3        |
| 4            | 2020-03-01   | 20       |
| 4            | 2020-03-04   | 30       |
| 4            | 2020-03-04   | 60       |
| 5            | 2020-02-25   | 50       |
| 5            | 2020-02-27   | 50       |
| 5            | 2020-03-01   | 50       |
+--------------+--------------+----------+
Output: 
+--------------------+---------+
| product_name       | unit    |
+--------------------+---------+
| Leetcode Solutions | 130     |
| Leetcode Kit       | 100     |
+--------------------+---------+
Explanation: 
Products with product_id = 1 is ordered in February a total of (60 + 70) = 130.
Products with product_id = 2 is ordered in February a total of 80.
Products with product_id = 3 is ordered in February a total of (2 + 3) = 5.
Products with product_id = 4 was not ordered in February 2020.
Products with product_id = 5 is ordered in February a total of (50 + 50) = 100.
*/

# [SETTING]
USE practice;
DROP TABLE Products;
CREATE TABLE Products (
  product_id INT,
  product_name VARCHAR(40),
  product_category VARCHAR(40)
);
INSERT INTO
  Products (product_id, product_name, product_category)
VALUES
  ('1', 'Leetcode Solutions', 'Book'),
  ('2', 'Jewels of Stringology', 'Book'),
  ('3', 'HP', 'Laptop'),
  ('4', 'Lenovo', 'Laptop'),
  ('5', 'Leetcode Kit', 'T-shirt');
SELECT *
FROM Products;

# [SETTING]
USE practice;
DROP TABLE Orders;
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
INSERT INTO
  Orders (product_id, order_date, unit)
VALUES
  ('1', '2020-02-05', '60'),
  ('1', '2020-02-10', '70'),
  ('2', '2020-01-18', '30'),
  ('2', '2020-02-11', '80'),
  ('3', '2020-02-17', '2'),
  ('3', '2020-02-24', '3'),
  ('4', '2020-03-01', '20'),
  ('4', '2020-03-04', '30'),
  ('4', '2020-03-04', '60'),
  ('5', '2020-02-25', '50'),
  ('5', '2020-02-27', '50'),
  ('5', '2020-03-01', '50');
SELECT *
FROM Orders;

# [KEY]
# EXTRACT: date type의 컬럼에서 원하는 부분만 추출하는 함수

# [PRACTICE]
SELECT
    product_id,
    SUM(unit) AS unit
FROM Orders
WHERE DATE_FORMAT(order_date, '%Y-%m') = '2020-02'
GROUP BY product_id
HAVING SUM(unit) >= 100;

# [MYSQL]
SELECT
    p.product_name,
    o.unit
FROM Products AS p
INNER JOIN (
			SELECT
                product_id,
                SUM(unit) AS unit
            FROM Orders
            WHERE DATE_FORMAT(order_date, '%Y-%m') = '2020-02'
            GROUP BY product_id
            HAVING SUM(unit) >= 100
) AS o
ON p.product_id = o.product_id;

# [MYSQL2]
SELECT 
	product_name, 
    SUM(unit) AS unit
FROM (SELECT product_id, unit
		FROM Orders
		WHERE YEAR(order_date) = 2020 AND MONTH(order_date) = 2) o
LEFT JOIN Products p ON o.product_id = p.product_id
GROUP BY o.product_id
HAVING SUM(unit) >= 100