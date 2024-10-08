-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 03, 2024 at 01:36 PM
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
-- Database: `ecomm`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `id` int(11) NOT NULL,
  `region` varchar(255) NOT NULL,
  `province` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `baranggay` varchar(255) NOT NULL,
  `street` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_id` int(11) NOT NULL,
  `selected` tinyint(1) NOT NULL DEFAULT 0,
  `type` varchar(50) NOT NULL DEFAULT 'Home' COMMENT 'Home, Office, Other'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`id`, `region`, `province`, `city`, `baranggay`, `street`, `created_at`, `user_id`, `selected`, `type`) VALUES
(6, 'Region IV-A (CALABARZON)', 'Laguna', 'Magdalena', 'Malinao', 'dada', '2024-09-02 07:50:45', 16, 0, 'Home'),
(7, 'Region IV-A (CALABARZON)', 'Laguna', 'Nigga', 'Malinao', 'dada', '2024-09-02 07:51:00', 16, 0, 'Home'),
(8, 'Region IV-A (CALABARZON)', 'Cavite', 'General Trias', 'Bacao I', '100 purok 1', '2024-09-02 07:53:51', 16, 0, 'Home'),
(9, 'Region IV-A (CALABARZON)', 'Laguna', 'Magdalena', 'Malinao', 'dada', '2024-09-02 12:05:21', 16, 0, 'Home'),
(23, 'Region IV-A (CALABARZON)', 'Cavite', 'General Trias', 'Panungyanan', 'tanginamo talaga pre', '2024-09-03 10:22:32', 16, 0, 'Other'),
(26, 'Region IV-A (CALABARZON)', 'Laguna', 'Kalayaan', 'Longos', 'street legal', '2024-09-03 11:12:25', 16, 0, 'Home'),
(27, 'Region IV-A (CALABARZON)', 'Cavite', 'General Trias', 'Bacao I', '100 purok 1', '2024-09-03 11:14:31', 16, 1, 'Office');

--
-- Triggers `address`
--
DELIMITER $$
CREATE TRIGGER `after insert` AFTER INSERT ON `address` FOR EACH ROW BEGIN
    UPDATE `users`
    SET `users`.`address_id` = NEW.id
    WHERE `users`.`address_id` IS NULL AND `users`.`id` = NEW.user_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `selected` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `user_id`, `product_id`, `quantity`, `selected`) VALUES
(100, 1, 56, 1, 1),
(105, 17, 54, 1, 1),
(117, 14, 51, 1, 0),
(118, 18, 56, 1, 1),
(124, 16, 56, 1, 1),
(125, 16, 51, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `cat_slug` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `cat_slug`) VALUES
(1, 'Laptops', 'laptops'),
(2, 'Desktop PC', 'desktop-pc'),
(3, 'Tablets', 'tablets'),
(4, 'Smart Phones', ''),
(8, 'Accessories', '');

-- --------------------------------------------------------

--
-- Table structure for table `details`
--

CREATE TABLE `details` (
  `id` int(11) NOT NULL,
  `sales_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `details`
--

INSERT INTO `details` (`id`, `sales_id`, `product_id`, `quantity`) VALUES
(14, 9, 11, 2),
(15, 9, 13, 5),
(16, 9, 3, 2),
(17, 9, 1, 3),
(18, 10, 13, 3),
(19, 10, 2, 4),
(20, 10, 19, 5);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `total` float NOT NULL DEFAULT 0,
  `status` varchar(255) NOT NULL DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `order_number` varchar(50) NOT NULL,
  `sales_date` date DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `product_id`, `quantity`, `total`, `status`, `created_at`, `order_number`, `sales_date`, `rating`, `address_id`) VALUES
(74, 14, 56, 1, 60990, 'Cancelled', '2024-09-02 12:41:57', '137986', NULL, NULL, 9),
(75, 14, 60, 1, 109000, 'Cancelled', '2024-09-02 12:58:17', '520653', NULL, NULL, 7),
(76, 14, 51, 1, 42990, 'Cancelled', '2024-09-02 13:04:57', '557563', NULL, NULL, 6),
(77, 14, 38, 1, 8490, 'Cancelled', '2024-09-02 13:07:39', '580293', NULL, NULL, 9),
(78, 14, 49, 1, 49990, 'Cancelled', '2024-09-02 13:17:31', '165376', NULL, NULL, 9),
(79, 14, 54, 1, 105990, 'Cancelled', '2024-09-02 13:28:46', '90101', NULL, NULL, 9),
(80, 14, 56, 1, 60990, 'Cancelled', '2024-09-03 10:25:02', '270384', NULL, NULL, 23),
(81, 14, 36, 1, 59491.5, 'Cancelled', '2024-09-03 10:26:09', '478752', NULL, NULL, 23),
(82, 16, 97, 1, 8099.99, 'Pending', '2024-09-03 11:16:59', '320203', NULL, NULL, 27),
(83, 16, 61, 1, 25256.2, 'Pending', '2024-09-03 11:29:12', '758016', NULL, NULL, 27),
(84, 16, 56, 1, 60990, 'Pending', '2024-09-03 11:30:09', '169214', NULL, NULL, 27),
(85, 16, 38, 1, 8490, 'Pending', '2024-09-03 11:31:16', '304289', NULL, NULL, 27),
(86, 16, 56, 1, 60990, 'Pending', '2024-09-03 11:31:56', '369343', NULL, NULL, 27),
(87, 16, 60, 1, 109000, 'Pending', '2024-09-03 11:32:18', '458349', NULL, NULL, 27);

