-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 09, 2024 at 10:44 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fast_food_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customerID` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` enum('customer','admin') DEFAULT 'customer'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customerID`, `name`, `email`, `phone`, `address`, `username`, `password`, `role`) VALUES
(1, 'Alice Johnson', 'alice.johnson@example.com', '123-456-7890', '123 Maple St', 'alicej', '$2b$12$x.sodpcpYLrwHWU7hN9UD.jH3qb1w8r0MIjapEtVNEusLvPLwvE1i', 'customer'),
(2, 'Bob Smith', 'bob.smith@example.com', '234-567-8901', '456 Oak St', 'bobsmith', '$2b$12$7UvQY95qcmkDPZgfWSqtY.lip58xN7G4Rsb7tPA6BgyDVwujbfQ5m', 'customer'),
(3, 'John Doe', 'john.doe@example.com', '1234567890', '123 Elm St', 'johndoe', '$2b$12$x.sodpcpYLrwHWU7hN9UD.jH3qb1w8r0MIjapEtVNEusLvPLwvE1i', 'customer'),
(4, 'Alice Johnson', 'alice.johnson@example.com', '123-456-7890', '123 Maple St', 'alicej', '$2b$12$x.sodpcpYLrwHWU7hN9UD.jH3qb1w8r0MIjapEtVNEusLvPLwvE1i', 'customer'),
(5, 'Admin User', 'admin@example.com', '000-000-0000', 'Admin Office', 'admin', '$2y$10$C2T3TN3xY5.onDiD0wjeEuSxi98xlDUjTnikTqxHSsZnfhunQR40m', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_method`
--

CREATE TABLE `delivery_method` (
  `deliveryMethodID` int(11) NOT NULL,
  `type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `delivery_method`
--

INSERT INTO `delivery_method` (`deliveryMethodID`, `type`) VALUES
(1, 'Drive-thru'),
(2, 'Curbside'),
(3, 'Home Delivery');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `feedbackID` int(11) NOT NULL,
  `customerID` int(11) DEFAULT NULL,
  `orderID` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` between 1 and 5),
  `comment` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feedback_review`
--

CREATE TABLE `feedback_review` (
  `reviewID` int(11) NOT NULL,
  `customerID` int(11) DEFAULT NULL,
  `orderID` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `reviewText` text DEFAULT NULL,
  `response` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `inventoryItemID` int(11) NOT NULL,
  `itemID` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `costPrice` decimal(10,2) DEFAULT NULL,
  `supplier` varchar(100) DEFAULT NULL,
  `expirationDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`inventoryItemID`, `itemID`, `name`, `quantity`, `costPrice`, `supplier`, `expirationDate`) VALUES
(1, 1, 'Pancake Mix', 50, 2.99, 'FoodSupplier Inc.', '2024-12-31'),
(2, 2, 'Eggs', 30, 1.99, 'DairyBest', '2024-11-30'),
(3, 3, 'Tea Bags', 100, 0.99, 'TeaMasters', '2025-01-15'),
(4, 4, 'Beverage Cups', 200, 0.49, 'CupWorld', '2025-06-01');

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `locationID` int(11) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `operatingHours` varchar(100) DEFAULT NULL,
  `specials` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`locationID`, `address`, `operatingHours`, `specials`, `status`) VALUES
(1, '123 Main St, Cityville', '8 AM - 10 PM', 'Buy 1 Get 1 Free on Burgers', 1),
(2, '456 Elm St, Townsville', '9 AM - 9 PM', '20% off on Drinks during Happy Hour', 1);

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `menuID` int(11) NOT NULL,
  `menuName` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`menuID`, `menuName`, `category`) VALUES
(1, 'Breakfast', 'Food'),
(2, 'Lunch', 'Food'),
(3, 'Drinks', 'Beverage');

-- --------------------------------------------------------

--
-- Table structure for table `menu_item`
--

