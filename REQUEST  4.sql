/*R4: Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? The final output contains these fields,
segment , product_count_2020,  product_count_2021, difference .*/


WITH ProductCount AS (
    SELECT 
        P.segment, 
        FS.fiscal_year, 
        COUNT(DISTINCT FS.product_code) AS product_count
    FROM 
        dim_product P
    JOIN 
        fact_sales_monthly FS ON P.product_code = FS.product_code
    WHERE 
        FS.fiscal_year IN (2020, 2021)
    GROUP BY 
        P.segment, FS.fiscal_year
)
SELECT 
    pc2020.segment, 
    pc2020.product_count AS product_count_2020, 
    pc2021.product_count AS product_count_2021, 
    (pc2021.product_count - pc2020.product_count) AS difference
FROM 
    ProductCount pc2020
JOIN 
    ProductCount pc2021 ON pc2020.segment = pc2021.segment
WHERE 
    pc2020.fiscal_year = 2020
AND 
    pc2021.fiscal_year = 2021;