--
-- Triggers `orders`
--
DELIMITER $$
CREATE TRIGGER `update_sales_date` BEFORE UPDATE ON `orders` FOR EACH ROW BEGIN
    -- Check if the status has been updated to 'Completed'
    IF OLD.status <> 'Completed' AND NEW.status = 'Completed' THEN
        -- Update the sales_date to the current date
        SET NEW.sales_date = CURDATE();
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` text NOT NULL,
  `description` text NOT NULL,
  `slug` varchar(200) NOT NULL,
  `price` double NOT NULL,
  `photo` varchar(200) NOT NULL,
  `date_view` date NOT NULL,
  `counter` int(11) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 1,
  `discount` float NOT NULL,
  `rating` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `description`, `slug`, `price`, `photo`, `date_view`, `counter`, `stock`, `discount`, `rating`) VALUES
(36, 1, 'MacBook Air', '<h2>8-Core CPU<br />\r\n8-Core GPU<br />\r\n8GB Unified Memory<br />\r\n256GB SSD Storage&nbsp;footnote&nbsp;&sup1;</h2>\r\n\r\n<ul>\r\n	<li>16-core Neural&nbsp;Engine</li>\r\n	<li>13.6-inch Liquid Retina display with True&nbsp;Tone&sup2;</li>\r\n	<li>1080p FaceTime HD camera</li>\r\n	<li>MagSafe&nbsp;3 charging port</li>\r\n	<li>Two Thunderbolt / USB&nbsp;4 ports</li>\r\n	<li>Support for up to two external displays (with laptop lid closed)</li>\r\n	<li>Magic Keyboard with Touch&nbsp;ID</li>\r\n	<li>Force Touch trackpad</li>\r\n	<li>30W USB-C Power Adapter</li>\r\n</ul>\r\n', 'macbook-air', 69990, 'macbook-air_1724848835.jpg', '2024-09-03', 2, 95, 15, 3.75),
(37, 1, 'MacBook Pro', '<h2>11-Core CPU<br />\r\n14-Core GPU<br />\r\n18GB Unified Memory<br />\r\n512GB SSD Storage&sup1;</h2>\r\n\r\n<ul>\r\n	<li>14-inch Liquid Retina XDR display&sup2;</li>\r\n	<li>Three Thunderbolt&nbsp;4 ports, HDMI port, SDXC card slot, headphone jack, MagSafe&nbsp;3 port</li>\r\n	<li>Magic Keyboard with Touch&nbsp;ID</li>\r\n	<li>Force Touch trackpad</li>\r\n	<li>70W USB-C Power Adapter</li>\r\n</ul>\r\n', 'macbook-pro', 104990, 'macbook-pro.jfif', '2024-09-02', 2, 97, 0, 4),
(38, 8, 'AirPods (2nd Generation)', '<p><strong>AirPods Sensors (each):</strong></p>\r\n\r\n<ul>\r\n	<li>Dual beamforming microphones</li>\r\n	<li>Dual optical sensors</li>\r\n	<li>Motion-detecting accelerometer</li>\r\n	<li>Speech-detecting accelerometer</li>\r\n</ul>\r\n\r\n<p><strong>Chip</strong></p>\r\n\r\n<ul>\r\n	<li>H1 headphone chip</li>\r\n</ul>\r\n\r\n<p><strong>Controls</strong></p>\r\n\r\n<ul>\r\n	<li>Double-tap to play, skip forward, or answer a phone call</li>\r\n	<li>Say &ldquo;Hey Siri&rdquo; to do things like play a song, make a call, or get directions*</li>\r\n</ul>\r\n\r\n<p><strong>Size and Weight</strong></p>\r\n\r\n<ul>\r\n	<li>AirPods (each): 0.65 by 0.71 by 1.59 inches (16.5 by 18.0 by 40.5 mm)?</li>\r\n	<li>Lightning Charging Case: 1.74 by 0.84 by 2.11 inches (44.3 by 21.3 by 53.5 mm)?</li>\r\n	<li>AirPods (each): 0.14 ounce (4 g)?</li>\r\n	<li>Lightning Charging Case: 1.35 ounces (38.2 g)?</li>\r\n</ul>\r\n\r\n<p><strong>Charging Case</strong></p>\r\n\r\n<ul>\r\n	<li>Works with the Lightning connector</li>\r\n</ul>\r\n\r\n<p><strong>Power</strong></p>\r\n\r\n<ul>\r\n	<li>AirPods with Lightning Charging Case: More than 24 hours listening time,&sup3; up to 18 hours talk time?</li>\r\n	<li>AirPods (single charge): Up to 5 hours listening time,&sup1; up to 3 hours talk time&sup2;</li>\r\n	<li>15 minutes in the case equals up to 3 hours listening time? or up to 2 hours talk time?</li>\r\n	<li>Connectivity</li>\r\n	<li>Bluetooth 5.0</li>\r\n</ul>\r\n\r\n<p><strong>Accessibility</strong></p>\r\n\r\n<ul>\r\n	<li>Accessibility features help people with disabilities get the most out of their new AirPods.</li>\r\n	<li>Features include:</li>\r\n	<li>Live Listen audio?</li>\r\n	<li>Headphone levels</li>\r\n	<li>Headphone Accommodations</li>\r\n</ul>\r\n', 'airpods-2nd-generation', 8490, 'airpods-2nd-generation_1724850025.jfif', '2024-09-03', 1, 98, 0, 0),
(39, 8, 'AirPods (3rd generation)', '<p><strong>Audio Technology</strong></p>\r\n\r\n<ul>\r\n	<li>Personalized Spatial Audio with dynamic head tracking&sup1;</li>\r\n	<li>Adaptive EQ</li>\r\n	<li>Custom high-excursion Apple driver</li>\r\n	<li>Custom high dynamic range amplifier</li>\r\n</ul>\r\n\r\n<p><strong>Sensors</strong></p>\r\n\r\n<ul>\r\n	<li>Dual beamforming microphones</li>\r\n	<li>Force sensor</li>\r\n	<li>Inward-facing microphone</li>\r\n	<li>Motion-detecting accelerometer</li>\r\n	<li>Skin-detect sensors</li>\r\n	<li>Speech-detecting accelerometer</li>\r\n</ul>\r\n\r\n<p><strong>Chip</strong></p>\r\n\r\n<ul>\r\n	<li>H1 headphone chip</li>\r\n</ul>\r\n\r\n<p><strong>Controls</strong></p>\r\n\r\n<ul>\r\n	<li>Press once to play, pause, or answer a phone call</li>\r\n	<li>Press twice to skip forward</li>\r\n	<li>Press three times to skip back</li>\r\n	<li>Press and hold for Siri</li>\r\n	<li>Say &ldquo;Hey Siri&rdquo; to do things like play a song, make a call, or get directions</li>\r\n	<li>Sweat and Water Resistant</li>\r\n	<li>Sweat and water resistant (IPX4)&sup3;</li>\r\n</ul>\r\n\r\n<p><strong>Size and Weight</strong></p>\r\n\r\n<ul>\r\n	<li>AirPods (each)?</li>\r\n	<li>Height: 1.21 inches (30.79 mm)</li>\r\n	<li>Width: 0.72 inch (18.26 mm)</li>\r\n	<li>Depth: 0.76 inch (19.21 mm)</li>\r\n	<li>Weight: 0.15 ounce (4.28 grams)</li>\r\n	<li>MagSafe Charging Case?</li>\r\n	<li>Height: 1.83 inches (46.40 mm)</li>\r\n	<li>Width: 2.14 inches (54.40 mm)</li>\r\n	<li>Depth: 0.84 inch (21.38 mm)</li>\r\n	<li>Weight: 1.34 ounces (37.91 grams)</li>\r\n</ul>\r\n\r\n<p><strong>Charging Case</strong></p>\r\n\r\n<ul>\r\n	<li>Works with MagSafe charger, Qi-certified chargers, or the Lightning connector</li>\r\n</ul>\r\n\r\n<p><strong>Battery</strong></p>\r\n\r\n<ul>\r\n	<li>AirPods</li>\r\n	<li>Up to 6 hours of listening time with a single charge (up to 5&nbsp;hours with Personalized Spatial Audio enabled)&sup2;</li>\r\n	<li>Up to 4 hours of talk time with a single charge?</li>\r\n	<li>AirPods with MagSafe Charging Case</li>\r\n	<li>Up to 30 hours of listening time?</li>\r\n	<li>Up to 20 hours of talk time&sup1;?</li>\r\n	<li>5 minutes in the case provides around 1 hour of listening time? or around 1 hour of talk time?</li>\r\n</ul>\r\n\r\n<p><strong>Connectivity</strong></p>\r\n\r\n<ul>\r\n	<li>Bluetooth 5.0</li>\r\n</ul>\r\n\r\n<p><strong>Accessibility</strong></p>\r\n\r\n<ul>\r\n	<li>Accessibility features help people with disabilities get the most out of their new AirPods.</li>\r\n	<li>Features include:</li>\r\n	<li>Live Listen audio&sup1;&sup1;</li>\r\n	<li>Headphone levels</li>\r\n	<li>Headphone Accommodations</li>\r\n</ul>\r\n', 'airpods-3rd-generation', 11990, 'airpods-3rd-generation.jfif', '2024-09-01', 1, 97, 0, 0),
(40, 8, 'AirPods Pro (2nd Generation)', '<p><strong>Audio Technology</strong></p>\r\n\r\n<ul>\r\n	<li>Adaptive Audio&sup1;?</li>\r\n	<li>Active Noise Cancellation</li>\r\n	<li>Transparency mode</li>\r\n	<li>Conversation Awareness&sup1;?</li>\r\n	<li>Personalized Volume&sup1;?</li>\r\n	<li>Personalized Spatial Audio with dynamic head tracking&ordm;</li>\r\n	<li>Adaptive EQ</li>\r\n	<li>Vent system for pressure equalization</li>\r\n	<li>Custom high-excursion Apple driver</li>\r\n	<li>Custom high dynamic range amplifier</li>\r\n</ul>\r\n\r\n<p><strong>Sensors</strong></p>\r\n\r\n<ul>\r\n	<li>Dual beamforming microphones</li>\r\n	<li>Inward-facing microphone</li>\r\n	<li>Skin-detecting sensor</li>\r\n	<li>Motion-detecting accelerometer</li>\r\n	<li>Speech-detecting accelerometer</li>\r\n	<li>Touch control</li>\r\n</ul>\r\n\r\n<p><strong>Chip</strong></p>\r\n\r\n<ul>\r\n	<li>Apple H2 headphone chip</li>\r\n	<li>Apple U1 chip in MagSafe Charging Case</li>\r\n</ul>\r\n\r\n<p><strong>Controls</strong></p>\r\n\r\n<ul>\r\n	<li>Press once to play and pause audio, or answer, mute, and unmute calls&sup1;?</li>\r\n	<li>Press twice to skip forward or end a call</li>\r\n	<li>Press three times to skip back</li>\r\n	<li>Press and hold the stem to switch between listening modes</li>\r\n	<li>Swipe up or down to adjust volume</li>\r\n</ul>\r\n\r\n<p><strong>Sweat and Water Resistant</strong></p>\r\n\r\n<ul>\r\n	<li>Dust, sweat, and water resistant (IP54): AirPods Pro and charging case&ordm;&ordm;&ordm;&ordm;</li>\r\n</ul>\r\n\r\n<p><strong>Size and Weight</strong></p>\r\n\r\n<ul>\r\n	<li>AirPods Pro (each)?</li>\r\n	<li>Height: 1.22 inches (30.9 mm)</li>\r\n	<li>Width: 0.86 inch (21.8 mm)</li>\r\n	<li>Depth: 0.94 inch (24.0 mm)</li>\r\n	<li>Weight: 0.19 ounce (5.3 grams)</li>\r\n	<li>MagSafe Charging Case?</li>\r\n	<li>Height: 45.2 mm (1.78 inches)</li>\r\n	<li>Width: 60.6 mm (2.39 inches)</li>\r\n	<li>Depth: 21.7 mm (0.85 inches)</li>\r\n	<li>Weight: 50.8&nbsp;grams (1.79&nbsp;ounces)</li>\r\n</ul>\r\n\r\n<p><strong>Charging Case</strong></p>\r\n\r\n<ul>\r\n	<li>MagSafe Charging Case can be charged with USB-C, Apple Watch, MagSafe, or Qi wireless chargers</li>\r\n</ul>\r\n\r\n<p><strong>Battery</strong></p>\r\n\r\n<ul>\r\n	<li>AirPods Pro</li>\r\n	<li>Up to 6 hours of listening time on a single charge (up to 5.5 hours with Personalized Spatial Audio and head tracking enabled)?</li>\r\n	<li>Up to 4.5 hours of talk time with a single charge?</li>\r\n	<li>AirPods Pro with MagSafe Charging Case</li>\r\n	<li>Up to 24 hours of talk time?</li>\r\n	<li>Up to 30 hours of listening time?</li>\r\n	<li>5 minutes in the case provides around 1 hour of listening time&sup1;? or around 1 hour of talk time&sup1;&sup1;</li>\r\n</ul>\r\n\r\n<p><strong>Connectivity</strong></p>\r\n\r\n<ul>\r\n	<li>Bluetooth 5.3 wireless technology</li>\r\n</ul>\r\n\r\n<p><strong>Accessibility</strong></p>\r\n\r\n<ul>\r\n	<li>Accessibility features help people with disabilities get the most out of their new AirPods&nbsp;Pro.</li>\r\n	<li>Features include:</li>\r\n	<li>Live Listen audio&sup1;&sup2;</li>\r\n	<li>Headphone levels</li>\r\n	<li>Headphone Accommodations</li>\r\n	<li>Conversation Boost</li>\r\n</ul>\r\n', 'airpods-pro-2nd-generation', 14990, 'airpods-pro-2nd-generation.jfif', '2024-08-31', 3, 100, 0, 0),
(41, 8, 'AirPods Max', '<p><strong>Audio Technology</strong></p>\r\n\r\n<ul>\r\n	<li>Apple-designed dynamic driver</li>\r\n	<li>Active Noise Cancellation</li>\r\n	<li>Transparency mode</li>\r\n	<li>Personalized Spatial Audio with dynamic head tracking<a href=\"https://www.apple.com/ph/airpods-max/specs/#footnote-1\">1</a></li>\r\n	<li>Adaptive EQ</li>\r\n</ul>\r\n\r\n<p><strong>Sensors</strong></p>\r\n\r\n<ul>\r\n	<li>Optical sensor (each ear cup)</li>\r\n	<li>Position sensor (each ear cup)</li>\r\n	<li>Case-detect sensor (each ear cup)</li>\r\n	<li>Accelerometer (each ear cup)</li>\r\n	<li>Gyroscope (left ear cup)</li>\r\n</ul>\r\n\r\n<p><strong>Microphones</strong></p>\r\n\r\n<ul>\r\n	<li>Nine microphones total:</li>\r\n	<li>Eight microphones for Active Noise Cancellation</li>\r\n	<li>Three microphones for voice pickup (two shared with Active Noise Cancellation and one additional microphone)</li>\r\n</ul>\r\n\r\n<p><strong>Chip</strong></p>\r\n\r\n<ul>\r\n	<li>Apple H1 headphone chip (each ear cup)</li>\r\n</ul>\r\n\r\n<p><strong>Controls</strong></p>\r\n\r\n<ul>\r\n	<li>Digital Crown</li>\r\n	<li>Turn for volume control</li>\r\n	<li>Press once to play or pause media</li>\r\n	<li>Press once to answer a call or mute or unmute</li>\r\n	<li>Press twice to end a call</li>\r\n	<li>Press twice to skip forward</li>\r\n	<li>Press three times to skip back</li>\r\n	<li>Noise control button</li>\r\n	<li>Press to switch between Active Noise Cancellation and Transparency mode</li>\r\n</ul>\r\n\r\n<p><strong>Battery</strong></p>\r\n\r\n<ul>\r\n	<li>Up to 20 hours of listening time on a single charge with Active Noise Cancellation or Transparency mode enabled<a href=\"https://www.apple.com/ph/airpods-max/specs/#footnote-3\">3</a></li>\r\n	<li>Up to 20 hours of movie playback on a single charge with Spatial&nbsp;Audio&nbsp;on<a href=\"https://www.apple.com/ph/airpods-max/specs/#footnote-4\">4</a></li>\r\n	<li>Up to 20 hours of talk time on a single charge<a href=\"https://www.apple.com/ph/airpods-max/specs/#footnote-5\">5</a></li>\r\n	<li>5 minutes of charge time provides around 1.5 hours of listening time<a href=\"https://www.apple.com/ph/airpods-max/specs/#footnote-6\">6</a></li>\r\n	<li>AirPods Max with Smart Case</li>\r\n	<li>Storage in the Smart Case preserves battery charge in ultra low-power state</li>\r\n	<li>Charging via Lightning connector</li>\r\n</ul>\r\n\r\n<p><strong>Connectivity</strong></p>\r\n\r\n<ul>\r\n	<li>Bluetooth 5.0 wireless&nbsp;technology</li>\r\n</ul>\r\n\r\n<p><strong>Accessibility</strong></p>\r\n\r\n<ul>\r\n	<li>Accessibility features help people with disabilities get the most out of their new AirPods Max.</li>\r\n	<li>Features include:</li>\r\n	<li>Live Listen audio</li>\r\n	<li>Headphone levels</li>\r\n	<li>Headphone Accommodations</li>\r\n</ul>\r\n', 'airpods-max', 32990, 'airpods-max.jfif', '0000-00-00', 0, 100, 0, 0),
(42, 8, 'USB-C Digital AV Multiport Adapter', '<p><strong>Connections</strong></p>\r\n\r\n<ul>\r\n	<li>HDMI</li>\r\n	<li>USB</li>\r\n	<li>USB-C</li>\r\n</ul>\r\n', 'usb-c-digital-av-multiport-adapter', 3890, 'usb-c-digital-av-multiport-adapter.jfif', '0000-00-00', 0, 100, 0, 0),
(43, 8, 'Power Adapter Extension Cable', '<p>&nbsp;</p>\r\n\r\n<ul>\r\n	<li><strong>The 1.8-meter Power Adapter Extension Cable is an AC extension lead that provides extra length for your Apple power adapter. Use it with MagSafe and MagSafe 2 power adapters, 10W and 12W USB-A power adapters and 29W, 30W, 61W, 67W, 87W, 96W, and 140W USB-C power adapters.</strong></li>\r\n</ul>\r\n', 'power-adapter-extension-cable', 1190, 'power-adapter-extension-cable_1724851160.jfif', '0000-00-00', 0, 100, 0, 0),
(44, 8, 'Beats Flex – All-Day Wireless Earphones - Flame Blue', '<ul>\r\n	<li>Height: 0.6 in / 1.6 cm</li>\r\n	<li>Length: 34 in / 86.4 cm</li>\r\n	<li>Width: 4.2 in / 10.6 cm</li>\r\n	<li>Weight: 18.6 g / 0.66 oz</li>\r\n	<li>Other Features: Bluetooth, With Mic, Inline Volume Control, Wireless</li>\r\n	<li>Form Factor: In Ear</li>\r\n	<li>Connections: Bluetooth, Wireless</li>\r\n	<li>Power Source: Battery</li>\r\n	<li>Batteries: Rechargeable lithium-ion</li>\r\n</ul>\r\n', 'beats-flex-all-day-wireless-earphones-flame-blue', 3990, 'beats-flex-all-day-wireless-earphones-flame-blue_1724851341.jfif', '0000-00-00', 0, 100, 0, 0),
(45, 8, 'Powerbeats Pro - True Wireless Earbuds', '<ul>\r\n	<li>Height: 2.3 cm / 0.9 in. (bud), 4.3 cm / 1.7 in. (case)</li>\r\n	<li>Length: 5.9 cm / 2.3 in. (bud), 7.7 cm / 3 in. (case)</li>\r\n	<li>Width: 3.8 cm / 1.5 in. (bud), 7.7 cm / 3 in. (case)</li>\r\n	<li>Weight: 11 g (bud), 80 g (case)</li>\r\n	<li>Other Features: Bluetooth, Wireless</li>\r\n	<li>Form Factor: Ear hook, In Ear</li>\r\n	<li>Connections: Bluetooth, Wireless</li>\r\n	<li>Batteries: Rechargeable lithium-ion</li>\r\n</ul>\r\n', 'powerbeats-pro-true-wireless-earbuds', 13990, 'powerbeats-pro-true-wireless-earbuds.jfif', '2024-08-29', 1, 90, 0, 0),
(46, 8, 'Magic Keyboard with Touch ID and Numeric Keypad for Mac models with Apple silicon ', '<p><strong>Size and Weight</strong></p>\r\n\r\n<ul>\r\n	<li>Height: 0.16&ndash;0.43 inch (0.41&ndash;1.09 cm)</li>\r\n	<li>Width: 16.48 inches (41.87 cm)</li>\r\n	<li>Depth: 4.52 inches (11.49 cm)</li>\r\n	<li>Weight: 0.81 pound (0.369 kg)**</li>\r\n</ul>\r\n\r\n<p><strong>General</strong></p>\r\n\r\n<ul>\r\n	<li>Multimedia keys</li>\r\n</ul>\r\n\r\n<p><strong>Connections and Expansion</strong></p>\r\n\r\n<ul>\r\n	<li>Bluetooth</li>\r\n	<li>Lightning port</li>\r\n	<li>Wireless</li>\r\n</ul>\r\n', 'magic-keyboard-touch-id-and-numeric-keypad-mac-models-apple-silicon', 8990, 'magic-keyboard-touch-id-and-numeric-keypad-mac-models-apple-silicon.jfif', '2024-08-29', 1, 100, 0, 0),
(47, 8, 'Anker Portable Charger Power Bank', '<h1><strong>About this item</strong></h1>\r\n\r\n<ul>\r\n	<li>Ultra-High Cell Capacity: The massive 20,000mAh cell capacity provides more than 5 charges for iPhone XS, almost 5 full charges for Samsung Galaxy S10, more than 4 charges for iPhone 11, and over 2 and a half charges for iPad mini 5.</li>\r\n	<li>Advanced Charging Technology: Anker&#39;s exclusive PowerIQ and VoltageBoost technology combine to deliver an optimized charge to your devices, while the trickle-charging mode is the best way to charge low-power accessories.</li>\r\n	<li>Simultaneous Charging: Twin USB ports allow you to charge two devices at the same time. The USB-C port cannot charge other devices.</li>\r\n	<li>Versatile Recharging: With both a USB-C and Micro USB input port, you have more options over how you recharge. Recharging PowerCore with a 10W charger will take approximately 10.5 hours, while recharging with a 5W charger will take approximately 20 hours.</li>\r\n	<li>What You Get: Anker 325 Power Bank (PowerCore 20K), Micro USB cable (to charge the power bank), welcome guide, our worry-free 18-month warranty, and friendly customer service. (USB-C cable, Lightning cable, and wall charger not included)</li>\r\n</ul>\r\n', 'anker-portable-charger-power-bank', 1461.054, 'anker-portable-charger-power-bank.jpg', '0000-00-00', 0, 100, 0, 0),
(48, 4, 'iPhone 15 Pro', '<ul>\r\n	<li>6.7&Prime; or 6.1&Prime;</li>\r\n	<li>Super Retina XDR display&nbsp;footnote&nbsp;&sup1;</li>\r\n	<li>ProMotion technology</li>\r\n	<li>Always-On display</li>\r\n	<li>Titanium with textured matte glass back</li>\r\n	<li>Action button</li>\r\n	<li>Dynamic Island</li>\r\n	<li>A magical way to interact with iPhone</li>\r\n	<li>A17 Pro chip with 6-core GPU</li>\r\n	<li>Pro camera system</li>\r\n	<li>48MP Main&nbsp;|&nbsp;Ultra Wide&nbsp;|&nbsp;Telephoto</li>\r\n	<li>Super-high-resolution photos</li>\r\n	<li>(24MP and 48MP)</li>\r\n	<li>Next-generation portraits with Focus and Depth Control</li>\r\n	<li>Up to</li>\r\n	<li>10x</li>\r\n	<li>optical zoom range</li>\r\n	<li>USB?C</li>\r\n	<li>&nbsp;</li>\r\n	<li>Up to 29 hours video playback</li>\r\n	<li>Supports USB&nbsp;3 for up to 20x faster transfers</li>\r\n</ul>\r\n', 'iphone-15-pro', 70990, 'iphone-15-pro.webp', '2024-08-30', 1, 96, 0, 0),
(49, 4, 'iPhone 14', '<ul>\r\n	<li>6.7&Prime; or 6.1&Prime;</li>\r\n	<li>Super Retina XDR display&nbsp;footnote</li>\r\n	<li>Aluminum with glass back</li>\r\n	<li>Ring/Silent switch</li>\r\n	<li>A15 Bionic chip</li>\r\n	<li>with 5-core GPU</li>\r\n	<li>Dual-camera system</li>\r\n	<li>12MP Main&nbsp;|&nbsp;Ultra Wide</li>\r\n	<li>Portrait mode with Focus and Depth Control</li>\r\n	<li>optical zoom range</li>\r\n	<li>&nbsp;</li>\r\n	<li>Up to 26 hours video playback&nbsp;</li>\r\n	<li>Lightning</li>\r\n	<li>Supports USB&nbsp;2</li>\r\n	<li>Face ID</li>\r\n</ul>\r\n', 'iphone-14', 49990, 'iphone-14.webp', '2024-09-02', 1, 99, 0, 0),
(50, 3, 'iPad Pro', '<ul>\r\n	<li><strong>Because innovation meets versatility in the iPad Pro 12.9&quot; 6th Gen with M2 Chip, this device redefines what&#39;s possible with a tablet. Experience a leap in performance with the M2 chip&#39;s 8-core CPU, which delivers up to 15 percent faster performance, and a 10-core GPU that offers up to 35 percent more graphics power. The 16-core Neural Engine propels machine learning tasks at lightning speeds, enhancing everything from 3D design to augmented reality and high-frame-rate gaming.The iPad Pro is not just a tablet; it&#39;s a creative powerhouse. With a 40 percent faster Neural Engine and 50 percent more memory bandwidth, the M2 chip enables you to tackle complex tasks with ease, all while maintaining the all-day battery life that iPad users love. The device&#39;s high-performance media engine accelerates ProRes encode and decode, allowing for rapid video project conversions, while the advanced cameras and M2&#39;s image signal processor enable ProRes video capture.A visual feast awaits with the 12.9&quot; L</strong></li>\r\n</ul>\r\n', 'ipad-pro', 72990, 'ipad-pro.webp', '2024-09-02', 3, 97, 0, 0),
(51, 3, 'iPad Air', '<ul>\r\n	<li>13&rdquo; or 11&rdquo;</li>\r\n	<li>Liquid Retina display2</li>\r\n	<li>P3 wide color</li>\r\n	<li>True Tone</li>\r\n	<li>Anti-reflective coating</li>\r\n	<li>Measured diagonally as a rectangle, the 13-inch iPad Air is 12.9 inches and the 11-inch iPad Air is 10.86 inches. Actual viewable area is less.</li>\r\n	<li>M2 chip</li>\r\n	<li>12MP Wide camera</li>\r\n	<li>4K video</li>\r\n	<li>Landscape 12MP Ultra&nbsp;Wide front camera</li>\r\n	<li>Supports Apple Pencil Pro</li>\r\n	<li>Supports Apple Pencil&nbsp;</li>\r\n	<li>(USB-C)</li>\r\n	<li>Supports Magic Keyboard</li>\r\n</ul>\r\n', 'ipad-air', 42990, 'ipad-air.webp', '2024-09-03', 2, 98, 0, 0),
(52, 3, 'iPad mini', '<p>8.3&rdquo;</p>\r\n\r\n<p>Liquid Retina display2</p>\r\n\r\n<p>P3 wide color</p>\r\n\r\n<p>True Tone</p>\r\n\r\n<p>Anti-reflective coating</p>\r\n\r\n<p>A15 Bionic chip</p>\r\n\r\n<p>12MP Wide camera</p>\r\n\r\n<p>4K video</p>\r\n\r\n<p>12MP Ultra Wide front camera</p>\r\n\r\n<p>Supports Apple Pencil<br />\r\n(2nd&nbsp;generation)</p>\r\n\r\n<p>Supports Apple Pencil&nbsp;<br />\r\n(USB-C)</p>\r\n\r\n<p>Supports Bluetooth keyboards</p>\r\n', 'ipad-mini', 32990, 'ipad-mini.webp', '2024-09-01', 1, 97, 0, 0),
(53, 8, 'Apple Pencil Pro', '<h3>Compatible with</h3>\r\n\r\n<ul>\r\n	<li>\r\n	<p>iPad&nbsp;Pro 13-inch</p>\r\n\r\n	<p>M4</p>\r\n	</li>\r\n	<li>\r\n	<p>iPad Pro 11-inch</p>\r\n\r\n	<p>M4</p>\r\n	</li>\r\n	<li>\r\n	<p>iPad Air 13-inch</p>\r\n\r\n	<p>M2</p>\r\n	</li>\r\n	<li>\r\n	<p>iPad&nbsp;Air 11-inch</p>\r\n	</li>\r\n</ul>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; M2</p>\r\n', 'apple-pencil-pro', 8690, 'apple-pencil-pro.png', '0000-00-00', 0, 100, 0, 0),
(54, 4, 'Galaxy Z Fold6', '<ul>\r\n	<li>7.6</li>\r\n	<li>1856x2160 pixels</li>\r\n	<li><strong>50MP</strong></li>\r\n	<li>4320p</li>\r\n	<li><strong>12GB RAM&nbsp;</strong></li>\r\n	<li>256GB/512GB/1TB storage, no card slot</li>\r\n	<li>Snapdragon 8 Gen 3</li>\r\n	<li><strong>4400mAh</strong></li>\r\n</ul>\r\n', 'galaxy-z-fold6', 105990, 'galaxy-z-fold6.jpg', '2024-09-02', 2, 98, 0, 0),
(55, 9, 'Apple Watch Series 9', '<ul>\r\n	<li>45mm or 41mm aluminum or stainless steel case size</li>\r\n	<li>Carbon neutral combinations available</li>\r\n	<li>Always-On Retina display</li>\r\n	<li>Up to 2000 nits</li>\r\n	<li>S9 SiP</li>\r\n	<li>Double tap gesture</li>\r\n	<li>Precision Finding for iPhone2</li>\r\n	<li>Blood Oxygen app3</li>\r\n	<li>ECG app4</li>\r\n	<li>High and low heart rate notifications4</li>\r\n	<li>Irregular rhythm notifications5</li>\r\n	<li>Low cardio notifications</li>\r\n	<li>Water resistant11</li>\r\n	<li>Swimproof</li>\r\n	<li>Available cellular connectivity</li>\r\n	<li>Up to 18 hours normal use</li>\r\n	<li>Up to 36&nbsp;hours in Low&nbsp;Power&nbsp;Mode</li>\r\n	<li>Fast charging</li>\r\n</ul>\r\n', 'apple-watch-series-9', 26490, 'apple-watch-series-9.jpg', '0000-00-00', 0, 100, 0, 0),
(56, 2, 'Exxact Valence Workstation - 1x 3rd Gen AMD Ryzen processor', '<ul>\r\n	<li><strong>Mid-Tower</strong></li>\r\n	<li><strong>1x 3rd Gen AMD Ryzen</strong></li>\r\n	<li><strong>1x 5.25&quot; External, 2x 2.5&quot; and 6x 2.5&quot;/3.5&quot; Internal</strong></li>\r\n	<li><strong>2x Double-Wide cards (x8/x8)</strong></li>\r\n</ul>\r\n', 'exxact-valence-workstation-1x-3rd-gen-amd-ryzen-processor', 60990, 'exxact-valence-workstation-1x-3rd-gen-amd-ryzen-processor.webp', '2024-09-03', 5, 87, 0, 0),
(57, 8, 'VRSHINECON G04BS+B01 Handle 3D Virtual Reality Helmet VR Glasses With Bluetooth Headset', '<p><strong>1. Multi-functional user-friendly design, suitable for 3.5-7.0 inches of mobile phone use<br />\r\n2. Blu-ray high-definition goggles<br />\r\n3. 360-degree three-dimensional space immersion, set application, entertainment, social integration<br />\r\n4. The front panel can be opened to increase the heat dissipation space, and the installation is simple and convenient<br />\r\n5. 3D phase sound technology, good sound insulation and strong bass<br />\r\n6. Wireless Bluetooth headset, boot automatic connection, easy to use<br />\r\n7. Double-lens independent adjustment, single lens to support 500 degrees of myopia to watch<br />\r\n8. Pupil-to-object distance dual regulation system<br />\r\n9. Comfortable adjustable headphones for more head shapes and Easy VR Experience<br />\r\n10. Adaptation to myopia: below 800 degrees<br />\r\n11. Natural material diaphragm, more texture and sound<br />\r\n12. PU leather mask, wear comfortable health, breathable fast, easy to clean and wipe<br />\r\n13. Immersive audio-visual experience, good sound insulation and strong bass<br />\r\n14. Display size: 300 inches<br />\r\n15. Features: with Bluetooth headset, watch 3D movies, play VR games<br />\r\n16. Lens aperture: 40mm<br />\r\n17. Lenses: PMMA anti-blue lenses<br />\r\n18. Front cover open mode: manual open, front cover flip-type operation<br />\r\n19. Interactive mode: combination of remote control and head control<br />\r\n20. Headphone horn sensitivity: 112 db<br />\r\n21. Headphone horn impedance: 32 ohms<br />\r\n22. Headphone frequency response range: 20-20000Hz<br />\r\n23. The headphone connection: a wireless bluetooth connection<br />\r\n24. Handle power mode: 2 x AA batteries (not included)<br />\r\n25. Range: about 15 hours<br />\r\n26. Operating current: 20-35mA<br />\r\n27. Bluetooth VR eyeglasses battery capacity: 3.7 V 350 Mah<br />\r\n28. Standard: VR glasses, specs, and lens wipes<br />\r\n29. Pupillary adjustment: 60-67mm<br />\r\n30. Material distance adjustment: 44-53mm<br />\r\n31. Wireless distance: less than 10 meters<br />\r\n32. Size: 20.5 x 22.2 x 9.9 cm<br />\r\n33. Gross weight: 586g</strong></p>\r\n', 'vrshinecon-g04bs-b01-handle-3d-virtual-reality-helmet-vr-glasses-bluetooth-headset', 3093.75, 'vrshinecon-g04bs-b01-handle-3d-virtual-reality-helmet-vr-glasses-bluetooth-headset.jpg', '0000-00-00', 0, 100, 0, 0),
(58, 9, 'Fitpolo Smart Watch for Women Android & iPhone, Alexa Built-in', '<ul>\r\n	<li><strong>?1.8&#39;&#39; HD Screen &amp; 102 Watch Faces?The fitness tracker watch is equipped with a large 1.8-inch HD colorful screen, delivering exceptional picture quality and highly responsive touch sensitivity. Express yourself with an collection of over 102 watch faces, or you can also personalize the watch face by selecting your favorite photo.</strong></li>\r\n	<li><strong>?Alexa Voice Control &amp; Bluetooth Calling?Work with Amazon Alexa, you can ask questions, control music playback, check the weather, set alarms and timers, and more by speaking to your watch. With Bluetooth 5.3, you can also answer/make clear calls directly from your smart watches when your phone is out of reach. (THE WATCH CAN NOT SEND MESSAGES, or TEXT BACK, Bluetooth distance 8-10 meters).</strong></li>\r\n	<li><strong>?24/7 Accurate Health Monitoring?This fitness watch will continously records your daily steps, distance, calorie consumption. Also it features advanced sensors to monitor heart rate, blood oxygen levels, stress levels &amp; sleep tracking. All recorded data can be synced to your phone for analysis, providing valuable insights into your health and facilitating lifestyle adjustments.</strong></li>\r\n	<li><strong>?105+ Sports Modes &amp; IP68 Waterproof?Fitpolo sports watch supports over 105 sports modes, including Running, Walking, Hiking, Badminton, Basketball, Boating, Climbing, Cycling, Fitness, Football. Swimming, Yoga &amp; More. This allows you to accurately track your exercise time and calories burned, aiding in maintaining a healthy balance between activity and rest. It boasts an IP68 waterproof rating, ensuring worry-free use even while washing hands, face, or engaging in sweaty activities.</strong></li>\r\n	<li><strong>?Message Notification &amp; Powerful?Stay connected to SMS and app messages from Text, Facebook, WhatsApp, Instagram, X, Telegram, Tiktok, Skype and more. Our fitness watch also contains many useful tools, such as Bluetooth answer/make call, Medication reminders, Cycle Tracking, Weather forecast, Music control, Camera control, Setting alarms, Stopwatch, Timer, Breather guide, Raise to wake, Find phone and so on.</strong></li>\r\n	<li><strong>?Widely Compatible &amp; Long-Battery Life?Work seemlessly with iOS or Android smartphones (Compatible with iOS 9.0 or above, Android 6.0 or above). Including but not limited to iPhone 6~iPhone 15, Samsung, Google pixel Nexus, Microsoft, Huawei, Xiaomi HTC and More. With 2.5 hours of full charging time, it can last 7 days with typical use or 30 days&#39; standby.</strong></li>\r\n	<li><strong>?5-Year Gua-rantee?We stand by our product and promise 5-Year Gua-rantee &amp; 24/7 tech support for your hassle-free purchase. Please feel free to reach us for any problem you encounted.</strong></li>\r\n</ul>\r\n', 'fitpolo-smart-watch-women-android-iphone-alexa-built', 3372.188, 'fitpolo-smart-watch-women-android-iphone-alexa-built.jpg', '0000-00-00', 0, 100, 0, 0),
(59, 1, 'ThinkPad E14 Gen 6', '<p><strong>Processor</strong></p>\r\n\r\n<ul>\r\n	<li>Intel&reg; Core&trade; Ultra 5 125U Processor (E-cores up to 3.60 GHz P-cores up to 4.30 GHz)</li>\r\n</ul>\r\n\r\n<p><strong>Operating System</strong></p>\r\n\r\n<ul>\r\n	<li>Windows 11 Home 64</li>\r\n</ul>\r\n\r\n<p><strong>Graphic Card</strong></p>\r\n\r\n<ul>\r\n	<li>Integrated Graphics</li>\r\n</ul>\r\n\r\n<p><strong>Memory</strong></p>\r\n\r\n<ul>\r\n	<li>8 GB DDR5-5600MHz (SODIMM)</li>\r\n</ul>\r\n\r\n<p><strong>Storage</strong></p>\r\n\r\n<ul>\r\n	<li>256 GB SSD M.2 2242 PCIe Gen4 TLC Opal</li>\r\n</ul>\r\n\r\n<p><strong>Display</strong></p>\r\n\r\n<ul>\r\n	<li>14&quot; WUXGA (1920 x 1200), IPS, Anti-Glare, Non-Touch, 45%NTSC, 300 nits, 60Hz</li>\r\n</ul>\r\n\r\n<p><strong>Camera</strong></p>\r\n\r\n<ul>\r\n	<li>720P HD RGB with Microphone</li>\r\n</ul>\r\n\r\n<p><strong>Battery</strong></p>\r\n\r\n<ul>\r\n	<li>3 Cell Li-Polymer 47Wh</li>\r\n</ul>\r\n\r\n<p><strong>AC Adapter / Power Supply</strong></p>\r\n\r\n<ul>\r\n	<li>65W USB-C Low Cost 90% PCC 3pin AC Adapter - US</li>\r\n</ul>\r\n\r\n<p><strong>Fingerprint Reader</strong></p>\r\n\r\n<ul>\r\n	<li>No Fingerprint Reader</li>\r\n</ul>\r\n\r\n<p><strong>Keyboard</strong></p>\r\n\r\n<ul>\r\n	<li>Backlit, Black - English (US)</li>\r\n</ul>\r\n\r\n<p><strong>WLAN</strong></p>\r\n\r\n<ul>\r\n	<li>Intel&reg; Wi-Fi 6 AX201 2x2 AX &amp; Bluetooth&reg; 5.1 (Windows 10) or Bluetooth&reg; 5.2 (Windows 11)</li>\r\n</ul>\r\n\r\n<p><strong>Warranty</strong></p>\r\n\r\n<ul>\r\n	<li>3 Year Onsite</li>\r\n</ul>\r\n\r\n<p><strong>Color</strong></p>\r\n\r\n<ul>\r\n	<li>Graphite Black</li>\r\n</ul>\r\n', 'thinkpad-e14-gen-6', 53691.78, 'thinkpad-e14-gen-6_1724877115.jpg', '2024-09-02', 1, 96, 0, 0),
(60, 2, 'Exxact TensorEX 4U Rackmountable Workstation - 1x AMD Ryzen Threadripper Pro 5000WX - TS4-128014635', '<p><strong>Rack Height:</strong></p>\r\n\r\n<ul>\r\n	<li>4U Rackmountable Workstation</li>\r\n</ul>\r\n\r\n<p><strong>Processor</strong>:</p>\r\n\r\n<ul>\r\n	<li>1x AMD Ryzen Threadripper Pro 5000WX</li>\r\n</ul>\r\n\r\n<p><strong>Drive Bays:</strong></p>\r\n\r\n<ul>\r\n	<li>2x 3.5&quot; and 4x 2.5&quot; Internal</li>\r\n</ul>\r\n\r\n<p><strong>Supports:</strong></p>\r\n\r\n<ul>\r\n	<li>Up to 4x Double-Wide cards</li>\r\n</ul>\r\n', 'exxact-tensorex-4u-rackmountable-workstation-1x-amd-ryzen-threadripper-pro-5000wx-ts4-128014635', 109000, 'exxact-tensorex-4u-rackmountable-workstation-1x-amd-ryzen-threadripper-pro-5000wx-ts4-128014635.webp', '2024-09-03', 1, 92, 0, 0),
(61, 2, 'STGAubron Gaming Desktop PC, Radeon RX 590 8G GDDR5, AMD Athlon 3000G 3.5G, 16G DDR4, 512G SSD, 600M WiFi,', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>STGAubron</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Windows 11 Home</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>Athlon</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Speed</td>\r\n			<td>3.5 GHz</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Card Description</td>\r\n			<td>Dedicated</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Coprocessor</td>\r\n			<td>AMD Radeon RX 590</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Memory Storage Capacity</td>\r\n			<td>512 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Specific Uses For Product</td>\r\n			<td>Gaming; Streaming</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>16 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>STGAubron</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'stgaubron-gaming-desktop-pc-radeon-rx-590-8g-gddr5-amd-athlon-3000g-3-5g-16g-ddr4-512g-ssd-600m-wifi', 25256.25, 'stgaubron-gaming-desktop-pc-radeon-rx-590-8g-gddr5-amd-athlon-3000g-3-5g-16g-ddr4-512g-ssd-600m-wifi.jpg', '2024-09-03', 1, 91, 0, 0),
(62, 2, ' ASUS ROG G16CH (2024) Gaming Desktop PC, Intel® Core™ i7-14700F, NVIDIA® GeForce RTX™ 4060Ti DUAL, 1TB PCIe® Gen4 SSD, 32GB DDR5 RAM, Windows 11, G16CHR-AS766Ti', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>ASUS</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Windows 11 Home</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>Core i7</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Speed</td>\r\n			<td>5.3 GHz</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Card Description</td>\r\n			<td>Dedicated</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Coprocessor</td>\r\n			<td>NVIDIA GeForce RTX 4060Ti DUAL</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Memory Storage Capacity</td>\r\n			<td>32 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Memory Slots Available</td>\r\n			<td>4</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Specific Uses For Product</td>\r\n			<td>Gaming</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>32 GB</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'asus-rog-g16ch-2024-gaming-desktop-pc-intel-core-i7-14700f-nvidia-geforce-rtx-4060ti-dual-1tb-pcie-gen4-ssd-32gb-ddr5-ram-windows-11-g16chr-as766ti', 70899, 'asus-rog-g16ch-2024-gaming-desktop-pc-intel-core-i7-14700f-nvidia-geforce-rtx-4060ti-dual-1tb-pcie-gen4-ssd-32gb-ddr5-ram-windows-11-g16chr-as766ti.jpg', '2024-08-30', 1, 98, 0, 0),
(63, 2, 'iMac', '<h2>8-Core CPU<br />\r\n8-Core GPU<br />\r\n256GB storag<br />\r\n8GB unified memory</h2>\r\n\r\n<ul>\r\n	<li>24-inch 4.5K Retina display&sup2;</li>\r\n	<li>Two Thunderbolt / USB 4 ports</li>\r\n	<li>Magic Keyboard</li>\r\n</ul>\r\n', 'imac', 84999, 'imac.jpg', '2024-09-01', 1, 95, 0, 0),
(64, 2, 'STGAubron Gaming Desktop PC, Radeon RX 580 16G GDDR5, Intel 10th Gen G5905 3.5G, 16G RAM, 512G SSD, WiFi, BT 5.0, RGB Fan x 5, RGB Keyboard & Mouse & Mouse Pad, W11H64', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>STGAubron</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Windows 11 Home</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>Celeron</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Speed</td>\r\n			<td>3.5 GHz</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Card Description</td>\r\n			<td>Dedicated</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Coprocessor</td>\r\n			<td>AMD Radeon RX 580 16G GDDR5</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Specific Uses For Product</td>\r\n			<td>Gaming</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>16 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>STGAubron</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Included Components</td>\r\n			<td>Mouse</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'stgaubron-gaming-desktop-pc-radeon-rx-580-16g-gddr5-intel-10th-gen-g5905-3-5g-16g-ram-512g-ssd-wifi-bt-5-0-rgb-fan-x-5-rgb-keyboard-mouse-mouse-pad-w11h64', 27499, 'stgaubron-gaming-desktop-pc-radeon-rx-580-16g-gddr5-intel-10th-gen-g5905-3-5g-16g-ram-512g-ssd-wifi-bt-5-0-rgb-fan-x-5-rgb-keyboard-mouse-mouse-pad-w11h64.jpg', '2024-08-30', 1, 99, 0, 4),
(65, 2, 'STGAubron Gaming Desktop PC, AMD Athlon 3000G 3.5G, Radeon RX 580 8G GDDR5, 16G DDR4 Memory, 1T SSD, 600M WiFi, BT 5.0, RGB Fan x 4, RGB Keyboard & Mouse & Mouse Pad, W11H64', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>STGAubron</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Windows 11 Home</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>Athlon</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Speed</td>\r\n			<td>3.5 GHz</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Card Description</td>\r\n			<td>Dedicated</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Coprocessor</td>\r\n			<td>AMD Radeon RX 580</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Specific Uses For Product</td>\r\n			<td>Gaming</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>16 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>STGAubron</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Included Components</td>\r\n			<td>Mouse</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'stgaubron-gaming-desktop-pc-amd-athlon-3000g-3-5g-radeon-rx-580-8g-gddr5-16g-ddr4-memory-1t-ssd-600m-wifi-bt-5-0-rgb-fan-x-4-rgb-keyboard-mouse-mouse-pad-w11h64', 26399, 'stgaubron-gaming-desktop-pc-amd-athlon-3000g-3-5g-radeon-rx-580-8g-gddr5-16g-ddr4-memory-1t-ssd-600m-wifi-bt-5-0-rgb-fan-x-4-rgb-keyboard-mouse-mouse-pad-w11h64.jpg', '2024-08-30', 1, 97, 0, 0),
(66, 4, 'Samsung Galaxy Z Flip6', '<table cellspacing=\"0\">\r\n	<tbody>\r\n		<tr>\r\n			<th rowspan=\"15\" scope=\"row\">Network</th>\r\n			<td><a href=\"https://www.gsmarena.com/network-bands.php3\">Technology</a></td>\r\n			<td><a href=\"https://www.gsmarena.com/samsung_galaxy_z_flip6-13192.php#\">GSM / CDMA / HSPA / EVDO / LTE / 5G</a></td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<table cellspacing=\"0\">\r\n	<tbody>\r\n		<tr>\r\n			<th rowspan=\"2\" scope=\"row\">Launch</th>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=phone-life-cycle\">Announced</a></td>\r\n			<td>2024, July 10</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=phone-life-cycle\">Status</a></td>\r\n			<td>Available. Released 2024, July 24</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<table cellspacing=\"0\">\r\n	<tbody>\r\n		<tr>\r\n			<th rowspan=\"6\" scope=\"row\">Body</th>\r\n			<td><a href=\"https://www.gsmarena.com/samsung_galaxy_z_flip6-13192.php#\" onclick=\"helpW(\'h_dimens.htm\');\">Dimensions</a></td>\r\n			<td>Unfolded: 165.1 x 71.9 x 6.9 mm<br />\r\n			Folded: 85.1 x 71.9 x 14.9 mm</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/samsung_galaxy_z_flip6-13192.php#\" onclick=\"helpW(\'h_weight.htm\');\">Weight</a></td>\r\n			<td>187 g (6.60 oz)</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=build\">Build</a></td>\r\n			<td>Plastic front (unfolded), glass back (Gorilla Glass Victus 2), aluminum frame</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=sim\">SIM</a></td>\r\n			<td>Nano-SIM and multi eSIM</td>\r\n		</tr>\r\n		<tr>\r\n			<td>&nbsp;</td>\r\n			<td>IP48 water resistant (up to 1.5m for 30 min)<br />\r\n			Enhanced armor aluminum frame with tougher drop and scratch resistance (advertised)</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<table cellspacing=\"0\">\r\n	<tbody>\r\n		<tr>\r\n			<th rowspan=\"5\" scope=\"row\">Display</th>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=display-type\">Type</a></td>\r\n			<td>Foldable Dynamic LTPO AMOLED 2X, 120Hz, HDR10+, 2600 nits (peak)</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/samsung_galaxy_z_flip6-13192.php#\" onclick=\"helpW(\'h_dsize.htm\');\">Size</a></td>\r\n			<td>6.7 inches, 101.5 cm2&nbsp;(~85.5% screen-to-body ratio)</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=resolution\">Resolution</a></td>\r\n			<td>1080 x 2640 pixels (~426 ppi density)</td>\r\n		</tr>\r\n		<tr>\r\n			<td>&nbsp;</td>\r\n			<td>Cover display:<br />\r\n			Super AMOLED, 60Hz, 1600 nits (peak), 3.4 inches, 720 x 748 pixels (Gorilla Glass Victus 2), 306 ppi</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<table cellspacing=\"0\">\r\n	<tbody>\r\n		<tr>\r\n			<th rowspan=\"4\" scope=\"row\">Platform</th>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=os\">OS</a></td>\r\n			<td>Android 14, One UI 6.1.1</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=chipset\">Chipset</a></td>\r\n			<td>Qualcomm SM8650-AC Snapdragon 8 Gen 3 (4 nm)</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=cpu\">CPU</a></td>\r\n			<td>8-core (1x3.39GHz Cortex-X4 &amp; 3x3.1GHz Cortex-A720 &amp; 2x2.9GHz Cortex-A720 &amp; 2x2.2GHz Cortex-A520)</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=gpu\">GPU</a></td>\r\n			<td>Adreno 750 (1 GHz)</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<table cellspacing=\"0\">\r\n	<tbody>\r\n		<tr>\r\n			<th rowspan=\"5\" scope=\"row\">Memory</th>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=memory-card-slot\">Card slot</a></td>\r\n			<td>No</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=dynamic-memory\">Internal</a></td>\r\n			<td>256GB 12GB RAM, 512GB 12GB RAM</td>\r\n		</tr>\r\n		<tr>\r\n			<td>&nbsp;</td>\r\n			<td>UFS 4.0</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<table cellspacing=\"0\">\r\n	<tbody>\r\n		<tr>\r\n			<th rowspan=\"4\" scope=\"row\">Main Camera</th>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=camera\">Dual</a></td>\r\n			<td>50 MP, f/1.8, 23mm (wide), 1.0&micro;m, dual pixel PDAF, OIS<br />\r\n			12 MP, f/2.2, 123? (ultrawide), 1.12&micro;m</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=camera\">Features</a></td>\r\n			<td>LED flash, HDR, panorama</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=camera\">Video</a></td>\r\n			<td>4K@30/60fps, 1080p@60/120/240fps, 720p@960fps, HDR10+</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<table cellspacing=\"0\">\r\n	<tbody>\r\n		<tr>\r\n			<th rowspan=\"4\" scope=\"row\">Selfie camera</th>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=secondary-camera\">Single</a></td>\r\n			<td>10 MP, f/2.2, 23mm (wide), 1.22&micro;m</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=secondary-camera\">Features</a></td>\r\n			<td>HDR</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=secondary-camera\">Video</a></td>\r\n			<td>4K@30/60fps</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<table cellspacing=\"0\">\r\n	<tbody>\r\n		<tr>\r\n			<th rowspan=\"3\" scope=\"row\">Sound</th>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=loudspeaker\">Loudspeaker</a></td>\r\n			<td>Yes, with stereo speakers</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=audio-jack\">3.5mm jack</a></td>\r\n			<td>No</td>\r\n		</tr>\r\n		<tr>\r\n			<td>&nbsp;</td>\r\n			<td>32-bit/384kHz audio</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<table cellspacing=\"0\">\r\n	<tbody>\r\n		<tr>\r\n			<th rowspan=\"9\" scope=\"row\">Comms</th>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=wi-fi\">WLAN</a></td>\r\n			<td>Wi-Fi 802.11 a/b/g/n/ac/6e, tri-band, Wi-Fi Direct</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=bluetooth\">Bluetooth</a></td>\r\n			<td>5.3, A2DP, LE</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=gnss\">Positioning</a></td>\r\n			<td>GPS, GALILEO, GLONASS, BDS, QZSS</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=nfc\">NFC</a></td>\r\n			<td>Yes</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=fm-radio\">Radio</a></td>\r\n			<td>No</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=usb\">USB</a></td>\r\n			<td>USB Type-C 3.2, OTG</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<table cellspacing=\"0\">\r\n	<tbody>\r\n		<tr>\r\n			<th rowspan=\"9\" scope=\"row\">Features</th>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=sensors\">Sensors</a></td>\r\n			<td>Fingerprint (side-mounted), accelerometer, gyro, proximity, compass, barometer</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<table cellspacing=\"0\">\r\n	<tbody>\r\n		<tr>\r\n			<th rowspan=\"7\" scope=\"row\">Battery</th>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=rechargeable-battery-types\">Type</a></td>\r\n			<td>4000 mAh, non-removable</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=battery-charging\">Charging</a></td>\r\n			<td>25W wired, QC2.0, 50% in 30 min (advertised)<br />\r\n			15W wireless<br />\r\n			4.5W reverse wireless</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<table cellspacing=\"0\">\r\n	<tbody>\r\n		<tr>\r\n			<th rowspan=\"6\" scope=\"row\">Misc</th>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=build\">Colors</a></td>\r\n			<td>Yellow, Silver Shadow, Mint, Blue, Black, White, Peach</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=models\">Models</a></td>\r\n			<td>SM-F741B, SM-F741B/DS, SM-F741U, SM-F741U1, SM-F741W, SM-F741N</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=sar\">SAR EU</a></td>\r\n			<td>1.09 W/kg (head) &nbsp; &nbsp; 1.51 W/kg (body) &nbsp; &nbsp;</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=price\">Price</a></td>\r\n			<td><a href=\"https://www.gsmarena.com/samsung_galaxy_z_flip6-price-13192.php\">$&thinsp;1,099.99 / &euro;&thinsp;739.90 / &pound;&thinsp;949.00 / ?&thinsp;109,999</a></td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<table cellspacing=\"0\">\r\n	<tbody>\r\n		<tr>\r\n			<th rowspan=\"4\" scope=\"row\">Tests</th>\r\n			<td><a href=\"https://www.gsmarena.com/glossary.php3?term=benchmarking\">Performance</a></td>\r\n			<td>AnTuTu: 1400594 (v10)<br />\r\n			GeekBench: 6265 (v6)<br />\r\n			3DMark Wild life: 14606 (offscreen 1440p)</td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/gsmarena_lab_tests-review-751p2.php\">Display</a></td>\r\n			<td><a href=\"https://www.gsmarena.com/samsung_galaxy_z_flip6-review-2727p3.php#dt\">1475 nits max brightness (measured)</a></td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/gsmarena_lab_tests-review-751p7.php\">Loudspeaker</a></td>\r\n			<td><a href=\"https://www.gsmarena.com/samsung_galaxy_z_flip6-review-2727p3.php#lt\">-26.3 LUFS (Good)</a></td>\r\n		</tr>\r\n		<tr>\r\n			<td><a href=\"https://www.gsmarena.com/how_we_test_gsmarena_battery_life_test_v2-news-60429.php\">Battery (new)</a></td>\r\n			<td>\r\n			<p><a href=\"https://www.gsmarena.com/samsung_galaxy_z_flip6-review-2727p3.php#bt\" onclick=\"showBatteryPopup(event, 13192); \">Active use score 10:35h</a></p>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'samsung-galaxy-z-flip6', 58999, 'samsung-galaxy-z-flip6.jpg', '2024-08-31', 1, 100, 0, 0),
(67, 3, 'SAMSUNG Galaxy Tab A9+ Plus 11” 64GB Android Tablet, Big Screen, Quad Speakers, Upgraded Chipset, Multi Window Display, Slim, Light, Durable, Kids Friendly Design, US Version, 2024, Silver', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>SAMSUNG</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>A9+</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Memory Storage Capacity</td>\r\n			<td>64 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>11 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Display Resolution Maximum</td>\r\n			<td>1920 X 1200 (WUXGA) Pixels</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'samsung-galaxy-tab-a9-plus-11-64gb-android-tablet-big-screen-quad-speakers-upgraded-chipset-multi-window-display-slim-light-durable-kids-friendly-design-us-version-2024-silver', 9675, 'samsung-galaxy-tab-a9-plus-11-64gb-android-tablet-big-screen-quad-speakers-upgraded-chipset-multi-window-display-slim-light-durable-kids-friendly-design-us-version-2024-silver.jpg', '2024-08-30', 1, 97, 0, 0),
(68, 3, 'SAMSUNG Galaxy Tab S6 Lite 10.4\" 64GB WiFi Android Tablet, S Pen Included, Gaming Ready, Long Battery Life, Slim Metal Design, Expandable Storage, US Version, Oxford Gray', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>SAMSUNG</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>Tab S6 Lite</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Memory Storage Capacity</td>\r\n			<td>64 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>10.4 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Display Resolution Maximum</td>\r\n			<td>2000 x 1200 Pixels</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'samsung-galaxy-tab-s6-lite-10-4-64gb-wifi-android-tablet-s-pen-included-gaming-ready-long-battery-life-slim-metal-design-expandable-storage-us-version-oxford-gray', 11756, 'samsung-galaxy-tab-s6-lite-10-4-64gb-wifi-android-tablet-s-pen-included-gaming-ready-long-battery-life-slim-metal-design-expandable-storage-us-version-oxford-gray.jpg', '2024-08-29', 1, 100, 0, 0),
(69, 3, 'Android Tablet with Keyboard, Android 13 Tablet, 12(6+6)GB+128GB, 1TB Expand, 2 in 1 Tablet, 10 inch Tablet with Case, Mouse, Stylus, 8000mAh Battery, 2.4G/5G WiFi, GPS, Certified Tablet PC, Green', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>QDDQ</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>TB02</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Memory Storage Capacity</td>\r\n			<td>128 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>10 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Display Resolution Maximum</td>\r\n			<td>1280 Pixels</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'android-tablet-keyboard-android-13-tablet-12-6-6-gb-128gb-1tb-expand-2-1-tablet-10-inch-tablet-case-mouse-stylus-8000mah-battery-2-4g-5g-wifi-gps-certified-tablet-pc-green', 56255, 'android-tablet-keyboard-android-13-tablet-12-6-6-gb-128gb-1tb-expand-2-1-tablet-10-inch-tablet-case-mouse-stylus-8000mah-battery-2-4g-5g-wifi-gps-certified-tablet-pc-green.jpg', '2024-09-01', 1, 99, 0, 0);
INSERT INTO `products` (`id`, `category_id`, `name`, `description`, `slug`, `price`, `photo`, `date_view`, `counter`, `stock`, `discount`, `rating`) VALUES
(70, 3, 'Latest Android 12 Tablet with 8GB RAM 256 ROM 1TB Expand,10.1 Inch Gaming Tablets,2.0GHz Octa-Core Tablet,1920 * 1200 FHD IPS Display,13MP+5MP Dual Camera,2.4/5G Dual Band WiFi+Bluetooth 5.0(Gray)', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>kinstone</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>102MB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Memory Storage Capacity</td>\r\n			<td>256 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>10.1 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Display Resolution Maximum</td>\r\n			<td>1920*1200</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'latest-android-12-tablet-8gb-ram-256-rom-1tb-expand-10-1-inch-gaming-tablets-2-0ghz-octa-core-tablet-1920-1200-fhd-ips-display-13mp-5mp-dual-camera-2-4-5g-dual-band-wifi-bluetooth-5-0-gray', 6750, 'latest-android-12-tablet-8gb-ram-256-rom-1tb-expand-10-1-inch-gaming-tablets-2-0ghz-octa-core-tablet-1920-1200-fhd-ips-display-13mp-5mp-dual-camera-2-4-5g-dual-band-wifi-bluetooth-5-0-gray.jpg', '2024-08-30', 1, 96, 0, 0),
(71, 3, 'UMIDIGI 10 inch Android 13 Gaming Tablet with Helio G99 Octa Core Processor 16GB (8+8Extend) RAM & 128GB (up to 1TB) ROM, 4G LTE Tablet with Dual SIM Card Slots GPS Bluetooth Cellular and WiFi', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>UMIDIGI</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>G3 Tab Ultra</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Memory Storage Capacity</td>\r\n			<td>128 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>10.1 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Display Resolution Maximum</td>\r\n			<td>1280&times;800 Pixels</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'umidigi-10-inch-android-13-gaming-tablet-helio-g99-octa-core-processor-16gb-8-8extend-ram-128gb-up-1tb-rom-4g-lte-tablet-dual-sim-card-slots-gps-bluetooth-cellular-and-wifi', 7143, 'umidigi-10-inch-android-13-gaming-tablet-helio-g99-octa-core-processor-16gb-8-8extend-ram-128gb-up-1tb-rom-4g-lte-tablet-dual-sim-card-slots-gps-bluetooth-cellular-and-wifi.jpg', '0000-00-00', 0, 100, 0, 0),
(72, 3, '2023 Newest Tablet 11 inch Android 13 Tablets, 16GB RAM+256GB ROM+1TB Expand, Octa-Core 2.0GHz', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>ZIOVO</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>Z128</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Memory Storage Capacity</td>\r\n			<td>256 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>11 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Display Resolution Maximum</td>\r\n			<td>2000*1200 Pixels</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', '2023-newest-tablet-11-inch-android-13-tablets-16gb-ram-256gb-rom-1tb-expand-octa-core-2-0ghz', 8437, '2023-newest-tablet-11-inch-android-13-tablets-16gb-ram-256gb-rom-1tb-expand-octa-core-2-0ghz-2k-2000-x-1200-fhd-display-8600mah-13mp-5mp-camera-5g-2-4g-wi-fi-bluetooth-case-blue.jpg', '2024-08-31', 3, 100, 0, 0),
(73, 3, 'YESTEL 11 Inch Android 13 Tablet,16GB RAM+256GB ROM,1TB Expand,Octa-Core Processor,8600mAh Large Battery,2000 * 1200 Pixels,GPS/ 5G WiFi/Bluetooth/with Case-Blue', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>YESTEL</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>T15</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Memory Storage Capacity</td>\r\n			<td>256 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>11 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Display Resolution Maximum</td>\r\n			<td>2000*1200 Pixels</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'yestel-11-inch-android-13-tablet-16gb-ram-256gb-rom-1tb-expand-octa-core-processor-8600mah-large-battery-2000-1200-pixels-gps-5g-wifi-bluetooth-case-blue', 8381, 'yestel-11-inch-android-13-tablet-16gb-ram-256gb-rom-1tb-expand-octa-core-processor-8600mah-large-battery-2000-1200-pixels-gps-5g-wifi-bluetooth-case-blue.jpg', '0000-00-00', 0, 1, 0, 0),
(74, 4, 'SAMSUNG Galaxy A15 5G A Series Cell Phone, 128GB Unlocked Android Smartphone, AMOLED Display, Expandable Storage, Knox Security, Super Fast Charging, US Version, 2024, Blue Black', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>SAMSUNG</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Android 14, One UI</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>4 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Memory Storage Capacity</td>\r\n			<td>128 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>6.5 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>Galaxy A15</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Wireless Carrier</td>\r\n			<td>Unlocked for All Carriers</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Cellular Technology</td>\r\n			<td>5G</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Connectivity Technology</td>\r\n			<td>USB Type C</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Color</td>\r\n			<td>Black</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'samsung-galaxy-a15-5g-series-cell-phone-128gb-unlocked-android-smartphone-amoled-display-expandable-storage-knox-security-super-fast-charging-us-version-2024-blue-black', 9787.5, 'samsung-galaxy-a15-5g-series-cell-phone-128gb-unlocked-android-smartphone-amoled-display-expandable-storage-knox-security-super-fast-charging-us-version-2024-blue-black.jpg', '2024-09-01', 1, 1, 0, 0),
(75, 4, 'HUAWEI nova Y90 Dual-SIM 128GB ROM + 6GB RAM (GSM only | No CDMA) Factory Unlocked 4G/LTE Smartphone (Crystal Blue) - International Version', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>HUAWEI</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>EMUI 12</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>6 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Speed</td>\r\n			<td>2.4 GHz</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Memory Storage Capacity</td>\r\n			<td>128 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>6.7 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Resolution</td>\r\n			<td>1080 x 2388</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>Huawei nova Y90</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Wireless Carrier</td>\r\n			<td>Unlocked for All Carriers</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Cellular Technology</td>\r\n			<td>4G</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'huawei-nova-y90-dual-sim-128gb-rom-6gb-ram-gsm-only-no-cdma-factory-unlocked-4g-lte-smartphone-crystal-blue-international-version', 11250, 'huawei-nova-y90-dual-sim-128gb-rom-6gb-ram-gsm-only-no-cdma-factory-unlocked-4g-lte-smartphone-crystal-blue-international-version.jpg', '2024-09-01', 4, 1, 0, 0),
(76, 4, 'Xiaomi Redmi Note 12S 4G LTE (256GB + 8GB) Global Unlocked 6.67\" 108MP Triple (Tmobile Mint Tello Global) + (w/ 33W Fast Car Dual Charger Bundle) (Onyx Gray)', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>Xiaomi</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>MIUI 14, Android 13</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>8 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>Snapdragon</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Memory Storage Capacity</td>\r\n			<td>256 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>6.43 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Resolution</td>\r\n			<td>1080 x 2400</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Refresh Rate</td>\r\n			<td>90 Hz</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>Redmi Note 12s 4g lte</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Wireless Carrier</td>\r\n			<td>3</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'xiaomi-redmi-note-12s-4g-lte-256gb-8gb-global-unlocked-6-67-108mp-triple-tmobile-mint-tello-global-w-33w-fast-car-dual-charger-bundle-onyx-gray', 10463, 'xiaomi-redmi-note-12s-4g-lte-256gb-8gb-global-unlocked-6-67-108mp-triple-tmobile-mint-tello-global-w-33w-fast-car-dual-charger-bundle-onyx-gray.jpg', '2024-08-31', 1, 100, 0, 0),
(77, 4, 'Xiaomi Redmi Note 12 4G LTE (128GB + 4GB) Global Unlocked 6.67\" 50MP Triple (ONLY T-Moble/Tello/Mint USA Market) + (w/ 33W Fast Car Dual Charger Bundle) (Mint Green Global + 33W Car Charger)', '<ul>\r\n	<li>U.S.A. Users : Only Works on Tmobile / Mint / Tello or any under Tmobile Network 4G VoLTE Worldwide Unlocked Dual Nano sim . FCC ID: 2AFZZRA42L</li>\r\n	<li>Dual Nano sim + SD Slot 4G: LTE 4G: LTE TDD B40, B41 4G: LTE FDD B1, B3, B5, B8 3G: WCDMA:1/2/5/8 2G: GSM: B2/B3/B5/B8</li>\r\n	<li>6.67&quot; FHD+ AMOLED DotDisplay Refresh rate: Up to 120Hz Contrast ratio: 4,500,000:1 Technology: 1200nits brightness, SGS eye care, Sunlight Mode, Reading Mode, Contrast ratio: 4500000:1 DCI P3: 100% (typical)</li>\r\n	<li>Qualcomm Snapdragon 4 Gen 1 CPU: 2X Cortex-A78 @ 2.0GHz ; 6X Cortex-A55 @ 1.8GHz GPU : Adreno 619 Bluetooth 5.2 Wi-Fi Protocol: 802.11a/b/g/n/ac</li>\r\n	<li>GPS/AGPS, Glonass Dual speakers 3.5mm headphone jack Hi-Res Audio Proximity sensor | Ambient light sensor | Accelerometer | Electronic compass | IR blaster ?Gyroscopecertification</li>\r\n	<li>50MP Main Camera (f/1.8) 8MP Ultra-Wide Camera (f/2.2) 2MP Macro Camera (f/2.4) LED flash / Front: 13 MP, (wide), 1/3.06&quot;, 1.0&micro;m</li>\r\n	<li>Manufacturer : Xiaomi</li>\r\n</ul>\r\n', 'xiaomi-redmi-note-12-4g-lte-128gb-4gb-global-unlocked-6-67-50mp-triple-only-t-moble-tello-mint-usa-market-w-33w-fast-car-dual-charger-bundle-mint-green-global-33w-car-charger', 8945, 'xiaomi-redmi-note-12-4g-lte-128gb-4gb-global-unlocked-6-67-50mp-triple-only-t-moble-tello-mint-usa-market-w-33w-fast-car-dual-charger-bundle-mint-green-global-33w-car-charger.jpg', '2024-08-30', 1, 96, 0, 0),
(78, 4, 'SAMSUNG Galaxy A14 5G + 4G LTE (128GB + 4GB) Unlocked Worldwide (Only T-Mobile/Mint/Tello USA Market) 1 Year Warranty Latin America 6.6\" 50MP Triple Camera + (15W Wall Charger) (Black)', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>SAMSUNG</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>4 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Memory Storage Capacity</td>\r\n			<td>128 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>6.6 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Resolution</td>\r\n			<td>1080 x 2408</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>Galaxy A14 5G</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Wireless Carrier</td>\r\n			<td>Unlocked</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Cellular Technology</td>\r\n			<td>2G, 3G, 4G, 5G</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Connectivity Technology</td>\r\n			<td>Wi-Fi</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Wireless network technology</td>\r\n			<td>Wi-Fi</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'samsung-galaxy-a14-5g-4g-lte-128gb-4gb-unlocked-worldwide-only-t-mobile-mint-tello-usa-market-1-year-warranty-latin-america-6-6-50mp-triple-camera-15w-wall-charger-black', 10699, 'samsung-galaxy-a14-5g-4g-lte-128gb-4gb-unlocked-worldwide-only-t-mobile-mint-tello-usa-market-1-year-warranty-latin-america-6-6-50mp-triple-camera-15w-wall-charger-black.jpg', '2024-08-29', 1, 100, 0, 0),
(79, 4, 'SAMSUNG Galaxy A34 5G + 4G LTE (128GB + 6GB) Unlocked Worldwide (Only T-Mobile/Mint/Metro USA Market) 6.6\" 120Hz 48MP Triple Camera + (25W Wall Charger) (Awesome Silver (SM-A346M))', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>SAMSUNG</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Android 13.0</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>6 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>MediaTek Helio</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Speed</td>\r\n			<td>2.6 GHz</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Memory Storage Capacity</td>\r\n			<td>128 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>6.6 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Resolution</td>\r\n			<td>1080 x 2408</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>Galaxy A34 5G</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Wireless Carrier</td>\r\n			<td>Unlocked for All Carriers</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'samsung-galaxy-a34-5g-4g-lte-128gb-6gb-unlocked-worldwide-only-t-mobile-mint-metro-usa-market-6-6-120hz-48mp-triple-camera-25w-wall-charger-awesome-silver-sm-a346m', 13999, 'samsung-galaxy-a34-5g-4g-lte-128gb-6gb-unlocked-worldwide-only-t-mobile-mint-metro-usa-market-6-6-120hz-48mp-triple-camera-25w-wall-charger-awesome-silver-sm-a346m.jpg', '2024-08-29', 2, 100, 0, 0),
(80, 1, 'Lenovo IdeaPad 1 Laptop, 15.6” FHD Display, AMD Ryzen 5 5500U, 8GB RAM, 512GB SSD, Windows 11 Home, 720p Camera w/Privacy Shutter, Smart Noise Cancelling, Cloud Grey', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>Lenovo</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>Ideapad 1 15&quot; - 82R400EMUS</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>15.6 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Color</td>\r\n			<td>Gray</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Hard Disk Size</td>\r\n			<td>512 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>AMD Ryzen 5 5500U</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>8 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Windows 11 Home</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Special Feature</td>\r\n			<td>Anti Glare Coating</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Card Description</td>\r\n			<td>Integrated</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'lenovo-ideapad-1-laptop-15-6-fhd-display-amd-ryzen-5-5500u-8gb-ram-512gb-ssd-windows-11-home-720p-camera-w-privacy-shutter-smart-noise-cancelling-cloud-grey', 17099, 'lenovo-ideapad-1-laptop-15-6-fhd-display-amd-ryzen-5-5500u-8gb-ram-512gb-ssd-windows-11-home-720p-camera-w-privacy-shutter-smart-noise-cancelling-cloud-grey.jpg', '2024-08-29', 1, 100, 0, 0),
(81, 1, 'Lenovo Newest V15 Business Laptop | Intel 4-core Processor | 15.6\" FHD (1920 x 1080) | 32GB RAM | 1TB SSD |', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>Lenovo</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>V15</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>15.6 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Color</td>\r\n			<td>Black</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Hard Disk Size</td>\r\n			<td>1 TB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>Celeron</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>32 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Windows 11 Pro</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Special Feature</td>\r\n			<td>HD Audio, Spill resistant, High Definition Audio, Anti Glare Coating, Numeric Keypad</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Card Description</td>\r\n			<td>Integrated</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'lenovo-newest-v15-business-laptop-intel-4-core-processor-15-6-fhd-1920-x-1080-32gb-ram-1tb-ssd', 30999, 'lenovo-newest-v15-business-laptop-intel-4-core-processor-15-6-fhd-1920-x-1080-32gb-ram-1tb-ssd-ethernet-rj-45-military-durability-windows-11-pro-w-wowpc-500gb-external-storage.jpg', '2024-09-01', 1, 100, 0, 0),
(82, 1, 'HP Newest 255 G10 15.6\" FHD Business Laptop, AMD Ryzen 7 7730U, 16GB RAM, 512GB PCIe SSD, Numeric Keypad, Webcam, Wi-Fi 6, HDMI, Windows 11 Pro, Black', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>HP</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>TPN-Q287</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>15.6 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Color</td>\r\n			<td>Black</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Hard Disk Size</td>\r\n			<td>512 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>Ryzen 7</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>16 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Windows 11 Pro</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Special Feature</td>\r\n			<td>Numeric Keypad</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Card Description</td>\r\n			<td>Integrated</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'hp-newest-255-g10-15-6-fhd-business-laptop-amd-ryzen-7-7730u-16gb-ram-512gb-pcie-ssd-numeric-keypad-webcam-wi-fi-6-hdmi-windows-11-pro-black', 29999, 'hp-newest-255-g10-15-6-fhd-business-laptop-amd-ryzen-7-7730u-16gb-ram-512gb-pcie-ssd-numeric-keypad-webcam-wi-fi-6-hdmi-windows-11-pro-black.jpg', '2024-09-03', 3, 91, 0, 2),
(83, 1, 'HP Laptop Computer, 15.6\'\' FHD Display Laptops, Intel Core i3-1215U, 16GB RAM|1TB SSD, for School College Student and Daily Life/Business', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>HP</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>15-dy5131wm</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>15.6 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Color</td>\r\n			<td>i3</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Hard Disk Size</td>\r\n			<td>1000 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>Intel Core i3</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>16 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Windows 11 Pro</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Special Feature</td>\r\n			<td>Fingerprint Reader, Memory Card Slot, Numeric Keypad</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Card Description</td>\r\n			<td>Integrated</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'hp-laptop-computer-15-6-fhd-display-laptops-intel-core-i3-1215u-16gb-ram-1tb-ssd-school-college-student-and-daily-life-business', 27999, 'hp-laptop-computer-15-6-fhd-display-laptops-intel-core-i3-1215u-16gb-ram-1tb-ssd-wi-fi-fast-charge-windows-11-pro-rk-date-cable-ready-school-college-student-and-daily-life-business.jpg', '0000-00-00', 0, 100, 0, 0),
(84, 1, 'Dell Latitude 3540 15.6\" FHD Business Laptop Computer, Intel 10-Core i5-1235U (Beat i7-1195G7), 16GB DDR4 RAM, 512GB PCIe SSD, WiFi 6E, Bluetooth, Black, Windows 11 Pro', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>Dell</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>Latitude</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>15.6 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Color</td>\r\n			<td>Black</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Hard Disk Size</td>\r\n			<td>512 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>Intel Core i5</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>16 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Windows 11 Pro</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Special Feature</td>\r\n			<td>HD Audio</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Card Description</td>\r\n			<td>Integrated</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'dell-latitude-3540-15-6-fhd-business-laptop-computer-intel-10-core-i5-1235u-beat-i7-1195g7-16gb-ddr4-ram-512gb-pcie-ssd-wifi-6e-bluetooth-black-windows-11-pro', 45999, 'dell-latitude-3540-15-6-fhd-business-laptop-computer-intel-10-core-i5-1235u-beat-i7-1195g7-16gb-ddr4-ram-512gb-pcie-ssd-wifi-6e-bluetooth-black-windows-11-pro.jpg', '2024-09-01', 6, 100, 0, 0),
(85, 1, 'ASUS ROG Strix G16 (2024) Gaming Laptop, 16” 16:10 FHD 165Hz Display, NVIDIA® GeForce RTX™ 4060, Intel Core i7-13650HX, 16GB DDR5', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>ASUS</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>Strix G16</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>16 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Color</td>\r\n			<td>Eclipse Gray</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Hard Disk Size</td>\r\n			<td>1 TB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>Core i7</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>16 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Windows 11 Home</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Card Description</td>\r\n			<td>Dedicated</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Coprocessor</td>\r\n			<td>NVIDIA GeForce RTX 4060</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'asus-rog-strix-g16-2024-gaming-laptop-16-16-10-fhd-165hz-display-nvidia-geforce-rtx-4060-intel-core-i7-13650hx-16gb-ddr5', 65399, 'asus-rog-strix-g16-2024-gaming-laptop-16-16-10-fhd-165hz-display-nvidia-geforce-rtx-4060-intel-core-i7-13650hx-16gb-ddr5-1tb-pcie-gen4-ssd-wi-fi-6e-windows-11-g614jv-as74.jpg', '0000-00-00', 0, 100, 0, 0),
(86, 1, 'ASUS TUF Gaming F16 (2024) Gaming Laptop, 16” FHD+ 165Hz 16:10 Display, Intel® Core™ i7-13650HX, NVIDIA® GeForce RTX™ 4060, 16GB DDR5', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>ASUS</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>FX607JV-ES73</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>16 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Color</td>\r\n			<td>Mecha Gray</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Hard Disk Size</td>\r\n			<td>512 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>Core i7</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>16 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Windows 11 Home</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Card Description</td>\r\n			<td>Dedicated</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Coprocessor</td>\r\n			<td>ASUS</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'asus-tuf-gaming-f16-2024-gaming-laptop-16-fhd-165hz-16-10-display-intel-core-i7-13650hx-nvidia-geforce-rtx-4060-16gb-ddr5', 61999, 'asus-tuf-gaming-f16-2024-gaming-laptop-16-fhd-165hz-16-10-display-intel-core-i7-13650hx-nvidia-geforce-rtx-4060-16gb-ddr5-512gb-pcie-gen4-ssd-wi-fi-6-windows-11-fx607jv-es73.jpg', '2024-08-29', 2, 95, 0, 0),
(87, 1, 'MSI Thin 15 15.6” 144Hz FHD Gaming Laptop: Intel Core i5-12450H, NVIDIA Geforce RTX 2050, 16GB DDR5, 512GB NVMe SSD, Cooler Boost 5, Win 11: Black B13UCX-2041US', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>MSI</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>Thin 15 B12UCX-2041US</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>15.6 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Color</td>\r\n			<td>Black</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Hard Disk Size</td>\r\n			<td>512 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>Intel Core i5</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>16 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Windows 11 Home</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Special Feature</td>\r\n			<td>HD Audio, Backlit Keyboard</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Card Description</td>\r\n			<td>RTX 2050</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'msi-thin-15-15-6-144hz-fhd-gaming-laptop-intel-core-i5-12450h-nvidia-geforce-rtx-2050-16gb-ddr5-512gb-nvme-ssd-cooler-boost-5-win-11-black-b13ucx-2041us', 35499, 'msi-thin-15-15-6-144hz-fhd-gaming-laptop-intel-core-i5-12450h-nvidia-geforce-rtx-2050-16gb-ddr5-512gb-nvme-ssd-cooler-boost-5-win-11-black-b13ucx-2041us.jpg', '2024-08-29', 1, 100, 0, 0),
(88, 1, 'Acer Nitro V Gaming Laptop | Intel Core i5-13420H Processor | NVIDIA GeForce RTX 4050 Laptop GPU | 15.6\" FHD IPS 144Hz Display | 8GB DDR5 | 512GB Gen 4 SSD', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>acer</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>Nitro V</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>15.6 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Color</td>\r\n			<td>Black</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Hard Disk Size</td>\r\n			<td>512 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>Intel Core i5</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>8 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Windows 11 Home</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Special Feature</td>\r\n			<td>Backlit Keyboard</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Card Description</td>\r\n			<td>Dedicated</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'acer-nitro-v-gaming-laptop-intel-core-i5-13420h-processor-nvidia-geforce-rtx-4050-laptop-gpu-15-6-fhd-ips-144hz-display-8gb-ddr5-512gb-gen-4-ssd', 36599, 'acer-nitro-v-gaming-laptop-intel-core-i5-13420h-processor-nvidia-geforce-rtx-4050-laptop-gpu-15-6-fhd-ips-144hz-display-8gb-ddr5-512gb-gen-4-ssd-wifi-6-backlit-kb-anv15-51-51h9.jpg', '0000-00-00', 0, 100, 0, 0),
(89, 1, 'ACEMAGIC Laptop Computer AMD Ryzen 7 5700U Gaming Laptop 16GB DDR4 512GB M.2 2280 NVMe SSD', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>ACEMAGIC</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>AX16PRO</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>16.1 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Color</td>\r\n			<td>Gray</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Hard Disk Size</td>\r\n			<td>512 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>AMD Ryzen 7</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>16 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Windows 11</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Special Feature</td>\r\n			<td>Backlit Keyboard, Memory Card Slot, Numeric Keypad</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Card Description</td>\r\n			<td>AMD Radeon Vega 8</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'acemagic-laptop-computer-amd-ryzen-7-5700u-gaming-laptop-16gb-ddr4-512gb-m-2-2280-nvme-ssd', 33699, 'acemagic-laptop-computer-amd-ryzen-7-5700u-gaming-laptop-16gb-ddr4-512gb-m-2-2280-nvme-ssd-windows-laptop-office-laptops-home-laptops-windows11-16-1-inch-ips-fhd-wifi6-bt5-2-hdmi-type-c-usb3-2.jpg', '2024-08-29', 3, 100, 0, 0),
(90, 1, 'AOC Gaming Laptop, AI Laptop Computer with Intel Core Ultra5 125U, 16GB DDR5 1TB SSD, 16.1-inch FHD Display', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>AOC</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>MX16</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>16.1 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Color</td>\r\n			<td>Gray</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Hard Disk Size</td>\r\n			<td>1 TB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>Intel Mobile CPU</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>16 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Windows 11</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Special Feature</td>\r\n			<td>Start AI with One Click, Backlit Keyboard, Memory Card Slot</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Card Description</td>\r\n			<td>Integrated</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'aoc-gaming-laptop-ai-laptop-computer-intel-core-ultra5-125u-16gb-ddr5-1tb-ssd-16-1-inch-fhd-display', 67499, 'aoc-gaming-laptop-ai-laptop-computer-intel-core-ultra5-125u-16gb-ddr5-1tb-ssd-16-1-inch-fhd-display-2024-newest-laptop-backlit-kb-support-wifi-6-type-c-bt5-2-one-click-copilot.jpg', '2024-08-30', 1, 100, 0, 0),
(91, 1, 'ASUS TUF Gaming A16 Laptop 16\" FHD+ 165Hz 7ms 100% sRGB AMD Octa-core Ryzen 7 7735HS 16GB RAM 512GB SSD Radeon RX 7700S 8GB Graphic (>RTX4060)', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>ASUS</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>TUF Gaming A16</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>16 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Color</td>\r\n			<td>Black</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Hard Disk Size</td>\r\n			<td>512 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>Ryzen 7</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>16 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Windows 11</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Special Feature</td>\r\n			<td>Backlit Keyboard</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Card Description</td>\r\n			<td>Dedicated</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'asus-tuf-gaming-a16-laptop-16-fhd-165hz-7ms-100-srgb-amd-octa-core-ryzen-7-7735hs-16gb-ram-512gb-ssd-radeon-rx-7700s-8gb-graphic-rtx4060', 49899, 'asus-tuf-gaming-a16-laptop-16-fhd-165hz-7ms-100-srgb-amd-octa-core-ryzen-7-7735hs-16gb-ram-512gb-ssd-radeon-rx-7700s-8gb-graphic-rtx4060-backlit-usb-c-usb4-fast-charging-win11-hdmi-cable.jpg', '0000-00-00', 0, 100, 0, 0),
(92, 1, 'N16 Pro Gaming Laptop 16 inch 2.5K 2560*1600 IPS 165Hz Display 13th Intel Core i7-13620H 32GB DDR4 RAM 1TB ', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>Ninkear</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>N16 PRO</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>16 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Color</td>\r\n			<td>Gray</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Hard Disk Size</td>\r\n			<td>1 TB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>Core i7</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>32 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Windows 11 Home</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Special Feature</td>\r\n			<td>Fingerprint Reader, Backlit Keyboard, Numeric Keypad</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Card Description</td>\r\n			<td>Integrated</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'n16-pro-gaming-laptop-16-inch-2-5k-2560-1600-ips-165hz-display-13th-intel-core-i7-13620h-32gb-ddr4-ram-1tb', 50999, 'n16-pro-gaming-laptop-16-inch-2-5k-2560-1600-ips-165hz-display-13th-intel-core-i7-13620h-32gb-ddr4-ram-1tb-pcie-ssd-wifi-6-fingerprint-unlocking-backlit-keyboard-computer-notebook-windows-11.jpg', '2024-08-29', 1, 100, 0, 0),
(93, 1, 'MSI Raider GE76 Gaming Laptop: Intel Core i9-12900H, GeForce RTX 3060, 17.3\" 144Hz FHD Display,16GB DDR5, 1TB NVMe SSD', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>MSI</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>Raider GE76 12UE-871</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>17.3 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Color</td>\r\n			<td>Black</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Hard Disk Size</td>\r\n			<td>1 TB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>Core i9</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>16 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Windows 11 Home</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Special Feature</td>\r\n			<td>Numeric Keypad</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Card Description</td>\r\n			<td>Dedicated</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'msi-raider-ge76-gaming-laptop-intel-core-i9-12900h-geforce-rtx-3060-17-3-144hz-fhd-display-16gb-ddr5-1tb-nvme-ssd', 62999, 'msi-raider-ge76-gaming-laptop-intel-core-i9-12900h-geforce-rtx-3060-17-3-144hz-fhd-display-16gb-ddr5-1tb-nvme-ssd-thunderbolt-4-cooler-boost-5-win-11-home-titanium-blue-12ue-871.jpg', '0000-00-00', 0, 100, 0, 0),
(94, 1, 'MSI Katana 17 Gaming Laptop: 13th Gen Intel Core i7, GeForce RTX 4060, 17.3\" 144Hz FHD Display, 32GB DDR5, 1TB NVMe SSD, USB-Type C', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>MSI</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>Katana 17 B13VFK-835US</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>17.3 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Color</td>\r\n			<td>Black</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Hard Disk Size</td>\r\n			<td>1 TB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>Core i7</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>32 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Windows 11 Home</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Card Description</td>\r\n			<td>RTX 4060</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Coprocessor</td>\r\n			<td>NVIDIA GeForce RTX 4060</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'msi-katana-17-gaming-laptop-13th-gen-intel-core-i7-geforce-rtx-4060-17-3-144hz-fhd-display-32gb-ddr5-1tb-nvme-ssd-usb-type-c', 60599, 'msi-katana-17-gaming-laptop-13th-gen-intel-core-i7-geforce-rtx-4060-17-3-144hz-fhd-display-32gb-ddr5-1tb-nvme-ssd-usb-type-c-cooler-boost-5-win11-home-black-b13vfk-835us.jpg', '2024-09-02', 1, 100, 0, 0),
(95, 1, 'ASUS 2024 MUX ROG ZEPHYRUS G14 14\" OLED 120HZ QHD(2560x1440) GAMING LAPTOP - AMD RYZEN 9 8945HS - NVIDIA GEFORCE RTX 4060-1TB SSD – WIN 11 HOME-W/MOUSE PAD', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>ASUS</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>ROG Zephyrus</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>14 Inches</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Hard Disk Size</td>\r\n			<td>1 TB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>Ryzen 9</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>16 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Windows 11</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Card Description</td>\r\n			<td>Dedicated</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Speed</td>\r\n			<td>4 GHz</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Hard Disk Description</td>\r\n			<td>SSD</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', 'asus-2024-mux-rog-zephyrus-g14-14-oled-120hz-qhd-2560x1440-gaming-laptop-amd-ryzen-9-8945hs-nvidia-geforce-rtx-4060-1tb-ssd-win-11-home-w-mouse-pad', 84399, 'asus-2024-mux-rog-zephyrus-g14-14-oled-120hz-qhd-2560x1440-gaming-laptop-amd-ryzen-9-8945hs-nvidia-geforce-rtx-4060-1tb-ssd-win-11-home-w-mouse-pad.jpg', '2024-08-29', 1, 100, 0, 0),
(96, 1, '16“ Laptop Computer, BaseBook Pro', '<table>\r\n	<tbody>\r\n		<tr>\r\n			<td>Brand</td>\r\n			<td>BHWW</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Model Name</td>\r\n			<td>WH-BHWW-160BP-Silver</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Screen Size</td>\r\n			<td>16.1</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Hard Disk Size</td>\r\n			<td>1 TB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Model</td>\r\n			<td>Intel Core i5</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Ram Memory Installed Size</td>\r\n			<td>32 GB</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Operating System</td>\r\n			<td>Windows 11 Pro</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Graphics Card Description</td>\r\n			<td>Integrated</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CPU Speed</td>\r\n			<td>1.1 GHz</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Hard Disk Description</td>\r\n			<td>SSD</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', '16-laptop-computer-basebook-pro', 25899, '16-laptop-computer-basebook-pro-laptops-lighting-gaming-i5-1035g4-cpu-iris-plus-graphics-16-10-ratio-display-1920x1200-ips-fhd-100-srgb-32gb-ram-1tb-ssd-lan-fingerprint-silver.jpg', '2024-09-03', 4, 1, 20, 0),
(97, 4, 'Narsuso', '<p><strong>Dimensity 7050 5G Chipset</strong></p>\r\n\r\n<p>CPU?6nm process, octa-core, 2*A78 @2.6 GHz?6*A55 @2.0 GHz</p>\r\n\r\n<p>GPU?Mali-G68</p>\r\n\r\n<p><strong>Up to 8GB + 8GB Dynamic RAM + 128GB ROM</strong></p>\r\n\r\n<p>RAM?Up to 8GB+8GB Dynamic RAM*</p>\r\n\r\n<p>ROM?128GB UFS 3.1</p>\r\n\r\n<p>*The dynamic 16GB memory is virtual and realized by software. It is different from actual storage space.</p>\r\n', 'narsuso', 8999.99, 'narsuso.webp', '2024-09-02', 3, 8, 10, 4.5);

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `rating` float NOT NULL,
  `message` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ratings`
