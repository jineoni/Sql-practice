/*
https://leetcode.com/problems/biggest-single-number/ 

Table: MyNumbers
+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
+-------------+------+
There is no primary key for this table. It may contain duplicates.
Each row of this table contains an integer.
A single number is a number that appeared only once in the MyNumbers table.

Write an SQL query to report the largest single number.
If there is no single number, report null.
The query result format is in the following example.

Example 1:
Input: 
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 3   |
| 3   |
| 1   |
| 4   |
| 5   |
| 6   |
+-----+
Output: 
+-----+
| num |
+-----+
| 6   |
+-----+
Explanation:
The single numbers are 1, 4, 5, and 6.
Since 6 is the largest single number, we return it.

Example 2:
Input: 
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 7   |
| 7   |
| 3   |
| 3   |
| 3   |
+-----+
Output: 
+------+
| num  |
+------+
| null |
+------+
Explanation:
There are no single numbers in the input table so we return null.
*/

# [SETTING]
USE practice;
DROP TABLE MyNumbers;
CREATE TABLE MyNumbers
(
    num INT
);
INSERT INTO MyNumbers
    (num)
VALUES ('8'),
    ('8'),
    ('3'),
    ('3'),
    ('1'),
    ('4'),
    ('5'),
    ('6');
SELECT *
FROM MyNumbers; 

# [WRONG]
SELECT MAX(num)
FROM MyNumbers
GROUP BY num -- GROUP BY를 사용하면, 해당 컬럼을 SELECT문에서 사용하는 것을 권장
HAVING COUNT(num) = 1; 

# [WRONG]
# 위 WRONG 쿼리는 아래 쿼리와 동일하다. 
# GROUP BY를 했기 때문에 num은 자기 자신 1개씩 나올텐데, 그 1개 중에 MAX이면 그 또한 자기 자신이다.
SELECT
    num,
    MAX(num)
FROM MyNumbers
GROUP BY num
HAVING COUNT(num) = 1; 

# [MYSQL]
SELECT
    MAX(num) AS num
FROM (
	SELECT
		num
	FROM MyNumbers
    GROUP BY num
    HAVING COUNT(num) = 1
) AS a; 
