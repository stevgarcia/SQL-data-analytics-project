/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

===============================================================================
*/



--find the total sales

SELECT SUM(sales_amount) as totalSales
FROM gold.fact_sales


---how many items are sold

SELECT SUM(quantity) as ItemsSold
FROM gold.fact_sales

--find the average selling price

SELECT avg(price)  averagePrice
FROM gold.fact_sales

-- find the total number of orders

SELECT count(distinct(order_number)) NumberOrders
FROM gold.fact_sales

---find the total number of products

SELECT count(distinct(product_key)) totalProducts
FROM gold.fact_sales

--find the total number of customers

SELECT count(distinct (customer_key)) NumberCustomers
FROM gold.fact_sales



---Generate a report with all measures***-*-----

SELECT 'Total Sales' as 'MeasureName',SUM(sales_amount) as 'Value'
FROM gold.fact_sales
UNION ALL
SELECT 'items Sold' as 'MeasureName', SUM(quantity)  as 'Value'
FROM gold.fact_sales
UNION ALL
SELECT 'average price' as 'MeasureName',  avg(price)  as 'Value'
FROM gold.fact_sales
UNION ALL
SELECT 'Number of orders' as 'MeasureName',  count(distinct(order_number))  as 'Value'
FROM gold.fact_sales
UNION ALL
SELECT 'Number of products' as 'MeasureName',  count(distinct(product_key))  as 'Value'
FROM gold.fact_sales
UNION ALL
SELECT 'Number of customers' as 'MeasureName',   count(distinct (customer_key))  as 'Value'
FROM gold.fact_sales
