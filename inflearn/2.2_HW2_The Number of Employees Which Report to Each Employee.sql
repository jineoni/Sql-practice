/*
https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/ 

Table: Employees
+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| reports_to  | int      |
| age         | int      |
+-------------+----------+
employee_id is the primary key for this table.
This table contains information about the employees and the id of the manager they report to.
Some employees do not report to anyone (reports_to is null). 

Write an SQL query to report the ids and the names of all managers, the number of employees who report directly to them, and the average age of the reports rounded to the nearest integer.
Return the result table ordered by employee_id.

Example:
Input: 
Employees table:
+-------------+---------+------------+-----+
| employee_id | name    | reports_to | age |
+-------------+---------+------------+-----+
| 9           | Hercy   | null       | 43  |
| 6           | Alice   | 9          | 41  |
| 4           | Bob     | 9          | 36  |
| 2           | Winston | null       | 37  |
+-------------+---------+------------+-----+
Output: 
+-------------+-------+---------------+-------------+
| employee_id | name  | reports_count | average_age |
+-------------+-------+---------------+-------------+
| 9           | Hercy | 2             | 39          |
+-------------+-------+---------------+-------------+
Explanation:
Hercy has 2 people report directly to him, Alice and Bob.
Their average age is (41+36)/2 = 38.5, which is 39 after rounding it to the nearest integer.
*/

# [SETTING]
USE practice;
DROP TABLE Employees;
CREATE TABLE Employees (
  employee_id INT,
  name VARCHAR(20),
  reports_to INT,
  age INT
);
INSERT INTO
  Employees (employee_id, name, reports_to, age)
VALUES
  ('9', 'Hercy', NULL, '43'),
  ('6', 'Alice', '9', '41'),
  ('4', 'Bob', '9', '36'),
  ('2', 'Winston', NULL, '37');
SELECT *
FROM Employees;

# [PRACTICE]
SELECT *
FROM Employees e
INNER JOIN Employees ee
ON e.employee_id = ee.reports_to;

# [MYSQL]
SELECT
  e.employee_id,
  e.name,
  COUNT(ee.employee_id) AS reports_count,
  ROUND(AVG(ee.age), 0) AS average_age
FROM Employees AS e
INNER JOIN Employees AS ee
ON e.employee_id = ee.reports_to
GROUP BY e.employee_id, e.name  # e.name도 반드시 있어야 함.
ORDER BY e.employee_id;

# [MYSQL2]
SELECT
    reports_to AS employee_id,
    (SELECT name FROM Employees e2 WHERE e1.reports_to=e2.employee_id) AS name,
    COUNT(*) AS reports_count,
    ROUND(AVG(age), 0) AS average_age
FROM Employees e1
GROUP BY reports_to
HAVING reports_to IS NOT NULL
ORDER BY employee_id

