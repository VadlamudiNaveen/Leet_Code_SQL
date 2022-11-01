1459. Rectangles Area
MEDIUM

/*
Create table If Not Exists Points (id int, x_value int, y_value int)
Truncate table Points
insert into Points (id, x_value, y_value) values ('1', '2', '7')
insert into Points (id, x_value, y_value) values ('2', '4', '8')
insert into Points (id, x_value, y_value) values ('3', '2', '10')
*/
Table: Points

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| x_value       | int     |
| y_value       | int     |
+---------------+---------+
id is the primary key for this table.
Each point is represented as a 2D coordinate (x_value, y_value).
 

Write an SQL query to report all possible axis-aligned rectangles with a non-zero area that can be formed by any two points from the Points table.

Each row in the result should contain three columns (p1, p2, area) where:

p1 and p2 are the ids of the two points that determine the opposite corners of a rectangle.
area is the area of the rectangle and must be non-zero.
Return the result table ordered by area in descending order. If there is a tie, order them by p1 in ascending order. If there is still a tie, order them by p2 in ascending order.

The query result format is in the following table.

 

Example 1:


Input: 
Points table:
+----------+-------------+-------------+
| id       | x_value     | y_value     |
+----------+-------------+-------------+
| 1        | 2           | 7           |
| 2        | 4           | 8           |
| 3        | 2           | 10          |
+----------+-------------+-------------+
Output: 
+----------+-------------+-------------+
| p1       | p2          | area        |
+----------+-------------+-------------+
| 2        | 3           | 4           |
| 1        | 2           | 2           |
+----------+-------------+-------------+
Explanation: 
The rectangle formed by p1 = 2 and p2 = 3 has an area equal to |4-2| * |8-10| = 4.
The rectangle formed by p1 = 1 and p2 = 2 has an area equal to |2-4| * |7-8| = 2.
Note that the rectangle formed by p1 = 1 and p2 = 3 is invalid because the area is 0.

--SOLUTION 
# Code Author Naveen Kumar Vadlamudi 

WITH CTE AS 
(
SELECT 
P.ID AS P1, PP.ID AS P2, ABS(P.X_VALUE - PP.X_VALUE) * ABS(P.Y_VALUE - PP.Y_VALUE) AS AREA
FROM POINTS AS P JOIN POINTS AS PP 
ON P.ID != PP.ID AND P.ID < PP.ID
)

SELECT 
P1, P2, AREA
FROM CTE 
WHERE AREA != 0 
ORDER BY AREA DESC, P1, P2 ASC


