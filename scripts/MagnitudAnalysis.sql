/*
===============================================================================
Magnitude Analysis
===============================================================================
Purpose:
    - To quantify data and group results by specific dimensions.
    - For understanding data distribution across categories.

===============================================================================
*/



--find total customers by country

SELECT country ,COUNT(customer_id) as NumCustom
FROM gold.dim_customers
GROUP BY  country
ORDER BY NumCustom desc

--find total products by category

SELECT category, COUNT(product_id) NumProducts
FROM gold.dim_products
GROUP BY category
ORDER BY NumProducts desc

--what is the average cost in each category

SELECT category, avg(cost) as avgcostProd
FROM gold.dim_products
GROUP BY category
ORDER BY avgcostProd desc


---what is the total revenue generated for each category



SELECT p.category ,SUM(f.sales_amount) TotalRevenue FROM 

gold.fact_sales f
LEFT JOIN gold.dim_products p
on f.product_key=p.product_key
GROUP BY p.category
ORDER BY TotalRevenue DESC 


---what is the total revenue generated for each customer

SELECT c.customer_id , c.first_name, c.last_name,  SUM(f.sales_amount) TotalRevenue FROM 

gold.fact_sales f
LEFT JOIN gold.dim_customers c
on f.customer_key=c.customer_key
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY TotalRevenue DESC 

--what is the distribution of sold items across countries

SELECT c.country ,SUM(f.quantity) SoldItems FROM 

gold.fact_sales f
LEFT JOIN gold.dim_customers c
on f.customer_key=c.customer_key
GROUP BY c.country
ORDER BY SoldItems DESC 

