-- exercises/chapter-02/exercise-2.3.sql
-- Objective: Show orders placed by customer_id 1 OR 3.

-- Databites Dilemma: Databites has two VIP customers, customer_id 1 and customer_id 3.
-- They want to review all orders placed by either of these customers.

-- Your task: Write a SQL query to select all columns (*) from the 'ORDERS' table,
-- where the 'customer_id' is either 1 or 3.
-- Consider using the IN operator for a more concise solution.

SELECT
    *
FROM
    ORDERS
WHERE
    customer_id IN (1, 3); -- Alternative: WHERE customer_id = 1 OR customer_id = 3;
