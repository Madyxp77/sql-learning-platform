-- exercises/chapter-09/exercise-9.3.sql
-- Objective: Categorize each individual order based on its total value:
-- 'Small' (total order value < $200), 'Medium' ($200-$500), 'Large' (>$500).

-- Databites Dilemma: The finance department wants to categorize individual orders
-- based on their total value to analyze order size distribution and identify
-- high-value transactions.

-- Your task: Write a SQL query to list 'order_id', 'customer_id', 'order_date',
-- 'total_order_value', and 'order_value_category'.
-- 1. Use a CTE to calculate the total value for each order (SUM(quantity * price)).
--    This CTE will need to join ORDERS and PRODUCTS and group by order details.
-- 2. Then, use a CASE statement on this 'total_order_value' to assign the category.

WITH OrderValue AS (
    SELECT
        O.order_id,
        O.customer_id,
        O.order_date,
        SUM(O.quantity * P.price) AS total_order_value
    FROM
        ORDERS AS O
    INNER JOIN
        PRODUCTS AS P ON O.product_id = P.product_id
    GROUP BY
        O.order_id, O.customer_id, O.order_date
)
SELECT
    order_id,
    customer_id,
    order_date,
    total_order_value,
    CASE
        WHEN total_order_value < 200 THEN 'Small'
        WHEN total_order_value BETWEEN 200 AND 500 THEN 'Medium'
        WHEN total_order_value > 500 THEN 'Large'
        ELSE 'Unknown' -- Fallback for any values not covered
    END AS order_value_category
FROM
    OrderValue
ORDER BY
    order_id ASC;
