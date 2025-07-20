/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.
===============================================================================
*/

 SELECT orderDate,TotalSales, sum(TotalSales) over(order by orderDate) as runningTotal,
 avg(avg_price) over (order by orderdate) as moving_average_price
 FROM
 (
 SELECT DATETRUNC(month, order_date) as orderDate,
 SUM(sales_amount) as TotalSales,
 avg(price) as avg_price
 FROM gold.fact_sales
 WHERE order_date IS NOT NULL
 GROUP BY DATETRUNC(month, order_date)

 ) t