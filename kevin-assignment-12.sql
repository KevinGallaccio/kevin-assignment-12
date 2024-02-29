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