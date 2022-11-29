197. Rising Temperature

link: https://leetcode.com/problems/rising-temperature/

-- TABLE SCHEMA
Create table If Not Exists Weather (id int, recordDate date, temperature int);
Truncate table Weather;
insert into Weather (id, recordDate, temperature) values ('1', '2015-01-01', '10');
insert into Weather (id, recordDate, temperature) values ('2', '2015-01-02', '25');
insert into Weather (id, recordDate, temperature) values ('3', '2015-01-03', '20');
insert into Weather (id, recordDate, temperature) values ('4', '2015-01-04', '30');

-- PROBLEM STATEMENT

Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the primary key for this table.
This table contains information about the temperature on a certain day.
 

Write an SQL query to find all dates Id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+
Explanation: 
In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
In 2015-01-04, the temperature was higher than the previous day (20 -> 30).

-- SOLUTION 

select w1.id
from 
weather w1,
weather w2
where 
/* 
This expression is the most beautiful one where we 
are trying to match the d2 with d1 by adding +1 to it... 
*/
to_days(w1.recordDate) = to_days(w2.recordDate) + 1
and w1.temperature > w2.temperature

-- SECOND SOLUTION USING LAG + CTE + CASE 
-- CODE AUTHOR NAVEEN KUMAR VADLAMUDI

WITH CTE AS 
(
SELECT *
FROM WEATHER 
ORDER BY RECORDDATE ASC
)

SELECT ID
FROM 
(
    SELECT 
    CASE 
        WHEN TEMPERATURE > LAG(TEMPERATURE) OVER() AND DATEDIFF(RECORDDATE,LAG(RECORDDATE)OVER()) = 1 THEN ID
    END AS ID
    FROM CTE
) AS A
WHERE A.ID IS NOT NULL
