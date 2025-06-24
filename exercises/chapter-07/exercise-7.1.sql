-- exercises/chapter-07/exercise-7.1.sql
-- Objective: Calculate the total revenue generated each month.

-- Databites Dilemma: Databites' finance department needs a report showing the
-- total revenue generated each month to track sales performance over time.

-- Your task: Write a SQL query using a Common Table Expression (CTE).
-- 1. Create a CTE to calculate the revenue for each order line item (quantity * price).
--    You'll need to join ORDERS and PRODUCTS.
-- 2. From this CTE, extract the month (e.g., 'YYYY-MM' format) from 'order_date'.
-- 3. Group the results by the extracted month and sum the line item revenues.
-- 4. Order the final results by month in ascending order.

-- Note: Date formatting functions might vary by SQL dialect.
-- For SQLite (used by SQL.js), you can use strftime('%Y-%m', order_date).
-- Example: SELECT strftime('%Y-%m', '2023-01-15') would return '2023-01'.

WITH OrderRevenue AS (
    SELECT
        O.order_id,
        O.customer_id,
        O.order_date,
        (O.quantity * P.price) AS revenue_per_line_item
    FROM
        ORDERS AS O
    INNER JOIN
        PRODUCTS AS P ON O.product_id = P.product_id
)
SELECT
    strftime('%Y-%m', order_date) AS sale_month,
    SUM(revenue_per_line_item) AS total_monthly_revenue
FROM
    OrderRevenue
GROUP BY
    sale_month
ORDER BY
    sale_month ASC;
