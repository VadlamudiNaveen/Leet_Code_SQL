1070. Product Sales Analysis III

Medium
-- TABLE SCHEMA
Create table If Not Exists Sales (sale_id int, product_id int, year int, quantity int, price int);
Create table If Not Exists Product (product_id int, product_name varchar(10));
Truncate table Sales;
insert into Sales (sale_id, product_id, year, quantity, price) values ('1', '100', '2008', '10', '5000');
insert into Sales (sale_id, product_id, year, quantity, price) values ('2', '100', '2009', '12', '5000');
insert into Sales (sale_id, product_id, year, quantity, price) values ('7', '200', '2011', '15', '9000');
Truncate table Product;
insert into Product (product_id, product_name) values ('100', 'Nokia');
insert into Product (product_id, product_name) values ('200', 'Apple');
insert into Product (product_id, product_name) values ('300', 'Samsung');

-- PROBLEM DESCRIPTION
Table: Sales

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+
(sale_id, year) is the primary key of this table.
product_id is a foreign key to Product table.
Each row of this table shows a sale on the product product_id in a certain year.
Note that the price is per unit.
 

Table: Product

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
+--------------+---------+
product_id is the primary key of this table.
Each row of this table indicates the product name of each product.
 

Write an SQL query that selects the product id, year, quantity, and price for the first year of every product sold.

Return the resulting table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Sales table:
+---------+------------+------+----------+-------+
| sale_id | product_id | year | quantity | price |
+---------+------------+------+----------+-------+ 
| 1       | 100        | 2008 | 10       | 5000  |
| 2       | 100        | 2009 | 12       | 5000  |
| 7       | 200        | 2011 | 15       | 9000  |
+---------+------------+------+----------+-------+
Product table:
+------------+--------------+
| product_id | product_name |
+------------+--------------+
| 100        | Nokia        |
| 200        | Apple        |
| 300        | Samsung      |
+------------+--------------+
Output: 
+------------+------------+----------+-------+
| product_id | first_year | quantity | price |
+------------+------------+----------+-------+ 
| 100        | 2008       | 10       | 5000  |
| 200        | 2011       | 15       | 9000  |
+------------+------------+----------+-------+

--Solution -1
--Code author Naveen Kumar Vadlamudi
WITH FILTERED_TABLE AS 
(
SELECT 
SALE_ID, PRODUCT_ID, YEAR, QUANTITY, PRICE
FROM 
(
    SELECT 
    *, 
    DENSE_RANK() OVER(PARTITION BY PRODUCT_ID ORDER BY YEAR ASC) AS CRANK
    FROM SALES 
) AS A
WHERE A.CRANK = 1 
)

SELECT
FT.PRODUCT_ID,
FT.YEAR AS FIRST_YEAR,
FT.QUANTITY,
FT.PRICE
FROM FILTERED_TABLE AS FT JOIN PRODUCT AS P
ON FT.PRODUCT_ID = P.PRODUCT_ID

-- Solution 2
-- Code Author Naveen Kumar Vadlamudi.

SELECT 
A.PRODUCT_ID,
A.YEAR AS FIRST_YEAR,
A.QUANTITY,
A.PRICE
FROM
(
    SELECT  *,
    DENSE_RANK() OVER(PARTITION BY PRODUCT_ID ORDER BY YEAR) AS CRANK
    FROM SALES
) A
WHERE A.CRANK = 1 
