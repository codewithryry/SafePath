-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Oct 26, 2024 at 01:20 AM
-- Server version: 8.2.0
-- PHP Version: 8.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `safepath`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
CREATE TABLE IF NOT EXISTS `admins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`, `created_at`) VALUES
(1, 'guidanceoffice@gmail.com', 'guidanceoffice', '2024-10-25 11:38:47');

-- --------------------------------------------------------

--
-- Table structure for table `complaints`
--

DROP TABLE IF EXISTS `complaints`;
CREATE TABLE IF NOT EXISTS `complaints` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `student_id` varchar(50) DEFAULT NULL,
  `department` varchar(100) NOT NULL,
  `issue_type` varchar(100) NOT NULL,
  `issue_description` text NOT NULL,
  `contact_method` varchar(50) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `other_department` varchar(100) DEFAULT NULL,
  `other_contact_method` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('pending','in_progress','resolved','rejected') DEFAULT 'pending',
  `severity` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `complaints`
--

INSERT INTO `complaints` (`id`, `name`, `email`, `student_id`, `department`, `issue_type`, `issue_description`, `contact_method`, `phone_number`, `other_department`, `other_contact_method`, `created_at`, `status`, `severity`) VALUES
(8, 'jkscna', 'luamark@gmail.com', 'MCC2021-0333', 'CCJE', 'guidance', 'help', 'email', '', '', '', '2024-10-25 15:33:43', 'pending', NULL),
(7, 'Kayc Arejola', 'arejolakayc@gmail.com', 'MCC2021-0343', 'CCS', 'bullying', 'need help', 'email', '', '', '', '2024-10-25 15:32:55', 'pending', NULL),
(6, '', 'mislangreymel12@gmail.com', 'MCC2021-0345', 'CAS', 'guidance', 'Can you help me', 'email', '', '', '', '2024-10-25 13:04:52', 'pending', NULL),
(5, 'Ken Mislang', 'mislangreymel6@gmail.com', 'MCC20210344', 'CCS', 'bullying', 'dfasifhdsofhdusfgdwf', 'email', '', '', '', '2024-10-25 13:03:42', 'pending', NULL),
(9, 'Darllyd Tupaz', 'texsun16@gmail.com', 'MCC2021-0344', 'CBM', 'guidance', 'Someone harras me', 'email', '', '', '', '2024-10-26 01:10:36', 'pending', NULL),
(10, 'Emmanuel Calica', 'arawarawholiday@gmail.com', 'MCC2021-0333', 'CAS', 'technical', 'I feel threatened and unsafe.', 'email', '', '', '', '2024-10-26 01:16:49', 'pending', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
CREATE TABLE IF NOT EXISTS `feedback` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `feedback` text NOT NULL,
  `rating` int DEFAULT NULL,
  `suggestions` text,
  `recommend` enum('yes','no','maybe') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
