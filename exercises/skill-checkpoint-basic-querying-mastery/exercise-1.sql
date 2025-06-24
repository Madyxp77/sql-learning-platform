-- exercises/skill-checkpoint-basic-querying-mastery/exercise-1.sql
-- Objective: Create a New Customer Report.

-- Scenario: Our marketing team wants a list of the first_name, last_name, and country
-- of all customers who signed up in March 2023. They want this list ordered by signup_date
-- from newest to oldest.

-- Your task: Write a SQL query that combines SELECT, FROM, WHERE (with BETWEEN), and ORDER BY
-- to fulfill this request.

SELECT
    first_name,
    last_name,
    country
FROM
    CUSTOMERS
WHERE
    signup_date BETWEEN '2023-03-01' AND '2023-03-31'
ORDER BY
    signup_date DESC;
