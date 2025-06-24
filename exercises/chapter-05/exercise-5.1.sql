-- exercises/chapter-05/exercise-5.1.sql
-- Objective: List the order_id, product_name, and category for all orders.

-- Databites Dilemma: The inventory team wants a report showing each order,
-- but instead of just the product_id, they need to see the actual product_name
-- and its category.

-- Your task: Write a SQL query that joins the 'ORDERS' table with the 'PRODUCTS' table
-- to retrieve the requested information. Use aliases for clarity.

SELECT
    O.order_id,
    P.product_name,
    P.category
FROM
    ORDERS AS O
INNER JOIN
    PRODUCTS AS P ON O.product_id = P.product_id;
