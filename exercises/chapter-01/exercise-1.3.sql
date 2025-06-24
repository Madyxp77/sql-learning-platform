-- exercises/chapter-01/exercise-1.3.sql
-- Objective: List all the unique categories of products we sell.

-- Databites Dilemma: Databites wants to know all the unique categories of products they sell
-- to understand their product diversification.

-- Your task: Write a SQL query to select only the unique values from the 'category' column
-- from the 'PRODUCTS' table.

SELECT DISTINCT category
FROM PRODUCTS;
