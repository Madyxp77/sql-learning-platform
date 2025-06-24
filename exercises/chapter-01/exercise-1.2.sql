-- exercises/chapter-01/exercise-1.2.sql
-- Objective: Show all details for the top 2 products.

-- Databites Dilemma: You're doing a quick check and just want to see
-- the first two products from the 'PRODUCTS' table, including all their details.

-- Your task: Write a SQL query to select all columns (*) from the 'PRODUCTS' table,
-- and then limit the result to only the first 2 rows.

SELECT *
FROM PRODUCTS
LIMIT 2; -- For MySQL/PostgreSQL. In SQL Server, use SELECT TOP 2 * FROM PRODUCTS;
