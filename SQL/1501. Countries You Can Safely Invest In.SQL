1501. Countries You Can Safely Invest In
Medium

/*
Create table If Not Exists Person (id int, name varchar(15), phone_number varchar(11))
Create table If Not Exists Country (name varchar(15), country_code varchar(3))
Create table If Not Exists Calls (caller_id int, callee_id int, duration int)
Truncate table Person
insert into Person (id, name, phone_number) values ('3', 'Jonathan', '051-1234567')
insert into Person (id, name, phone_number) values ('12', 'Elvis', '051-7654321')
insert into Person (id, name, phone_number) values ('1', 'Moncef', '212-1234567')
insert into Person (id, name, phone_number) values ('2', 'Maroua', '212-6523651')
insert into Person (id, name, phone_number) values ('7', 'Meir', '972-1234567')
insert into Person (id, name, phone_number) values ('9', 'Rachel', '972-0011100')
Truncate table Country
insert into Country (name, country_code) values ('Peru', '051')
insert into Country (name, country_code) values ('Israel', '972')
insert into Country (name, country_code) values ('Morocco', '212')
insert into Country (name, country_code) values ('Germany', '049')
insert into Country (name, country_code) values ('Ethiopia', '251')
Truncate table Calls
insert into Calls (caller_id, callee_id, duration) values ('1', '9', '33')
insert into Calls (caller_id, callee_id, duration) values ('2', '9', '4')
insert into Calls (caller_id, callee_id, duration) values ('1', '2', '59')
insert into Calls (caller_id, callee_id, duration) values ('3', '12', '102')
insert into Calls (caller_id, callee_id, duration) values ('3', '12', '330')
insert into Calls (caller_id, callee_id, duration) values ('12', '3', '5')
insert into Calls (caller_id, callee_id, duration) values ('7', '9', '13')
insert into Calls (caller_id, callee_id, duration) values ('7', '1', '3')
insert into Calls (caller_id, callee_id, duration) values ('9', '7', '1')
insert into Calls (caller_id, callee_id, duration) values ('1', '7', '7')
*/

Table Person:

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| id             | int     |
| name           | varchar |
| phone_number   | varchar |
+----------------+---------+
id is the primary key for this table.
Each row of this table contains the name of a person and their phone number.
Phone number will be in the form 'xxx-yyyyyyy' where xxx is the country code (3 characters) and yyyyyyy is the phone number (7 characters) where x and y are digits. Both can contain leading zeros.
 

Table Country:

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| name           | varchar |
| country_code   | varchar |
+----------------+---------+
country_code is the primary key for this table.
Each row of this table contains the country name and its code. country_code will be in the form 'xxx' where x is digits.
 

Table Calls:

+-------------+------+
| Column Name | Type |
+-------------+------+
| caller_id   | int  |
| callee_id   | int  |
| duration    | int  |
+-------------+------+
There is no primary key for this table, it may contain duplicates.
Each row of this table contains the caller id, callee id and the duration of the call in minutes. caller_id != callee_id
 

A telecommunications company wants to invest in new countries. The company intends to invest in the countries where the average call duration of the calls in this country is strictly greater than the global average call duration.

