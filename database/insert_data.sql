-- database/insert_data.sql
-- This script combines all data insertion scripts for the Databites database.
-- It is designed to be run after schema.sql to populate all tables with sample data.

-- Insert data into Customers table
INSERT INTO Customers (customer_id, first_name, last_name, email, registration_date, country) VALUES
(1, 'Alice', 'Smith', 'alice.smith@example.com', '2022-01-15', 'USA'),
(2, 'Bob', 'Johnson', 'bob.johnson@example.com', '2022-02-20', 'Canada'),
(3, 'Charlie', 'Brown', 'charlie.brown@example.com', '2022-03-01', 'UK'),
(4, 'Diana', 'Miller', 'diana.miller@example.com', '2022-03-10', 'USA'),
(5, 'Eve', 'Davis', 'eve.davis@example.com', '2022-04-05', 'Australia'),
(6, 'Frank', 'Garcia', 'frank.garcia@example.com', '2022-04-12', 'USA'),
(7, 'Grace', 'Rodriguez', 'grace.rodriguez@example.com', '2022-05-01', 'Canada'),
(8, 'Henry', 'Martinez', 'henry.martinez@example.com', '2022-05-15', 'Mexico'),
(9, 'Ivy', 'Hernandez', 'ivy.hernandez@example.com', '2022-06-01', 'UK'),
(10, 'Jack', 'Lopez', 'jack.lopez@example.com', '2022-06-10', 'USA'),
(11, 'Karen', 'Gonzalez', 'karen.gonzalez@example.com', '2022-07-01', 'Canada'),
(12, 'Liam', 'Perez', 'liam.perez@example.com', '2022-07-18', 'Spain'),
(13, 'Mia', 'Sanchez', 'mia.sanchez@example.com', '2022-08-05', 'France'),
(14, 'Noah', 'Ramirez', 'noah.ramirez@example.com', '2022-08-22', 'Germany'),
(15, 'Olivia', 'Torres', 'olivia.torres@example.com', '2022-09-01', 'Italy'),
(16, 'Peter', 'Flores', 'peter.flores@example.com', '2022-09-10', 'USA'),
(17, 'Quinn', 'Rivera', 'quinn.rivera@example.com', '2022-10-01', 'Canada'),
(18, 'Rachel', 'Gomez', 'rachel.gomez@example.com', '2022-10-15', 'Mexico'),
(19, 'Sam', 'Diaz', 'sam.diaz@example.com', '2022-11-01', 'UK'),
(20, 'Tina', 'Reyes', 'tina.reyes@example.com', '2022-11-12', 'USA'),
(21, 'Uma', 'Cruz', 'uma.cruz@example.com', '2022-12-01', 'Australia'),
(22, 'Victor', 'Ortiz', 'victor.ortiz@example.com', '2022-12-05', 'Canada'),
(23, 'Wendy', 'Morales', 'wendy.morales@example.com', '2023-01-01', 'USA'),
(24, 'Xavier', 'Gutierrez', 'xavier.gutierrez@example.com', '2023-01-10', 'Spain'),
(25, 'Yara', 'Ruiz', 'yara.ruiz@example.com', '2023-02-01', 'France'),
(26, 'Zane', 'Herrera', 'zane.herrera@example.com', '2023-02-15', 'Germany'),
(27, 'Amy', 'Alvarez', 'amy.alvarez@example.com', '2023-03-01', 'Italy'),
(28, 'Ben', 'Castro', 'ben.castro@example.com', '2023-03-10', 'USA'),
(29, 'Chloe', 'Rubio', 'chloe.rubio@example.com', '2023-04-01', 'Canada'),
(30, 'David', 'Serrano', 'david.serrano@example.com', '2023-04-15', 'Mexico');

-- Insert data into Products table
INSERT INTO Products (product_id, product_name, category, price, stock_quantity) VALUES
(101, 'Wireless Bluetooth Headphones', 'Electronics', 149.99, 80),
(102, 'Portable External Hard Drive 1TB', 'Electronics', 79.99, 120),
(103, 'Ergonomic Office Chair', 'Furniture', 249.00, 30),
(104, 'Smart Home Speaker with AI', 'Electronics', 99.50, 150),
(105, 'Organic Coffee Beans 500g', 'Groceries', 12.99, 200),
(106, 'Stainless Steel Water Bottle', 'Kitchenware', 19.99, 180),
(107, '4K UHD Smart TV 55-inch', 'Electronics', 799.00, 45),
(108, 'Gaming Laptop Pro', 'Electronics', 1299.99, 25),
(109, 'Modern Bookshelf', 'Furniture', 120.00, 60),
(110, 'Noise Cancelling Earbuds', 'Electronics', 89.99, 100),
(111, 'Electric Kettle', 'Appliances', 45.00, 75),
(112, 'Digital Camera 24MP', 'Electronics', 349.99, 40),
(113, 'Robot Vacuum Cleaner', 'Appliances', 399.00, 20),
(114, 'Yoga Mat Eco-Friendly', 'Sports', 25.00, 110),
(115, 'Desk Lamp with Wireless Charger', 'Furniture', 55.00, 90),
(116, 'High-Performance Blender', 'Appliances', 85.50, 50),
(117, 'Mechanical Gaming Keyboard', 'Electronics', 110.00, 70),
(118, 'Non-stick Frying Pan Set', 'Kitchenware', 65.00, 85),
(119, 'Protein Powder Vanilla 1kg', 'Supplements', 35.00, 130),
(120, 'Smartwatch Fitness Tracker', 'Electronics', 199.99, 65),
(121, 'Air Fryer XL', 'Appliances', 120.00, 35),
(122, 'Camping Tent 2-person', 'Sports', 90.00, 40),
(123, 'Luxury Leather Wallet', 'Accessories', 70.00, 100),
(124, 'Wireless Mouse Ergonomic', 'Electronics', 25.99, 160),
(125, 'Glass Food Storage Containers', 'Kitchenware', 30.00, 115),
(126, 'Adjustable Standing Desk', 'Furniture', 450.00, 15),
(127, 'Portable Projector', 'Electronics', 299.99, 20),
(128, 'Espresso Machine', 'Appliances', 250.00, 10),
(129, 'Running Shoes Mens', 'Sports', 80.00, 95),
(130, 'Silk Pillowcase Set', 'Home Decor', 40.00, 70);

