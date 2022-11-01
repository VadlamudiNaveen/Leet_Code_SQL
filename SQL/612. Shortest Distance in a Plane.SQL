612. Shortest Distance in a Plane

/*
Create Table If Not Exists Point2D (x int not null, y int not null)
Truncate table Point2D
insert into Point2D (x, y) values ('-1', '-1')
insert into Point2D (x, y) values ('0', '0')
insert into Point2D (x, y) values ('-1', '-2')
*/
Table: Point2D

+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
| y           | int  |
+-------------+------+
(x, y) is the primary key column for this table.
Each row of this table indicates the position of a point on the X-Y plane.
 

The distance between two points p1(x1, y1) and p2(x2, y2) is sqrt((x2 - x1)2 + (y2 - y1)2).

Write an SQL query to report the shortest distance between any two points from the Point2D table. Round the distance to two decimal points.

The query result format is in the following example.

 

Example 1:

Input: 
Point2D table:
+----+----+
| x  | y  |
+----+----+
| -1 | -1 |
| 0  | 0  |
| -1 | -2 |
+----+----+
Output: 
+----------+
| shortest |
+----------+
| 1.00     |
+----------+
Explanation: The shortest distance is 1.00 from point (-1, -1) to (-1, 2).

--SOLUTION
WITH CTE AS  (
SELECT 
SQRT(POWER(PD.X - P2D.X,2) + POWER(PD.Y - P2D.Y,2)) AS VAL
FROM POINT2D AS P2D JOIN POINT2D AS PD
WHERE P2D.X != PD.X OR P2D.Y != PD.Y
)

SELECT ROUND(MIN(VAL),2) AS SHORTEST FROM CTE