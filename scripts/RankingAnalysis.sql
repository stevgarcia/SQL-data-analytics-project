/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

===============================================================================
*/






--which 5 products generate the highest revenue?



SELECT TOP 5(p.product_name), sum(f.sales_amount) revenue
FROM gold.fact_sales f 
LEFT JOIN gold.dim_products p on f.product_key=p.product_key
GROUP BY p.product_name
order by revenue desc


--what are the 5 worst-performing products in terms of sales


SELECT TOP 5(p.product_name), sum(f.sales_amount) revenue
FROM gold.fact_sales f 
LEFT JOIN gold.dim_products p on f.product_key=p.product_key
GROUP BY p.product_name
order by revenue asc


----Find the top 10 customers who have generated the highest value
SELECT TOP 10 c.customer_id,c.first_name, c.last_name, sum(f.sales_amount) revenue
FROM gold.fact_sales f 
LEFT JOIN gold.dim_customers c on f.customer_key=c.customer_key
GROUP BY customer_id,first_name,last_name
order by revenue DESC


---The 3 customers with the fewer orders placed

SELECT top 3 c.customer_id,c.first_name, c.last_name, count(distinct f.order_number) orders
FROM gold.fact_sales f 
LEFT JOIN gold.dim_customers c on f.customer_key=c.customer_key
GROUP BY customer_id,first_name,last_name
order by orders 
