/*R5. Get the products that have the highest and lowest manufacturing costs. The final output should contain these fields,
product_code ,product, manufacturing_cost*/

WITH max_min_costs AS (
    SELECT 
        MAX(manufacturing_cost) AS max_cost,
        MIN(manufacturing_cost) AS min_cost
    FROM fact_manufacturing_cost
)
SELECT 
    F.product_code,
    P.product,
    F.manufacturing_cost
FROM 
    fact_manufacturing_cost F
JOIN 
    dim_product P ON F.product_code = P.product_code
JOIN 
    max_min_costs MMC ON 1=1
WHERE 
    F.manufacturing_cost = MMC.max_cost
    OR F.manufacturing_cost = MMC.min_cost
ORDER BY 
    F.manufacturing_cost DESC;
