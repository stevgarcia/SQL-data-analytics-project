/*===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

===============================================================================
*/


--SEGMENT PRODUCTS INTO COST RANGES AND COUNT HOW MANY PRODUCTS FALL INTO EACH SEGMENT

WITH segment as(

    SELECT 
    product_key, 
    product_name,
    cost,
    CASE WHEN cost<100 THEN 'Below 100'
         WHEN cost BETWEEN 100 and 500 THEN '100-500'
         WHEN cost BETWEEN 600 and 1000 THEN '600-1000'
         ELSE 'above 1000'
    END cost_range
    from gold.dim_products
    

    )
SELECT  cost_range, count(product_key) TotalProd
FROM segment
GROUP BY cost_range
ORDER BY TotalProd


---Group customers into three segments on their spending behavior
--VIP Customers with at least 12 months of history and spending more than 5.000
--REGULAR at least 12 months of history but spending 5000 or less
--NEW lifespan less than 12 monts

WITH customer_spending as
    (
    SELECT c.first_name, c.last_name, SUM(f.sales_amount) total, MIN(order_date) FirstOrder, MAX(order_date) LastOrder,
    DATEDIFF(MONTH, MIN(order_date) , MAX(order_date)) as lifespan
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_customers c
    on f.customer_key=c.customer_key
    group by  c.first_name, c.last_name
    )
SELECT first_name, last_name,total,lifespan,
CASE WHEN lifespan>=12 and total> 5000 then 'VIP'
     WHEN lifespan>=12 and total<= 5000 then 'REGULAR'
     ELSE 'New'
end Category

FROM customer_spending


----

