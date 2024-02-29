-- creating the DataBase for my Pizzeria:

CREATE DATABASE IF NOT EXISTS `maestro_kevin_slices`;

-- selecting from script the correct DB:

USE `maestro_kevin_slices`;

-- creating `customer` table:

CREATE TABLE IF NOT EXISTS `customer` (
  `customer_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(100) NULL,
  `phone_number` VARCHAR(100) NOT NULL
  );
  
  -- creating `order` table with a MANY to ONE relationship with `customer` table:
  
  CREATE TABLE IF NOT EXISTS `order` (
	`order_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	`customer_id` INT NOT NULL,
	`order_date_time` DATETIME NOT NULL,
	FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`)
  );
  
  -- creating `pizza` table to list the menu items and their prices:

CREATE TABLE IF NOT EXISTS `pizza` (
	`pizza_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	`pizza_name` VARCHAR(30) NOT NULL,
	`pizza_price` DECIMAL(4,2) NOT NULL
  );
  
  -- creating `pizza_order` as a JOIN table between `order` and `pizza` so that they have a MANY to MANY relationship:
  
  CREATE TABLE IF NOT EXISTS `pizza_order`(
	`order_id` INT NOT NULL,
    `pizza_id` INT NOT NULL,
    `quantity`INT NOT NULL,
    FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`),
	FOREIGN KEY (`pizza_id`) REFERENCES `pizza` (`pizza_id`)
  );
  
    
-- Now let's start populating the data with the 3 orders given in the assignment:

-- Inserting data into `customer` table:
INSERT INTO `customer` (`customer_name`, `phone_number`) VALUES
('Trevor Page', '226-555-4982'),
('John Doe', '555-555-9498');

-- checking the data:
select * from `customer`;

-- Inserting data into `order` table:
INSERT INTO `order` (`customer_id`, `order_date_time`) VALUES
(1, '2014-09-10 09:47:00'), -- Order #1 from Trevor Page
(2, '2014-09-10 13:20:00'), -- Order #2 from John Doe
(1, '2014-09-10 09:47:00'); -- Order #3 from Trevor Page

-- checking the data:
select * from `order`;

-- Inserting data into `pizza` table:
INSERT INTO `pizza` (`pizza_name`, `pizza_price`) VALUES
('Pepperoni & Cheese', 7.99),
('Vegetarian', 9.99),
('Meat Lovers', 14.99),
('Hawaiian', 12.99);

-- checking the data:
select * from `pizza`;

-- Inserting data into `pizza_order` table
INSERT INTO `pizza_order` (`order_id`, `pizza_id`, `quantity`) VALUES
(1, 1, 1),  -- Order #1: 1x Pepperoni & Cheese Pizza
(1, 3, 1),  -- Order #1: 1x Meat Lovers Pizza
(2, 2, 1),  -- Order #2: 1x Vegetarian Pizza
(2, 3, 2),  -- Order #2: 2x Meat Lovers Pizza
(3, 3, 1),  -- Order #3: 1x Meat Lovers Pizza
(3, 4, 1);  -- Order #3: 1x Hawaiian Pizza

-- checking the data:
select * from `pizza_order`;

-- ---------------------------- STOP ----------------------------
-- Our Database is correctly created and populated.
-- Now we can start our queries for Q4 and Q5:

-- First, since my DB is small, I have the luxury to check if all my data is correctly populated and my relationships are correct:

SELECT * FROM `order` o
JOIN `customer` c ON c.customer_id = o.customer_id
JOIN `pizza_order` po ON po.order_id = o.order_id
JOIN `pizza` p ON p.pizza_id = po.pizza_id
WHERE o.order_id IN (1, 2, 3);

-- Now let's go into Q4 where we need to SUM up each customers spendings in our pizzeria:

SELECT c.customer_name AS 'Customer', 
	SUM(p.pizza_price * po.quantity) AS 'Total Spent'
FROM `customer` c
JOIN `order` o ON c.customer_id = o.customer_id
JOIN `pizza_order` po ON po.order_id = o.order_id
JOIN `pizza` p ON p.pizza_id = po.pizza_id
GROUP BY c.customer_id;

-- Now Q5, we need to add the date to see how much each customer is spending on which date:

SELECT c.customer_name AS 'Customer', 
	DATE(o.order_date_time) AS 'Date',
    SUM(p.pizza_price * po.quantity) AS 'Total Spent'
FROM `customer` c
JOIN `order` o ON c.customer_id = o.customer_id
JOIN `pizza_order` po ON po.order_id = o.order_id
JOIN `pizza` p ON p.pizza_id = po.pizza_id
GROUP BY c.customer_id, o.order_date_time;

-- ---------------------------- STOP ----------------------------
-- In the assignment, all orders from each customers are placed on the same date (9/10/2014)
-- I would personally add an order at a later date for both customers to check if my script is working correctly
-- let's try and do this by adding an order for John Doe for the next day:

INSERT INTO `order` (`customer_id`, `order_date_time`) VALUES
(2, '2014-09-11 10:50:00'); -- Order #3 from John Doe

INSERT INTO `pizza_order` (`order_id`, `pizza_id`, `quantity`) VALUES
(4, 2, 2),  -- Order #4: 2x Vegetarian Pizza
(4, 1, 1);  -- Order #3: 1x Pepperoni Pizza

-- Now if we check again the script we wrote above to have the SUM by DATE for each CUSTOMER:

SELECT c.customer_name AS 'Customer', 
	DATE(o.order_date_time) AS 'Date',
    SUM(p.pizza_price * po.quantity) AS 'Total Spent'
FROM `customer` c
JOIN `order` o ON c.customer_id = o.customer_id
JOIN `pizza_order` po ON po.order_id = o.order_id
JOIN `pizza` p ON p.pizza_id = po.pizza_id
GROUP BY c.customer_id, o.order_date_time;

-- We can be sure that everything works perfectly and we have a result by date for each customer. ET VOILA !!