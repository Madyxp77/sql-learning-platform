-- exercises/skill-checkpoint-aggregation-joins-expertise/exercise-2.sql
-- Objective: Get a detailed summary of each customer's orders, including product names.

-- Scenario: The customer success team wants a detailed summary of each customer's orders,
-- including the actual product names, not just IDs.
-- For each order, list the customer_id, first_name, last_name, product_name, quantity, and order_date.
-- Sort by customer_id (ascending) then order_date (ascending).

-- Your task: Write a SQL query that uses multiple JOINs to combine information from
-- the Customers, Orders, and Products tables, and then orders the results.

SELECT
    C.customer_id,
    C.first_name,
    C.last_name,
    P.product_name,
    O.quantity,
    O.order_date
FROM
    CUSTOMERS AS C
INNER JOIN
    ORDERS AS O ON C.customer_id = O.customer_id
INNER JOIN
    PRODUCTS AS P ON O.product_id = P.product_id
ORDER BY
    C.customer_id ASC,
    O.order_date ASC;
