-- exercises/chapter-07/exercise-7.2.sql
-- Objective: List the first_name, last_name, and total_spent for all customers
-- whose total_spent is greater than the overall average total spent by all customers.

-- Databites Dilemma: The marketing team wants to identify high-value customers
-- for a special loyalty program, specifically those whose spending is above the average.

-- Your task: Write a SQL query using two CTEs (or one CTE and a subquery).
-- 1. Create a CTE named 'CustomerTotalSpending' to calculate each customer's total spending.
--    This CTE will need to join CUSTOMERS, ORDERS, and PRODUCTS, then group by customer details.
-- 2. From this CTE, select the customer details and total_spent, filtering those
--    where 'total_spent' is greater than the overall average of 'total_spent'
--    (which you'll calculate using a scalar subquery or another CTE).

WITH CustomerTotalSpending AS (
    SELECT
        C.customer_id,
        C.first_name,
        C.last_name,
        SUM(O.quantity * P.price) AS total_spent
    FROM
        CUSTOMERS AS C
    INNER JOIN
        ORDERS AS O ON C.customer_id = O.customer_id
    INNER JOIN
        PRODUCTS AS P ON O.product_id = P.product_id
    GROUP BY
        C.customer_id, C.first_name, C.last_name
)
SELECT
    first_name,
    last_name,
    total_spent
FROM
    CustomerTotalSpending
WHERE
    total_spent > (SELECT AVG(total_spent) FROM CustomerTotalSpending);
