/*
Table: activity
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some game.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on some day using some device.

Write a SQL query that reports the device that is first logged in for each player.

Example:
activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+

Result table:
+-----------+-----------+
| player_id | device_id |
+-----------+-----------+
| 1         | 2         |
| 2         | 3         |
| 3         | 1         |
+-----------+-----------+
*/

# [SETTING]
USE practice;
DROP TABLE activity;
CREATE TABLE activity
(
    player_id    INT,
    device_id    INT,
    event_date   DATE,
    games_played INT
);
INSERT INTO activity
    (player_id, device_id, event_date, games_played)
VALUES ('1', '2', '2016-03-01', '5'),
    ('1', '2', '2016-05-02', '6'),
    ('2', '3', '2017-06-25', '1'),
    ('3', '1', '2016-03-02', '0'),
    ('3', '4', '2018-07-03', '5');
SELECT *
FROM activity;  

# [PRACTICE]
SELECT
    player_id,
    MIN(event_date) AS first_login
FROM activity
GROUP BY player_id;

# [MYSQL1]
# MIN
SELECT
    a.player_id,
    a.device_id
FROM activity AS a
INNER JOIN (
	SELECT
		player_id,
		MIN(event_date) AS min_date
	FROM activity
	GROUP BY player_id
) aa
ON a.player_id = aa.player_id
    AND a.event_date = aa.min_date; -- 각 플레이어의 가장 이른 로그인 날짜와 연결
    
# [PRACTICE]
SELECT
    player_id,
    event_date,
    device_id,
    RANK() OVER (PARTITION BY player_id ORDER BY event_date) AS rk
FROM activity
ORDER BY player_id, event_date; 

# [MYSQL2]
# RANK
SELECT
    player_id,
    device_id
FROM (
	SELECT
	  player_id,
	  device_id,
	  RANK() OVER (PARTITION BY player_id ORDER BY event_date) AS rk
FROM activity
) AS a
WHERE rk = 1; 