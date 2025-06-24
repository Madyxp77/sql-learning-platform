-- exercises/chapter-04/exercise-4.2.sql
-- Objective: Find the maximum price for products in each category.

-- Databites Dilemma: The pricing committee needs a quick overview of product pricing
-- across different categories to understand price ranges.

-- Your task: Write a SQL query to select the 'category' and the maximum 'price'
-- for products within that category. You'll need to use an aggregate function
-- and group the results by 'category'.

SELECT
    category,
    MAX(price) AS max_price_in_category
FROM
    PRODUCTS
GROUP BY
    category;
