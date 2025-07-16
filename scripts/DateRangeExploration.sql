/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.


===============================================================================
*/


--find the yougest and the oldest customer

SELECT DATEDIFF(year, max (birthdate), GETDATE()) youngest, 
DATEDIFF(year,min  (birthdate), GETDATE() ) oldest
FROM gold.dim_customers


SELECT * FROM gold.fact_sales

--find the date of the first and last order
--how many years of sales are available

SELECT  max (order_date)
FROM gold.fact_sales
SELECT  min  (order_date)
FROM gold.fact_sales


select datediff(year,min (order_date), max  (order_date)) years
FROM gold.fact_sales
