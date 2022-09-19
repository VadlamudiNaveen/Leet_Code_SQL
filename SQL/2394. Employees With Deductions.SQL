2394. Employees With Deductions

/*
Create table If Not Exists Employees (employee_id int, needed_hours int)
Create table If Not Exists Logs (employee_id int, in_time datetime, out_time datetime)
Truncate table Employees
insert into Employees (employee_id, needed_hours) values ('1', '20')
insert into Employees (employee_id, needed_hours) values ('2', '12')
insert into Employees (employee_id, needed_hours) values ('3', '2')
Truncate table Logs
insert into Logs (employee_id, in_time, out_time) values ('1', '2022-10-01 09:00:00', '2022-10-01 17:00:00')
insert into Logs (employee_id, in_time, out_time) values ('1', '2022-10-06 09:05:04', '2022-10-06 17:09:03')
insert into Logs (employee_id, in_time, out_time) values ('1', '2022-10-12 23:00:00', '2022-10-13 03:00:01')
insert into Logs (employee_id, in_time, out_time) values ('2', '2022-10-29 12:00:00', '2022-10-29 23:58:58')
*/
Table: Employees

+--------------+------+
| Column Name  | Type |
+--------------+------+
| employee_id  | int  |
| needed_hours | int  |
+--------------+------+
employee_id is the primary key for this table.
Each row contains the id of an employee and the minimum number of hours needed for them to work to get their salary.
 

Table: Logs

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| in_time     | datetime |
| out_time    | datetime |
+-------------+----------+
(employee_id, in_time, out_time) is the primary key for this table.
Each row of this table shows the time stamps for an employee. in_time is the time the employee started to work, and out_time is the time the employee ended work.
All the times are in October 2022. out_time can be one day after in_time which means the employee worked after the midnight.
 

In a company, each employee must work a certain number of hours every month. Employees work in sessions. The number of hours an employee worked can be calculated from the sum of the number of minutes the employee worked in all of their sessions. The number of minutes in each session is rounded up.

For example, if the employee worked for 51 minutes and 2 seconds in a session, we consider it 52 minutes.
Write an SQL query to report the IDs of the employees that will be deducted. In other words, report the IDs of the employees that did not work the needed hours.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Employees table:
+-------------+--------------+
| employee_id | needed_hours |
+-------------+--------------+
| 1           | 20           |
| 2           | 12           |
| 3           | 2            |
+-------------+--------------+
Logs table:
+-------------+---------------------+---------------------+
| employee_id | in_time             | out_time            |
+-------------+---------------------+---------------------+
| 1           | 2022-10-01 09:00:00 | 2022-10-01 17:00:00 |
| 1           | 2022-10-06 09:05:04 | 2022-10-06 17:09:03 |
| 1           | 2022-10-12 23:00:00 | 2022-10-13 03:00:01 |
| 2           | 2022-10-29 12:00:00 | 2022-10-29 23:58:58 |
+-------------+---------------------+---------------------+
Output: 
+-------------+
| employee_id |
+-------------+
| 2           |
| 3           |
+-------------+
Explanation: 
Employee 1:
 - Worked for three sessions:
    - On 2022-10-01, they worked for 8 hours.
    - On 2022-10-06, they worked for 8 hours and 4 minutes.
    - On 2022-10-12, they worked for 4 hours and 1 minute. Note that they worked through midnight.
 - Employee 1 worked a total of 20 hours and 5 minutes across sessions and will not be deducted.
Employee 2:
 - Worked for one session:
    - On 2022-10-29, they worked for 11 hours and 59 minutes.
 - Employee 2 did not work their hours and will be deducted.
Employee 3:
 - Did not work any session.
 - Employee 3 did not work their hours and will be deducted.

 ---SOLUTION
 
 WITH HOURS_WORKED AS 
(
        SELECT 
        E.EMPLOYEE_ID,
        CASE 
             WHEN SUM(CEIL(TIMESTAMPDIFF(SECOND,L.IN_TIME,L.OUT_TIME)/60)/60) > 0 THEN 
                  SUM(CEIL(TIMESTAMPDIFF(SECOND,L.IN_TIME,L.OUT_TIME)/60)/60)
             ELSE 0
        END
        AS WORKED_HOURS
        FROM EMPLOYEES AS E LEFT JOIN LOGS AS L
        ON E.EMPLOYEE_ID = L.EMPLOYEE_ID
        GROUP BY E.EMPLOYEE_ID
)

SELECT 
E.EMPLOYEE_ID
FROM EMPLOYEES AS E JOIN HOURS_WORKED AS HW
ON E.EMPLOYEE_ID = HW.EMPLOYEE_ID
WHERE E.NEEDED_HOURS > HW.WORKED_HOURS


