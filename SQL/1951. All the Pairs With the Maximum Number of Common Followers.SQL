1951. All the Pairs With the Maximum Number of Common Followers

/*
Create table If Not Exists Relations (user_id int, follower_id int)
Truncate table Relations
insert into Relations (user_id, follower_id) values ('1', '3')
insert into Relations (user_id, follower_id) values ('2', '3')
insert into Relations (user_id, follower_id) values ('7', '3')
insert into Relations (user_id, follower_id) values ('1', '4')
insert into Relations (user_id, follower_id) values ('2', '4')
insert into Relations (user_id, follower_id) values ('7', '4')
insert into Relations (user_id, follower_id) values ('1', '5')
insert into Relations (user_id, follower_id) values ('2', '6')
insert into Relations (user_id, follower_id) values ('7', '5')
*/

Table: Relations

+-------------+------+
| Column Name | Type |
+-------------+------+
| user_id     | int  |
| follower_id | int  |
+-------------+------+
(user_id, follower_id) is the primary key for this table.
Each row of this table indicates that the user with ID follower_id is following the user with ID user_id.
 

Write an SQL query to find all the pairs of users with the maximum number of common followers. In other words, if the maximum number of common followers between any two users is maxCommon, then you have to return all pairs of users that have maxCommon common followers.

The result table should contain the pairs user1_id and user2_id where user1_id < user2_id.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Relations table:
+---------+-------------+
| user_id | follower_id |
+---------+-------------+
| 1       | 3           |
| 2       | 3           |
| 7       | 3           |
| 1       | 4           |
| 2       | 4           |
| 7       | 4           |
| 1       | 5           |
| 2       | 6           |
| 7       | 5           |
+---------+-------------+
Output: 
+----------+----------+
| user1_id | user2_id |
+----------+----------+
| 1        | 7        |
+----------+----------+
Explanation: 
Users 1 and 2 have two common followers (3 and 4).
Users 1 and 7 have three common followers (3, 4, and 5).
Users 2 and 7 have two common followers (3 and 4).
Since the maximum number of common followers between any two users is 3, we return all pairs of users with three common followers, which is only the pair (1, 7). We return the pair as (1, 7), not as (7, 1).
Note that we do not have any information about the users that follow users 3, 4, and 5, so we consider them to have 0 followers.

--SOLUTION

        SELECT 
        A.USER1_ID, 
        A.USER2_ID  
        FROM 
        (
        SELECT 
            R.USER_ID AS USER1_ID, 
            RR.USER_ID AS USER2_ID, 
            DENSE_RANK()OVER(ORDER BY COUNT(*) DESC) AS CRANK
        FROM RELATIONS AS R JOIN RELATIONS AS RR
        ON R.USER_ID < RR.USER_ID
        AND R.FOLLOWER_ID = RR.FOLLOWER_ID
        GROUP BY R.USER_ID, RR.USER_ID
        )  AS A
        WHERE A.CRANK = 1