/*
https://leetcode.com/problems/combine-two-tables/ 

Table: Person
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| personId    | int     |
| lastName    | varchar |
| firstName   | varchar |
+-------------+---------+
personId is the primary key column for this table.
This table contains information about the ID of some persons and their first and last names.
personId는 이 테이블의 기본 키 열입니다.
이 테이블에는 일부 개인의 ID와 성과 이름에 대한 정보가 포함되어 있습니다.
 
 
Table: Address
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| addressId   | int     |
| personId    | int     |
| city        | varchar |
| state       | varchar |
+-------------+---------+
addressId is the primary key column for this table.
Each row of this table contains information about the city and state of one person with ID = personId.
addressId는 이 테이블의 기본 키 열입니다.
이 테이블의 각 행에는 ID = personId인 한 사람의 도시 및 주에 대한 정보가 포함되어 있습니다.


Write an SQL query to report the first name, last name, city, and state of each person in the Person table.
If the Address of a personId is not present in the Address table, report null instead.
Return the result table in any order.
Person 테이블에 있는 각 사람의 이름, 성, 도시 및 주를 보고하는 SQL 쿼리를 작성하세요.
personId의 주소가 Address 테이블에 없으면 대신 null을 보고합니다.
어떤 순서로든 결과 테이블을 반환합니다.


Example:
Input: 
Person table:
+----------+----------+-----------+
|personId  | lastName | firstName |
+----------+----------+-----------+
| 1        | Wang     | Allen     |
| 2        | Alice    | Bob       |
+----------+----------+-----------+
Address table:
+-----------+----------+---------------+------------+
|addressId  |personId  | city          | state      |
+-----------+----------+---------------+------------+
| 1         | 2        | New York City | New York   |
| 2         | 3        | Leetcode      | California |
+-----------+----------+---------------+------------+
Output: 
+-----------+----------+---------------+----------+
|firstName  | lastName | city          | state    |
+-----------+----------+---------------+----------+
| Allen     | Wang     | null          | null     |
| Bob       | Alice    | New York City | New York |
+-----------+----------+---------------+----------+
Explanation: 
There is no Address in the Address table for the personId = 1 so we return null in their city and state.
addressId = 1 contains information about the Address of personId = 2.
*/

# [SETTING]
USE practice;
DROP TABLE Person;
CREATE TABLE Person (
  personId INT,
  lastName VARCHAR(255),
  firstName VARCHAR(255)
);
INSERT INTO
  Person (personId, lastName, firstName)
VALUES
  ('1', 'Wang', 'Allen'),
  ('2', 'Alice', 'Bob');
SELECT *
FROM Person;

# [SETTING]
USE practice;
DROP TABLE Address;
CREATE TABLE Address (
  addressId INT,
  personId INT,
  city VARCHAR(255),
  state VARCHAR(255)
);
INSERT INTO
  Address (addressId, personId, city, state)
VALUES
  ('1', '2', 'New York City', 'New York'),
  ('2', '3', 'Leetcode', 'California');
SELECT *
FROM Address;

# [KEY]
# 'If the Address of a personId is not present in the Address table, report null instead.'
# -> INNER JOIN이 아니라, LEFT OUTER JOIN 필요

# [PRACTICE]
SELECT *
FROM Person AS p
LEFT OUTER JOIN Address AS a
ON p.personId = a.personId;

# [MYSQL]
SELECT
  p.firstName,
  p.lastName,
  a.city,
  a.state
FROM Person AS p
LEFT OUTER JOIN Address AS a
ON p.personId = a.personId;