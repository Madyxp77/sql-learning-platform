-- exercises/chapter-08/exercise-8.3.sql
-- Objective: For each order, show the order date and the date of the customer's previous order,
-- and calculate the days since the previous order.

-- Databites Dilemma: The customer retention team wants to understand the time gap
-- between a customer's consecutive orders to identify potential churn risks or
-- successful re-engagement efforts.

-- Your task: Write a SQL query that uses the LAG() window function.
-- 1. Select 'customer_id', 'order_id', 'order_date'.
-- 2. Use LAG(order_date, 1, '1900-01-01') OVER (PARTITION BY customer_id ORDER BY order_date ASC)
--    to get the 'previous_order_date' for each customer's orders.
-- 3. Calculate the difference in days between the 'order_date' and 'previous_order_date'.
--    Note: Date difference functions vary by SQL dialect. For SQLite (used by SQL.js),
--    you can calculate the difference in days by subtracting the dates directly
--    if they are in 'YYYY-MM-DD' format, or use JULIANDAY() for precise day differences.
--    Example: (JULIANDAY(order_date) - JULIANDAY(previous_order_date))

SELECT
    customer_id,
    order_id,
    order_date,
    LAG(order_date, 1, '1900-01-01') OVER (PARTITION BY customer_id ORDER BY order_date ASC) AS previous_order_date,
    -- Calculate days difference. For SQLite, assuming dates are 'YYYY-MM-DD' format:
    JULIANDAY(order_date) - JULIANDAY(LAG(order_date, 1, '1900-01-01') OVER (PARTITION BY customer_id ORDER BY order_date ASC)) AS days_since_previous_order
FROM
    ORDERS
ORDER BY
    customer_id ASC,
    order_date ASC;
