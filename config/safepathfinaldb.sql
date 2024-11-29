-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 28, 2024 at 08:46 AM
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
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`, `created_at`, `reset_token`) VALUES
(1, 'guidanceoffice@gmail.com', '$2b$10$cgfN/VzcAyiBjgkXmqn0NOzL7vjMKjSWCVOQcBuCysa6yW.YnTwY2', '2024-10-25 11:38:47', 'df119308bf04067e6d8a53f340b1037a1c9385ff');

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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('pending','in_progress','resolved','rejected') DEFAULT 'pending',
  `year_level` varchar(10) DEFAULT NULL,
  `sentiment` enum('mild','severe','normal') NOT NULL DEFAULT 'normal',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `complaints`
--

INSERT INTO `complaints` (`id`, `name`, `email`, `student_id`, `department`, `issue_type`, `issue_description`, `contact_method`, `phone_number`, `other_department`, `other_contact_method`, `created_at`, `status`, `severity`, `year_level`, `sentiment`) VALUES
(60, 'John Doe', 'johndoe@example.com', 'MCC2021-001', 'CAS', 'bullying', 'Been constantly taunted by a group in class.', 'email', '09123456789', NULL, NULL, '2024-09-05 01:15:00', 'in_progress', 'mild', '2', ''),
(61, 'Jane Smith', 'janesmith@example.com', 'MCC2021-002', 'CCS', 'harassment', 'Received inappropriate comments from classmates.', 'phone', '09123456780', NULL, NULL, '2024-09-10 02:30:00', 'in_progress', 'severe', '3', ''),
(62, 'James Brown', 'jamesbrown@example.com', 'MCC2021-003', 'CCJE', 'bullying', 'Pushed by a fellow student during a lecture.', 'email', '09123456781', NULL, NULL, '2024-09-15 03:45:00', 'resolved', 'moderate', '4', ''),
(55, 'Reymel R Mislang', 'reymelrey.mislang@gmail.com', 'MCC2021-0334', 'CAS', 'bullying', 'I’ve been continuously bullied by a group of students in my class, and the school refuses to take any action. It’s making me feel worthless and unsafe. I can\'t go to school anymore because I fear for my mental and physical well-being. I’ve reached out to the guidance office multiple times, but nothing is being done about it!', 'email', '', '', '', '2024-11-25 15:33:42', 'rejected', NULL, '4', 'severe'),
(54, 'Erika Joy', 'erika@gmail.com', 'MCC2021-0321', 'CCS', 'guidance', 'I’ve been continuously bullied by a group of students in my class, and the school refuses to take any action. It’s making me feel worthless and unsafe. I can\'t go to school anymore because I fear for my mental and physical well-being. I’ve reached out to the guidance office multiple times, but nothing is being done about it!', 'email', '', '', '', '2024-11-25 15:28:45', 'in_progress', NULL, '1', 'normal'),
(63, 'Sara Davis', 'saradavis@example.com', 'MCC2021-004', 'CTE', 'bullying', 'Targeted by a group of students in the cafeteria.', 'email', '09123456782', NULL, NULL, '2024-09-20 04:00:00', 'in_progress', 'severe', '1', ''),
(64, 'Michael Miller', 'michaelmiller@example.com', 'MCC2021-005', 'CAS', 'harassment', 'Teased about my academic performance in front of class.', 'phone', '09123456783', NULL, NULL, '2024-09-25 06:10:00', 'in_progress', 'mild', '2', ''),
(58, 'Raemae Mistal', 'raemae@gmail.com', 'MCC2021-0343', 'CCJE', 'bullying', 'Can you help me i got been called by my classmate a God like feature a daughter of God it offended me ', 'email', '', '', '', '2024-11-28 06:52:27', 'in_progress', NULL, '2', 'normal'),
(59, 'Juluis Castillo', 'castillojuluis@gmail.com', 'MCC2021-0332', 'CBM', 'bullying', 'I got hit by my friend', 'email', '', '', '', '2024-11-28 07:52:59', 'in_progress', NULL, '4', 'mild'),
(57, 'Gwen Basconcillo', 'gwenbasconcill0@gmail.com', 'MCC2021-0333', 'CTE', 'bullying', 'I\' ve noticed a recurring issue that’s been a bit frustrating, and I’d appreciate it if someone could address it soon.', 'email', '', '', '', '2024-11-25 15:54:25', 'resolved', NULL, '3', 'mild'),
(65, 'Olivia Wilson', 'oliviawilson@example.com', 'MCC2021-006', 'CCS', 'bullying', 'Mocked by a student for my appearance.', 'email', '09123456784', NULL, NULL, '2024-10-01 01:20:00', 'resolved', 'mild', '3', ''),
(66, 'Ethan Clark', 'ethanclark@example.com', 'MCC2021-007', 'CCJE', 'harassment', 'Subjected to discriminatory remarks during a group project.', 'email', '09123456785', NULL, NULL, '2024-10-03 03:00:00', 'resolved', 'moderate', '4', ''),
(67, 'Sophia Martinez', 'sophiamartinez@example.com', 'MCC2021-008', 'CTE', 'bullying', 'Constantly excluded from group activities by classmates.', 'phone', '09123456786', NULL, NULL, '2024-10-05 05:30:00', 'in_progress', 'mild', '2', ''),
(68, 'Liam Robinson', 'liamrobinson@example.com', 'MCC2021-009', 'CAS', 'harassment', 'Made fun of for my accent during a speech presentation.', 'email', '09123456787', NULL, NULL, '2024-10-10 06:40:00', 'resolved', 'severe', '3', ''),
(69, 'Ava Young', 'avayoung@example.com', 'MCC2021-010', 'CCS', 'bullying', 'Students make hurtful jokes about my family situation.', 'phone', '09123456788', NULL, NULL, '2024-10-12 07:55:00', 'resolved', 'moderate', '4', ''),
(70, 'Isabella Thomas', 'isabellathomas@example.com', 'MCC2021-011', 'CCJE', 'harassment', 'A fellow student often mocks my work in front of the class.', 'email', '09123456789', NULL, NULL, '2024-10-15 08:25:00', 'in_progress', 'mild', '2', ''),
(71, 'Benjamin Lee', 'benjaminlee@example.com', 'MCC2021-012', 'CTE', 'bullying', 'Fellow students have been bullying me about my attire.', 'phone', '09123456790', NULL, NULL, '2024-10-20 09:00:00', 'resolved', 'mild', '1', ''),
(72, 'Mason Harris', 'masonharris@example.com', 'MCC2021-013', 'CAS', 'harassment', 'Classmates often ridicule me about my personal life.', 'email', '09123456791', NULL, NULL, '2024-10-25 10:15:00', 'in_progress', 'moderate', '3', ''),
(73, 'Charlotte Scott', 'charlottescott@example.com', 'MCC2021-014', 'CCS', 'bullying', 'Humiliated by students in the hallway for no reason.', 'phone', '09123456792', NULL, NULL, '2024-11-01 01:35:00', 'in_progress', 'severe', '4', ''),
(74, 'Lucas Perez', 'lucasperez@example.com', 'MCC2021-015', 'CCJE', 'harassment', 'Unwanted comments about my appearance from a classmate.', 'email', '09123456793', NULL, NULL, '2024-11-03 02:50:00', 'resolved', 'mild', '2', ''),
(75, 'Grace Evans', 'graceevans@example.com', 'MCC2021-016', 'CTE', 'bullying', 'A group of students frequently calls me names during breaks.', 'phone', '09123456794', NULL, NULL, '2024-11-05 03:00:00', 'in_progress', 'severe', '1', ''),
(76, 'Henry King', 'henryking@example.com', 'MCC2021-017', 'CAS', 'harassment', 'Ridiculed for my cultural background during group work.', 'email', '09123456795', NULL, NULL, '2024-11-08 04:00:00', 'in_progress', 'moderate', '3', ''),
(77, 'Ella Green', 'ellagreen@example.com', 'MCC2021-018', 'CCS', 'bullying', 'I was pushed and shoved in the hallway.', 'phone', '09123456796', NULL, NULL, '2024-11-10 05:10:00', 'resolved', 'moderate', '2', ''),
(78, 'Amelia Wright', 'ameliawright@example.com', 'MCC2021-019', 'CCJE', 'harassment', 'Often stared at and belittled in front of others.', 'email', '09123456797', NULL, NULL, '2024-11-12 06:20:00', 'in_progress', 'severe', '4', ''),
(79, 'Zoe Adams', 'zoeadams@example.com', 'MCC2021-020', 'CTE', 'bullying', 'A group of students has been calling me names every day.', 'phone', '09123456798', NULL, NULL, '2024-11-15 07:30:00', 'resolved', 'mild', '2', '');

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
(13, 'Gwen Basconcillo', 'gwen@gmail.com', 'The website is cool', 3, '', 'yes', '2024-11-09 01:46:46', NULL),
(12, 'Erika Joy ', 'erika@finaltesting.com', 'Nice', 4, '', 'yes', '2024-11-09 01:25:39', NULL),
(15, 'Reymel Mislang', 'reymelrey.mislang@gmail.com', 'So Clean So Good', 5, '', 'yes', '2024-11-26 23:50:23', NULL);

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
