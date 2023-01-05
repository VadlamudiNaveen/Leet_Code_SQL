1454. Active Users

-- Data Model
Create table If Not Exists Accounts (id int, name varchar(10));
Create table If Not Exists Logins (id int, login_date date);
Truncate table Accounts;
insert into Accounts (id, name) values ('1', 'Winston');
insert into Accounts (id, name) values ('7', 'Jonathan');
Truncate table Logins;
insert into Logins (id, login_date) values ('7', '2020-05-30');
insert into Logins (id, login_date) values ('1', '2020-05-30');
insert into Logins (id, login_date) values ('7', '2020-05-31');
insert into Logins (id, login_date) values ('7', '2020-06-01');
insert into Logins (id, login_date) values ('7', '2020-06-02');
insert into Logins (id, login_date) values ('7', '2020-06-02');
insert into Logins (id, login_date) values ('7', '2020-06-03');
insert into Logins (id, login_date) values ('1', '2020-06-07');
insert into Logins (id, login_date) values ('7', '2020-06-10');

-- Problem Statement 

Table: Accounts

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
+---------------+---------+
id is the primary key for this table.
This table contains the account id and the user name of each account.
 

Table: Logins

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| login_date    | date    |
+---------------+---------+
There is no primary key for this table, it may contain duplicates.
This table contains the account id of the user who logged in and the login date. A user may log in multiple times in the day.
 

Active users are those who logged in to their accounts for five or more consecutive days.

Write an SQL query to find the id and the name of active users.

Return the result table ordered by id.

The query result format is in the following example.

 

Example 1:

Input: 
Accounts table:
+----+----------+
| id | name     |
+----+----------+
| 1  | Winston  |
| 7  | Jonathan |
+----+----------+
Logins table:
+----+------------+
| id | login_date |
+----+------------+
| 7  | 2020-05-30 |
| 1  | 2020-05-30 |
| 7  | 2020-05-31 |
| 7  | 2020-06-01 |
| 7  | 2020-06-02 |
| 7  | 2020-06-02 |
| 7  | 2020-06-03 |
| 1  | 2020-06-07 |
| 7  | 2020-06-10 |
+----+------------+
Output: 
+----+----------+
| id | name     |
+----+----------+
| 7  | Jonathan |
+----+----------+
Explanation: 
User Winston with id = 1 logged in 2 times only in 2 different days, so, Winston is not an active user.
User Jonathan with id = 7 logged in 7 times in 6 different days, five of them were consecutive days, so, Jonathan is an active user.
 

Follow up: Could you write a general solution if the active users are those who logged in to their accounts for n or more consecutive days?

-- Solution 

# Code Author Naveen Kumar Vadlamudi
# Solution Using ROW_NUMBER technique + GROUP BY 
# So after trying my own logic using LAG 
# and finding the difference between the most recent value ..
# it has some limitations where we cant perform N like operations as the following 
# link provided here 
# http://leetcode.com/problems/find-interview-candidates/discuss/2761922/Super-Simple-Solution-Using-JOIN-%2B-CTE


# So this approach follows, a simple technique by using ROW_NUMBER
# Try to execute the following snippet

		SELECT 
		ID,
        LOGIN_DATE,
        ROW_NUMBER() OVER(PARTITION BY ID ORDER BY LOGIN_DATE) AS RN
        FROM 
        (
            SELECT 
            DISTINCT *
            FROM LOGINS
        ) AS A	
		
# result is the following  
[1, "2020-05-30", 1]
[1, "2020-06-07", 2] 
[7, "2020-05-30", 1] 
[7, "2020-05-31", 2] 
[7, "2020-06-01", 3] 
[7, "2020-06-02", 4] 
[7, "2020-06-03", 5] 
[7, "2020-06-10", 6]

# Now inorder to say that, they are consecutive 
# we will perform a difference operation as shown in the below snippet at group by.
# By doing this our solution looks like the following.

[1, "2020-05-29"]
[1, "2020-06-05"]
[7, "2020-05-29"] 
[7, "2020-05-29"] 
[7, "2020-06-29"] 
[7, "2020-06-29"] 
[7, "2020-06-29"] 
[7, "2020-06-29"]


-- Final Solution 
-- Code Author Naveen Kumar Vadlamudi

SELECT *
FROM ACCOUNTS
WHERE ID IN 
(
    SELECT 
    ID
    FROM 
    (
        SELECT 
        ID,
        LOGIN_DATE,
        ROW_NUMBER() OVER(PARTITION BY ID ORDER BY LOGIN_DATE) AS RN
        FROM 
        (
            SELECT 
            DISTINCT *
            FROM LOGINS
        ) AS A
    ) AS B
    GROUP BY ID, DATE_SUB(LOGIN_DATE, INTERVAL RN DAY)
    HAVING COUNT(*) >= 5
)
ORDER BY ID