1990. Count the Number of Experiments

/*
Create table If Not Exists Experiments (experiment_id int, platform ENUM('Android', 'IOS', 'Web'), experiment_name ENUM('Reading', 'Sports', 'Programming'))
Truncate table Experiments
insert into Experiments (experiment_id, platform, experiment_name) values ('4', 'IOS', 'Programming')
insert into Experiments (experiment_id, platform, experiment_name) values ('13', 'IOS', 'Sports')
insert into Experiments (experiment_id, platform, experiment_name) values ('14', 'Android', 'Reading')
insert into Experiments (experiment_id, platform, experiment_name) values ('8', 'Web', 'Reading')
insert into Experiments (experiment_id, platform, experiment_name) values ('12', 'Web', 'Reading')
insert into Experiments (experiment_id, platform, experiment_name)
*/
Table: Experiments

+-----------------+------+
| Column Name     | Type |
+-----------------+------+
| experiment_id   | int  |
| platform        | enum |
| experiment_name | enum |
+-----------------+------+
experiment_id is the primary key for this table.
platform is an enum with one of the values ('Android', 'IOS', 'Web').
experiment_name is an enum with one of the values ('Reading', 'Sports', 'Programming').
This table contains information about the ID of an experiment done with a random person, the platform used to do the experiment, and the name of the experiment.
 

Write an SQL query to report the number of experiments done on each of the three platforms for each of the three given experiments. Notice that all the pairs of (platform, experiment) should be included in the output including the pairs with zero experiments.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input:
Experiments table:
+---------------+----------+-----------------+
| experiment_id | platform | experiment_name |
+---------------+----------+-----------------+
| 4             | IOS      | Programming     |
| 13            | IOS      | Sports          |
| 14            | Android  | Reading         |
| 8             | Web      | Reading         |
| 12            | Web      | Reading         |
| 18            | Web      | Programming     |
+---------------+----------+-----------------+
Output: 
+----------+-----------------+-----------------+
| platform | experiment_name | num_experiments |
+----------+-----------------+-----------------+
| Android  | Reading         | 1               |
| Android  | Sports          | 0               |
| Android  | Programming     | 0               |
| IOS      | Reading         | 0               |
| IOS      | Sports          | 1               |
| IOS      | Programming     | 1               |
| Web      | Reading         | 2               |
| Web      | Sports          | 0               |
| Web      | Programming     | 1               |
+----------+-----------------+-----------------+
Explanation: 
On the platform "Android", we had only one "Reading" experiment.
On the platform "IOS", we had one "Sports" experiment and one "Programming" experiment.
On the platform "Web", we had two "Reading" experiments and one "Programming" experiment.
--SOLUTION
WITH CTE AS 
(
        SELECT 'Android' AS PLATFORM, 'Reading' AS EXPERIMENT_NAME
        UNION 
        SELECT 'Android' AS PLATFORM, 'Sports' AS EXPERIMENT_NAME
        UNION
        SELECT 'Android' AS PLATFORM, 'Programming' AS EXPERIMENT_NAME
        UNION
        SELECT 'IOS' AS PLATFORM, 'Reading' AS EXPERIMENT_NAME
        UNION 
        SELECT 'IOS' AS PLATFORM, 'Sports' AS EXPERIMENT_NAME
        UNION
        SELECT 'IOS' AS PLATFORM, 'Programming' AS EXPERIMENT_NAME
        UNION
        SELECT 'Web' AS PLATFORM, 'Reading' AS EXPERIMENT_NAME
        UNION 
        SELECT 'Web' AS PLATFORM, 'Sports' AS EXPERIMENT_NAME
        UNION
        SELECT 'Web' AS PLATFORM, 'Programming' AS EXPERIMENT_NAME
)

SELECT
T2.PLATFORM,
T2.EXPERIMENT_NAME,
CASE 
    WHEN T1.CNT IS NOT NULL THEN T1.CNT 
    ELSE 0 
END AS NUM_EXPERIMENTS
FROM 
(
    SELECT
    PLATFORM,
    EXPERIMENT_NAME,
    COUNT(*) AS CNT
    FROM EXPERIMENTS
    GROUP BY PLATFORM, EXPERIMENT_NAME
) AS T1 RIGHT JOIN CTE AS T2
ON T1.PLATFORM = T2.PLATFORM 
AND T1.EXPERIMENT_NAME = T2.EXPERIMENT_NAME