-- Insert data into Orders table
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status, shipping_address) VALUES
(1001, 1, '2023-01-16', 299.98, 'Completed', '123 Main St, Anytown, USA'),
(1002, 2, '2023-01-17', 149.99, 'Pending', '456 Oak Ave, Big City, Canada'),
(1003, 3, '2023-01-18', 249.00, 'Completed', '789 Pine Rd, Smallville, UK'),
(1004, 4, '2023-01-19', 99.50, 'Shipped', '101 Elm St, New York, USA'),
(1005, 5, '2023-01-20', 12.99, 'Completed', '202 Bridge Rd, Sydney, Australia'),
(1006, 1, '2023-02-01', 79.99, 'Completed', '123 Main St, Anytown, USA'),
(1007, 6, '2023-02-05', 899.00, 'Shipped', '303 River Dr, Houston, USA'),
(1008, 7, '2023-02-10', 110.00, 'Pending', '404 Lake Blvd, Toronto, Canada'),
(1009, 8, '2023-02-15', 399.00, 'Completed', '505 Mountain Way, Mexico City, Mexico'),
(1010, 9, '2023-02-20', 65.00, 'Completed', '606 Hill Lane, London, UK'),
(1011, 10, '2023-03-01', 199.99, 'Shipped', '707 Valley Rd, Los Angeles, USA'),
(1012, 11, '2023-03-05', 35.00, 'Pending', '808 Prairie Ct, Vancouver, Canada'),
(1013, 12, '2023-03-10', 450.00, 'Completed', '909 Ocean St, Barcelona, Spain'),
(1014, 13, '2023-03-15', 120.00, 'Completed', '111 City Rd, Paris, France'),
(1015, 14, '2023-03-20', 299.99, 'Shipped', '222 Forest Ave, Berlin, Germany'),
(1016, 15, '2023-04-01', 250.00, 'Pending', '333 Country Ln, Rome, Italy'),
(1017, 16, '2023-04-05', 80.00, 'Completed', '444 Village Dr, Dallas, USA'),
(1018, 17, '2023-04-10', 40.00, 'Completed', '555 Lake View, Ottawa, Canada'),
(1019, 18, '2023-04-15', 149.99, 'Shipped', '666 Desert Rd, Guadalajara, Mexico'),
(1020, 19, '2023-04-20', 79.99, 'Pending', '777 Urban St, Edinburgh, UK'),
(1021, 20, '2023-05-01', 249.00, 'Completed', '888 Beach Blvd, Miami, USA'),
(1022, 21, '2023-05-05', 99.50, 'Shipped', '999 Park Rd, Perth, Australia'),
(1023, 22, '2023-05-10', 12.99, 'Completed', '1010 Mountain St, Calgary, Canada'),
(1024, 23, '2023-05-15', 19.99, 'Completed', '1111 Vine St, Chicago, USA'),
(1025, 24, '2023-05-20', 799.00, 'Shipped', '1212 Cliff Ave, Madrid, Spain'),
(1026, 25, '2023-06-01', 1299.99, 'Pending', '1313 Green Ln, Marseille, France'),
(1027, 26, '2023-06-05', 120.00, 'Completed', '1414 Red St, Munich, Germany'),
(1028, 27, '2023-06-10', 89.99, 'Completed', '1515 Blue Ave, Naples, Italy'),
(1029, 28, '2023-06-15', 45.00, 'Shipped', '1616 Gold St, Phoenix, USA'),
(1030, 29, '2023-06-20', 349.99, 'Pending', '1717 Silver Ave, Edmonton, Canada');

-- Insert data into OrderItems table
INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, item_price) VALUES
(1, 1001, 101, 2, 149.99),
(2, 1002, 102, 1, 79.99),
(3, 1002, 105, 1, 12.99), -- Added item to order 1002
(4, 1003, 103, 1, 249.00),
(5, 1004, 104, 1, 99.50),
(6, 1005, 105, 1, 12.99),
(7, 1006, 102, 1, 79.99),
(8, 1007, 107, 1, 799.00),
(9, 1007, 104, 1, 99.50), -- Added item to order 1007
(10, 1008, 117, 1, 110.00),
(11, 1009, 113, 1, 399.00),
(12, 1010, 118, 1, 65.00),
(13, 1011, 120, 1, 199.99),
(14, 1012, 119, 1, 35.00),
(15, 1013, 126, 1, 450.00),
(16, 1014, 109, 1, 120.00),
(17, 1015, 127, 1, 299.99),
(18, 1016, 128, 1, 250.00),
(19, 1017, 129, 1, 80.00),
(20, 1018, 130, 1, 40.00),
(21, 1019, 101, 1, 149.99),
(22, 1020, 102, 1, 79.99),
(23, 1021, 103, 1, 249.00),
(24, 1022, 104, 1, 99.50),
(25, 1023, 105, 1, 12.99),
(26, 1024, 106, 1, 19.99),
(27, 1025, 107, 1, 799.00),
(28, 1026, 108, 1, 1299.99),
(29, 1027, 109, 1, 120.00),
(30, 1028, 110, 1, 89.99),
(31, 1029, 111, 1, 45.00),
(32, 1030, 112, 1, 349.99);

