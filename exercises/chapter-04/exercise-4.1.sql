-- exercises/chapter-04/exercise-4.1.sql
-- Objective: Calculate the total number of orders placed by each customer.

-- Databites Dilemma: The customer loyalty team wants to know how many orders
-- each customer has placed to identify frequent buyers.

-- Your task: Write a SQL query to select 'customer_id' and a count of their orders.
-- You'll need to use an aggregate function and group the results by customer_id.

SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM
    ORDERS
GROUP BY
    customer_id;
