-- exercises/chapter-02/exercise-2.4.sql
-- Objective: Find all products whose names contain the word 'Desk'.

-- Databites Dilemma: You're helping update the website, and you need to find
-- all products whose names contain the word 'Desk' (case-insensitive if your
-- database supports it, otherwise be mindful of casing).

-- Your task: Write a SQL query to select 'product_name' from the 'PRODUCTS' table.
-- Use the LIKE operator with the appropriate wildcard character (%) to find
-- names that contain 'Desk'.

SELECT
    product_name
FROM
    PRODUCTS
WHERE
    product_name LIKE '%Desk%'; -- Use LOWER(product_name) LIKE '%desk%' for case-insensitivity
