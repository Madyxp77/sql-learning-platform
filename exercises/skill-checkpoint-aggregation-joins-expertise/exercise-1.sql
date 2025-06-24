-- exercises/skill-checkpoint-aggregation-joins-expertise/exercise-1.sql
-- Objective: Find the top-selling product categories based on total quantity sold.

-- Scenario: The sales director wants to know which product categories are performing best.
-- Find the category and the total_quantity_sold for each product category.
-- Only include categories where the total_quantity_sold is greater than 3.
-- Sort the results by total_quantity_sold in descending order.

-- Your task: Write a SQL query that uses JOINs, GROUP BY, HAVING, and ORDER BY
-- to achieve this.

SELECT
    P.category,
    SUM(O.quantity) AS total_quantity_sold
FROM
    ORDERS AS O
INNER JOIN
    PRODUCTS AS P ON O.product_id = P.product_id
GROUP BY
    P.category
HAVING
    SUM(O.quantity) > 3
ORDER BY
    total_quantity_sold DESC;