--

INSERT INTO `ratings` (`id`, `user_id`, `product_id`, `rating`, `message`, `created_at`) VALUES
(1, 14, 36, 4, 'test message', '2024-09-01 00:33:39'),
(2, 14, 36, 4, 'test message', '2024-09-01 00:33:43'),
(3, 16, 36, 5, '', '2024-09-01 00:37:08'),
(4, 16, 36, 5, 'tanginam-', '2024-09-01 00:37:22'),
(5, 16, 36, 1, 'tanginam-', '2024-09-01 00:42:30'),
(6, 16, 36, 5, 'tetetete', '2024-09-01 00:42:37'),
(7, 16, 36, 3, 'dsdad', '2024-09-01 00:42:47'),
(8, 16, 36, 3, 'dsdad', '2024-09-01 00:52:07'),
(11, 16, 97, 4, 'dsda', '2024-09-01 00:54:45'),
(12, 16, 97, 4, 'dsda', '2024-09-01 00:55:08'),
(13, 16, 64, 4, 'test', '2024-09-01 00:55:15'),
(14, 16, 64, 4, 'test', '2024-09-01 00:56:25'),
(15, 16, 36, 4, 'dadadad', '2024-09-01 00:56:42'),
(16, 16, 36, 4, 'dadadad', '2024-09-01 00:58:20'),
(17, 16, 36, 5, 'tetetete', '2024-09-01 00:58:26'),
(18, 16, 97, 4, 'tanginamo lods', '2024-09-01 09:16:13'),
(19, 16, 97, 5, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has su', '2024-09-01 09:16:46'),
(20, 16, 97, 4, 'tanginamo lods', '2024-09-01 09:17:01'),
(21, 16, 36, 3, 'tetetete', '2024-09-01 09:24:21'),
(22, 16, 64, 5, 'bbjhkhjkhjkhjk', '2024-09-01 09:24:51'),
(23, 16, 37, 4, 'dadadad', '2024-09-01 10:36:03'),
(24, 16, 97, 5, 'testing', '2024-09-02 06:38:16'),
(25, 16, 82, 2, 'pangit, tangina mo sir', '2024-09-02 06:38:59');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `pay_id` varchar(50) NOT NULL,
  `sales_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(60) NOT NULL,
  `type` int(1) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `address` text NOT NULL,
  `contact_info` varchar(100) NOT NULL,
  `photo` varchar(200) NOT NULL,
  `status` int(1) NOT NULL DEFAULT 1,
  `activate_code` varchar(15) NOT NULL,
  `reset_code` varchar(15) NOT NULL,
  `created_on` date NOT NULL,
  `address_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `type`, `firstname`, `lastname`, `address`, `contact_info`, `photo`, `status`, `activate_code`, `reset_code`, `created_on`, `address_id`) VALUES
