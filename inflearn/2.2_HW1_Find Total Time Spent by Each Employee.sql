/*
https://leetcode.com/problems/find-total-time-spent-by-each-employee/ 

Table: Employees
+-------------+------+
| Column Name | Type |
+-------------+------+
| emp_id      | int  |
| event_day   | date |
| in_time     | int  |
| out_time    | int  |
+-------------+------+
(emp_id, event_day, in_time) is the primary key of this table.
The table shows the employees' entries and exits in an office.
event_day is the day at which this event happened, in_time is the minute at which the employee entered the office, and out_time is the minute at which they left the office.
in_time and out_time are between 1 and 1440.
It is guaranteed that no two events on the same day intersect in time, and in_time < out_time.

Write an SQL query to calculate the total time in minutes spent by each employee on each day at the office.
Note that within one day, an employee can enter and leave more than once.
The time spent in the office for a single entry is out_time - in_time.
Return the result table in any order.

Example:
Input: 
Employees table:
+--------+------------+---------+----------+
| emp_id | event_day  | in_time | out_time |
+--------+------------+---------+----------+
| 1      | 2020-11-28 | 4       | 32       |
| 1      | 2020-11-28 | 55      | 200      |
| 2      | 2020-11-28 | 3       | 33       |
| 1      | 2020-12-03 | 1       | 42       |
| 2      | 2020-12-09 | 47      | 74       |
+--------+------------+---------+----------+
Output: 
+------------+--------+------------+
| day        | emp_id | total_time |
+------------+--------+------------+
| 2020-11-28 | 1      | 173        |
| 2020-11-28 | 2      | 30         |
| 2020-12-03 | 1      | 41         |
| 2020-12-09 | 2      | 27         |
+------------+--------+------------+
Explanation: 
Employee 1 has three events: two on day 2020-11-28 with a total of (32 - 4) + (200 - 55) = 173, and one on day 2020-12-03 with a total of (42 - 1) = 41.
Employee 2 has two events: one on day 2020-11-28 with a total of (33 - 3) = 30, and one on day 2020-12-09 with a total of (74 - 47) = 27.
*/

# [SETTING]
USE practice;
DROP TABLE Employees;
CREATE TABLE Employees
(
    emp_id    INT,
    event_day DATE,
    in_time   INT,
    out_time  INT
);
INSERT INTO Employees
    (emp_id, event_day, in_time, out_time)
VALUES ('1', '2020-11-28', '4', '32'),
    ('1', '2020-11-28', '55', '200'),
    ('2', '2020-11-28', '3', '33'),
    ('1', '2020-12-3', '1', '42'),
    ('2', '2020-12-9', '47', '74');
SELECT *
FROM Employees; 

# [MYSQL]
SELECT
    event_day AS day,
    emp_id,
    SUM(out_time) - SUM(in_time) AS total_time
FROM Employees
GROUP BY event_day, emp_id; 

# [MYSQL2]
SELECT
    event_day AS day,
    emp_id,
    SUM(out_time-in_time) AS total_time
FROM Employees
GROUP BY emp_id, event_day