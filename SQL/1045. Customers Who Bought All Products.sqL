1045. Customers Who Bought All Products

Medium

-- Table Schema
Create table If Not Exists Customer (customer_id int, product_key int);
Create table Product (product_key int);
Truncate table Customer;
insert into Customer (customer_id, product_key) values ('1', '5');
insert into Customer (customer_id, product_key) values ('2', '6');
insert into Customer (customer_id, product_key) values ('3', '5');
insert into Customer (customer_id, product_key) values ('3', '6');
insert into Customer (customer_id, product_key) values ('1', '6');
Truncate table Product;
insert into Product (product_key) values ('5');
insert into Product (product_key) values ('6');

--Problem Definition

Table: Customer

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| customer_id | int     |
| product_key | int     |
+-------------+---------+
There is no primary key for this table. It may contain duplicates.
product_key is a foreign key to Product table.
 

Table: Product

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_key | int     |
+-------------+---------+
product_key is the primary key column for this table.
 

Write an SQL query to report the customer ids from the Customer table that bought all the products in the Product table.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Customer table:
+-------------+-------------+
| customer_id | product_key |
+-------------+-------------+
| 1           | 5           |
| 2           | 6           |
| 3           | 5           |
| 3           | 6           |
| 1           | 6           |
+-------------+-------------+
Product table:
+-------------+
| product_key |
+-------------+
| 5           |
| 6           |
+-------------+
Output: 
+-------------+
| customer_id |
+-------------+
| 1           |
| 3           |
+-------------+
Explanation: 
The customers who bought all the products (5 and 6) are customers with IDs 1 and 3.

-- Solution 1
-- code Author Naveen Kumar Vadlamudi


        SELECT  
        CUSTOMER_ID
        FROM PRODUCT AS P LEFT JOIN CUSTOMER AS C
        ON P.PRODUCT_KEY = C.PRODUCT_KEY
        GROUP BY C.CUSTOMER_ID
        HAVING COUNT(DISTINCT C.PRODUCT_KEY) = (SELECT COUNT(*) FROM PRODUCT)

-- Solution 2
-- Code Author Naveen Kumar Vadladmudi
WITH AGG_COUNT AS 
    (
    SELECT 
    CUSTOMER_ID, 
    COUNT(DISTINCT PRODUCT_KEY) AS DCOUNT,
    (SELECT COUNT(*) FROM PRODUCT) AS PCOUNT 
    FROM CUSTOMER
    GROUP BY CUSTOMER_ID
    )
    
SELECT CUSTOMER_ID
FROM AGG_COUNT
WHERE DCOUNT = PCOUNT

--Solution 3
-- Code Author Naveen Kumar Vadlamudi
SELECT *
FROM 
    (
        SELECT  
        CASE WHEN (SELECT COUNT(*) FROM PRODUCT) = COUNT(DISTINCT C.PRODUCT_KEY) THEN CUSTOMER_ID END AS CUSTOMER_ID
        FROM PRODUCT AS P LEFT JOIN CUSTOMER AS C
        ON P.PRODUCT_KEY = C.PRODUCT_KEY
        GROUP BY CUSTOMER_ID
    ) AS A 
WHERE A.CUSTOMER_ID IS NOT NULL
    