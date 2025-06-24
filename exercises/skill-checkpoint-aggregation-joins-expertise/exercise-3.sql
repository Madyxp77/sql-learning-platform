-- exercises/skill-checkpoint-aggregation-joins-expertise/exercise-3.sql
-- Objective: Identify products purchased by specific customer types.

-- Scenario: Identify products purchased by customers from 'Canada' who have placed at least two orders.
-- List the DISTINCT product_name for products that were purchased by customers from 'Canada'
-- who have made two or more orders.

-- Your task: Write a SQL query that combines JOINs and a subquery to filter customers
-- based on their country and order count, then lists the distinct products.

SELECT DISTINCT
    P.product_name
FROM
    PRODUCTS AS P
INNER JOIN
    ORDERS AS O ON P.product_id = O.product_id
INNER JOIN
    CUSTOMERS AS C ON O.customer_id = C.customer_id
WHERE
    C.country = 'Canada'
AND
    C.customer_id IN (
        SELECT
            customer_id
        FROM
            ORDERS
        GROUP BY
            customer_id
        HAVING
            COUNT(order_id) >= 2
    );
