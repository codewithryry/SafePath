-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 01, 2024 at 11:57 AM
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
-- Table structure for table `about_us`
--

DROP TABLE IF EXISTS `about_us`;
CREATE TABLE IF NOT EXISTS `about_us` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `alt_text` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
  `reset_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`, `created_at`, `reset_token`) VALUES
(1, 'guidanceoffice@gmail.com', '$2b$10$UiyXl5RVzsruDdszlsLsh.VUr3zvElz8E59Apw3gI3B8KAdCZ6H9u', '2024-10-25 11:38:47', NULL),
(5, 'admin@admin', '$2b$10$bpftu/7gxvnQuO19z1PJBeh./UyW4RBm99T99t4KAlU5LMuYDoHi.', '2024-11-01 11:41:18', NULL),
(3, 'guidanceoffice123@gmail.com', '$2b$10$966GTzQ90C3R66K3Ixlwquo2zAPIVZN8JZkRX7DVZzksVI.zd1hU6', '2024-11-01 04:44:14', '048ef59037e3d0a231fa9b313ea4e64081d013b4'),
(4, 'luamark@gmail.com', '$2b$10$Nkkihx/Yjn/x2ym1dqzu4eBBebeyQ46SYEZc.jH1mRFQDpqrN46Va', '2024-11-01 05:52:38', NULL);

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
  `year_level` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `complaints`
--

INSERT INTO `complaints` (`id`, `name`, `email`, `student_id`, `department`, `issue_type`, `issue_description`, `contact_method`, `phone_number`, `other_department`, `other_contact_method`, `created_at`, `status`, `severity`, `year_level`) VALUES
(28, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'MCC2021-0345', 'CCJE', 'guidance', 'harassing me', 'email', '', '', '', '2024-10-26 07:43:40', 'resolved', NULL, '4'),
(31, '', 'gwenbasconcill0@gmail.com', 'MCC2022-0312', 'CTE', 'bullying', 'kldjwqihfwifhufhewufgf', 'email', '', '', '', '2024-11-01 05:57:23', 'rejected', NULL, '1'),
(32, 'Rommel Mislang', 'rommelmislang49@gmail.com', 'mcc2023-2322', 'CAS', 'guidance', 'ocvhcjdscnx', 'email', '', '', '', '2024-11-01 05:58:23', 'rejected', NULL, '2'),
(27, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'MCC2021-0345', 'CBM', 'guidance', 'harassing me', 'email', '', '', '', '2024-10-26 07:43:31', 'rejected', NULL, '3'),
(30, 'Gwen Basconcillo', 'gwenbasconcillo11@gmail.com', 'MCC2022-0368', 'CCS', 'bullying', 'PANGIT RAW AKO', 'email', '', '', '', '2024-10-29 03:23:44', 'resolved', NULL, '3'),
(29, 'Mark Lua', 'marklua@gmail.com', 'MCC20210344', 'CCJE', 'technical', 'wklqdhp', 'email', '', '', '', '2024-10-28 15:50:16', 'rejected', NULL, '4');

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

DROP TABLE IF EXISTS `faqs`;
CREATE TABLE IF NOT EXISTS `faqs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question` varchar(255) NOT NULL,
  `answer` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `faqs`
--

INSERT INTO `faqs` (`id`, `question`, `answer`) VALUES
(1, 'What is the purpose of this FAQ?', 'This FAQ section helps answer common questions.'),
(2, 'How can I contact support?', 'You can contact support via email or through our contact form.'),
(3, 'Who will have access to my report?', 'Only authorized personnel, such as the guidance office and school administrators, will have access to your report.'),
(4, 'Can I report other forms of harassment or threats?', 'Yes, our platform allows you to report any form of harassment, threats, or abusive behavior for further investigation.');

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

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `name`, `email`, `feedback`, `rating`, `suggestions`, `recommend`, `created_at`) VALUES
(1, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'im good to this', 4, 'nothing', 'yes', '2024-10-26 02:17:18'),
(2, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'im good to this', 4, 'nothing', 'yes', '2024-10-26 02:20:31'),
(3, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'im good to this', 4, 'nothing', 'yes', '2024-10-26 02:20:44'),
(4, 'Kayc Arejola', 'arejolakayc@gmail.com', 'PANGET', 3, 'GOOD AS NEW', 'maybe', '2024-10-26 05:54:38'),
(5, 'jkscna', 'luamark@gmail.com', 'dzffdff', 5, 'dfdfgvdfcvx', 'no', '2024-10-26 06:27:02'),
(6, 'james nitura', 'arejolakayc@gmail.com', 'im good to this', 3, 'nothing', 'yes', '2024-10-26 06:38:13'),
(7, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'panget gui', 1, 'kwdwiuvhdsbewf', 'yes', '2024-11-01 05:56:15'),
(8, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'skdahdshdc', 2, 'csmncc', 'no', '2024-11-01 07:18:29');

-- --------------------------------------------------------

--
-- Table structure for table `why_we_are_here`
--

DROP TABLE IF EXISTS `why_we_are_here`;
CREATE TABLE IF NOT EXISTS `why_we_are_here` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `paragraph1` text,
  `paragraph2` text,
  `paragraph3` text,
  `video_link` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `why_we_are_here`
--

INSERT INTO `why_we_are_here` (`id`, `title`, `paragraph1`, `paragraph2`, `paragraph3`, `video_link`) VALUES
(1, 'Why We Are Here', 'SafePath provides a secure platform for students to report bullying incidents and seek support. Our goal is to create a safe, inclusive environment where every student feels protected and heard.\n', 'Bullying can lead to serious mental health issues, including anxiety, depression, and even suicide. By understanding its impact, we can work together to build a culture of empathy and safety.', 'Watch the video below to learn more about the effects of bullying and how we can combat it.', 'https://www.youtube.com/embed/YyDJafzuUK4');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
