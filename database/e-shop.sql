CREATE DATABASE IF NOT EXISTS `e-shop` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `e-shop`;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `order_items`;
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `products`;
DROP TABLE IF EXISTS `categories`;
DROP TABLE IF EXISTS `users`;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `phone_number` VARCHAR(50) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `user_type` VARCHAR(20) NOT NULL DEFAULT 'customer',
  `created` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_users_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  `photo` LONGTEXT NULL,
  `parent_id` INT NOT NULL DEFAULT 0,
  `created` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_categories_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `buying_price` DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  `price` DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  `description` LONGTEXT NULL,
  `photo` LONGTEXT NULL,
  `category_id` INT NOT NULL DEFAULT 0,
  `user_id` INT NOT NULL DEFAULT 0,
  `created` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_products_category_id` (`category_id`),
  KEY `idx_products_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL,
  `customer_name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `phone_number` VARCHAR(50) NOT NULL,
  `address_line_1` VARCHAR(255) NOT NULL,
  `address_line_2` VARCHAR(255) NULL,
  `city` VARCHAR(120) NOT NULL,
  `state` VARCHAR(120) NULL,
  `zip_code` VARCHAR(30) NULL,
  `country` VARCHAR(120) NOT NULL,
  `note` TEXT NULL,
  `subtotal` DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  `status` VARCHAR(30) NOT NULL DEFAULT 'pending',
  `created` INT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_orders_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `order_items` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `product_name` VARCHAR(255) NOT NULL,
  `product_price` DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  `quantity` INT NOT NULL DEFAULT 1,
  `photo` LONGTEXT NULL,
  `created` INT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_order_items_order_id` (`order_id`),
  KEY `idx_order_items_product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT IGNORE INTO `categories` (`id`, `name`, `description`, `photo`, `parent_id`, `created`) VALUES
(1, 'All Products', 'Main category for the demo store.', NULL, 0, 1710000000),
(2, 'Fashion', 'Clothing and accessories.', NULL, 1, 1710000100),
(3, 'Electronics', 'Phones, laptops, and gadgets.', NULL, 1, 1710000200),
(4, 'Home & Living', 'Home, kitchen, and daily use items.', NULL, 1, 1710000300);

INSERT IGNORE INTO `products` (`id`, `name`, `buying_price`, `price`, `description`, `photo`, `category_id`, `user_id`, `created`) VALUES
(1, 'Yellow Footwear - Women Footwear', 1200.00, 1999.00, 'Demo product for testing the catalog and product page.', NULL, 2, 1, 1710001000),
(2, 'Iphone XR - Latest Iphone', 35000.00, 42999.00, 'Demo product for testing product details, cart, and checkout.', NULL, 3, 1, 1710002000),
(3, 'HP 250R G9 Notebook PC - Raptor Lake', 52000.00, 57999.00, 'Demo laptop product for testing the admin and product listing pages.', NULL, 3, 1, 1710003000),
(4, 'Men''s Shorts - Men Wears', 900.00, 1499.00, 'Demo fashion product for testing cart flow.', NULL, 2, 1, 1710004000);
