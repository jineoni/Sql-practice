/*
https://leetcode.com/problems/user-activity-for-the-past-30-days-i/ 

Table: Activity
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| session_id    | int     |
| activity_date | date    |
| activity_type | enum    |
+---------------+---------+
There is no primary key for this table, it may have duplicate rows.
The activity_type column is an ENUM of type ('open_session', 'end_session', 'scroll_down', 'send_message').
The table shows the user activities for a social media website. 
Note that each session belongs to exactly one user.

Write an SQL query to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively.
A user was active on someday if they made at least one activity on that day.
Return the result table in any order.

Example:
Input: 
Activity table:
+---------+------------+---------------+---------------+
| user_id | session_id | activity_date | activity_type |
+---------+------------+---------------+---------------+
| 1       | 1          | 2019-07-20    | open_session  |
| 1       | 1          | 2019-07-20    | scroll_down   |
| 1       | 1          | 2019-07-20    | end_session   |
| 2       | 4          | 2019-07-20    | open_session  |
| 2       | 4          | 2019-07-21    | send_message  |
| 2       | 4          | 2019-07-21    | end_session   |
| 3       | 2          | 2019-07-21    | open_session  |
| 3       | 2          | 2019-07-21    | send_message  |
| 3       | 2          | 2019-07-21    | end_session   |
| 4       | 3          | 2019-06-25    | open_session  |
| 4       | 3          | 2019-06-25    | end_session   |
+---------+------------+---------------+---------------+
Output: 
+------------+--------------+ 
| day        | active_users |
+------------+--------------+ 
| 2019-07-20 | 2            |
| 2019-07-21 | 2            |
+------------+--------------+ 

*/

# [SETTING]
USE practice;
DROP TABLE Activity;
CREATE TABLE Activity
(
    user_id       INT,
    session_id    INT,
    activity_date DATE,
    activity_type VARCHAR(255)
);
INSERT INTO Activity
    (user_id, session_id, activity_date, activity_type)
VALUES ('1', '1', '2019-07-20', 'open_session'),
    ('1', '1', '2019-07-20', 'scroll_down'),
    ('1', '1', '2019-07-20', 'end_session'),
    ('2', '4', '2019-07-20', 'open_session'),
    ('2', '4', '2019-07-21', 'send_message'),
    ('2', '4', '2019-07-21', 'end_session'),
    ('3', '2', '2019-07-21', 'open_session'),
    ('3', '2', '2019-07-21', 'send_message'),
    ('3', '2', '2019-07-21', 'end_session'),
    ('4', '3', '2019-06-25', 'open_session'),
    ('4', '3', '2019-06-25', 'end_session');
SELECT *
FROM Activity; 

# [WRONG DATE]
SELECT
    '2019-07-27' AS dt,
    '2019-07-27' - 30 AS dt_sub,
    '2019-07-27' + 30 AS dt_add;
    

# [RIGHT DATE]
# DATE_SUB 함수, DATE_ADD 함수
SELECT
    '2019-07-27' AS dt,
    DATE_SUB('2019-07-27', INTERVAL 30 DAY) AS dt_sub,
    DATE_ADD('2019-07-27', INTERVAL 30 DAY) AS dt_add;
    

# [MYSQL]
# '30일 동안': 한 쪽은 등호 있고, 한 쪽은 등호가 없어야지 기간이 30일이 된다.
SELECT
    activity_date AS day,
    COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE DATE_SUB('2019-07-27', INTERVAL 30 DAY) < activity_date
AND activity_date <= '2019-07-27'
GROUP BY activity_date;

# [MYSQL2]
SELECT
    activity_date AS day,
    COUNT(DISTINCT user_id) AS active_users
FROM Activity
GROUP BY activity_date
HAVING '2019-06-27' < activity_date AND activity_date <= '2019-07-27'