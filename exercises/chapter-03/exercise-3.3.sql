-- exercises/chapter-03/exercise-3.3.sql
-- Objective: Retrieve the order_id and quantity for all orders,
-- sorted by quantity in descending order, and then by order_date in ascending order.

-- Databites Dilemma: You're analyzing order patterns and need to see which orders
-- had the highest quantities, and for orders with the same quantity,
-- which were placed earliest.

-- Your task: Write a SQL query to select 'order_id', 'quantity', and 'order_date'
-- from the 'ORDERS' table. Order the results first by 'quantity' in descending order,
-- and then by 'order_date' in ascending order.

SELECT
    order_id,
    quantity,
    order_date
FROM
    ORDERS
ORDER BY
    quantity DESC,
    order_date ASC;
