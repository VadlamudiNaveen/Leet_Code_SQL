Medium 
link: https://leetcode.com/problems/nth-highest-salary/

/*
Create table If Not Exists Employee (Id int, Salary int)
Truncate table Employee
insert into Employee (id, salary) values ('1', '100')
insert into Employee (id, salary) values ('2', '200')
insert into Employee (id, salary) values ('3', '300')
*/
Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key column for this table.
Each row of this table contains information about the salary of an employee.
 

Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.

The query result format is in the following example.

 

Example 1:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
n = 2
Output: 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
n = 2
Output: 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| null                   |
+------------------------+

--SOLUTION 

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN 
  (
            SELECT DISTINCT
            SALARY AS getNthHighestSalary
            FROM 
            (
            SELECT
            SALARY,
            DENSE_RANK() OVER(ORDER BY SALARY DESC) AS  CRANK  
            FROM EMPLOYEE 
            ) AS A
            WHERE A.CRANK = N
              
  );
END