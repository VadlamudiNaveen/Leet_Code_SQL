1635. Hopper Company Queries I
/*
Truncate table Drivers
insert into Drivers (driver_id, join_date) values ('10', '2019-12-10')
insert into Drivers (driver_id, join_date) values ('8', '2020-1-13')
insert into Drivers (driver_id, join_date) values ('5', '2020-2-16')
insert into Drivers (driver_id, join_date) values ('7', '2020-3-8')
insert into Drivers (driver_id, join_date) values ('4', '2020-5-17')
insert into Drivers (driver_id, join_date) values ('1', '2020-10-24')
insert into Drivers (driver_id, join_date) values ('6', '2021-1-5')
Truncate table Rides
insert into Rides (ride_id, user_id, requested_at) values ('6', '75', '2019-12-9')
insert into Rides (ride_id, user_id, requested_at) values ('1', '54', '2020-2-9')
insert into Rides (ride_id, user_id, requested_at) values ('10', '63', '2020-3-4')
insert into Rides (ride_id, user_id, requested_at) values ('19', '39', '2020-4-6')
insert into Rides (ride_id, user_id, requested_at) values ('3', '41', '2020-6-3')
insert into Rides (ride_id, user_id, requested_at) values ('13', '52', '2020-6-22')
insert into Rides (ride_id, user_id, requested_at) values ('7', '69', '2020-7-16')
insert into Rides (ride_id, user_id, requested_at) values ('17', '70', '2020-8-25')
insert into Rides (ride_id, user_id, requested_at) values ('20', '81', '2020-11-2')
insert into Rides (ride_id, user_id, requested_at) values ('5', '57', '2020-11-9')
insert into Rides (ride_id, user_id, requested_at) values ('2', '42', '2020-12-9')
insert into Rides (ride_id, user_id, requested_at) values ('11', '68', '2021-1-11')
insert into Rides (ride_id, user_id, requested_at) values ('15', '32', '2021-1-17')
insert into Rides (ride_id, user_id, requested_at) values ('12', '11', '2021-1-19')
insert into Rides (ride_id, user_id, requested_at) values ('14', '18', '2021-1-27')
Truncate table AcceptedRides
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('10', '10', '63', '38')
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('13', '10', '73', '96')
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('7', '8', '100', '28')
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('17', '7', '119', '68')
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('20', '1', '121', '92')
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('5', '7', '42', '101')
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('2', '4', '6', '38')
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('11', '8', '37', '43')
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('15', '8', '108', '82')
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('12', '8', '38', '34')
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('14', '1', '90', '74')
*/

Table: Drivers

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| driver_id   | int     |
| join_date   | date    |
+-------------+---------+
driver_id is the primary key for this table.
Each row of this table contains the driver's ID and the date they joined the Hopper company.
 

Table: Rides

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| ride_id      | int     |
| user_id      | int     |
| requested_at | date    |
+--------------+---------+
ride_id is the primary key for this table.
Each row of this table contains the ID of a ride, the user's ID that requested it, and the day they requested it.
There may be some ride requests in this table that were not accepted.
 

Table: AcceptedRides

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| ride_id       | int     |
| driver_id     | int     |
| ride_distance | int     |
| ride_duration | int     |
+---------------+---------+
ride_id is the primary key for this table.
Each row of this table contains some information about an accepted ride.
It is guaranteed that each accepted ride exists in the Rides table.
 

Write an SQL query to report the following statistics for each month of 2020:

The number of drivers currently with the Hopper company by the end of the month (active_drivers).
The number of accepted rides in that month (accepted_rides).
Return the result table ordered by month in ascending order, where month is the months number (January is 1, February is 2, etc.).

The query result format is in the following example.

 

Example 1:

