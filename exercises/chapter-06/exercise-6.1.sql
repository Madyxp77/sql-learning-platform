-- exercises/chapter-06/exercise-6.1.sql
-- Objective: List the first_name and last_name of customers who have placed an order
-- for a product with a price greater than $300.

-- Databites Dilemma: The sales team wants to target customers who have ordered any product
-- costing more than $300 for a special offer on premium accessories.

-- Your task: Write a SQL query using a subquery in the WHERE clause.
-- 1. The inner query should identify the customer_ids of those who ordered products > $300.
-- 2. The outer query should then select the first_name and last_name from the Customers table
--    using the customer_ids obtained from the inner query.

SELECT
    C.first_name,
    C.last_name
FROM
    CUSTOMERS AS C
WHERE
    C.customer_id IN (
        SELECT O.customer_id
        FROM ORDERS AS O
        INNER JOIN PRODUCTS AS P ON O.product_id = P.product_id
        WHERE P.price > 300
    );
