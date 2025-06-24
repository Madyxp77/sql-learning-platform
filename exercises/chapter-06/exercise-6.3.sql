-- exercises/chapter-06/exercise-6.3.sql
-- Objective: Select the customer_id, order_id, and order_date for all orders
-- placed by customers who have placed a total of more than one order.

-- Databites Dilemma: The loyalty program team is refining its strategy and needs to analyze
-- customers who have placed more than one order to identify their most engaged segment.

-- Your task: Write a SQL query that uses a derived table (a subquery in the FROM clause).
-- 1. The inner query should identify 'customer_id's of customers who placed more than one order,
--    using GROUP BY and HAVING.
-- 2. The outer query should then join the 'ORDERS' table with this derived table
--    to get the details of all orders placed by those specific customers.

SELECT
    O.customer_id,
    O.order_id,
    O.order_date
FROM
    ORDERS AS O
INNER JOIN (
    SELECT
        customer_id
    FROM
        ORDERS
    GROUP BY
        customer_id
    HAVING
        COUNT(order_id) > 1
) AS MultiOrderCustomers ON O.customer_id = MultiOrderCustomers.customer_id;
