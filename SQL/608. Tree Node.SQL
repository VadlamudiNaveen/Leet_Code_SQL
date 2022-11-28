608. Tree Node

MEDIUM

-- SCHEMA
Create table If Not Exists Tree (id int, p_id int);
Truncate table Tree;
insert into Tree (id, p_id) values ('1', 'None');
insert into Tree (id, p_id) values ('2', '1');
insert into Tree (id, p_id) values ('3', '1');
insert into Tree (id, p_id) values ('4', '2');
insert into Tree (id, p_id) values ('5', '2');

-- QUESTION 

Table: Tree

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| p_id        | int  |
+-------------+------+
id is the primary key column for this table.
Each row of this table contains information about the id of a node and the id of its parent node in a tree.
The given structure is always a valid tree.
 

Each node in the tree can be one of three types:

"Leaf": if the node is a leaf node.
"Root": if the node is the root of the tree.
"Inner": If the node is neither a leaf node nor a root node.
Write an SQL query to report the type of each node in the tree.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:


Input: 
Tree table:
+----+------+
| id | p_id |
+----+------+
| 1  | null |
| 2  | 1    |
| 3  | 1    |
| 4  | 2    |
| 5  | 2    |
+----+------+
Output: 
+----+-------+
| id | type  |
+----+-------+
| 1  | Root  |
| 2  | Inner |
| 3  | Leaf  |
| 4  | Leaf  |
| 5  | Leaf  |
+----+-------+
Explanation: 
Node 1 is the root node because its parent node is null and it has child nodes 2 and 3.
Node 2 is an inner node because it has parent node 1 and child node 4 and 5.
Nodes 3, 4, and 5 are leaf nodes because they have parent nodes and they do not have child nodes.
Example 2:


Input: 
Tree table:
+----+------+
| id | p_id |
+----+------+
| 1  | null |
+----+------+
Output: 
+----+-------+
| id | type  |
+----+-------+
| 1  | Root  |
+----+-------+
Explanation: If there is only one node on the tree, you only need to output its root attributes.

-- Code Author 
-- Naveen Kumar Vadlamudi
-- SOLUTION USING UNION

SELECT id, "Root" AS type
FROM TREE 
WHERE P_ID IS NULL

UNION 

SELECT id, "Inner" AS type
FROM TREE
WHERE ID IN (SELECT P_ID FROM TREE WHERE P_ID NOT IN (SELECT ID FROM TREE WHERE P_ID IS NULL))

UNION 

-- IN THIS METHOD I WILL BE FETCHING INNER AND ROOT VALUES AND THEN WILL FIND THE NODES
-- THAT ARE LEAVES.
SELECT id, "Leaf" as type
FROM TREE
WHERE ID NOT IN 
(
        SELECT P_ID FROM TREE WHERE P_ID NOT IN (SELECT ID FROM TREE WHERE P_ID IS NULL) 
        UNION 
        SELECT ID FROM TREE WHERE P_ID IS NULL
)

-- SOLUTION USING JOIN + UNION
SELECT ID, 'Root' as type
FROM TREE 
WHERE P_ID IS NULL

UNION 

(
SELECT DISTINCT
T1.ID, 'Inner' as type
FROM TREE AS T1 JOIN TREE AS T2
ON T1.ID = T2.P_ID

EXCEPT 

SELECT ID, 'Inner' as type
FROM TREE 
WHERE P_ID IS NULL 

)

UNION

SELECT ID , 'Leaf' AS type
FROM TREE 
WHERE P_ID IS NOT NULL AND 
ID NOT IN 
(
SELECT DISTINCT T1.ID
FROM TREE AS T1 JOIN TREE AS T2
ON T1.ID = T2.P_ID
)
