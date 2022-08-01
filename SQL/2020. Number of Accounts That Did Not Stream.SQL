2020. Number of Accounts That Did Not Stream
Medium
/*
Create table If Not Exists Subscriptions (account_id int, start_date date, end_date date)
Create table If Not Exists Streams (session_id int, account_id int, stream_date date)
Truncate table Subscriptions
insert into Subscriptions (account_id, start_date, end_date) values ('9', '2020-02-18', '2021-10-30')
insert into Subscriptions (account_id, start_date, end_date) values ('3', '2021-09-21', '2021-11-13')
insert into Subscriptions (account_id, start_date, end_date) values ('11', '2020-02-28', '2020-08-18')
insert into Subscriptions (account_id, start_date, end_date) values ('13', '2021-04-20', '2021-09-22')
insert into Subscriptions (account_id, start_date, end_date) values ('4', '2020-10-26', '2021-05-08')
insert into Subscriptions (account_id, start_date, end_date) values ('5', '2020-09-11', '2021-01-17')
Truncate table Streams
insert into Streams (session_id, account_id, stream_date) values ('14', '9', '2020-05-16')
insert into Streams (session_id, account_id, stream_date) values ('16', '3', '2021-10-27')
insert into Streams (session_id, account_id, stream_date) values ('18', '11', '2020-04-29')
insert into Streams (session_id, account_id, stream_date) values ('17', '13', '2021-08-08')
insert into Streams (session_id, account_id, stream_date) values ('19', '4', '2020-12-31')
insert into Streams (session_id, account_id, stream_date) values ('13', '5', '2021-01-05')
*/
Table: Subscriptions

+-------------+------+
| Column Name | Type |
+-------------+------+
| account_id  | int  |
| start_date  | date |
| end_date    | date |
+-------------+------+
account_id is the primary key column for this table.
Each row of this table indicates the start and end dates of an accounts subscription.
Note that always start_date < end_date.
 

Table: Streams

+-------------+------+
| Column Name | Type |
+-------------+------+
| session_id  | int  |
| account_id  | int  |
| stream_date | date |
+-------------+------+
session_id is the primary key column for this table.
account_id is a foreign key from the Subscriptions table.
Each row of this table contains information about the account and the date associated with a stream session.
 

Write an SQL query to report the number of accounts that bought a subscription in 2021 but did not have any stream session.

The query result format is in the following example.

 

Example 1:

Input: 
Subscriptions table:
+------------+------------+------------+
| account_id | start_date | end_date   |
+------------+------------+------------+
| 9          | 2020-02-18 | 2021-10-30 |
| 3          | 2021-09-21 | 2021-11-13 |
| 11         | 2020-02-28 | 2020-08-18 |
| 13         | 2021-04-20 | 2021-09-22 |
| 4          | 2020-10-26 | 2021-05-08 |
| 5          | 2020-09-11 | 2021-01-17 |
+------------+------------+------------+
Streams table:
+------------+------------+-------------+
| session_id | account_id | stream_date |
+------------+------------+-------------+
| 14         | 9          | 2020-05-16  |
| 16         | 3          | 2021-10-27  |
| 18         | 11         | 2020-04-29  |
| 17         | 13         | 2021-08-08  |
| 19         | 4          | 2020-12-31  |
| 13         | 5          | 2021-01-05  |
+------------+------------+-------------+
Output: 
+----------------+
| accounts_count |
+----------------+
| 2              |
+----------------+
Explanation: Users 4 and 9 did not stream in 2021.
User 11 did not subscribe in 2021.


--WORKING SOLUTION

SELECT COUNT(*) AS ACCOUNTS_COUNT
FROM SUBSCRIPTIONS 
WHERE ACCOUNT_ID IN (SELECT 
                     ACCOUNT_ID 
                     FROM STREAMS 
                     WHERE YEAR(STREAM_DATE) = 2020
                    )
AND YEAR(START_DATE) IN (2020,2021) AND YEAR(END_DATE) IN (2021)


--- UNUNSED LOGIC -> USING CUR_ROW_IND FOR DATA TRACKING 
(
    SELECT 
    SUB.ACCOUNT_ID, 
    CASE   
        WHEN 
        YEAR(SUB.START_DATE) IN (2020,2021) AND YEAR(SUB.END_DATE) IN (2021) 
        THEN 'Y'
        ELSE 'N'
    END AS IS_SUBSRIBED
    FROM SUBSCRIPTIONS 
) AS SUB