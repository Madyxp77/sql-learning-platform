-- exercises/chapter-06/exercise-6.4.sql
-- Objective: For each customer, show their name and the total number of orders they have placed.

-- Databites Dilemma: The customer analytics team wants a quick summary of customer activity,
-- specifically how many orders each customer has made, displayed alongside their names.

-- Your task: Write a SQL query using a scalar subquery in the SELECT clause.
-- 1. The outer query should select 'first_name' and 'last_name' from the 'CUSTOMERS' table.
-- 2. The subquery in the SELECT clause should count the orders for the *current* customer
--    (based on the customer_id from the outer query) from the 'ORDERS' table.

SELECT
    C.first_name,
    C.last_name,
    (SELECT COUNT(O.order_id) FROM ORDERS AS O WHERE O.customer_id = C.customer_id) AS total_orders_count
FROM
    CUSTOMERS AS C;
