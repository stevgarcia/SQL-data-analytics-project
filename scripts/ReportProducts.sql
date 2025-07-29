/*

product report
purpose: this report consolidates key product metrics and behaviours

Highlights
1. Gathers essential fields such s product name, category, subcategory and cost.
2. segments products by revenue to identify high performers, mid-range or low performers
3. aggregates product-level metrics:

-total orders
-total sales
-total quantity sold
-total customers(unique)
-lifespan in months

4.Calculates valuable KPIS
-recency(months since last sale)
-average order revenue
-average monthly revenue
*/

--QUERY BASE




WITH BASEQUERY as 

	(SELECT 

	order_number,
	order_date,
	sales_amount,
	product_name,
	category,
	subcategory,
	cost,
	quantity,
	product_line,
	customer_key


	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p
	on f.product_key=p.product_key

	),

--PRODUCT AGGREGATIONS

ProductAggregations AS
(
	SELECT 
	product_name,
	category,
	subcategory,
	cost,
	MAX(order_date) as Last_sale_date,
	count(DISTINCT order_number) totalOrders,
	SUM(sales_amount) as totalSales,
	SUM(quantity) as totalQuantity,
	COUNT(distinct customer_key) as TotalCustomers,
	DATEDIFF(MONTH, min(order_date),MAX(order_date)) lifespan,
	ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)),1) AS avg_selling_price

	FROM basequery
	group by product_name,category,	subcategory,cost
)


--FINAL QUERY COMBINES ALL PRODUCT RESULTS

SELECT 
	product_name,
	category,
	subcategory,

	CASE

		WHEN totalSales > 50000 then 'high performer'
		WHEN totalSales > 10000 then 'Mid-range'
		ELSE 'low-performer'
	END as product_segment,

	cost,
	totalSales,
	Last_sale_date,
	totalOrders,
	TotalSales,
	totalquantity,
	totalcustomers,
	avg_selling_price,

	

	DATEDIFF(MONTH,Last_sale_date,GETDATE()) as recency_in_months,
	
	CASE

		WHEN totalOrders=0 THEN 0
		ELSE totalSales/totalOrders
	END as avg_order_revenue,

	CASE

		WHEN lifespan=0 THEN totalSales
		ELSE totalSales/lifespan

	END as avg_monthly_revenue


	FROM ProductAggregations