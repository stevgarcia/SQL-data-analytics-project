/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

===============================================================================
*/


--sales over the years

SELECT YEAR(order_date) as order_date, SUM(sales_amount) TotalSales, 
Count(DISTINCT customer_key) as total_Customer,
SUM(quantity) totalQuantity
FROM
gold.fact_sales
WHERE YEAR(order_date)  IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY order_date asc

--sales over time



SELECT DATETRUNC(MONTH,order_date) as order_date, SUM(sales_amount) TotalSales, 
Count(DISTINCT customer_key) as total_Customer,
SUM(quantity) totalQuantity
FROM
gold.fact_sales
WHERE DATETRUNC(MONTH,order_date) IS NOT NULL
GROUP BY DATETRUNC(MONTH,order_date)
ORDER BY order_date asc
