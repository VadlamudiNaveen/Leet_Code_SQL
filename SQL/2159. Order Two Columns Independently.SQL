2159. Order Two Columns Independently
/*
Create table If Not Exists Data (first_col int, second_col int)
Truncate table Data
insert into Data (first_col, second_col) values ('4', '2')
insert into Data (first_col, second_col) values ('2', '3')
insert into Data (first_col, second_col) values ('3', '1')
insert into Data (first_col, second_col) values ('1', '4')
*/
Table: Data

+-------------+------+
| Column Name | Type |
+-------------+------+
| first_col   | int  |
| second_col  | int  |
+-------------+------+
There is no primary key for this table and it may contain duplicates.
 

Write an SQL query to independently:

order first_col in ascending order.
order second_col in descending order.
The query result format is in the following example.

 

Example 1:

Input: 
Data table:
+-----------+------------+
| first_col | second_col |
+-----------+------------+
| 4         | 2          |
| 2         | 3          |
| 3         | 1          |
| 1         | 4          |
+-----------+------------+
Output: 
+-----------+------------+
| first_col | second_col |
+-----------+------------+
| 1         | 4          |
| 2         | 3          |
| 3         | 2          |
| 4         | 1          |
+-----------+------------+

--SOLUTION
WITH COL1 AS 
(
    SELECT FIRST_COL, ROW_NUMBER() OVER() AS SECOND_COL
    FROM DATA 
    ORDER BY FIRST_COL
) ,
COL2 AS (
    SELECT 
    ROW_NUMBER() OVER() AS FIRST_COL ,SECOND_COL
    FROM DATA
    ORDER BY SECOND_COL DESC 
) 

SELECT  COL1.FIRST_COL, COL2.SECOND_COL
FROM COL1 JOIN COL2 
ON COL1.SECOND_COL = COL2.FIRST_COL 
