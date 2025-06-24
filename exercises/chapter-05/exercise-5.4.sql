-- exercises/chapter-05/exercise-5.4.sql
-- Objective: For each order, show the customer_id, product_name, quantity, and the total cost for that specific line item (quantity multiplied by price).

-- Databites Dilemma: For each order, the finance department wants to see the individual product,
-- its quantity, and the total cost for that specific line item (quantity multiplied by price)
-- to better track revenue per product sold.

-- Your task: Write a SQL query that joins the 'ORDERS' table with the 'PRODUCTS' table.
-- Select 'customer_id', 'product_name', 'quantity', and a calculated column
-- named 'total_line_item_cost' which is the 'quantity' multiplied by the 'price'.

SELECT
    O.customer_id,
    P.product_name,
    O.quantity,
    (O.quantity * P.price) AS total_line_item_cost
FROM
    ORDERS AS O
INNER JOIN
    PRODUCTS AS P ON O.product_id = P.product_id;
