/*
https://leetcode.com/problems/the-latest-login-in-2020 

Table: Logins
+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
+----------------+----------+
(user_id, time_stamp) is the primary key for this table.
Each row contains information about the login time for the user with ID user_id.

Write an SQL query to report the latest login for all users in the year 2020.
Do not include the users who did not login in 2020.
Return the result table in any order.

Example:
Input: 
Logins table:
+---------+---------------------+
| user_id | time_stamp          |
+---------+---------------------+
| 6       | 2020-06-30 15:06:07 |
| 6       | 2021-04-21 14:06:06 |
| 6       | 2019-03-07 00:18:15 |
| 8       | 2020-02-01 05:10:53 |
| 8       | 2020-12-31 07:46:50 |
| 2       | 2020-01-16 02:49:50 |
| 2       | 2019-08-25 07:59:08 |
| 14      | 2019-07-14 09:00:00 |
| 14      | 2021-01-06 11:59:59 |
+---------+---------------------+
Output: 
+---------+---------------------+
| user_id | last_stamp          |
+---------+---------------------+
| 6       | 2020-06-30 15:06:07 |
| 8       | 2020-12-31 07:46:50 |
| 2       | 2020-01-16 02:49:50 |
+---------+---------------------+
Explanation: 
User 6 logged into their account 3 times but only once in 2020, so we include this login in the result table.
User 8 logged into their account 2 times in 2020, once in February and once in December. We include only the latest one (December) in the result table.
User 2 logged into their account 2 times but only once in 2020, so we include this login in the result table.
User 14 did not login in 2020, so we do not include them in the result table.
*/

# [SETTING]
USE practice;
DROP TABLE Logins;
CREATE TABLE Logins
(
    user_id    INT,
    time_stamp DATETIME
);
INSERT INTO Logins
    (user_id, time_stamp)
VALUES ('6', '2020-06-30 15:06:07'),
    ('6', '2021-04-21 14:06:06'),
    ('6', '2019-03-07 00:18:15'),
    ('8', '2020-02-01 05:10:53'),
    ('8', '2020-12-31 07:46:50'),
    ('2', '2020-01-16 02:49:50'),
    ('2', '2019-08-25 07:59:08'),
    ('14', '2019-07-14 09:00:00'),
    ('14', '2021-01-06 11:59:59');
SELECT *
FROM Logins; 

# [PRACTICE]
SELECT TIMESTAMP('2020-12-31') AS time_stamp; 

# [WRONG]
# user_id=8의 2020-12-31 07:46:50 케이스는 미포함
SELECT *
FROM Logins
WHERE '2020-01-01' <= time_stamp
AND time_stamp <= '2020-12-31'; 


# [MYSQL1]
# 등호 조심하기
# 최신 날짜: MAX 사용
SELECT
    user_id,
    MAX(time_stamp) AS last_stamp
FROM Logins
WHERE '2020-01-01' <= time_stamp
AND time_stamp < '2021-01-01'
GROUP BY user_id; 

# [MYSQL2]
SELECT
    user_id,
    MAX(time_stamp) AS last_stamp
FROM Logins
WHERE time_stamp BETWEEN '2020-01-01 00:00:00' AND '2020-12-31 23:59:59'
GROUP BY user_id; 

# [MYSQL3]
# 하지만 권장하지는 않음: YEAR 함수를 사용하면 time_stamp 컬럼의 인덱스를 활용하지 못하게 되어 전체 테이블을 스캔해야 할 수 있음
# 인프런 질문란 참고: https://www.inflearn.com/questions/1212290
SELECT
    user_id,
    MAX(time_stamp) AS last_stamp
FROM Logins
WHERE YEAR(time_stamp) = 2020
GROUP BY user_id; 