Input: 
Drivers table:
+-----------+------------+
| driver_id | join_date  |
+-----------+------------+
| 10        | 2019-12-10 |
| 8         | 2020-1-13  |
| 5         | 2020-2-16  |
| 7         | 2020-3-8   |
| 4         | 2020-5-17  |
| 1         | 2020-10-24 |
| 6         | 2021-1-5   |
+-----------+------------+
Rides table:
+---------+---------+--------------+
| ride_id | user_id | requested_at |
+---------+---------+--------------+
| 6       | 75      | 2019-12-9    |
| 1       | 54      | 2020-2-9     |
| 10      | 63      | 2020-3-4     |
| 19      | 39      | 2020-4-6     |
| 3       | 41      | 2020-6-3     |
| 13      | 52      | 2020-6-22    |
| 7       | 69      | 2020-7-16    |
| 17      | 70      | 2020-8-25    |
| 20      | 81      | 2020-11-2    |
| 5       | 57      | 2020-11-9    |
| 2       | 42      | 2020-12-9    |
| 11      | 68      | 2021-1-11    |
| 15      | 32      | 2021-1-17    |
| 12      | 11      | 2021-1-19    |
| 14      | 18      | 2021-1-27    |
+---------+---------+--------------+
AcceptedRides table:
+---------+-----------+---------------+---------------+
| ride_id | driver_id | ride_distance | ride_duration |
+---------+-----------+---------------+---------------+
| 10      | 10        | 63            | 38            |
| 13      | 10        | 73            | 96            |
| 7       | 8         | 100           | 28            |
| 17      | 7         | 119           | 68            |
| 20      | 1         | 121           | 92            |
| 5       | 7         | 42            | 101           |
| 2       | 4         | 6             | 38            |
| 11      | 8         | 37            | 43            |
| 15      | 8         | 108           | 82            |
| 12      | 8         | 38            | 34            |
| 14      | 1         | 90            | 74            |
+---------+-----------+---------------+---------------+
Output: 
+-------+----------------+----------------+
| month | active_drivers | accepted_rides |
+-------+----------------+----------------+
| 1     | 2              | 0              |
| 2     | 3              | 0              |
| 3     | 4              | 1              |
| 4     | 4              | 0              |
| 5     | 5              | 0              |
| 6     | 5              | 1              |
| 7     | 5              | 1              |
| 8     | 5              | 1              |
| 9     | 5              | 0              |
| 10    | 6              | 0              |
| 11    | 6              | 2              |
| 12    | 6              | 1              |
+-------+----------------+----------------+
Explanation: 
By the end of January --> two active drivers (10, 8) and no accepted rides.
By the end of February --> three active drivers (10, 8, 5) and no accepted rides.
By the end of March --> four active drivers (10, 8, 5, 7) and one accepted ride (10).
By the end of April --> four active drivers (10, 8, 5, 7) and no accepted rides.
By the end of May --> five active drivers (10, 8, 5, 7, 4) and no accepted rides.
By the end of June --> five active drivers (10, 8, 5, 7, 4) and one accepted ride (13).
By the end of July --> five active drivers (10, 8, 5, 7, 4) and one accepted ride (7).
By the end of August --> five active drivers (10, 8, 5, 7, 4) and one accepted ride (17).
By the end of September --> five active drivers (10, 8, 5, 7, 4) and no accepted rides.
By the end of October --> six active drivers (10, 8, 5, 7, 4, 1) and no accepted rides.
By the end of November --> six active drivers (10, 8, 5, 7, 4, 1) and two accepted rides (20, 5).
By the end of December --> six active drivers (10, 8, 5, 7, 4, 1) and one accepted ride (2).

--Solution
# Code Author Naveen Kumar Vadlamudi 
# This Code Might Scare a lil bit ...
# but if we dug a bit deeper i have used 4 CTES (1 is a temp table for Report Generation )
# 3 others are core logic...

# The major part of the problem is to get the Active Drivers which i have covered in 2 CTE 
# Later the Accepted Rides Logic Pretty Straight Forward and i have modularized at 3 rd and 4 th CTE

