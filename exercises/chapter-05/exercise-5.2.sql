-- exercises/chapter-05/exercise-5.2.sql
-- Objective: Find the first_name and last_name of customers,
-- along with the product_name of everything they've ever ordered.

-- Databites Dilemma: The customer relationship management (CRM) team wants
-- a comprehensive view of what each customer has purchased to personalize
-- future interactions.

-- Your task: Write a SQL query that joins the 'CUSTOMERS', 'ORDERS', and 'PRODUCTS' tables
-- to connect customer names with the products in their orders. Use appropriate aliases.

SELECT
    C.first_name,
    C.last_name,
    P.product_name
FROM
    CUSTOMERS AS C
INNER JOIN
    ORDERS AS O ON C.customer_id = O.customer_id
INNER JOIN
    PRODUCTS AS P ON O.product_id = P.product_id;
