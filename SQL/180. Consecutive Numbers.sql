180. Consecutive Numbers
Medium
Link: https://leetcode.com/problems/consecutive-numbers/

/*

Create table If Not Exists Logs (id int, num int)
Truncate table Logs
insert into Logs (id, num) values ('1', '1')
insert into Logs (id, num) values ('2', '1')
insert into Logs (id, num) values ('3', '1')
insert into Logs (id, num) values ('4', '2')
insert into Logs (id, num) values ('5', '1')
insert into Logs (id, num) values ('6', '2')
insert into Logs (id, num) values ('7', '2')

*/

Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
id is the primary key for this table.
id is an autoincrement column.
 

Write an SQL query to find all numbers that appear at least three times consecutively.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
Explanation: 1 is the only number that appears consecutively for at least three times.

--SOLUTION

# Code Author Naveen Kumar Vadlamudi
# Solution Using LEAD 


SELECT DISTINCT 
NUM AS ConsecutiveNums
FROM 
(
        SELECT
        ID,
        NUM,
        ABS(NUM - LEAD(NUM) OVER()) AS STATUS_FLAG,
        ABS(ID - LEAD(ID) OVER()) AS LEAD_STATUS
        FROM 
        ( 
                SELECT
                    ID,
                    NUM
                FROM  
                (
                    SELECT 
                    ID, NUM,
                    ABS(NUM - LEAD(NUM) OVER()) AS STATUS_FLAG 
                    FROM LOGS 
                ) AS A 
                WHERE A.STATUS_FLAG = 0

        ) AS B 
) AS C
WHERE C.STATUS_FLAG = 0 AND C.LEAD_STATUS = 1

