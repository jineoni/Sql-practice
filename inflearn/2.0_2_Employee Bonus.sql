/*
https://leetcode.com/problems/employee-bonus/ 

Table: Employee
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| empId       | int     |
| name        | varchar |
| supervisor  | int     |
| salary      | int     |
+-------------+---------+
empId is the primary key column for this table.
Each row of this table indicates the name and the ID of an employee in addition to their salary and the id of their manager.

 Table: Bonus
 +-------------+------+
| Column Name | Type |
+-------------+------+
| empId       | int  |
| bonus       | int  |
+-------------+------+
empId is the primary key column for this table.
empId is a foreign key to empId from the Employee table.
Each row of this table contains the id of an employee and their respective bonus.

Write an SQL query to report the name and bonus amount of each employee with a bonus less than 1000.
Return the result table in any order.

Example:
Input: 
Employee table:
+-------+--------+------------+--------+
| empId | name   | supervisor | salary |
+-------+--------+------------+--------+
| 3     | Brad   | null       | 4000   |
| 1     | John   | 3          | 1000   |
| 2     | Dan    | 3          | 2000   |
| 4     | Thomas | 3          | 4000   |
+-------+--------+------------+--------+
Bonus table:
+-------+-------+
| empId | bonus |
+-------+-------+
| 2     | 500   |
| 4     | 2000  |
+-------+-------+
Output: 
+------+-------+
| name | bonus |
+------+-------+
| Brad | NULL  |
| John | NULL  |
| Dan  | 500   |
+------+-------+
*/

# [SETTING]
USE practice;
DROP TABLE Employee;
CREATE TABLE Employee (
  empid INT,
  name VARCHAR(255),
  supervisor INT,
  salary INT
);
INSERT INTO
  Employee (empid, name, supervisor, salary)
VALUES
  ('1', 'John', '3', '1000'),
  ('2', 'Dan', '3', '2000'),
  ('3', 'Brad', NULL, '4000'),
  ('4', 'Thomas', '3', '4000');
SELECT *
FROM Employee;

# [SETTING]
USE practice;
DROP TABLE Bonus;
CREATE TABLE Bonus (empid INT, bonus INT);
INSERT INTO
  Bonus (empid, bonus)
VALUES
  ('2', '500'),
  ('4', '2000');
SELECT *
FROM Bonus;

# [PRACTICE]
SELECT *
FROM Employee AS e
LEFT OUTER JOIN Bonus AS b
ON e.empId = b.empId;

# [MYSQL1]
SELECT e.name,
       b.bonus
FROM Employee AS e
LEFT OUTER JOIN Bonus AS b
ON e.empId = b.empId
WHERE (b.bonus < 1000 OR b.bonus IS NULL); -- IFNULL(b.bonus, 0) < 1000와 동일

# [WRONG]
# 실행 순서:
# (1) LEFT OUTER JOIN을 먼저 진행
# (2) WHERE 조건을 기준으로 필터링 -> 이때 WHERE 조건에 오른쪽 테이블이 있다면, 오른쪽 데이터의 NULL값들이 제거되면서 결국에는 INNER JOIN처럼 변한다.
SELECT e.name,
       b.bonus
FROM Employee AS e
LEFT OUTER JOIN Bonus AS b
ON e.empId = b.empId
WHERE b.bonus < 1000;

# [WRONG]
# ON 절에 조건을 추가하면, Employee 테이블의 모든 행을 포함하되 Bonus 테이블에는 bonus 값이 1000 미만인 행만을 포함하도록 조인을 제한햔다.
SELECT *
FROM Employee AS e
LEFT OUTER JOIN Bonus AS b
ON e.empId = b.empId
	AND b.bonus < 1000;

# [MYSQL2]
# LEFT OUTER JOIN 이후에 WHERE 조건을 넣어서 실수할까봐, WHERE 조건을 안쓰는 방법:
# 서브 쿼리로 정리해서 temp 테이블 A와 Bonus 테이블을 조인
SELECT
    e.name,
    b.bonus
FROM (SELECT
          empId,
          name
      FROM Employee
      WHERE empId NOT IN (SELECT
                               empId
                           FROM Bonus
                           WHERE bonus >= 1000
						  )
) AS e
LEFT OUTER JOIN Bonus AS b
ON e.empId = b.empId; 		

# [MYSQL3]
SELECT 
	name, 
    bonus
FROM Employee e
LEFT JOIN Bonus b ON e.empId = b.empId
WHERE e.empId NOT IN (SELECT empId FROM Bonus WHERE bonus >= 1000)	