CREATE TABLE `menu_item` (
  `itemID` int(11) NOT NULL,
  `menuID` int(11) DEFAULT NULL,
  `itemName` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `availability` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu_item`
--

INSERT INTO `menu_item` (`itemID`, `menuID`, `itemName`, `description`, `price`, `availability`) VALUES
(1, 1, 'Pancakes', 'Fluffy golden pancakes served with syrup', 5.99, 1),
(2, 1, 'Scrambled Eggs', 'Classic scrambled eggs with a side of toast', 4.99, 1),
(3, 2, 'Burger Combo', 'Beef burger with fries and a drink', 9.99, 1),
(4, 3, 'Iced Tea', 'Freshly brewed iced tea', 2.99, 1);

-- --------------------------------------------------------

--
-- Table structure for table `orderItem`
--

CREATE TABLE `orderItem` (
  `orderItemID` int(11) NOT NULL,
  `orderID` int(11) DEFAULT NULL,
  `itemID` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orderItem`
--

INSERT INTO `orderItem` (`orderItemID`, `orderID`, `itemID`, `quantity`) VALUES
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 1),
(4, 2, 4, 2),
(5, 3, 1, 1),
(6, 3, 3, 1),
(7, 4, 1, 1),
(8, 4, 4, 1),
(9, 5, 1, 1),
(10, 5, 2, 1),
(11, 6, 1, 1),
(12, 6, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `orderID` int(11) NOT NULL,
  `customerID` int(11) DEFAULT NULL,
  `deliveryMethodID` int(11) DEFAULT NULL,
  `locationID` int(11) DEFAULT NULL,
  `dateTime` datetime DEFAULT NULL,
  `totalPrice` decimal(10,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`orderID`, `customerID`, `deliveryMethodID`, `locationID`, `dateTime`, `totalPrice`, `status`) VALUES
(1, 1, 1, 1, '2024-12-09 15:04:47', 17.48, 0),
(2, 2, 2, 2, '2024-12-09 15:04:47', 12.99, 1),
(3, 3, 3, 2, '2024-12-09 15:27:07', 15.98, 0),
(4, 3, 1, 2, '2024-12-09 15:27:53', 8.98, 0),
(5, 3, 2, 1, '2024-12-09 15:46:23', 10.98, 0),
(6, 3, 1, 1, '2024-12-09 16:43:55', 10.98, 0);

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `report` (
  `reportID` int(11) NOT NULL,
  `customerID` int(11) DEFAULT NULL,
  `issueType` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `report`
--

INSERT INTO `report` (`reportID`, `customerID`, `issueType`, `description`) VALUES
(1, 3, 'App Bug', 'fhfhfhf');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staffID` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `contactInfo` varchar(255) DEFAULT NULL,
  `shiftSchedule` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_request`
--

CREATE TABLE `support_request` (
  `requestID` int(11) NOT NULL,
  `customerID` int(11) DEFAULT NULL,
  `issueType` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `response` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `transactionID` int(11) NOT NULL,
  `orderID` int(11) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `dateTime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`transactionID`, `orderID`, `amount`, `status`, `dateTime`) VALUES
(1, 1, 50.00, 'Completed', '2024-12-09 16:37:07'),
(2, 2, 75.00, 'Pending', '2024-12-09 16:37:07'),
(3, 3, 120.00, 'Cancelled', '2024-12-09 16:37:07');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customerID`);

--
-- Indexes for table `delivery_method`
--
ALTER TABLE `delivery_method`
  ADD PRIMARY KEY (`deliveryMethodID`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`feedbackID`),
  ADD KEY `customerID` (`customerID`),
  ADD KEY `orderID` (`orderID`);

--
-- Indexes for table `feedback_review`
--
ALTER TABLE `feedback_review`
  ADD PRIMARY KEY (`reviewID`),
  ADD KEY `customerID` (`customerID`),
  ADD KEY `orderID` (`orderID`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`inventoryItemID`),
  ADD KEY `itemID` (`itemID`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`locationID`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`menuID`);

--
-- Indexes for table `menu_item`
--
ALTER TABLE `menu_item`
  ADD PRIMARY KEY (`itemID`),
  ADD KEY `menuID` (`menuID`);

--
-- Indexes for table `orderItem`
--
ALTER TABLE `orderItem`
  ADD PRIMARY KEY (`orderItemID`),
  ADD KEY `orderID` (`orderID`),
  ADD KEY `itemID` (`itemID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`orderID`),
  ADD KEY `customerID` (`customerID`),
  ADD KEY `deliveryMethodID` (`deliveryMethodID`),
  ADD KEY `locationID` (`locationID`);

--
-- Indexes for table `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`reportID`),
  ADD KEY `customerID` (`customerID`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staffID`);

--
-- Indexes for table `support_request`
--
ALTER TABLE `support_request`
  ADD PRIMARY KEY (`requestID`),
  ADD KEY `customerID` (`customerID`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transactionID`),
  ADD KEY `orderID` (`orderID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `delivery_method`
--
ALTER TABLE `delivery_method`
  MODIFY `deliveryMethodID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `feedbackID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `feedback_review`
--
ALTER TABLE `feedback_review`
  MODIFY `reviewID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `inventoryItemID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
  MODIFY `locationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `menuID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `menu_item`
--
ALTER TABLE `menu_item`
  MODIFY `itemID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orderItem`
--
ALTER TABLE `orderItem`
  MODIFY `orderItemID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `orderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `report`
--
ALTER TABLE `report`
  MODIFY `reportID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staffID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_request`
--
ALTER TABLE `support_request`
  MODIFY `requestID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `transactionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE CASCADE,
  ADD CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`orderID`) REFERENCES `orders` (`orderID`) ON DELETE CASCADE;

--
-- Constraints for table `feedback_review`
--
ALTER TABLE `feedback_review`
  ADD CONSTRAINT `feedback_review_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE SET NULL,
  ADD CONSTRAINT `feedback_review_ibfk_2` FOREIGN KEY (`orderID`) REFERENCES `orders` (`orderID`) ON DELETE CASCADE;

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`itemID`) REFERENCES `menu_item` (`itemID`) ON DELETE SET NULL;

--
-- Constraints for table `menu_item`
--
ALTER TABLE `menu_item`
  ADD CONSTRAINT `menu_item_ibfk_1` FOREIGN KEY (`menuID`) REFERENCES `menu` (`menuID`) ON DELETE CASCADE;

--
-- Constraints for table `orderItem`
--
ALTER TABLE `orderItem`
  ADD CONSTRAINT `orderitem_ibfk_1` FOREIGN KEY (`orderID`) REFERENCES `orders` (`orderID`) ON DELETE CASCADE,
  ADD CONSTRAINT `orderitem_ibfk_2` FOREIGN KEY (`itemID`) REFERENCES `menu_item` (`itemID`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE SET NULL,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`deliveryMethodID`) REFERENCES `delivery_method` (`deliveryMethodID`) ON DELETE SET NULL,
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`locationID`) REFERENCES `location` (`locationID`) ON DELETE SET NULL;

--
-- Constraints for table `report`
--
ALTER TABLE `report`
  ADD CONSTRAINT `report_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE CASCADE;

--
-- Constraints for table `support_request`
--
ALTER TABLE `support_request`
  ADD CONSTRAINT `support_request_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE SET NULL;

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`orderID`) REFERENCES `orders` (`orderID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
