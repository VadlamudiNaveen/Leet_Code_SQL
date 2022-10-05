1613. Find the Missing IDs

Medium

/*
Create table If Not Exists Customers (customer_id int, customer_name varchar(20))
Truncate table Customers
insert into Customers (customer_id, customer_name) values ('1', 'Alice')
insert into Customers (customer_id, customer_name) values ('4', 'Bob')
insert into Customers (customer_id, customer_name) values ('5', 'Charlie')
*/

Table: Customers

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| customer_name | varchar |
+---------------+---------+
customer_id is the primary key for this table.
Each row of this table contains the name and the id customer.
 

Write an SQL query to find the missing customer IDs. The missing IDs are ones that are not in the Customers table but are in the range between 1 and the maximum customer_id present in the table.

Notice that the maximum customer_id will not exceed 100.

Return the result table ordered by ids in ascending order.

The query result format is in the following example.

 

Example 1:

Input: 
Customers table:
+-------------+---------------+
| customer_id | customer_name |
+-------------+---------------+
| 1           | Alice         |
| 4           | Bob           |
| 5           | Charlie       |
+-------------+---------------+
Output: 
+-----+
| ids |
+-----+
| 2   |
| 3   |
+-----+
Explanation: 
The maximum customer_id present in the table is 5, so in the range [1,5], IDs 2 and 3 are missing from the table.

--solution 
WITH RECURSIVE CTE AS 
(
SELECT  1 AS IDS UNION ALL SELECT IDS + 1 AS IDS FROM CTE WHERE IDS < 100
)


SELECT ids 
FROM CTE WHERE IDS < (SELECT MAX(CUSTOMER_ID) FROM CUSTOMERS) AND 
IDS NOT IN (SELECT CUSTOMER_ID FROM CUSTOMERS)
ORDER BY IDS 