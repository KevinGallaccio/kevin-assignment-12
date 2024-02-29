-- creating the DataBase for my Pizzeria:

CREATE DATABASE `maestro_kevin_slices`;

-- selecting from script the correct DB:

USE `maestro_kevin_slices`;

-- creating `customer` table:

CREATE TABLE `maestro_kevin_slices`.`customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(100) NULL,
  `phone_number` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`customer_id`));


