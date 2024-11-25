-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 17, 2024 at 07:14 AM
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
  `reset_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`, `created_at`, `reset_token`) VALUES
(1, 'guidanceoffice@gmail.com', '$2b$10$cgfN/VzcAyiBjgkXmqn0NOzL7vjMKjSWCVOQcBuCysa6yW.YnTwY2', '2024-10-25 11:38:47', 'df119308bf04067e6d8a53f340b1037a1c9385ff'),
(5, 'admin@admin', '$2b$10$bpftu/7gxvnQuO19z1PJBeh./UyW4RBm99T99t4KAlU5LMuYDoHi.', '2024-11-01 11:41:18', NULL),
(3, 'guidanceoffice123@gmail.com', '$2b$10$966GTzQ90C3R66K3Ixlwquo2zAPIVZN8JZkRX7DVZzksVI.zd1hU6', '2024-11-01 04:44:14', '1bdaaea479c5ea62335365e577c789421697e39f'),
(15, 'sakodkhidsds@GMAIL.COM', '$2b$10$XR9cj3X1aBFGfn5LuBqn1.ZIQjmjZg1497yGSK7ocLLWr.SdTZDp2', '2024-11-17 04:34:02', NULL),
(16, 'guidanceoffice23@gmail.com', '$2b$10$FxvWTY0OErjk7nzG7lvVqO41IA2qY7a97krvpvqR1yBt2TspPv.uq', '2024-11-17 05:13:35', NULL),
(12, 'guidanceoffice12345@gmail.com', '$2b$10$RU/knyzcEWgjMwxooAWbduXEsbxaVaSo5h0Ehj8zKmr.Y1aFmTF4C', '2024-11-09 01:53:22', NULL),
(11, 'guidanceoffice1234@gmail.com', '$2b$10$6dYc1jsP9/uJanSha.Hiau2UXPxk8S6gLUJaVXeI1ydz.v0aHMoey', '2024-11-09 01:42:35', NULL),
(14, 'guidanceoffice34@gmail.com', '$2b$10$SjU3MqTO1IsYsPByDHctzuWHLlk2644Zlzgpsp484sOhsbKoNDsQG', '2024-11-17 04:27:18', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `advocacy`
--

DROP TABLE IF EXISTS `advocacy`;
CREATE TABLE IF NOT EXISTS `advocacy` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `goals` text,
  `how_to_help` text,
  `author` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `advocacy`
--

INSERT INTO `advocacy` (`id`, `title`, `description`, `goals`, `how_to_help`, `author`, `created_at`, `updated_at`) VALUES
(1, 'SafePath Advocacy', 'At SafePath, we are committed to advocating for a safe and supportive environment for all students. Our mission is to raise awareness about bullying and promote resources that help students seek assistance and report incidents effectively.', '[\r\n        \"Raise awareness about bullying and its impacts on mental health.\",\r\n        \"Provide resources and support for victims of bullying.\",\r\n        \"Encourage open communication between students and school authorities.\",\r\n        \"Foster a culture of kindness and respect within the educational community.\"\r\n    ]', '[\r\n        \"Participate in awareness campaigns and events.\",\r\n        \"Share your story to inspire others.\",\r\n        \"Volunteer with local organizations focused on bullying prevention.\",\r\n        \"Spread the word about SafePath and our mission.\"\r\n    ]', 'Reymel Rey Mislang', '2024-11-17 06:28:06', '2024-11-17 06:28:06');

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
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `complaints`
--

INSERT INTO `complaints` (`id`, `name`, `email`, `student_id`, `department`, `issue_type`, `issue_description`, `contact_method`, `phone_number`, `other_department`, `other_contact_method`, `created_at`, `status`, `severity`, `year_level`) VALUES
(38, 'Kayc Arejola', 'arejolakayc@gmail.com', 'MCC2021-0333', 'CCJE', 'guidance', 'Call me kayc\r\n', 'email', '', '', '', '2024-11-02 01:41:59', 'in_progress', NULL, '3'),
(37, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'MCC2021-0344', 'CBM', 'bullying', 'bading daw ako sabi ni sir ', 'email', '', '', '', '2024-11-02 01:39:57', 'rejected', NULL, '3'),
(45, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'MCC2021-0334', 'Other', 'bullying', 'OJDWADHIDHS', 'email', '', 'BTVED', '', '2024-11-11 12:50:11', 'in_progress', NULL, '4'),
(39, 'Matthew Balinton', 'bagnetpares@gmail.com', 'MCC2021-0345', 'CCS', 'guidance', 'sadasdSA', 'email', '', '', '', '2024-11-02 01:42:35', 'rejected', NULL, '1'),
(40, 'Harlyn Nebreja', 'bagnetpares@gmail.com', 'MCC2021-0345', 'CCJE', 'bullying', 'SDSREWE4Q32', 'email', '', '', '', '2024-11-02 01:52:09', 'rejected', NULL, '2'),
(41, 'Darllyd Tupaz', 'texsun16@gmail.com', 'MCC2021-0343', 'CTE', 'technical', 'ZDxSADDQ3RERDFWFE', 'email', '', '', '', '2024-11-02 02:01:39', 'rejected', NULL, '3'),
(42, '', 'texsun16@gmail.com', 'MCC2021-0327', 'CCS', 'bullying', 'I got bully ', 'email', '', '', '', '2024-11-09 01:23:18', 'in_progress', NULL, '2'),
(43, '', 'harshid.vasoya2827@gmail.com', 'MCC2021-0322', 'CAS', 'bullying', 'I got bully on my friend', 'email', '', '', '', '2024-11-09 01:44:59', 'pending', NULL, '3'),
(44, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'MCC2021-0334', 'CCS', 'bullying', 'I got bully ', 'email', '', '', '', '2024-11-09 01:56:14', 'in_progress', NULL, '3');

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

DROP TABLE IF EXISTS `faqs`;
CREATE TABLE IF NOT EXISTS `faqs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question` varchar(255) DEFAULT NULL,
  `answer` text NOT NULL,
  `question_hash` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_question_hash` (`question_hash`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `faqs`
--

INSERT INTO `faqs` (`id`, `question`, `answer`, `question_hash`) VALUES
(1, 'What is the purpose of this FAQ?', 'This FAQ section helps answer common questions.', 'ea9242fc850808a240a2739c2ec46dbd'),
(2, 'How can I contact support?', 'You can contact support via email or through our contact form.', 'a345d728267e55bb4992f848b7b95247'),
(3, 'Who will have access to my report?', 'Only authorized personnel, such as the guidance office and school administrators, will have access to your report.', 'c1c4d5c4e148955c940cc8dade27674e'),
(4, 'Can I report other forms of harassment or threats?', 'Yes, our platform allows you to report any form of harassment, threats, or abusive behavior for further investigation.', '1b832109007c137b8127241d1d83dbe2'),
(15, 'What is SafePath?', 'SafePath is a platform that allows students to anonymously report bullying incidents and receive support through our integrated chatbot.', 'eafd791e65a466ac412acf61c164eaaf');

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
  `department` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `name`, `email`, `feedback`, `rating`, `suggestions`, `recommend`, `created_at`, `department`) VALUES
(13, 'Erika Joy ', 'erika@finaltesting.com', 'Good Morning the website is cool', 3, '', 'yes', '2024-11-09 01:46:46', NULL),
(12, 'Erika Joy ', 'erika@finaltesting.com', 'Good Morning Sir ayus na po ba?', 4, '', 'yes', '2024-11-09 01:25:39', NULL),
(11, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'The system has a clean and approachable design, which makes me feel comfortable navigating through it. The clear call-to-action buttons and the simple layout on each page help me focus on the tasks I want to accomplish without feeling overwhelmed.', 5, 'Introduce gamification elements that encourage users to engage with the platform, such as completing informational modules or participating in awareness campaigns, potentially earning rewards for participation.', 'yes', '2024-11-02 01:33:20', NULL);

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
