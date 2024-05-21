/* R2:What is the percentage of unique product increase in 2021 vs. 2020? The final output contains these fields,
unique_products_2020, unique_products_2021 ,percentage_chg

WITH unique_products AS (
    SELECT
        fiscal_year,
        COUNT(DISTINCT product_code) AS unique_product_count
    FROM
        fact_sales_monthly
    WHERE
        fiscal_year IN (2020, 2021)
    GROUP BY
        fiscal_year)
SELECT
    A.unique_product_count AS unique_product_2020,
    B.unique_product_count AS unique_product_2021,
    ROUND((B.unique_product_count - A.unique_product_count) * 100.0 / A.unique_product_count, 2) AS percentage_chg
FROM
    unique_products A
JOIN
    unique_products B ON A.fiscal_year = 2020 AND B.fiscal_year = 2021;
