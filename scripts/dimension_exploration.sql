
/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
===============================================================================
*/

--explore all countries our customers come from

SELECT distinct(country)
FROM gold.dim_customers



--explore all categories "major divisions"

SELECT distinct category, subcategory, product_name
FROM gold.dim_products
order by 1,2,3

