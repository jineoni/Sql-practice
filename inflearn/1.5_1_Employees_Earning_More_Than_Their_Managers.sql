/*
https://leetcode.com/problems/employees-earning-more-than-their-managers/

Table: Employee
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| salary      | int     |
| managerId   | int     |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the ID of an employee, their name, salary, and the ID of their manager.

Write an SQL query to find the employees who earn more than their managers.
Return the result table in any order.

Example:
Input: 
Employee table:
+----+-------+--------+-----------+
| id | name  | salary | managerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | Null      |
| 4  | Max   | 90000  | Null      |
+----+-------+--------+-----------+
Output: 
+----------+
| Employee |
+----------+
| Joe      |
+----------+
Explanation: Joe is the only employee who earns more than his manager.
*/

# [SETTING]
USE practice;
DROP TABLE Employee;
CREATE TABLE Employee (
  id INT,
  name VARCHAR(255),
  salary INT,
  managerid INT
);
INSERT INTO
  Employee (id, name, salary, managerid)
VALUES
  ('1', 'Joe', '70000', '3'),
  ('2', 'Henry', '80000', '4'),
  ('3', 'Sam', '60000', NULL),
  ('4', 'Max', '90000', NULL);
SELECT *
FROM Employee;

# [KEY]
# [MYSQL1] self join
# [MYSQL2] in: 바깥 table의 alias를 안쪽 table의 alias에 그대로 사용 가능
# 안그러면 in 안에 전체 테이블 다 읽어야 되는데, 그럼 너무 비효율적. 바깥 테이블 alias를 사용해서 in 절 안에 있는 데이터 양을 적게 해서 가져오는 셈.
# 그럼 의미에서 subquery도 바깥 테이블 가져올 수 있음

# [WRONG]
# Jack 같은 경우, managerId가 있지만 Mark의 manager이다. 따라서 managerId IS NULL을 썼다고 해서 모든 manager들을 가져올 수 없다.
-- | id | name | salary | managerId |
-- | -- | ---- | ------ | --------- |
-- | 1  | Mark | 40000  | 3         |
-- | 3  | Jack | 30000  | 2         |
-- | 2  | Alan | 20000  | null      |
SELECT
  e.name AS employee
FROM Employee AS e
INNER JOIN (
SELECT
  id,
  name,
  salary
FROM Employee
WHERE managerid IS NULL
) AS m
ON e.managerid = m.id
WHERE e.salary > m.salary;


# [PRACTICE]
SELECT *
FROM Employee AS e
INNER JOIN Employee AS m -- SELF JOIN
ON e.managerId = m.id;

# [MYSQL1]
SELECT
    e.name AS employee
FROM Employee AS e
INNER JOIN Employee AS m
ON e.managerId = m.id -- SELF JOIN
WHERE e.salary > m.salary;

# [MYSQL2]
SELECT
    e.name AS employee
FROM Employee AS e
WHERE e.name IN (SELECT
                     e.name -- 바깥 테이블 e를 사용
                 FROM Employee AS m
                 WHERE e.managerId = m.id -- 바깥 테이블 e를 사용
                   AND e.salary > m.salary -- 바깥 테이블 e를 사용
);

# [MYSQL3]
SELECT 
	e.name AS Employee
FROM Employee e
WHERE e.salary > (SELECT m.salary FROM Employee m WHERE e.managerId = m.id)