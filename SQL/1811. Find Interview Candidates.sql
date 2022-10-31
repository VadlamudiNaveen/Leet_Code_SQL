1811. Find Interview Candidates
/*
Create table If Not Exists Contests (contest_id int, gold_medal int, silver_medal int, bronze_medal int)
Create table If Not Exists Users (user_id int, mail varchar(50), name varchar(30))
Truncate table Contests
insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('190', '1', '5', '2')
insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('191', '2', '3', '5')
insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('192', '5', '2', '3')
insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('193', '1', '3', '5')
insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('194', '4', '5', '2')
insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('195', '4', '2', '1')
insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('196', '1', '5', '2')
Truncate table Users
insert into Users (user_id, mail, name) values ('1', 'sarah@leetcode.com', 'Sarah')
insert into Users (user_id, mail, name) values ('2', 'bob@leetcode.com', 'Bob')
insert into Users (user_id, mail, name) values ('3', 'alice@leetcode.com', 'Alice')
insert into Users (user_id, mail, name) values ('4', 'hercy@leetcode.com', 'Hercy')
insert into Users (user_id, mail, name) values ('5', 'quarz@leetcode.com', 'Quarz')
*/
Table: Contests

+--------------+------+
| Column Name  | Type |
+--------------+------+
| contest_id   | int  |
| gold_medal   | int  |
| silver_medal | int  |
| bronze_medal | int  |
+--------------+------+
contest_id is the primary key for this table.
This table contains the LeetCode contest ID and the user IDs of the gold, silver, and bronze medalists.
It is guaranteed that any consecutive contests have consecutive IDs and that no ID is skipped.
 

Table: Users

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| mail        | varchar |
| name        | varchar |
+-------------+---------+
user_id is the primary key for this table.
This table contains information about the users.
 

Write an SQL query to report the name and the mail of all interview candidates. A user is an interview candidate if at least one of these two conditions is true:

The user won any medal in three or more consecutive contests.
The user won the gold medal in three or more different contests (not necessarily consecutive).
Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Contests table:
+------------+------------+--------------+--------------+
| contest_id | gold_medal | silver_medal | bronze_medal |
+------------+------------+--------------+--------------+
| 190        | 1          | 5            | 2            |
| 191        | 2          | 3            | 5            |
| 192        | 5          | 2            | 3            |
| 193        | 1          | 3            | 5            |
| 194        | 4          | 5            | 2            |
| 195        | 4          | 2            | 1            |
| 196        | 1          | 5            | 2            |
+------------+------------+--------------+--------------+
Users table:
+---------+--------------------+-------+
| user_id | mail               | name  |
+---------+--------------------+-------+
| 1       | sarah@leetcode.com | Sarah |
| 2       | bob@leetcode.com   | Bob   |
| 3       | alice@leetcode.com | Alice |
| 4       | hercy@leetcode.com | Hercy |
| 5       | quarz@leetcode.com | Quarz |
+---------+--------------------+-------+
Output: 
+-------+--------------------+
| name  | mail               |
+-------+--------------------+
| Sarah | sarah@leetcode.com |
| Bob   | bob@leetcode.com   |
| Alice | alice@leetcode.com |
| Quarz | quarz@leetcode.com |
+-------+--------------------+
Explanation: 
Sarah won 3 gold medals (190, 193, and 196), so we include her in the result table.
Bob won a medal in 3 consecutive contests (190, 191, and 192), so we include him in the result table.
    - Note that he also won a medal in 3 other consecutive contests (194, 195, and 196).
Alice won a medal in 3 consecutive contests (191, 192, and 193), so we include her in the result table.
Quarz won a medal in 5 consecutive contests (190, 191, 192, 193, and 194), so we include them in the result table.
 

Follow up:

What if the first condition changed to be "any medal in n or more consecutive contests"? How would you change your solution to get the interview candidates? Imagine that n is the parameter of a stored procedure.
Some users may not participate in every contest but still perform well in the ones they do. How would you change your solution to only consider contests where the user was a participant? Suppose the registered users for each contest are given in another table.

---Solution

# Code Author Naveen Kumar Vadlamudi 
# Used Custom logic to filter out the users 
# that are consecutively repeated for 3 or more times.


WITH CTE AS  
(
        SELECT *
        FROM 
        (
        SELECT
        CONTEST_ID, GOLD_MEDAL AS USER_ID
        FROM CONTESTS

        UNION 

        SELECT 
        CONTEST_ID, SILVER_MEDAL AS USER_ID
        FROM CONTESTS

        UNION 

        SELECT 
        CONTEST_ID, BRONZE_MEDAL AS USER_ID
        FROM CONTESTS
        ) AS A
        ORDER BY USER_ID, CONTEST_ID
), FILTERED_USERS AS 
(
        SELECT 
        GOLD_MEDAL AS USER_ID
        FROM CONTESTS
        GROUP BY GOLD_MEDAL
        HAVING COUNT(*) >= 3

        UNION 

        SELECT C.USER_ID
        FROM 
        (
        SELECT  USER_ID, 
                CONTEST_ID, 
                ABS(CONTEST_ID - LAG(CONTEST_ID) 
                OVER(PARTITION BY USER_ID ORDER BY CONTEST_ID)) AS DIFF
        FROM 
        (
            SELECT USER_ID, CONTEST_ID
            FROM 
            (
                SELECT 
                USER_ID, CONTEST_ID, ABS(CONTEST_ID - LAG(CONTEST_ID) 
                OVER(PARTITION BY USER_ID ORDER BY CONTEST_ID)) AS DIFF
                FROM CTE
            ) AS A
            WHERE DIFF = 1 
        ) AS B
        ) AS C
        WHERE C.DIFF = 1
        GROUP BY C.USER_ID
        HAVING COUNT(*) >= 1
)

--- One Approach...
SELECT NAME, MAIL
FROM FILTERED_USERS AS FU JOIN USERS AS U
ON FU.USER_ID = U.USER_ID

--- Second Approach Instead of Join we can use IN operator..
SELECT 
NAME,
MAIL
FROM USERS
WHERE USER_ID IN (SELECT USER_ID FROM FILTERED_USERS)
