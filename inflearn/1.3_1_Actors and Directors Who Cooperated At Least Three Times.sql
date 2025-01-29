/*
https://leetcode.com/problems/actors-and-directors-who-cooperated-at-least-three-times/ 

Table: ActorDirector
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| actor_id    | int     |
| director_id | int     |
| timestamp   | int     |
+-------------+---------+
timestamp is the primary key column for this table. 
 
Write a SQL query for a report that provides the pairs (actor_id, director_id) where the actor has cooperated with the director at least three times.
Return the result table in any order.

Example:
Input: 
ActorDirector table:
+-------------+-------------+-------------+
| actor_id    | director_id | timestamp   |
+-------------+-------------+-------------+
| 1           | 1           | 0           |
| 1           | 1           | 1           |
| 1           | 1           | 2           |
| 1           | 2           | 3           |
| 1           | 2           | 4           |
| 2           | 1           | 5           |
| 2           | 1           | 6           |
+-------------+-------------+-------------+
Output: 
+-------------+-------------+
| actor_id    | director_id |
+-------------+-------------+
| 1           | 1           |
+-------------+-------------+
Explanation: The only pair is (1, 1) where they cooperated exactly 3 times.
*/

# [SETTING]
USE practice;
DROP TABLE ActorDirector;
CREATE TABLE ActorDirector (actor_id INT, director_id INT, timestamp INT);
INSERT INTO
  ActorDirector (actor_id, director_id, timestamp)
VALUES
  ('1', '1', '0'),
  ('1', '1', '1'),
  ('1', '1', '2'),
  ('1', '2', '3'),
  ('1', '2', '4'),
  ('2', '1', '5'),
  ('2', '1', '6');
SELECT *
FROM ActorDirector;

# [KEY]
# 'at least': 등호 포함된 >=
# having절에서 사용해도 정답: COUNT(actor_id), COUNT(director_id), COUNT(timestamp), COUNT(*)
# having절에서 사용하면 오답: COUNT(DISTINCT actor_id), COUNT(DISTINCT director_id)

# [PRACTICE]
SELECT
  actor_id,
  director_id,
  COUNT(actor_id),
  COUNT(DISTINCT actor_id),
  COUNT(director_id),
  COUNT(DISTINCT director_id),
  COUNT(timestamp),
  COUNT(DISTINCT timestamp),
  COUNT(*)
FROM ActorDirector
GROUP BY actor_id, director_id;

# [MYSQL] 
SELECT
  actor_id,
  director_id
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(*) >= 3;