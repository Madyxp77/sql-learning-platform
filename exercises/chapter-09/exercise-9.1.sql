-- exercises/chapter-09/exercise-9.1.sql
-- Objective: Segment customers based on the number of orders they've placed:
-- 'New' (1 order), 'Loyal' (2-3 orders), 'VIP' (4+ orders), 'No Orders' (0 orders).

-- Databites Dilemma: The marketing team wants to segment customers based on their order frequency
-- to tailor loyalty programs and targeted campaigns.

-- Your task: Write a SQL query to list 'customer_id', 'first_name', 'last_name',
-- and their calculated 'loyalty_segment'.
-- 1. Use a LEFT JOIN between CUSTOMERS and ORDERS to include customers with no orders.
-- 2. Group the results by customer details.
-- 3. Use a CASE statement with COUNT(O.order_id) to define the 'loyalty_segment'.

SELECT
    C.customer_id,
    C.first_name,
    C.last_name,
    CASE
        WHEN COUNT(O.order_id) = 0 THEN 'No Orders' -- Handles customers with no matching orders
        WHEN COUNT(O.order_id) = 1 THEN 'New'
        WHEN COUNT(O.order_id) BETWEEN 2 AND 3 THEN 'Loyal'
        WHEN COUNT(O.order_id) >= 4 THEN 'VIP'
        ELSE 'Unknown' -- Fallback for unexpected scenarios, though unlikely here
    END AS loyalty_segment
FROM
    CUSTOMERS AS C
LEFT JOIN
    ORDERS AS O ON C.customer_id = O.customer_id
GROUP BY
    C.customer_id, C.first_name, C.last_name
ORDER BY
    C.customer_id ASC;
