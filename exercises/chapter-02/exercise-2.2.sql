-- exercises/chapter-02/exercise-2.2.sql
-- Objective: List all products that are 'Electronics' AND cost less than $100.

-- Databites Dilemma: The purchasing department needs a list of electronics products
-- that are considered "budget-friendly" (costing less than $100) to consider for a flash sale.

-- Your task: Write a SQL query to select 'product_name', 'price', and 'category'
-- from the 'PRODUCTS' table. Apply two conditions:
-- 1. The 'category' must be 'Electronics'.
-- 2. The 'price' must be less than 100.
-- Use the AND logical operator to combine these conditions.

SELECT
    product_name,
    price,
    category
FROM
    PRODUCTS
WHERE
    category = 'Electronics' AND price < 100;
