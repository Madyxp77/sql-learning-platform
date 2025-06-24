-- exercises/chapter-05/exercise-5.3.sql
-- Objective: Identify any customers who have not placed an order. Show their first_name and last_name.

-- Databites Dilemma: Databites wants to identify customers who have signed up
-- but have not yet placed any orders, so they can target them with a welcome discount.

-- Your task: Write a SQL query that uses a LEFT JOIN to combine the 'CUSTOMERS' table
-- with the 'ORDERS' table. Then, use a WHERE clause with IS NULL to find customers
-- who do not have a matching order.

SELECT
    C.first_name,
    C.last_name
FROM
    CUSTOMERS AS C
LEFT JOIN
    ORDERS AS O ON C.customer_id = O.customer_id
WHERE
    O.order_id IS NULL;
