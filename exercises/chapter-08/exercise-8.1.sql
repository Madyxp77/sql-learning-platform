-- exercises/chapter-08/exercise-8.1.sql
-- Objective: For each order, list the customer_id, order_date, product_name, quantity,
-- and a running_total_quantity column that sums quantities for that customer
-- up to the current order date.

-- Databites Dilemma: The analytics team wants to see a running total of the quantity
-- of products a customer has ordered over time to understand their purchase accumulation.

-- Your task: Write a SQL query that uses a window function.
-- 1. Join the 'ORDERS' table with the 'PRODUCTS' table to get product_name.
-- 2. Use SUM(quantity) as a window function.
-- 3. PARTITION BY customer_id to calculate the sum for each customer independently.
-- 4. ORDER BY order_date ASC within each partition to create a running total.

SELECT
    O.customer_id,
    O.order_date,
    P.product_name,
    O.quantity,
    SUM(O.quantity) OVER (PARTITION BY O.customer_id ORDER BY O.order_date ASC) AS running_total_quantity
FROM
    ORDERS AS O
INNER JOIN
    PRODUCTS AS P ON O.product_id = P.product_id
ORDER BY -- Optional: Order the final result set for readability
    O.customer_id ASC,
    O.order_date ASC;
