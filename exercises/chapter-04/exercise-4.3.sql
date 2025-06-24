-- exercises/chapter-04/exercise-4.3.sql
-- Objective: Determine which product categories have more than 2 products.

-- Databites Dilemma: The product sourcing team wants to focus on categories
-- with a diverse product offering (i.e., more than a few products).

-- Your task: Write a SQL query to select the 'category' and the count of products
-- in that category. Filter these groups to include only categories that have
-- more than 2 products. Remember the distinction between WHERE and HAVING.

SELECT
    category,
    COUNT(product_id) AS num_products
FROM
    PRODUCTS
GROUP BY
    category
HAVING
    COUNT(product_id) > 2;
