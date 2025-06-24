-- exercises/chapter-08/exercise-8.2.sql
-- Objective: See how each product's price ranks relative to other products in the same category.

-- Databites Dilemma: The product manager wants to analyze product pricing and performance
-- by understanding where each product stands within its own category in terms of price.

-- Your task: Write a SQL query that uses the DENSE_RANK() window function.
-- 1. Select 'product_name', 'category', and 'price' from the 'PRODUCTS' table.
-- 2. Use DENSE_RANK() to assign a rank based on 'price' (highest price = rank 1)
--    within each 'category'.
-- 3. The ranking should be partitioned by 'category' and ordered by 'price' in descending order.

SELECT
    product_name,
    category,
    price,
    DENSE_RANK() OVER (PARTITION BY category ORDER BY price DESC) AS price_rank_in_category
FROM
    PRODUCTS
ORDER BY -- Optional: Order the final result set for readability
    category ASC,
    price DESC;
