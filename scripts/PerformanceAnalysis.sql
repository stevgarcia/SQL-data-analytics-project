/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

===============================================================================
*/

--analyze the yearly performance of products
--to both  the average sales perfomance of the product and the previous year's sales

WITH analysis as (


	SELECT YEAR(order_date) YEAR, p.product_name,  SUM(sales_amount) CurrentSales
	FROM gold.fact_sales
	LEFT JOIN gold.dim_products as p
	ON fact_sales.product_key=p.product_key
	WHERE YEAR(order_date) IS NOT NULL
	GROUP BY YEAR(order_date), product_name
)

SELECT *,
AVG(CurrentSales) over(PARTITION BY product_name) avg_sales,

CurrentSales-AVG(CurrentSales) over(PARTITION BY product_name) as Diff_avg,
	CASE WHEN CurrentSales-AVG(CurrentSales) over(PARTITION BY product_name)> 0 then 'Above AVG'
		 WHEN CurrentSales-AVG(CurrentSales) over(PARTITION BY product_name)< 0 then 'Below AVG'
		 ELSE 'Avg'
	END indicator,
LAG(CurrentSales) over(partition by product_name order by year) PYSales,
CurrentSales - LAG(CurrentSales) over(partition by product_name order by year) as DiffPYsales,

CASE WHEN CurrentSales-LAG(CurrentSales) over(partition by product_name order by year)> 0 then 'Increase'
		 WHEN CurrentSales-LAG(CurrentSales) over(partition by product_name order by year)< 0 then 'Decrease'
		 ELSE 'No change'
	END indicator2

FROM analysis
ORDER BY product_name, year


 