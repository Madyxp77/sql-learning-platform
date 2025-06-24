-- exercises/chapter-07/exercise-7.3.sql
-- Objective: For each category, list the product_name and price of the most expensive product within that category.

-- Databites Dilemma: The product merchandising team wants to know the single most expensive
-- product in each category to highlight it or analyze its market positioning. If there are ties
-- in price, any one of them is fine.

-- Your task: Write a SQL query using a Common Table Expression (CTE).
-- 1. Create a CTE named 'MaxPricePerCategory' that identifies the maximum price for each category.
-- 2. Then, join this CTE back to the original 'PRODUCTS' table to retrieve the 'product_name'
--    that corresponds to that maximum price within its respective category.

WITH MaxPricePerCategory AS (
    SELECT
        category,
        MAX(price) AS max_price
    FROM
        PRODUCTS
    GROUP BY
        category
)
SELECT
    P.category,
    P.product_name,
    P.price
FROM
    PRODUCTS AS P
INNER JOIN
    MaxPricePerCategory AS MPC
    ON P.category = MPC.category AND P.price = MPC.max_price;
