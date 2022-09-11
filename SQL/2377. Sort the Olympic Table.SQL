-- 2377. Sort the Olympic Table

/*

Create table If Not Exists Olympic (country varchar(50), gold_medals int, silver_medals int, bronze_medals int)
Truncate table Olympic
insert into Olympic (country, gold_medals, silver_medals, bronze_medals) values ('China', '10', '10', '20')
insert into Olympic (country, gold_medals, silver_medals, bronze_medals) values ('South Sudan', '0', '0', '1')
insert into Olympic (country, gold_medals, silver_medals, bronze_medals) values ('USA', '10', '10', '20')
insert into Olympic (country, gold_medals, silver_medals, bronze_medals) values ('Israel', '2', '2', '3')
insert into Olympic (country, gold_medals, silver_medals, bronze_medals) values ('Egypt', '2', '2', '2')

*/

-- Code Author Naveen Kumar Vadlamudi
-- How to Approach the solution 
-- A Major Pitfall one might be doing
-- Writing the Statements as following 
-- SELECT * FROM OLYMPIC ORDER BY GOLD_MEDALS, SILVER_MEDALS, BRONZE_MEDALS DESC, COUNTRY ASC
-- Which gives erroneous answer to us as the columns over there are soreted combinedly which is obviously wrong.
-- Instead use the below Code ... 
-- Which sorts the data by every column and gives us the result as expected.


SELECT *
FROM OLYMPIC
ORDER BY GOLD_MEDALS DESC, SILVER_MEDALS DESC, BRONZE_MEDALS DESC, COUNTRY ASC