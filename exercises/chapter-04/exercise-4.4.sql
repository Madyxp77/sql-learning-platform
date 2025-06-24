-- exercises/chapter-04/exercise-4.4.sql
-- Objective: Calculate the total quantity of Laptops (product_id 1001) that have been sold.

-- Databites Dilemma: The inventory manager wants to know the total quantity of Laptops
-- (product_id 1001) that have been sold to assess stock levels and demand.

-- Your task: Write a SQL query to calculate the sum of 'quantity' for all orders
-- where the 'product_id' is 1001. You will need to use an aggregate function
-- and filter the rows before aggregation.

SELECT
    SUM(quantity) AS total_laptops_sold
FROM
    ORDERS
WHERE
    product_id = 1001;
