-- exercises/skill-checkpoint-advanced-techniques-challenge/exercise-3.sql
-- Objective: Categorize customer sign-ups by country into 'Recent Signup' or 'Older Signup'.

-- Scenario: The retention team wants to see a count of 'Recent Signup' (signed up in Feb 2023 or later)
-- vs. 'Older Signup' (signed up before Feb 2023) customers, broken down by their country.
-- This helps analyze customer acquisition trends based on their geographic location.

-- Your task: Write a SQL query that uses a CASE statement and aggregation.
-- 1. Select the 'country'.
-- 2. Use SUM(CASE WHEN ...) to conditionally count 'recent_signups' (>= '2023-02-01').
-- 3. Use SUM(CASE WHEN ...) again to conditionally count 'older_signups' (< '2023-02-01').
-- 4. Group the results by 'country'.

SELECT
    country,
    SUM(CASE WHEN signup_date >= '2023-02-01' THEN 1 ELSE 0 END) AS recent_signups,
    SUM(CASE WHEN signup_date < '2023-02-01' THEN 1 ELSE 0 END) AS older_signups
FROM
    CUSTOMERS
GROUP BY
    country
ORDER BY
    country ASC;
