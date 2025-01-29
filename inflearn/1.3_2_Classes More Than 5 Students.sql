/*
https://leetcode.com/problems/classes-more-than-5-students/ 

Table: Courses
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| student     | varchar |
| class       | varchar |
+-------------+---------+
(student, class) is the primary key column for this table. 
Each row of this table indicates the name of a student and the class in which they are enrolled.

Write an SQL query to report all the classes that have at least five students.
Return the result table in any order.

Example:
Input: 
Courses table:
+---------+----------+
| student | class    |
+---------+----------+
| A       | Math     |
| B       | English  |
| C       | Math     |
| D       | Biology  |
| E       | Math     |
| F       | Computer |
| G       | Math     |
| H       | Math     |
| I       | Math     |
+---------+----------+
Output: 
+---------+
| class   |
+---------+
| Math    |
+---------+
Explanation: 
- Math has 6 students, so we include it.
- English has 1 student, so we do not include it.
- Biology has 1 student, so we do not include it.
- Computer has 1 student, so we do not include it.
*/

# [SETTING]
USE practice;
DROP TABLE Courses;
CREATE TABLE Courses (student VARCHAR(255), class VARCHAR(255));
INSERT INTO
  Courses (student, class)
VALUES
  ('A', 'Math'),
  ('B', 'English'),
  ('C', 'Math'),
  ('D', 'Biology'),
  ('E', 'Math'),
  ('F', 'Computer'),
  ('G', 'Math'),
  ('H', 'Math'),
  ('I', 'Math');
SELECT *
FROM Courses;

# [KEY]
# COUNT(class), COUNT(student), COUNT(*): 모두 having절에서 사용해도 정답
# '(student, class) is the primary key column for this table': 그래서 COUNT(DISTINCT student)로 쓸 필요 없음
# 만약 NOT primary key이였다면, COUNT(DISTINCT student)로 꼭 써야된다.

# [MYSQL]
SELECT
  class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;