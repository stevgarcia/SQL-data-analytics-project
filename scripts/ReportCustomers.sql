
--Purpose
	--this report consolidates key customer metrics and behaviours

--highlights
--1.Gathers essential fields such as names, ages and transaction details.
--2.Segments customers into categories (vip,regular,new) and age groups
--3.Aggregates customer level metrics:
	--total orders
	--total sales
	--total quantity purchased
	--total products
	--lifespan in months
--4. calculates valuable KPIS
	--recency(months since the last order)
	--average order value
	--average monthly spend

WITH BASEQUERY as 
	(
	--1. BASE QUERY
	SELECT
	f.order_number,
	f.product_key,
	f.order_date,
	f.sales_amount,
	f.quantity,
	c.customer_key,
	c.customer_number,
	CONCAT(c.first_name,' ',c.last_name) as CustomerName,
	DATEDIFF(YEAR,c.birthdate,GETDATE()) as age
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_customers c
	ON c.customer_key=f.customer_key
	WHERE order_date IS NOT NULL

	),

	CustomerAggregation AS
	(
	--2.customer aggregations and key metrics
	SELECT
		customer_key,
		customer_number,
		CustomerName,
		age,
		COUNT(DISTINCT order_number) total_orders,
		SUM(sales_amount) as total_sales,
		sum(quantity) as total_quantity,
		count(DISTINCT product_key) as total_products,
		DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) as lifespan,
		min(order_date) last_order_date

		FROM BASEQUERY
		GROUP BY 
		customer_key,
		customer_number,
		CustomerName,
		age
	)
	--3. final report
	SELECT 
	customer_key,
	customer_number,
	CustomerName,
	age,
	CASE WHEN age<20 then 'Under 20'
		 WHEN age  between 20  and 29 then '20-29'
		 WHEN age  between 30  and 39 then '30-39'
		 WHEN age  between 40  and 49 then '40-49'
		 ELSE 'above 50'
	END ageGroup,

	CASE WHEN lifespan>=12 and total_sales>5000  then 'VIP'
		 WHEN lifespan<12 and total_sales<=5000  then 'REGULAR'
		 ELSE 'New'
	END AS customer_segment,
	DATEDIFF(MONTH, last_order_date,GETDATE()) recency,
	total_orders,
	total_sales,
	total_quantity,
	total_products,
	lifespan,

	CASE WHEN total_sales=0 THEN 0
		 ELSE	(total_sales/total_orders) 
	END avg_order_valuem,


	CASE WHEN lifespan=0 THEN 0
		 ELSE	(total_sales/lifespan) 
	END avg_monthlySpend


	from CustomerAggregation