(1, 'admin@admin.com', '$2y$10$0SHFfoWzz8WZpdu9Qw//E.tWamILbiNCX7bqhy3od0gvK5.kSJ8N2', 1, 'Code', 'Projects', '', '', 'thanos1.jpg', 1, '', '', '2018-05-01', NULL),
(9, 'harry@den.com', '$2y$10$Oongyx.Rv0Y/vbHGOxywl.qf18bXFiZOcEaI4ZpRRLzFNGKAhObSC', 0, 'Harry', 'Den', 'Silay City, Negros Occidental', '09092735719', 'bg-login.jpg', 1, 'k8FBpynQfqsv', 'wzPGkX5IODlTYHg', '2018-05-09', NULL),
(12, 'christine@gmail.com', '$2y$10$ozW4c8r313YiBsf7HD7m6egZwpvoE983IHfZsPRxrO1hWXfPRpxHO', 0, 'Christine', 'becker', 'demo', '7542214500', 'female3.jpg', 1, '', '', '2018-07-09', NULL),
(13, 'kyle@gmail.com', '$2y$10$bMcRQO8gXdrt5qaiOhPXbeiqKn26sjHsjoxOVhbJ6TDKkuv8s6oPq', 1, 'Kyle', 'Reginaldo', '', '', 'takashi-miyazaki-G4Mg_0urKnI-unsplash.jpg', 1, 'MdFXjc9YnIKP', '', '2024-08-18', NULL),
(14, 'customer@gmail.com', '$2y$10$WpU5RqWDLiHdfsrp2GCbZuJqG690FeuuRzBZ0wzEw3znBfwin9X8e', 0, 'Tester', '1234', 'bacao 1 purok 1 general trias cavite', '09509181094', 'takashi-miyazaki-G4Mg_0urKnI-unsplash.jpg', 1, 'ef6FxTn3I8C9', '', '2024-08-18', 6),
(15, 'isaac@gmail.com', '$2y$10$y4GW1ASNADa4Ydtho8a4k.AOEAZ7YtvV6ljIKcslJ031mFGUNspty', 0, 'Isaac', 'Winner', '', '', '', 1, '1AeruKhZgpy5', '', '2024-08-19', NULL),
(16, 'jelica@gmail.com', '$2y$10$amiQTCx5NGk.XU6pRAw9Ber7mClMEeuRLrCwIQZuppoo2errAD7FK', 0, 'Jelica', 'Panzuelo', 'bagtas tanzza cavite\r\n', '09509181094', 'WIN_20240827_16_17_05_Pro.jpg', 1, 'o1WvF7zH5Cqb', '', '2024-08-21', 26),
(17, 'norly@gmail.com', '$2y$10$.PE3b8uN0Lg94NbX81Xyye0GNWe1Rv90OjzMqwHPB3ofNw.ylCHpO', 0, 'Norly', 'Villanueva', '', '', '', 1, 'jk3MgBnpwNfl', '', '2024-09-02', 8),
(18, 'tmc.isaac.manalo@cvsu.edu.ph', '$2y$10$E1dcolBDwQY9eaulB83zbeMuEheY6xoaf/OLMPwNYW1YK05S.lL2u', 0, 'Bisaac', 'Manalo', '', '09509181094', 'isaac.jpg', 1, 'd6HSvi5Qxjh2', '', '2024-09-03', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `details`
--
ALTER TABLE `details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `address_id` (`address_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `address_id` (`address_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `details`
--
ALTER TABLE `details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `address_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`);

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
