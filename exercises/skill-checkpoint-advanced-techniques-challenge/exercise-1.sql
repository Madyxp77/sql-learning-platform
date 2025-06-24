-- exercises/skill-checkpoint-advanced-techniques-challenge/exercise-1.sql
-- Objective: For each customer, list their total spending, spending rank, and loyalty tier.

-- Scenario: The executive team wants a report showing each customer's total spending
-- and classifying them into loyalty tiers based on that spending, along with their rank by spending.
-- Loyalty tiers are defined as:
-- 'Bronze' if total spent < $500
-- 'Silver' if $500-$1000
-- 'Gold' if > $1000
-- Use DENSE_RANK() for spending_rank (highest spender = rank 1).

-- Your task: Write a SQL query that combines CTEs, Window Functions (DENSE_RANK), and CASE statements.
-- 1. Create a CTE to calculate each customer's total spending (joining Customers, Orders, Products).
-- 2. In the final SELECT, apply DENSE_RANK() to assign spending_rank.
-- 3. Use a CASE statement to determine the 'loyalty_tier'.

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
    CTS.customer_id,
    CTS.first_name,
    CTS.last_name,
    CTS.total_spent,
    DENSE_RANK() OVER (ORDER BY CTS.total_spent DESC) AS spending_rank,
    CASE
        WHEN CTS.total_spent < 500 THEN 'Bronze'
        WHEN CTS.total_spent BETWEEN 500 AND 1000 THEN 'Silver'
        WHEN CTS.total_spent > 1000 THEN 'Gold'
        ELSE 'No Spend' -- Handles cases where a customer might have 0 total_spent (e.g., via LEFT JOIN with no orders, if applicable)
    END AS loyalty_tier
FROM
    CustomerTotalSpending AS CTS
ORDER BY
    CTS.total_spent DESC;
