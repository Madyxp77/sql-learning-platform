-- exercises/chapter-09/exercise-9.2.sql
-- Objective: Rate products based on their total sales quantity:
-- 'Low Sales' (total quantity < 3), 'Medium Sales' (total quantity 3-5),
-- 'High Sales' (total quantity > 5), 'No Sales Data' (product not in orders).

-- Databites Dilemma: The product team wants to rate products based on their
-- overall sales volume to prioritize inventory and marketing efforts.

-- Your task: Write a SQL query to list 'product_name', 'category',
-- 'total_quantity_sold', and their calculated 'sales_performance_rating'.
-- 1. Use a LEFT JOIN between PRODUCTS and ORDERS to include products with no sales.
-- 2. Group the results by product details.
-- 3. Use a CASE statement with SUM(O.quantity) to define the 'sales_performance_rating'.

SELECT
    P.product_name,
    P.category,
    SUM(O.quantity) AS total_quantity_sold,
    CASE
        WHEN SUM(O.quantity) IS NULL OR SUM(O.quantity) = 0 THEN 'No Sales Data' -- For products not in orders or 0 quantity
        WHEN SUM(O.quantity) < 3 THEN 'Low Sales'
        WHEN SUM(O.quantity) BETWEEN 3 AND 5 THEN 'Medium Sales'
        WHEN SUM(O.quantity) > 5 THEN 'High Sales'
        ELSE 'Unknown' -- Fallback, though unlikely here
    END AS sales_performance_rating
FROM
    PRODUCTS AS P
LEFT JOIN
    ORDERS AS O ON P.product_id = O.product_id
GROUP BY
    P.product_id, P.product_name, P.category
ORDER BY
    total_quantity_sold DESC;
