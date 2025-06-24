-- exercises/chapter-03/exercise-3.2.sql
-- Objective: Show product_name, category, and price for all products,
-- sorted first by category (A-Z) and then by price (highest to lowest within each category).

-- Databites Dilemma: The product manager wants a view of the product catalog.
-- They first want products grouped by category (alphabetically), and then within each
-- category, they want the most expensive products listed first.

-- Your task: Write a SQL query to select 'product_name', 'category', and 'price'
-- from the 'PRODUCTS' table. Order the results by 'category' in ascending order,
-- and then by 'price' in descending order within each category.

SELECT
    product_name,
    category,
    price
FROM
    PRODUCTS
ORDER BY
    category ASC,
    price DESC;