WITH MONTHS AS 
(
   SELECT 1 AS MONTH, 2020 AS YEAR 
   UNION 
   SELECT 2 AS MONTH, 2020 AS YEAR 
   UNION  
   SELECT 3 AS MONTH, 2020 AS YEAR 
   UNION 
   SELECT 4 AS MONTH, 2020 AS YEAR 
   UNION 
   SELECT 5 AS MONTH, 2020 AS YEAR 
   UNION 
   SELECT 6 AS MONTH, 2020 AS YEAR 
   UNION 
   SELECT 7 AS MONTH, 2020 AS YEAR 
   UNION 
   SELECT 8 AS MONTH, 2020 AS YEAR 
   UNION 
   SELECT 9 AS MONTH, 2020 AS YEAR 
   UNION 
   SELECT 10 AS MONTH, 2020 AS YEAR 
   UNION 
   SELECT 11 AS MONTH, 2020 AS YEAR 
   UNION 
   SELECT 12 AS MONTH, 2020 AS YEAR 
),
ACTIVE_DRIVERS AS 
(
                SELECT 
                DISTINCT
                D.MONTH,
                FIRST_VALUE(D.TOTAL_RIDERS)
                OVER(PARTITION BY D.TR 
                     ORDER BY D.MONTH 
                     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
                AS TOTAL_RIDERS
                FROM 
                (
                    SELECT 
                    M.MONTH,
                    CASE 
                        WHEN C.TOTAL_RIDERS IS NULL THEN 0
                        ELSE C.TOTAL_RIDERS 
                    END AS TOTAL_RIDERS,
                    SUM(CASE WHEN C.TOTAL_RIDERS IS NULL THEN 0 ELSE 1 END) 
                    OVER(ORDER BY M.MONTH) AS TR
                    FROM 
                    (
                            SELECT 
                            *
                            FROM 
                            (        
                                    SELECT 
                                    DISTINCT
                                    A.JOINED_YEAR,
                                    A.MONTH,
                                    SUM(A.MONTHLY_TOTAL) 
                                    OVER(ORDER BY A.JOINED_YEAR, A.MONTH) AS TOTAL_RIDERS
                                    FROM 
                                    (
                                       
                                        SELECT DISTINCT 
                                        YEAR(JOIN_DATE) AS JOINED_YEAR,
                                        MONTH(JOIN_DATE) AS MONTH, 
                                        COUNT(*) 
                                        OVER
                                        (
                                        PARTITION BY
                                        MONTH(JOIN_DATE),YEAR(JOIN_DATE)
                                        ) 
                                        AS MONTHLY_TOTAL
                                        FROM DRIVERS 
                                        
                                    ) AS A
                                    WHERE A.JOINED_YEAR IN (2019,2020)
                                    
                            ) AS B
                            WHERE B.JOINED_YEAR = 2020
                    ) AS C RIGHT JOIN MONTHS AS M
                    ON C.MONTH = M.MONTH
                    
               ) AS D
)
,
ACCEPTED_RIDES AS 
( 
    SELECT MONTH(R.REQUESTED_AT) AS MONTH , COUNT(*) AS ACCEPTED_RIDES
    FROM  RIDES AS R JOIN ACCEPTEDRIDES AS AR
    ON R.RIDE_ID = AR.RIDE_ID
    WHERE YEAR(R.REQUESTED_AT) = 2020
    GROUP BY MONTH(R.REQUESTED_AT)

),
ACCEPTED_RIDE_RESULT AS 
(
        SELECT M.MONTH, 
        CASE    
            WHEN AR.ACCEPTED_RIDES IS NOT NULL THEN AR.ACCEPTED_RIDES 
            ELSE 0 
        END AS ACCEPTED_RIDES
        FROM MONTHS AS M LEFT JOIN ACCEPTED_RIDES AS AR 
        ON AR.MONTH = M.MONTH
)

SELECT 
AD.MONTH, 
AD.TOTAL_RIDERS AS ACTIVE_DRIVERS, 
ARR.ACCEPTED_RIDES 
FROM ACTIVE_DRIVERS AS AD JOIN ACCEPTED_RIDE_RESULT ARR
ON AD.MONTH = ARR.MONTH
ORDER BY AD.MONTH


