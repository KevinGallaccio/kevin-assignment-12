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
	`pizza_name` VARCHAR(30) CHARACTER SET 'DEFAULT' NOT NULL,
	`pizza_price` DECIMAL(4,2) NOT NULL
  );
  
  -- creating `pizza_order` as a JOIN table between `order` and `pizza` so that they have a MANY to MANY relationship:
  
  CREATE TABLE IF NOT EXISTS `pizza_order`(
	`order_id` INT NOT NULL,
    `pizza_id` INT NOT NULL,
    FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`),
	FOREIGN KEY (`pizza_id`) REFERENCES `pizza` (`pizza_id`)
  );
  
    
-- Now let's start populating the data with the 3 orders given in the assignment:

-- Inserting data into `customer` table:
INSERT INTO `customer` (`customer_name`, `phone_number`) VALUES
('Trevor Page', '226-555-4982'),
('John Doe', '555-555-9498');

-- Inserting data into `order` table:
INSERT INTO `order` (`customer_id`, `order_date_time`) VALUES
(1, '2014-09-10 09:47:00'), -- Order #1 from Trevor Page
(2, '2014-09-10 13:20:00'), -- Order #2 from John Doe
(1, '2014-09-10 09:47:00'); -- Order #3 from Trevor Page

-- Inserting data into `pizza` table:
INSERT INTO `pizza` (`pizza_name`, `pizza_price`) VALUES
('Pepperoni & Cheese', 7.99),
('Vegetarian', 9.99),
('Meat Lovers', 14.99),
('Hawaiian', 12.99);

-- Inserting data into `pizza_order` table
INSERT INTO `pizza_order` (`order_id`, `pizza_id`) VALUES
(1, 1),  -- Order #1: 1x Pepperoni & Cheese Pizza
(1, 3),  -- Order #1: 1x Meat Lovers Pizza
(2, 2),  -- Order #2: 1x Vegetarian Pizza
(2, 3),  -- Order #2: 2x Meat Lovers Pizza
(3, 3),  -- Order #3: 1x Meat Lovers Pizza
(3, 4);  -- Order #3: 1x Hawaiian Pizza