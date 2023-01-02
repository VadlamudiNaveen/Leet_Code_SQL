-- Table Schema
Create table If Not Exists Calls (from_id int, to_id int, duration int)
Truncate table Calls
insert into Calls (from_id, to_id, duration) values ('1', '2', '59')
insert into Calls (from_id, to_id, duration) values ('2', '1', '11')
insert into Calls (from_id, to_id, duration) values ('1', '3', '20')
insert into Calls (from_id, to_id, duration) values ('3', '4', '100')
insert into Calls (from_id, to_id, duration) values ('3', '4', '200')
insert into Calls (from_id, to_id, duration) values ('3', '4', '200')
insert into Calls (from_id, to_id, duration) values ('4', '3', '499')

-- Problem Definition
Table: Calls

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| from_id     | int     |
| to_id       | int     |
| duration    | int     |
+-------------+---------+
This table does not have a primary key, it may contain duplicates.
This table contains the duration of a phone call between from_id and to_id.
from_id != to_id
 

Write an SQL query to report the number of calls and the total call duration between each pair of distinct persons (person1, person2) where person1 < person2.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Calls table:
+---------+-------+----------+
| from_id | to_id | duration |
+---------+-------+----------+
| 1       | 2     | 59       |
| 2       | 1     | 11       |
| 1       | 3     | 20       |
| 3       | 4     | 100      |
| 3       | 4     | 200      |
| 3       | 4     | 200      |
| 4       | 3     | 499      |
+---------+-------+----------+
Output: 
+---------+---------+------------+----------------+
| person1 | person2 | call_count | total_duration |
+---------+---------+------------+----------------+
| 1       | 2       | 2          | 70             |
| 1       | 3       | 1          | 20             |
| 3       | 4       | 4          | 999            |
+---------+---------+------------+----------------+
Explanation: 
Users 1 and 2 had 2 calls and the total duration is 70 (59 + 11).
Users 1 and 3 had 1 call and the total duration is 20.
Users 3 and 4 had 4 calls and the total duration is 999 (100 + 200 + 200 + 499).

--Solution 
# Code Author Naveen Kumar Vadlamudi

SELECT 
FROM_ID AS person1, TO_ID as person2, COUNT(*) AS CALL_COUNT, SUM(DURATION) AS TOTAL_DURATION
FROM 
(
        SELECT FROM_ID, TO_ID, DURATION
        FROM CALLS 

        UNION ALL

        SELECT TO_ID AS FROM_ID, FROM_ID AS TO_ID, DURATION 
        FROM CALLS

) AS A

WHERE FROM_ID < TO_ID
GROUP BY FROM_ID, TO_ID
