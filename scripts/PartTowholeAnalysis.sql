/*===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.

===============================================================================
*/

---which categories contribute the most to overall sales
WITH category_sales AS

	(
	SELECT   category, sum(sales_amount) TotalSales  from gold.fact_sales f
	LEFT JOIN gold.dim_products p on f.product_key=p.product_key 
	GROUP BY category
	)

SELECT category, TotalSales,
SUM(TotalSales) over() overall_sales,
ROUND((CAST(TotalSales AS FLOAT)/SUM(TotalSales) over())*100,2)  as PercentageOfTotal
FROM category_sales
order by TotalSales
