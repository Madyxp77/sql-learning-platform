-- exercises/skill-checkpoint-advanced-techniques-challenge/exercise-2.sql
-- Objective: For each distinct product, for each month it was ordered,
-- show the product_name, the order_month, and a running_order_count
-- (which counts orders for that specific product cumulatively over time).

-- Scenario: The product manager wants to see a running count of how many times
-- each product has been ordered, segmented by month, to track its popularity over time.

-- Your task: Write a SQL query that uses CTEs and Window Functions.
-- 1. Create a CTE to get monthly order counts for each product.
--    This CTE will need to join ORDERS and PRODUCTS, then group by product and month.
-- 2. In the final SELECT, apply a SUM() window function to calculate the running count.
--    PARTITION BY product_id and ORDER BY order_month to ensure the running total is per product and cumulative over time.

-- Note: Date formatting functions might vary by SQL dialect.
-- For SQLite (used by SQL.js), you can use strftime('%Y-%m', order_date).

WITH ProductMonthlyOrders AS (
    SELECT
        P.product_id,
        P.product_name,
        strftime('%Y-%m', O.order_date) AS order_month,
        COUNT(O.order_id) AS monthly_order_count
    FROM
        ORDERS AS O
    INNER JOIN
        PRODUCTS AS P ON O.product_id = P.product_id
    GROUP BY
        P.product_id, P.product_name, order_month
)
SELECT
    product_name,
    order_month,
    monthly_order_count,
    SUM(monthly_order_count) OVER (PARTITION BY product_id ORDER BY order_month ASC) AS running_order_count
FROM
    ProductMonthlyOrders
ORDER BY
    product_name ASC,
    order_month ASC;
