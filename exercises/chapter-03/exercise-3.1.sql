-- exercises/chapter-03/exercise-3.1.sql
-- Objective: List all customers, ordered by their signup_date from oldest to newest.

-- Databites Dilemma: Databites wants to identify its longest-standing customers
-- to understand their historical engagement.

-- Your task: Write a SQL query to select 'first_name', 'last_name', and 'signup_date'
-- from the 'CUSTOMERS' table. Order the results by 'signup_date' in ascending order.

SELECT
    first_name,
    last_name,
    signup_date
FROM
    CUSTOMERS
ORDER BY
    signup_date ASC; -- 'ASC' is optional here as it's the default
