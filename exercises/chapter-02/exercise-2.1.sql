-- exercises/chapter-02/exercise-2.1.sql
-- Objective: Find all customers who signed up after '2023-02-01'.

-- Databites Dilemma: The customer success team wants to reach out to recently joined customers.

-- Your task: Write a SQL query to select all columns (*) from the 'Customers' table,
-- but only for customers whose 'signup_date' is later than '2023-02-01'.

SELECT
    *
FROM
    CUSTOMERS
WHERE
    signup_date > '2023-02-01';
