-- exercises/skill-checkpoint-basic-querying-mastery/exercise-2.sql
-- Objective: Find high-value electronics products.

-- Scenario: The product development team is reviewing high-value electronics.
-- Find the product_name and price of all 'Electronics' products that cost more than $200.
-- Sort them by price from highest to lowest.

-- Your task: Write a SQL query that selects specific columns, filters by category AND price,
-- and then orders the results.

SELECT
    product_name,
    price
FROM
    PRODUCTS
WHERE
    category = 'Electronics' AND price > 200
ORDER BY
    price DESC;
