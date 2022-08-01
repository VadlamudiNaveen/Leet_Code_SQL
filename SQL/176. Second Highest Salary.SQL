176. Second Highest Salary

/*Create table If Not Exists Employee (id int, salary int)
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
 

Write an SQL query to report the second highest salary from the Employee table. If there is no second highest salary, the query should report null.

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
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+

--SOLUTION 1
SELECT MAX(SALARY) AS SECONDHIGHESTSALARY
FROM EMPLOYEE 
WHERE SALARY < (SELECT MAX(SALARY) FROM EMPLOYEE);

--SOLUTION 2 
select 
    case 
    when salary is null then null
    else salary
    end as SecondHighestSalary
from (select distinct salary from employee order by salary desc limit 2 ) as t1
order by salary limit 1

--SOLUTION 3

select 
(select distinct Salary
from Employee 
order by Salary desc limit 1,1) as SecondHighestSalary
from dual