-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 15, 2024 at 03:30 PM
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
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`, `created_at`, `reset_token`) VALUES
(1, 'guidanceoffice@gmail.com', '$2b$10$cgfN/VzcAyiBjgkXmqn0NOzL7vjMKjSWCVOQcBuCysa6yW.YnTwY2', '2024-10-25 11:38:47', 'df119308bf04067e6d8a53f340b1037a1c9385ff'),
(21, 'mislangreymel6@gmail.com', '$2b$10$1DyJEx/Lqq2IaMAYMsv53.a3JzTcXDrE6yUbyR8fJEQRax0dF3LFu', '2024-11-30 07:13:37', NULL),
(19, 'gwenbasconcillo11@gmail.com', '$2b$10$c1K2wHCAZRc9hB62cYjLLuhCIrADcf2L59ucz6srvXNlV8Jdg8kPi', '2024-11-28 10:33:16', NULL),
(20, 'reymelrey.mislang@gmail.com', '$2b$10$iTWD2JcNzs2tS496h8D0OO6srWCK2DyfOagnQ9YAcTyRuy38tmpre', '2024-11-29 10:14:56', NULL);

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
  `sentiment` enum('mild','severe','normal') NOT NULL DEFAULT 'normal',
  `accuracy` float NOT NULL DEFAULT '0',
  `Role` varchar(255) NOT NULL DEFAULT 'User',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=359 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `complaints`
--

INSERT INTO `complaints` (`id`, `name`, `email`, `student_id`, `department`, `issue_type`, `issue_description`, `contact_method`, `phone_number`, `other_department`, `other_contact_method`, `created_at`, `status`, `severity`, `year_level`, `sentiment`, `accuracy`, `Role`) VALUES
(261, 'Ava Robinson', 'avar@example.com', 'MCC2021-019', 'CCS', 'classroom issue', 'Poor air circulation in the lecture room affecting concentration.', 'phone', NULL, NULL, NULL, '2023-10-18 16:00:00', 'resolved', NULL, '3', 'mild', 0, 'User'),
(262, 'Sebastian Adams', 'sebastiana@example.com', 'MCC2021-020', 'CAS', 'academic misconduct', 'Suspects cheating during a final exam in History.', 'email', NULL, NULL, NULL, '2023-10-19 16:00:00', 'resolved', NULL, '4', 'normal', 0, 'User'),
(263, 'James Turner', 'jamest@example.com', 'MCC2021-021', 'CTE', 'bullying', 'Targeted online harassment through social media by peers.', 'email', NULL, NULL, NULL, '2023-10-20 16:00:00', 'pending', NULL, '2', 'severe', 0, 'User'),
(264, 'Harper Lee', 'harperl@example.com', 'MCC2021-022', 'CCJE', 'grade dispute', 'Claims that grades on an exam were graded unfairly.', 'phone', NULL, NULL, NULL, '2023-10-21 16:00:00', 'in_progress', NULL, '1', 'normal', 0, 'User'),
(265, 'Jack Wilson', 'jackw@example.com', 'MCC2021-023', 'CCS', 'bullying', 'Inappropriate jokes about appearance and behavior in class.', 'email', NULL, NULL, NULL, '2023-10-22 16:00:00', 'resolved', NULL, '3', 'mild', 0, 'User'),
(258, 'Charlotte King', 'charlottek@example.com', 'MCC2021-016', 'CCS', 'academic misconduct', 'Caught a classmate plagiarizing during a written exam.', 'email', NULL, NULL, NULL, '2023-10-15 16:00:00', 'in_progress', NULL, '4', 'mild', 0, 'User'),
(259, 'Amelia Perez', 'ameliap@example.com', 'MCC2021-017', 'CCJE', 'harassment', 'Threatened by a group of students in the hallway.', 'phone', NULL, NULL, NULL, '2023-10-16 16:00:00', 'pending', NULL, '2', 'severe', 0, 'User'),
(260, 'Ethan Garcia', 'ethang@example.com', 'MCC2021-018', 'CAS', 'bullying', 'Bullied for being outspoken during class discussions.', 'email', NULL, NULL, NULL, '2023-10-17 16:00:00', 'in_progress', NULL, '1', 'normal', 0, 'User'),
(257, 'Benjamin Scott', 'benjamins@example.com', 'MCC2021-015', 'CBM', 'technical issue', 'Facing login issues on the student portal for weeks.', 'email', NULL, NULL, NULL, '2023-10-14 16:00:00', 'resolved', NULL, '2', 'normal', 0, 'User'),
(254, 'Isabella Moore', 'isabellam@example.com', 'MCC2021-012', 'CCS', 'bullying', 'Verbal abuse from a group of students in the lab.', 'phone', NULL, NULL, NULL, '2023-10-11 16:00:00', 'pending', NULL, '2', 'severe', 0, 'User'),
(255, 'Lucas Walker', 'lucasw@example.com', 'MCC2021-013', 'CTE', 'classroom issue', 'Uncomfortable seating arrangement in the lecture hall.', 'email', NULL, NULL, NULL, '2023-10-12 16:00:00', 'in_progress', NULL, '1', 'mild', 0, 'User'),
(256, 'Mia White', 'miaw@example.com', 'MCC2021-014', 'CTE', 'bullying', 'Being ridiculed by classmates during group presentations.', 'phone', NULL, NULL, NULL, '2023-10-13 16:00:00', 'pending', NULL, '3', 'normal', 0, 'User'),
(252, 'Sophia Martinez', 'sophiam@example.com', 'MCC2021-010', 'CAS', 'harassment', 'Being targeted by a professor for personal reasons.', 'email', NULL, NULL, NULL, '2023-10-09 16:00:00', 'in_progress', NULL, '1', 'severe', 0, 'User'),
(253, 'Daniel Thomas', 'danielt@example.com', 'MCC2021-011', 'CCS', 'technical issue', 'Unable to access important course materials on the portal.', 'email', NULL, NULL, NULL, '2023-10-10 16:00:00', 'resolved', NULL, '3', 'normal', 0, 'User'),
(251, 'William Harris', 'williamh@example.com', 'MCC2021-009', 'CCJE', 'academic misconduct', 'Witnessed another student cheating during the exam.', 'phone', NULL, NULL, NULL, '2023-10-08 16:00:00', 'in_progress', NULL, '4', 'normal', 0, 'User'),
(250, 'Sarah Clark', 'sarahc@example.com', 'MCC2021-008', 'CCJE', 'grade dispute', 'Believes a grade on the Criminal Law exam was unfairly given.', 'email', NULL, NULL, NULL, '2023-10-07 16:00:00', 'resolved', NULL, '2', 'mild', 0, 'User'),
(249, 'Michael Wilson', 'michaelw@example.com', 'MCC2021-007', 'CBM', 'bullying', 'Exclusion from group projects and activities.', 'phone', NULL, NULL, NULL, '2023-10-06 16:00:00', 'in_progress', NULL, '3', 'normal', 0, 'User'),
(248, 'Olivia Brown', 'oliviab@example.com', 'MCC2021-006', 'CBM', 'harassment', 'Repeatedly receiving unwanted messages from a classmate.', 'email', NULL, NULL, NULL, '2023-10-05 16:00:00', 'pending', NULL, '4', 'severe', 0, 'User'),
(247, 'Chris Lee', 'chrisl@example.com', 'MCC2021-005', 'CTE', 'classroom issue', 'Overcrowded classrooms making it hard to focus.', 'phone', NULL, NULL, NULL, '2023-10-04 16:00:00', 'resolved', NULL, '2', 'normal', 0, 'User'),
(246, 'Emily Davis', 'emilyd@example.com', 'MCC2021-004', 'CAS', 'bullying', 'Targeted by peers for not fitting in socially.', 'email', NULL, NULL, NULL, '2023-10-03 16:00:00', 'in_progress', NULL, '1', 'mild', 0, 'User'),
(245, 'Alex Johnson', 'alexj@example.com', 'MCC2021-003', 'CAS', 'grade dispute', 'Disagreement over final exam grades in Psychology.', 'email', NULL, NULL, NULL, '2023-10-02 16:00:00', 'resolved', NULL, '3', 'normal', 0, 'User'),
(244, 'Jane Smith', 'janesmith@example.com', 'MCC2021-002', 'CCS', 'harassment', 'Received inappropriate comments from a professor.', 'phone', NULL, NULL, NULL, '2023-10-01 16:00:00', 'pending', NULL, '2', 'severe', 0, 'User'),
(243, 'John Doe', 'johndoe@example.com', 'MCC2021-001', 'CCS', 'bullying', 'Been constantly taunted by a group in class.', 'email', NULL, NULL, NULL, '2023-09-30 16:00:00', 'in_progress', NULL, '1', 'normal', 0, 'User'),
(242, 'Max Anderson', 'maxa@example.com', 'MCC2021-033', 'CTE', 'grade dispute', 'Disagreement over the evaluation of an internship project.', 'email', NULL, NULL, NULL, '2023-10-02 16:00:00', 'pending', NULL, '3', 'mild', 0, 'User'),
(241, 'Charlotte Green', 'charlotteg@example.com', 'MCC2021-032', 'CAS', 'harassment', 'Verbal abuse from a professor about personal beliefs.', 'phone', NULL, NULL, NULL, '2023-10-01 16:00:00', 'resolved', NULL, '4', 'normal', 0, 'User'),
(240, 'Liam Robinson', 'liamr@example.com', 'MCC2021-031', 'CCS', 'bullying', 'Being excluded from study groups and peer interactions.', 'email', NULL, NULL, NULL, '2023-09-30 16:00:00', 'in_progress', NULL, '1', 'severe', 0, 'User'),
(239, 'Nina Clark', 'ninac@example.com', 'MCC2021-030', 'CCJE', 'technical issue', 'Struggled with accessing online course materials.', 'phone', NULL, NULL, NULL, '2023-09-29 16:00:00', 'resolved', NULL, '2', 'normal', 0, 'User'),
(236, 'Grace Lee', 'gracel@example.com', 'MCC2021-027', 'CCS', 'classroom issue', 'Difficulty hearing the lectures due to noise from outside.', 'email', NULL, NULL, NULL, '2023-09-26 16:00:00', 'in_progress', NULL, '3', 'mild', 0, 'User'),
(238, 'Zara Mitchell', 'zarap@example.com', 'MCC2021-029', 'CAS', 'grade dispute', 'Felt that the grade on the midterm was unfairly low.', 'email', NULL, NULL, NULL, '2023-09-28 16:00:00', 'in_progress', NULL, '4', 'mild', 0, 'User'),
(237, 'Leo Allen', 'leoa@example.com', 'MCC2021-028', 'CBM', 'bullying', 'Subjected to derogatory remarks and name-calling by classmates.', 'phone', NULL, NULL, NULL, '2023-09-27 16:00:00', 'pending', NULL, '2', 'normal', 0, 'User'),
(235, 'Mason Carter', 'masonc@example.com', 'MCC2021-026', 'CCJE', 'harassment', 'Inappropriate behavior from a professor in class.', 'phone', NULL, NULL, NULL, '2023-09-25 16:00:00', 'resolved', NULL, '2', 'normal', 0, 'User'),
(234, 'Zoe Harris', 'zoeh@example.com', 'MCC2021-025', 'CAS', 'bullying', 'Intimidation from a group of classmates during exams.', 'email', NULL, NULL, NULL, '2023-09-24 16:00:00', 'pending', NULL, '4', 'severe', 0, 'User'),
(233, 'Lily Walker', 'lilyw@example.com', 'MCC2021-024', 'CBM', 'technical issue', 'Experiencing issues with submitting assignments online.', 'phone', NULL, NULL, NULL, '2023-09-23 16:00:00', 'in_progress', NULL, '2', 'normal', 0, 'User'),
(232, 'Jack Wilson', 'jackw@example.com', 'MCC2021-023', 'CCS', 'bullying', 'Inappropriate jokes about appearance and behavior in class.', 'email', NULL, NULL, NULL, '2023-09-22 16:00:00', 'resolved', NULL, '3', 'mild', 0, 'User'),
(231, 'Harper Lee', 'harperl@example.com', 'MCC2021-022', 'CCJE', 'grade dispute', 'Claims that grades on an exam were graded unfairly.', 'phone', NULL, NULL, NULL, '2023-09-21 16:00:00', 'in_progress', NULL, '1', 'normal', 0, 'User'),
(230, 'James Turner', 'jamest@example.com', 'MCC2021-021', 'CTE', 'bullying', 'Targeted online harassment through social media by peers.', 'email', NULL, NULL, NULL, '2023-09-20 16:00:00', 'pending', NULL, '2', 'severe', 0, 'User'),
(229, 'Sebastian Adams', 'sebastiana@example.com', 'MCC2021-020', 'CAS', 'academic misconduct', 'Suspects cheating during a final exam in History.', 'email', NULL, NULL, NULL, '2023-09-19 16:00:00', 'resolved', NULL, '4', 'normal', 0, 'User'),
(228, 'Ava Robinson', 'avar@example.com', 'MCC2021-019', 'CCS', 'classroom issue', 'Poor air circulation in the lecture room affecting concentration.', 'phone', NULL, NULL, NULL, '2023-09-18 16:00:00', 'resolved', NULL, '3', 'mild', 0, 'User'),
(225, 'Charlotte King', 'charlottek@example.com', 'MCC2021-016', 'CCS', 'academic misconduct', 'Caught a classmate plagiarizing during a written exam.', 'email', NULL, NULL, NULL, '2023-09-15 16:00:00', 'in_progress', NULL, '4', 'mild', 0, 'User'),
(227, 'Ethan Garcia', 'ethang@example.com', 'MCC2021-018', 'CAS', 'bullying', 'Bullied for being outspoken during class discussions.', 'email', NULL, NULL, NULL, '2023-09-17 16:00:00', 'in_progress', NULL, '1', 'normal', 0, 'User'),
(226, 'Amelia Perez', 'ameliap@example.com', 'MCC2021-017', 'CCJE', 'harassment', 'Threatened by a group of students in the hallway.', 'phone', NULL, NULL, NULL, '2023-09-16 16:00:00', 'pending', NULL, '2', 'severe', 0, 'User'),
(224, 'Benjamin Scott', 'benjamins@example.com', 'MCC2021-015', 'CBM', 'technical issue', 'Facing login issues on the student portal for weeks.', 'email', NULL, NULL, NULL, '2023-09-14 16:00:00', 'resolved', NULL, '2', 'normal', 0, 'User'),
(223, 'Mia White', 'miaw@example.com', 'MCC2021-014', 'CTE', 'bullying', 'Being ridiculed by classmates during group presentations.', 'phone', NULL, NULL, NULL, '2023-09-13 16:00:00', 'pending', NULL, '3', 'normal', 0, 'User'),
(222, 'Lucas Walker', 'lucasw@example.com', 'MCC2021-013', 'CTE', 'classroom issue', 'Uncomfortable seating arrangement in the lecture hall.', 'email', NULL, NULL, NULL, '2023-09-12 16:00:00', 'in_progress', NULL, '1', 'mild', 0, 'User'),
(221, 'Isabella Moore', 'isabellam@example.com', 'MCC2021-012', 'CCS', 'bullying', 'Verbal abuse from a group of students in the lab.', 'phone', NULL, NULL, NULL, '2023-09-11 16:00:00', 'pending', NULL, '2', 'severe', 0, 'User'),
(220, 'Daniel Thomas', 'danielt@example.com', 'MCC2021-011', 'CCS', 'technical issue', 'Unable to access important course materials on the portal.', 'email', NULL, NULL, NULL, '2023-09-10 16:00:00', 'resolved', NULL, '3', 'normal', 0, 'User'),
(219, 'Sophia Martinez', 'sophiam@example.com', 'MCC2021-010', 'CAS', 'harassment', 'Being targeted by a professor for personal reasons.', 'email', NULL, NULL, NULL, '2023-09-09 16:00:00', 'in_progress', NULL, '1', 'severe', 0, 'User'),
(217, 'Sarah Clark', 'sarahc@example.com', 'MCC2021-008', 'CCJE', 'grade dispute', 'Believes a grade on the Criminal Law exam was unfairly given.', 'email', NULL, NULL, NULL, '2023-09-07 16:00:00', 'resolved', NULL, '2', 'mild', 0, 'User'),
(218, 'William Harris', 'williamh@example.com', 'MCC2021-009', 'CCJE', 'academic misconduct', 'Witnessed another student cheating during the exam.', 'phone', NULL, NULL, NULL, '2023-09-08 16:00:00', 'rejected', NULL, '4', 'normal', 0, 'User'),
(216, 'Michael Wilson', 'michaelw@example.com', 'MCC2021-007', 'CBM', 'bullying', 'Exclusion from group projects and activities.', 'phone', NULL, NULL, NULL, '2023-09-06 16:00:00', 'in_progress', NULL, '3', 'normal', 0, 'User'),
(215, 'Olivia Brown', 'oliviab@example.com', 'MCC2021-006', 'CBM', 'harassment', 'Repeatedly receiving unwanted messages from a classmate.', 'email', NULL, NULL, NULL, '2023-09-05 16:00:00', 'pending', NULL, '4', 'severe', 0, 'User'),
(214, 'Chris Lee', 'chrisl@example.com', 'MCC2021-005', 'CTE', 'classroom issue', 'Overcrowded classrooms making it hard to focus.', 'phone', NULL, NULL, NULL, '2023-09-04 16:00:00', 'resolved', NULL, '2', 'normal', 0, 'User'),
(213, 'Emily Davis', 'emilyd@example.com', 'MCC2021-004', 'CAS', 'bullying', 'Targeted by peers for not fitting in socially.', 'email', NULL, NULL, NULL, '2023-09-03 16:00:00', 'in_progress', NULL, '1', 'mild', 0, 'User'),
(212, 'Alex Johnson', 'alexj@example.com', 'MCC2021-003', 'CAS', 'grade dispute', 'Disagreement over final exam grades in Psychology.', 'email', NULL, NULL, NULL, '2023-09-02 16:00:00', 'pending', NULL, '3', 'normal', 0, 'User'),
(211, 'Jane Smith', 'janesmith@example.com', 'MCC2021-002', 'CCS', 'harassment', 'Received inappropriate comments from a professor.', 'phone', NULL, NULL, NULL, '2023-09-01 16:00:00', 'pending', NULL, '2', 'severe', 0, 'User'),
(210, 'John Doe', 'johndoe@example.com', 'MCC2021-001', 'CCS', 'bullying', 'Been constantly taunted by a group in class.', 'email', NULL, NULL, NULL, '2023-08-31 16:00:00', 'in_progress', NULL, '1', 'normal', 0, 'User'),
(266, 'Lily Walker', 'lilyw@example.com', 'MCC2021-024', 'CBM', 'technical issue', 'Experiencing issues with submitting assignments online.', 'phone', NULL, NULL, NULL, '2023-10-23 16:00:00', 'in_progress', NULL, '2', 'normal', 0, 'User'),
(267, 'Zoe Harris', 'zoeh@example.com', 'MCC2021-025', 'CAS', 'bullying', 'Intimidation from a group of classmates during exams.', 'email', NULL, NULL, NULL, '2023-10-24 16:00:00', 'pending', NULL, '4', 'severe', 0, 'User'),
(268, 'Mason Carter', 'masonc@example.com', 'MCC2021-026', 'CCJE', 'harassment', 'Inappropriate behavior from a professor in class.', 'phone', NULL, NULL, NULL, '2023-10-25 16:00:00', 'resolved', NULL, '2', 'normal', 0, 'User'),
(269, 'Grace Lee', 'gracel@example.com', 'MCC2021-027', 'CCS', 'classroom issue', 'Difficulty hearing the lectures due to noise from outside.', 'email', NULL, NULL, NULL, '2023-10-26 16:00:00', 'in_progress', NULL, '3', 'mild', 0, 'User'),
(270, 'Leo Allen', 'leoa@example.com', 'MCC2021-028', 'CBM', 'bullying', 'Subjected to derogatory remarks and name-calling by classmates.', 'phone', NULL, NULL, NULL, '2023-10-27 16:00:00', 'pending', NULL, '2', 'normal', 0, 'User'),
(271, 'Zara Mitchell', 'zarap@example.com', 'MCC2021-029', 'CAS', 'grade dispute', 'Felt that the grade on the midterm was unfairly low.', 'email', NULL, NULL, NULL, '2023-10-28 16:00:00', 'in_progress', NULL, '4', 'mild', 0, 'User'),
(272, 'Nina Clark', 'ninac@example.com', 'MCC2021-030', 'CCJE', 'technical issue', 'Struggled with accessing online course materials.', 'phone', NULL, NULL, NULL, '2023-10-29 16:00:00', 'resolved', NULL, '2', 'normal', 0, 'User'),
(273, 'Liam Robinson', 'liamr@example.com', 'MCC2021-031', 'CCS', 'bullying', 'Being excluded from study groups and peer interactions.', 'email', NULL, NULL, NULL, '2023-10-30 16:00:00', 'in_progress', NULL, '1', 'severe', 0, 'User'),
(274, 'Charlotte Green', 'charlotteg@example.com', 'MCC2021-032', 'CAS', 'harassment', 'Verbal abuse from a professor about personal beliefs.', 'phone', NULL, NULL, NULL, '2023-10-31 16:00:00', 'resolved', NULL, '4', 'normal', 0, 'User'),
(275, 'Max Anderson', 'maxa@example.com', 'MCC2021-033', 'CTE', 'grade dispute', 'Disagreement over the evaluation of an internship project.', 'email', NULL, NULL, NULL, '2023-11-01 16:00:00', 'pending', NULL, '3', 'mild', 0, 'User'),
(276, 'Mason Harris', 'masonh@example.com', 'MCC2021-034', 'CCJE', 'bullying', 'Persistent mocking during physical education classes.', 'phone', NULL, NULL, NULL, '2023-11-02 16:00:00', 'in_progress', NULL, '2', 'severe', 0, 'User'),
(277, 'John Doe', 'johndoe@example.com', 'MCC2021-001', 'CCS', 'bullying', 'Been constantly taunted by a group in class.', 'email', NULL, NULL, NULL, '2023-08-31 16:00:00', 'in_progress', NULL, '1', 'normal', 0, 'User'),
(278, 'Jane Smith', 'janesmith@example.com', 'MCC2021-002', 'CCS', 'harassment', 'Received inappropriate comments from a professor.', 'phone', NULL, NULL, NULL, '2023-09-14 16:00:00', 'pending', NULL, '2', 'severe', 0, 'User'),
(279, 'Alex Johnson', 'alexj@example.com', 'MCC2021-003', 'CAS', 'grade dispute', 'Disagreement over final exam grades in Psychology.', 'email', NULL, NULL, NULL, '2023-09-24 16:00:00', 'resolved', NULL, '3', 'normal', 0, 'User'),
(280, 'Emily Davis', 'emilyd@example.com', 'MCC2021-004', 'CAS', 'bullying', 'Targeted by peers for not fitting in socially.', 'email', NULL, NULL, NULL, '2023-10-04 16:00:00', 'in_progress', NULL, '1', 'mild', 0, 'User'),
(281, 'Chris Lee', 'chrisl@example.com', 'MCC2021-005', 'CTE', 'classroom issue', 'Overcrowded classrooms making it hard to focus.', 'phone', NULL, NULL, NULL, '2023-10-09 16:00:00', 'resolved', NULL, '2', 'normal', 0, 'User'),
(282, 'Olivia Brown', 'oliviab@example.com', 'MCC2021-006', 'CBM', 'harassment', 'Repeatedly receiving unwanted messages from a classmate.', 'email', NULL, NULL, NULL, '2023-10-19 16:00:00', 'pending', NULL, '4', 'severe', 0, 'User'),
(283, 'Michael Wilson', 'michaelw@example.com', 'MCC2021-007', 'CBM', 'bullying', 'Exclusion from group projects and activities.', 'phone', NULL, NULL, NULL, '2023-10-29 16:00:00', 'in_progress', NULL, '3', 'normal', 0, 'User'),
(284, 'Sarah Clark', 'sarahc@example.com', 'MCC2021-008', 'CCJE', 'grade dispute', 'Believes a grade on the Criminal Law exam was unfairly given.', 'email', NULL, NULL, NULL, '2023-11-04 16:00:00', 'resolved', NULL, '2', 'mild', 0, 'User'),
(285, 'William Harris', 'williamh@example.com', 'MCC2021-009', 'CCJE', 'academic misconduct', 'Witnessed another student cheating during the exam.', 'phone', NULL, NULL, NULL, '2023-11-09 16:00:00', 'in_progress', NULL, '4', 'normal', 0, 'User'),
(286, 'Sophia Martinez', 'sophiam@example.com', 'MCC2021-010', 'CAS', 'harassment', 'Being targeted by a professor for personal reasons.', 'email', NULL, NULL, NULL, '2023-11-14 16:00:00', 'in_progress', NULL, '1', 'severe', 0, 'User'),
(287, 'Daniel Thomas', 'danielt@example.com', 'MCC2021-011', 'CCS', 'technical issue', 'Unable to access important course materials on the portal.', 'email', NULL, NULL, NULL, '2023-11-19 16:00:00', 'resolved', NULL, '3', 'normal', 0, 'User'),
(288, 'Isabella Moore', 'isabellam@example.com', 'MCC2021-012', 'CCS', 'bullying', 'Verbal abuse from a group of students in the lab.', 'phone', NULL, NULL, NULL, '2023-11-24 16:00:00', 'pending', NULL, '2', 'severe', 0, 'User'),
(289, 'Lucas Walker', 'lucasw@example.com', 'MCC2021-013', 'CTE', 'classroom issue', 'Uncomfortable seating arrangement in the lecture hall.', 'email', NULL, NULL, NULL, '2023-11-27 16:00:00', 'in_progress', NULL, '1', 'mild', 0, 'User'),
(290, 'Mia White', 'miaw@example.com', 'MCC2021-014', 'CTE', 'bullying', 'Being ridiculed by classmates during group presentations.', 'phone', NULL, NULL, NULL, '2023-11-28 16:00:00', 'pending', NULL, '3', 'normal', 0, 'User'),
(291, 'Benjamin Scott', 'benjamins@example.com', 'MCC2021-015', 'CBM', 'technical issue', 'Facing login issues on the student portal for weeks.', 'email', NULL, NULL, NULL, '2023-09-14 16:00:00', 'resolved', NULL, '2', 'normal', 0, 'User'),
(292, 'Charlotte King', 'charlottek@example.com', 'MCC2021-016', 'CCS', 'academic misconduct', 'Caught a classmate plagiarizing during a written exam.', 'email', NULL, NULL, NULL, '2023-09-21 16:00:00', 'in_progress', NULL, '4', 'mild', 0, 'User'),
(293, 'Amelia Perez', 'ameliap@example.com', 'MCC2021-017', 'CCJE', 'harassment', 'Threatened by a group of students in the hallway.', 'phone', NULL, NULL, NULL, '2023-09-29 16:00:00', 'pending', NULL, '2', 'severe', 0, 'User'),
(294, 'Ethan Garcia', 'ethang@example.com', 'MCC2021-018', 'CAS', 'bullying', 'Bullied for being outspoken during class discussions.', 'email', NULL, NULL, NULL, '2023-10-02 16:00:00', 'in_progress', NULL, '1', 'normal', 0, 'User'),
(295, 'Ava Robinson', 'avar@example.com', 'MCC2021-019', 'CCS', 'classroom issue', 'Poor air circulation in the lecture room affecting concentration.', 'phone', NULL, NULL, NULL, '2023-10-11 16:00:00', 'resolved', NULL, '3', 'mild', 0, 'User'),
(296, 'Sebastian Adams', 'sebastiana@example.com', 'MCC2021-020', 'CAS', 'academic misconduct', 'Suspects cheating during a final exam in History.', 'email', NULL, NULL, NULL, '2023-10-31 16:00:00', 'resolved', NULL, '4', 'normal', 0, 'User'),
(297, 'James Turner', 'jamest@example.com', 'MCC2021-021', 'CTE', 'bullying', 'Targeted online harassment through social media by peers.', 'email', NULL, NULL, NULL, '2023-11-09 16:00:00', 'pending', NULL, '2', 'severe', 0, 'User'),
(298, 'Harper Lee', 'harperl@example.com', 'MCC2021-022', 'CCJE', 'grade dispute', 'Claims that grades on an exam were graded unfairly.', 'phone', NULL, NULL, NULL, '2023-11-19 16:00:00', 'in_progress', NULL, '1', 'normal', 0, 'User'),
(299, 'Jack Wilson', 'jackw@example.com', 'MCC2021-023', 'CCS', 'bullying', 'Inappropriate jokes about appearance and behavior in class.', 'email', NULL, NULL, NULL, '2023-11-24 16:00:00', 'resolved', NULL, '3', 'mild', 0, 'User'),
(300, 'Lily Walker', 'lilyw@example.com', 'MCC2021-024', 'CBM', 'technical issue', 'Experiencing issues with submitting assignments online.', 'phone', NULL, NULL, NULL, '2023-10-07 16:00:00', 'in_progress', NULL, '2', 'normal', 0, 'User'),
(301, 'Zoe Harris', 'zoeh@example.com', 'MCC2021-025', 'CAS', 'bullying', 'Intimidation from a group of classmates during exams.', 'email', NULL, NULL, NULL, '2023-10-15 16:00:00', 'pending', NULL, '4', 'severe', 0, 'User'),
(302, 'Mason Carter', 'masonc@example.com', 'MCC2021-026', 'CCJE', 'harassment', 'Inappropriate behavior from a professor in class.', 'phone', NULL, NULL, NULL, '2023-11-07 16:00:00', 'resolved', NULL, '2', 'normal', 0, 'User'),
(303, 'Grace Lee', 'gracel@example.com', 'MCC2021-027', 'CCS', 'classroom issue', 'Difficulty hearing the lectures due to noise from outside.', 'email', NULL, NULL, NULL, '2023-11-14 16:00:00', 'in_progress', NULL, '3', 'mild', 0, 'User'),
(304, 'Leo Allen', 'leoa@example.com', 'MCC2021-028', 'CBM', 'bullying', 'Subjected to derogatory remarks and name-calling by classmates.', 'phone', NULL, NULL, NULL, '2023-10-18 16:00:00', 'pending', NULL, '2', 'normal', 0, 'User'),
(305, 'Zara Mitchell', 'zarap@example.com', 'MCC2021-029', 'CAS', 'grade dispute', 'Felt that the grade on the midterm was unfairly low.', 'email', NULL, NULL, NULL, '2023-11-01 16:00:00', 'in_progress', NULL, '4', 'mild', 0, 'User'),
(306, 'Nina Clark', 'ninac@example.com', 'MCC2021-030', 'CCJE', 'technical issue', 'Struggled with accessing online course materials.', 'phone', NULL, NULL, NULL, '2023-10-24 16:00:00', 'resolved', NULL, '2', 'normal', 0, 'User'),
(307, 'Liam Robinson', 'liamr@example.com', 'MCC2021-031', 'CCS', 'bullying', 'Being excluded from study groups and peer interactions.', 'email', NULL, NULL, NULL, '2023-09-01 16:00:00', 'in_progress', NULL, '1', 'severe', 0, 'User'),
(308, 'Charlotte Green', 'charlotteg@example.com', 'MCC2021-032', 'CAS', 'harassment', 'Verbal abuse from a professor about personal beliefs.', 'phone', NULL, NULL, NULL, '2023-10-01 16:00:00', 'resolved', NULL, '4', 'normal', 0, 'User'),
(309, 'Max Anderson', 'maxa@example.com', 'MCC2021-033', 'CTE', 'grade dispute', 'Disagreement over the evaluation of an internship project.', 'email', NULL, NULL, NULL, '2023-10-17 16:00:00', 'pending', NULL, '3', 'mild', 0, 'User'),
(310, 'Mason Harris', 'masonh@example.com', 'MCC2021-034', 'CCJE', 'bullying', 'Persistent mocking during physical education classes.', 'phone', NULL, NULL, NULL, '2023-11-06 16:00:00', 'in_progress', NULL, '2', 'severe', 0, 'User'),
(311, 'Ella Turner', 'ellat@example.com', 'MCC2021-035', 'CCS', 'technical issue', 'Problems with online exam submissions.', 'email', NULL, NULL, NULL, '2023-09-17 16:00:00', 'resolved', NULL, '1', 'normal', 0, 'User'),
(312, 'Isabella Wood', 'isabellaw@example.com', 'MCC2021-036', 'CCJE', 'academic misconduct', 'Witnessed cheating during a group project presentation.', 'phone', NULL, NULL, NULL, '2023-10-22 16:00:00', 'in_progress', NULL, '3', 'normal', 0, 'User'),
(313, 'Noah King', 'noahk@example.com', 'MCC2021-037', 'CAS', 'harassment', 'Received threats from classmates for personal views.', 'email', NULL, NULL, NULL, '2023-11-02 16:00:00', 'resolved', NULL, '4', 'normal', 0, 'User'),
(314, 'Grace Wilson', 'gracew@example.com', 'MCC2021-038', 'CBM', 'classroom issue', 'Felt that group projects were unfairly distributed.', 'phone', NULL, NULL, NULL, '2023-11-12 16:00:00', 'in_progress', NULL, '2', 'normal', 0, 'User'),
(315, 'Wyatt Moore', 'wyattm@example.com', 'MCC2021-039', 'CTE', 'bullying', 'Public humiliation in front of peers during a presentation.', 'email', NULL, NULL, NULL, '2023-11-24 16:00:00', 'pending', NULL, '4', 'severe', 0, 'User'),
(316, 'Madeline Clark', 'madelinec@example.com', 'MCC2021-040', 'CCJE', 'academic misconduct', 'Accused of cheating without valid evidence.', 'phone', NULL, NULL, NULL, '2023-10-13 16:00:00', 'resolved', NULL, '3', 'normal', 0, 'User'),
(317, 'Lucas Harris', 'lucash@example.com', 'MCC2021-041', 'CCS', 'grade dispute', 'Disagrees with a grading policy on a group assignment.', 'email', NULL, NULL, NULL, '2023-11-11 16:00:00', 'in_progress', NULL, '2', 'mild', 0, 'User'),
(318, 'Jaxon Scott', 'jaxons@example.com', 'MCC2021-042', 'CBM', 'technical issue', 'Unable to access project files on the university server.', 'phone', NULL, NULL, NULL, '2023-09-11 16:00:00', 'resolved', NULL, '1', 'normal', 0, 'User'),
(319, 'Aiden Walker', 'aidenw@example.com', 'MCC2021-043', 'CAS', 'bullying', 'Harassed by classmates due to their appearance.', 'email', NULL, NULL, NULL, '2023-10-31 16:00:00', 'in_progress', NULL, '4', 'severe', 0, 'User'),
(320, 'Ruby Young', 'rubyy@example.com', 'MCC2021-044', 'CTE', 'bullying', 'Subjected to cyberbullying through social media platforms.', 'phone', NULL, NULL, NULL, '2023-10-28 16:00:00', 'pending', NULL, '3', 'normal', 0, 'User'),
(321, 'Oliver Hill', 'oliverh@example.com', 'MCC2021-045', 'CCS', 'classroom issue', 'Discomfort due to poorly arranged seating in lectures.', 'email', NULL, NULL, NULL, '2023-10-03 16:00:00', 'resolved', NULL, '1', 'mild', 0, 'User'),
(322, 'Henry Allen', 'henrya@example.com', 'MCC2021-046', 'CCJE', 'harassment', 'Received inappropriate comments during an internship.', 'phone', NULL, NULL, NULL, '2023-11-17 16:00:00', 'in_progress', NULL, '2', 'severe', 0, 'User'),
(323, 'Chloe King', 'chloek@example.com', 'MCC2021-047', 'CAS', 'academic misconduct', 'Caught plagiarizing an article for a research paper.', 'email', NULL, NULL, NULL, '2023-11-21 16:00:00', 'resolved', NULL, '4', 'normal', 0, 'User'),
(324, 'Ella Martin', 'ellam@example.com', 'MCC2021-048', 'CTE', 'bullying', 'Bullying during a field trip.', 'phone', NULL, NULL, NULL, '2023-10-09 16:00:00', 'pending', NULL, '2', 'mild', 0, 'User'),
(325, 'Oliver Lee', 'oliverl@example.com', 'MCC2021-049', 'CCS', 'technical issue', 'Can’t submit assignments due to website malfunction.', 'email', NULL, NULL, NULL, '2023-11-14 16:00:00', 'resolved', NULL, '3', 'normal', 0, 'User'),
(326, 'Mia Taylor', 'miat@example.com', 'MCC2021-050', 'CCJE', 'classroom issue', 'Difficulty focusing due to excessive noise in the classroom.', 'phone', NULL, NULL, NULL, '2023-11-24 16:00:00', 'in_progress', NULL, '1', 'severe', 0, 'User'),
(327, 'Juluis Castillo', 'castillojuluis@gmail.com', 'MCC2021-0332', 'CCS', 'bullying', 'i got bully by my friend also i got kick on my classroom', 'email', '', '', '', '2024-11-28 09:11:59', 'in_progress', NULL, '3', 'mild', 0, 'User'),
(328, 'gwenita', 'gwenbasconcillo11@gmail.com', 'MCC2022-0368', 'CCS', 'discrimination', 'They are racist!', 'email', '', '', '', '2024-11-28 10:32:00', 'resolved', NULL, '3', 'severe', 0, 'User'),
(329, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'MCC2021-0334', 'CCS', 'academic-misconduct', 'My profesor give a lot of the homework', 'email', '', '', '', '2024-11-28 11:05:54', 'pending', NULL, '3', 'mild', 0, 'User'),
(330, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'MCC2021-0343', 'CAS', 'harassment', 'Can you help me i got been called by my classmate a God like feature a daughter of God it offended me ', 'email', '', '', '', '2024-11-28 11:09:17', 'pending', NULL, '2', 'normal', 0, 'User'),
(331, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'MCC2021-0343', 'CCS', 'discrimination', 'My profesor give a lot of the homework', 'email', '', '', '', '2024-11-28 11:18:41', 'pending', NULL, '3', 'mild', 0, 'User'),
(332, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'MCC2021-0343', 'CCS', 'guidance', 'Can you help me i got been called by my classmate a God like feature a daughter of God it offended me ', 'email', '', '', '', '2024-11-28 11:22:01', 'pending', NULL, '3', 'normal', 0, 'User'),
(333, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'MCC2021-0343', 'CBM', 'violence', 'My profesor give a lot of the homework', 'email', '', '', '', '2024-11-28 11:23:26', 'pending', NULL, '3', 'mild', 0, 'User'),
(334, 'Gwen Basconcillo', 'gwenbasconcillo11@gmail.com', 'MCC2021-0343', 'CTE', 'classroom-issue', 'Can you help me i got been called by my classmate a God like feature a daughter of God it offended me ', 'email', '', '', '', '2024-11-28 11:26:54', 'in_progress', NULL, '3', 'normal', 0, 'User'),
(335, 'Gwen Basconcillo', 'moanabasconcillo@gmail.com', 'MCC2021-0343', 'CCS', 'guidance', 'Can you help me i got been called by my classmate a God like feature a daughter of God it offended me ', 'email', '', '', '', '2024-11-28 11:27:35', 'pending', NULL, '3', 'normal', 0, 'User'),
(336, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'MCC2021-0343', 'CCS', 'mental-health', 'My profesor give a lot of the homework', 'email', '', '', '', '2024-11-28 11:32:13', 'pending', NULL, '3', 'mild', 0, 'User'),
(337, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'MCC2021-0343', 'CCJE', 'sexual-assault', 'we got sex of my prof', 'email', '', '', '', '2024-11-28 11:40:10', 'pending', NULL, '4', 'mild', 0, 'User'),
(338, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'MCC2021-0343', 'CBM', 'substance-abuse', 'kdsfiofc[aoifasiofhdasf', 'email', '', '', '', '2024-11-28 11:43:36', 'resolved', NULL, '3', 'mild', 0, 'User'),
(339, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'MCC2021-0343', 'CTE', 'discrimination', 'we discrimination', 'email', '', '', '', '2024-11-28 11:45:14', 'resolved', NULL, '4', 'mild', 0, 'User'),
(340, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'MCC2021-0343', 'CTE', 'discrimination', 'last na papatayin na ako', 'email', '', '', '', '2024-11-28 11:46:17', 'resolved', NULL, '2', 'mild', 0, 'User'),
(341, 'Darllyd Tupaz', 'aash100227@gmail.com', 'MCC2021-0343', 'CCS', 'violence', 'Nakipagsuntukan sa guro', 'email', '', '', '', '2024-11-28 11:48:00', 'resolved', NULL, '3', 'mild', 0, 'User'),
(342, 'Kayc Arejola', 'alcariakayc@gmail.com', 'MCC2022-0255', 'CCS', 'sexual-assault', 'secret', 'email', '', '', '', '2024-11-29 05:14:11', 'resolved', NULL, '3', 'mild', 0, 'User'),
(343, 'Reymel Rey Mislang', 'mislangreymel12@gmail.com', 'MCC2021-0334', 'CCS', 'bullying', 'I’m deeply affected by bullying I’ve been experiencing. It’s causing me severe emotional distress, and I don’t know how to cope anymore.', 'email', '', '', '', '2024-11-29 09:04:45', 'resolved', NULL, '3', 'severe', 0, 'User'),
(344, 'Rommel Mislang', 'rommelmislang49@gmail.com', 'MCC2021-0334', 'CTE', 'academic-misconduct', 'My racist classmate bully me', 'email', '', '', '', '2024-11-29 11:53:50', 'resolved', NULL, '1', 'severe', 0, 'User'),
(345, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'MCC2021-0334', 'CCS', 'bullying', 'My racist classmate bully me', 'email', '', '', '', '2024-11-30 07:08:41', 'rejected', NULL, '3', 'severe', 0, 'User'),
(346, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'MCC2021-0334', 'CCS', 'discrimination', 'they say im a gay', 'email', '', '', '', '2024-11-30 09:10:13', 'rejected', NULL, '2', 'mild', 0, 'User'),
(347, '', 'mislangreymel6@gmail.com', 'MCC2021-0334', 'CCS', 'classroom-issue', 'full of backstab on me', 'email', '', '', '', '2024-12-07 14:51:01', 'pending', NULL, '3', 'mild', 0, 'User'),
(348, 'last try ko na to', 'mislangreymel12@gmail.com', 'MCC2021-0344', 'CCS', 'substance-abuse', 'They harras me ', 'email', '', '', '', '2024-12-10 01:57:14', 'in_progress', NULL, '3', 'mild', 0, 'User'),
(349, 'Erika ', 'erikaborsotorubio18@gmail.com', 'MCC2022-0300', 'CCS', 'academic-misconduct', 'bullied ', 'email', '', '', '', '2024-12-10 05:37:37', 'pending', NULL, '3', 'severe', 0, 'User'),
(350, 'Erika Joy Rubio', 'athelmaxim@gmail.com', 'MCC2022-0300', 'CCS', 'classroom-issue', 'They call me principal when i dress formal', 'email', '', '', '', '2024-12-10 06:09:20', 'pending', NULL, '3', 'mild', 0, 'User'),
(351, 'Harley Garcia', 'moanabasconcillo@gmail.com', 'MCC2021-0333', 'CCS', 'harassment', 'bullied by bshm department', 'email', '', '', '', '2024-12-10 07:49:19', 'resolved', NULL, '3', 'severe', 0, 'User'),
(352, 'Reymel Rey Mislang', 'mislangreymel18@gmail.com', 'MCC2021-0333', 'CCS', 'discrimination', 'I GOT BULLIED BY YOU', 'email', '', '', '', '2024-12-10 07:53:41', 'resolved', NULL, '3', 'severe', 0, 'User'),
(353, 'Reymel Rey Mislang', 'mislangreymel18@gmail.com', 'MCC2021-0333', 'CCS', 'classroom-issue', 'bullied me', 'email', '', '', '', '2024-12-10 10:52:31', 'pending', NULL, '4', 'severe', 0.41, 'User'),
(354, 'Reymel Rey Mislang', 'mislangreymel18@gmail.com', 'MCC2021-0333', 'CAS', 'other-academic-issue', 'THEY SAY IM GAY AND IT GET ME SAD', 'email', '', '', '', '2024-12-10 11:31:34', 'pending', NULL, '1', 'mild', 0.4767, 'User'),
(355, 'Reymel Rey Mislang', 'mislangreymel18@gmail.com', 'MCC2021-0333', 'CTE', 'discrimination', 'bading daw ako\r\n', 'email', '', '', '', '2024-12-13 06:53:52', 'pending', NULL, '3', 'mild', 0, 'User'),
(356, 'rom dmislang', 'mislangreymel18@gmail.com', 'MCC2021-0333', 'CAS', 'violence', 'THEY SAY IM GAY AND IT GET ME SAD', 'email', '', '', '', '2024-12-13 06:55:52', 'pending', NULL, '2', 'mild', 0.4767, 'User'),
(357, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'MCC2021-0333', 'CBM', 'violence', 'They are targeting me with abusive language', 'email', '', '', '', '2024-12-13 06:57:23', 'pending', NULL, '4', 'severe', 0.6369, 'User'),
(358, 'Reymel Rey Mislang', 'reymelrey.mislang@gmail.com', 'MCC2021-0333', 'CAS', 'harassment', 'I was blackmailed by someone', 'email', '', '', '', '2024-12-15 00:27:57', 'pending', NULL, '2', 'mild', 0, 'User');

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
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `faqs`
--

INSERT INTO `faqs` (`id`, `question`, `answer`, `question_hash`) VALUES
(1, 'What is SafePath?', 'SafePath is a platform that allows students to anonymously report bullying incidents and receive support through our integrated chatbot.', 'ea9242fc850808a240a2739c2ec46dbd'),
(2, 'How can I contact support?', 'You can contact support via email or through our contact form.', 'a345d728267e55bb4992f848b7b95247'),
(3, 'Who will have access to my report?', 'Only authorized personnel, such as the guidance office and school administrators, will have access to your report.', 'c1c4d5c4e148955c940cc8dade27674e'),
(4, 'Can I report other forms of harassment or threats?', 'Yes, our platform allows you to report any form of harassment, threats, or abusive behavior for further investigation.', '1b832109007c137b8127241d1d83dbe2');

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
(15, 'Reymel Mislang', 'reymelrey.mislang@gmail.com', 'So Clean So Good', 5, '', 'yes', '2024-11-26 23:50:23', NULL),
(16, 'Harlyn Nebreja', 'harshid.vasoya2827@gmail.com', 'nice ', 5, 'more ui improvement\r\n', 'yes', '2024-11-30 09:11:22', NULL),
(17, 'Harlyn Nebreja', 'harshid.vasoya2827@gmail.com', 'Good and More Gui improvements', 3, '', 'yes', '2024-12-07 14:53:30', NULL);

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