Write an SQL query to find the countries where this company can invest.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Person table:
+----+----------+--------------+
| id | name     | phone_number |
+----+----------+--------------+
| 3  | Jonathan | 051-1234567  |
| 12 | Elvis    | 051-7654321  |
| 1  | Moncef   | 212-1234567  |
| 2  | Maroua   | 212-6523651  |
| 7  | Meir     | 972-1234567  |
| 9  | Rachel   | 972-0011100  |
+----+----------+--------------+
Country table:
+----------+--------------+
| name     | country_code |
+----------+--------------+
| Peru     | 051          |
| Israel   | 972          |
| Morocco  | 212          |
| Germany  | 049          |
| Ethiopia | 251          |
+----------+--------------+
Calls table:
+-----------+-----------+----------+
| caller_id | callee_id | duration |
+-----------+-----------+----------+
| 1         | 9         | 33       |
| 2         | 9         | 4        |
| 1         | 2         | 59       |
| 3         | 12        | 102      |
| 3         | 12        | 330      |
| 12        | 3         | 5        |
| 7         | 9         | 13       |
| 7         | 1         | 3        |
| 9         | 7         | 1        |
| 1         | 7         | 7        |
+-----------+-----------+----------+
Output: 
+----------+
| country  |
+----------+
| Peru     |
+----------+
Explanation: 
The average call duration for Peru is (102 + 102 + 330 + 330 + 5 + 5) / 6 = 145.666667
The average call duration for Israel is (33 + 4 + 13 + 13 + 3 + 1 + 1 + 7) / 8 = 9.37500
The average call duration for Morocco is (33 + 4 + 59 + 59 + 3 + 7) / 6 = 27.5000 
Global call duration average = (2 * (33 + 4 + 59 + 102 + 330 + 5 + 13 + 3 + 1 + 7)) / 20 = 55.70000
Since Peru is the only country where the average call duration is greater than the global average, it is the only recommended country.

--SOLUTION

WITH COUNTRY_DESC AS 
(
    SELECT 
    P.ID,
    C.NAME AS COUNTRY
    FROM PERSON AS P JOIN COUNTRY AS C
    ON SUBSTR(P.PHONE_NUMBER,1,3) = C.COUNTRY_CODE
), 
GLOBAL_AVG AS 
(
   SELECT AVG(DURATION) AS GLOBAL_AVG
   FROM CALLS    
),  
DURATION AS
(
        SELECT 
        CALLER_ID, 
        SUM(TDURATION) AS TDURATION,
        SUM(TCOUNT) AS TCOUNT
        FROM 
        (
                SELECT 
                    CALLER_ID, 
                    SUM(DURATION) AS TDURATION,
                    COUNT(*) AS TCOUNT
                FROM CALLS 
                GROUP BY CALLER_ID
            
                UNION 
            
                SELECT 
                    CALLEE_ID AS CALLER_ID,
                    SUM(DURATION) AS TDURATION,
                    COUNT(*) AS TCOUNT
                FROM CALLS
                GROUP BY CALLEE_ID
        ) AS A
        GROUP BY CALLER_ID
)

SELECT A.COUNTRY
FROM 
(
    SELECT 
    CD.COUNTRY, 
    SUM(D.TDURATION)/ SUM(D.TCOUNT) AS AVERAGE
    FROM DURATION AS D JOIN COUNTRY_DESC AS CD
    ON D.CALLER_ID = CD.ID 
    GROUP BY CD.COUNTRY
    HAVING AVERAGE > (SELECT * FROM GLOBAL_AVG)
) AS A

--SOLUTION 2

WITH COUNTRY_INFO AS 
(
    SELECT 
        P.ID,
        P.NAME,
        C.NAME AS COUNTRY_NAME
    FROM PERSON AS P JOIN COUNTRY AS C  
    ON C.COUNTRY_CODE = SUBSTR(P.PHONE_NUMBER,1,3)
),
GLOBAL_AVG AS 
(
    SELECT (2*SUM(DURATION))/(2*COUNT(*)) AS GLOBAL_AVG 
    FROM CALLS
),
COUNTRY_AVG AS 
(
    SELECT 
    C.CALLER_ID,
    C.CALLEE_ID,
    C.DURATION AS DURATION,
    CI.COUNTRY_NAME
    FROM CALLS AS C JOIN COUNTRY_INFO AS CI
    ON C.CALLER_ID = CI.ID
    
    UNION 
    
    SELECT 
    C.CALLEE_ID AS CALLER_ID,
    C.CALLER_ID AS CALLEE_ID,
    C.DURATION AS DURATION,
    CI.COUNTRY_NAME
    FROM CALLS AS C JOIN COUNTRY_INFO AS CI
    ON C.CALLEE_ID = CI.ID
)

SELECT COUNTRY_NAME AS COUNTRY 
FROM COUNTRY_AVG 
GROUP BY COUNTRY_NAME
HAVING AVG(DURATION) > (SELECT * FROM GLOBAL_AVG)

