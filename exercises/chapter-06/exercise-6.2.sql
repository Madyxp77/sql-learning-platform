-- exercises/chapter-06/exercise-6.2.sql
-- Objective: List the product_name and category of products that have no entries in the ORDERS table.

-- Databites Dilemma: Databites wants to identify products currently in their catalog
-- that have never been included in an order, to potentially discontinue them or
-- initiate new marketing campaigns.

-- Your task: Write a SQL query using a subquery with the NOT IN operator.
-- 1. The inner query should select the DISTINCT product_id from the ORDERS table
--    to get a list of all products that HAVE been ordered.
-- 2. The outer query should then select the product_name and category from the
--    PRODUCTS table, excluding any product_id found in the inner query's result.

SELECT
    product_name,
    category
FROM
    PRODUCTS
WHERE
    product_id NOT IN (SELECT DISTINCT product_id FROM ORDERS);
