-- exercises/skill-checkpoint-basic-querying-mastery/exercise-3.sql
-- Objective: Retrieve specific order details.

-- Scenario: A customer support agent needs quick access to details for particular orders.
-- Retrieve all details (*) for orders placed by customer_id 1 that had a quantity of 1.

-- Your task: Write a SQL query that selects all columns, filters by two conditions
-- (customer_id AND quantity), and combines the filtering logic.

SELECT
    *
FROM
    ORDERS
WHERE
    customer_id = 1 AND quantity = 1;
