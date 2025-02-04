/*
https://leetcode.com/problems/employees-with-missing-information/ 

Table: Employees
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| name        | varchar |
+-------------+---------+
employee_id is the primary key for this table.
Each row of this table indicates the name of the employee whose ID is employee_id.

Table: Salaries
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| salary      | int     |
+-------------+---------+
employee_id is the primary key for this table.
Each row of this table indicates the salary of the employee whose ID is employee_id.

Write an SQL query to report the IDs of all the employees with missing information.
The information of an employee is missing if:
- The employee's name is missing, or
- The employee's salary is missing.
Return the result table ordered by employee_id in ascending order.

Example:
Input: 
Employees table:
+-------------+----------+
| employee_id | name     |
+-------------+----------+
| 2           | Crew     |
| 4           | Haven    |
| 5           | Kristian |
+-------------+----------+
Salaries table:
+-------------+--------+
| employee_id | salary |
+-------------+--------+
| 1           | 22517  |
| 4           | 63539  |
| 5           | 76071  |
+-------------+--------+
Output: 
+-------------+
| employee_id |
+-------------+
| 1           |
| 2           |
+-------------+
Explanation: 
Employees 1, 2, 4, and 5 are working at this company.
The name of employee 1 is missing.
The salary of employee 2 is missing.
*/

# [SETTING]
USE practice;
DROP TABLE Employees;
CREATE TABLE Employees
(
    employee_id INT,
    name        VARCHAR(30)
);
INSERT INTO Employees
    (employee_id, name)
VALUES ('2', 'Crew'),
    ('4', 'Haven'),
    ('5', 'Kristian');
SELECT *
FROM Employees;

# [SETTING]
USE practice;
DROP TABLE Salaries;
CREATE TABLE Salaries
(
    employee_id INT,
    salary      INT
);
INSERT INTO Salaries
    (employee_id, salary)
VALUES ('1', '22517'),
	('4', '63539'),
	('5', '76071');
SELECT *
FROM Salaries; 

# [PRACTICE]
SELECT *
FROM Employees AS a
LEFT OUTER JOIN Salaries AS b
ON a.employee_id = b.employee_id;

SELECT *
FROM Salaries AS a
LEFT OUTER JOIN Employees AS b
ON a.employee_id = b.employee_id;


#[MYSQL1]
# MYSQL에서는 full outer join을 지원하지 않아서, 이렇게 대체로 full outer join 로직을 작성한다.
SELECT
    a.employee_id
FROM Employees AS a
LEFT OUTER JOIN Salaries AS b
ON a.employee_id = b.employee_id
WHERE b.employee_id IS NULL

UNION

SELECT
    a.employee_id
FROM Salaries AS a
LEFT OUTER JOIN Employees AS b
ON a.employee_id = b.employee_id
WHERE b.employee_id IS NULL
ORDER BY employee_id; 

# [MYSQL1-2]
SELECT
    u.employee_id
FROM (
    SELECT
        e.employee_id, e.name, s.salary
    FROM Employees e
    LEFT JOIN Salaries s ON e.employee_id=s.employee_id

    UNION

    SELECT
        s.employee_id, e.name, s.salary
    FROM Salaries s
    LEFT JOIN Employees e ON e.employee_id=s.employee_id
) u
WHERE ISNULL(name) OR ISNULL(salary)
ORDER BY u.employee_id;


# [PRACTICE]
SELECT *
FROM Employees AS a
RIGHT OUTER JOIN Salaries AS b
ON a.employee_id = b.employee_id;

#[MYSQL2]
# A RIGHT OUTER JOIN B = B LEFT OUTER JOIN A
SELECT
    a.employee_id
FROM Employees AS a
LEFT OUTER JOIN Salaries AS b
ON a.employee_id = b.employee_id
WHERE b.employee_id IS NULL

UNION

SELECT
    b.employee_id
FROM Employees AS a
RIGHT OUTER JOIN Salaries AS b
ON a.employee_id = b.employee_id
WHERE a.employee_id IS NULL
ORDER BY employee_id;



/*
# [ORACLE]
SELECT
	CASE
		WHEN e.employee_id IS NULL THEN s.employee_id
		WHEN s.employee_id IS NULL THEN e.employee_id
	END AS employee_id
FROM Employees e
FULL OUTER JOIN Salaries s
ON e.employee_id = s.employee_id
WHERE e.employee_id IS NULL
	OR s.employee_id IS NULL
ORDER BY employee_id;
*/
