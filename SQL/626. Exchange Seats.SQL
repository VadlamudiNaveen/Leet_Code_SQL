626. Exchange Seats
Medium
/*
Create table If Not Exists Seat (id int, student varchar(255))
Truncate table Seat
insert into Seat (id, student) values ('1', 'Abbot')
insert into Seat (id, student) values ('2', 'Doris')
insert into Seat (id, student) values ('3', 'Emerson')
insert into Seat (id, student) values ('4', 'Green')
insert into Seat (id, student) values ('5', 'Jeames')
*/
+
Table: Seat

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| student     | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the name and the ID of a student.
id is a continuous increment.
 

Write an SQL query to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

Return the result table ordered by id in ascending order.

The query result format is in the following example.

 

Example 1:

Input: 
Seat table:
+----+---------+
| id | student |
+----+---------+
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |
+----+---------+
Output: 
+----+---------+
| id | student |
+----+---------+
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |
+----+---------+
Explanation: 
Note that if the number of students is odd, there is no need to change the last ones seat.

--1ST Solution 

SELECT
ID,
CASE 
     WHEN ID % 2 = 0 THEN LAG(STUDENT,1) OVER()
     WHEN ID % 2 != 0 AND 
          ID != (SELECT COUNT(*) FROM SEAT) 
          THEN LEAD(STUDENT,1) OVER()
     ELSE STUDENT
END AS STUDENT
FROM SEAT



--2ND SOLUTION  
SELECT
ID,
CASE 
    WHEN ID % 2 != 0 AND ID != (SELECT MAX(ID) FROM  SEAT) 
    THEN LEAD(STUDENT) OVER()
    WHEN ID % 2 != 0 THEN STUDENT
    ELSE LAG(STUDENT) OVER()
END AS STUDENT
FROM SEAT
ORDER BY ID 
