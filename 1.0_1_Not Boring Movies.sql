/*
https://leetcode.com/problems/not-boring-movies/ 

Table: Cinema
+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| id             | int      |
| movie          | varchar  |
| description    | varchar  |
| rating         | float    |
+----------------+----------+
id is the primary key for this table.
Each row contains information about the name of a movie, its genre, and its rating.
rating is a 2 decimal places float in the range [0, 10]

Write an SQL query to report the movies with an odd-numbered ID and a description that is not "boring".
Return the result table ordered by rating in descending order.

Example:
Input: 
Cinema table:
+----+------------+-------------+--------+
| id | movie      | description | rating |
+----+------------+-------------+--------+
| 1  | War        | great 3D    | 8.9    |
| 2  | Science    | fiction     | 8.5    |
| 3  | irish      | boring      | 6.2    |
| 4  | Ice song   | Fantacy     | 8.6    |
| 5  | House card | Interesting | 9.1    |
+----+------------+-------------+--------+
Output: 
+----+------------+-------------+--------+
| id | movie      | description | rating |
+----+------------+-------------+--------+
| 5  | House card | Interesting | 9.1    |
| 1  | War        | great 3D    | 8.9    |
+----+------------+-------------+--------+
Explanation: 
We have three movies with odd-numbered IDs: 1, 3, and 5.
The movie with ID = 3 is boring so we do not include it in the answer.
설명:
홀수 ID인 1, 3, 5의 영화 3개가 있습니다.
ID = 3인 영화는 'boring'이므로 답변에 포함하지 않습니다.
*/

# [SETTING]
USE practice;
DROP TABLE Cinema;
CREATE TABLE Cinema (
  id INT,
  movie VARCHAR(255),
  description VARCHAR(255),
  rating FLOAT(2, 1)
);
INSERT INTO
  Cinema (id, movie, description, rating)
VALUES
  ('1', 'War', 'great 3D', '8.9'),
  ('2', 'Science', 'fiction', '8.5'),
  ('3', 'irish', 'boring', '6.2'),
  ('4', 'Ice song', 'Fantacy', '8.6'),
  ('5', 'House card', 'Interesting', '9.1');
SELECT *
FROM Cinema;

# [KEY]
# MOD: input(숫자, 나눌 값) 2개 필요-> output 나머지
# 홀수 판별: MOD(id,2)=1 <-> 짝수 판별: MOD(id,2)=0

# [MYSQL1]
SELECT *
FROM Cinema
WHERE MOD(id, 2) = 1
  AND description != 'boring'
ORDER BY rating DESC;

# [MYSQL2]
SELECT *
FROM Cinema
WHERE id % 2 = 1
  AND description != 'boring'
ORDER BY rating DESC;
