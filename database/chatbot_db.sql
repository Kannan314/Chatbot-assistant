-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 05, 2021 at 09:56 AM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `chatbot_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `frequent_asks`
--

CREATE TABLE `frequent_asks` (
  `id` int(30) NOT NULL,
  `question_id` int(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `frequent_asks`
--

INSERT INTO `frequent_asks` (`id`, `question_id`) VALUES
(1, 0),
(2, 0),
(3, 0),
(4, 0),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 4),
(12, 1),
(13, 6),
(14, 7),
(15, 7),
(16, 1),
(17, 7),
(18, 8),
(19, 7),
(20, 7),
(21, 7),
(22, 6),
(23, 7),
(24, 7),
(25, 7),
(26, 7),
(27, 7),
(28, 7),
(29, 9),
(30, 1),
(31, 8),
(32, 2),
(33, 7),
(34, 14),
(35, 9),
(36, 9),
(37, 9),
(38, 1),
(39, 4),
(40, 6),
(41, 7);

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(30) NOT NULL,
  `question` text DEFAULT NULL,
  `response_id` int(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `question`, `response_id`) VALUES
(1, 'what are you', 1),
(2, 'who are you', 1),
(3, 'what is your name', 1),
(4, 'What can you do', 2),
(7, 'what is PHP', 4),
(8, 'What is ChatBot', 5),
(9, 'hi', 6),
(10, 'hello', 6),
(11, 'yow', 6),
(12, 'good day', 6),
(14, 'sample', 7),
(15, 'what topic can I ask', 8);

-- --------------------------------------------------------

--
-- Table structure for table `responses`
--

CREATE TABLE `responses` (
  `id` int(30) NOT NULL,
  `response_message` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `responses`
--

INSERT INTO `responses` (`id`, `response_message`) VALUES
(1, 'I am John, the chatBot of this application.'),
(2, 'I am in charge to answer your questions.'),
(3, 'You can ask me about something related to this website.'),
(4, 'PHP (recursive acronym for PHP: Hypertext Preprocessor ) is a widely-used open source general-purpose scripting language that is especially suited for web development and can be embedded into HTML.'),
(5, 'A chatbot is a software application used to conduct an on-line chat conversation via text or text-to-speech, in lieu of providing direct contact with a live human agent.'),
(6, 'Hi there, how can I help you ? :)'),
(7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam congue, lectus non tincidunt viverra, lacus erat venenatis mauris, sed hendrerit libero diam ac tellus. Integer imperdiet massa lacus, sed porta ligula efficitur at. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; '),
(8, 'You can ask me about something related to this website.');

-- --------------------------------------------------------

--
-- Table structure for table `system_info`
--

CREATE TABLE `system_info` (
  `id` int(30) NOT NULL,
  `meta_field` text NOT NULL,
  `meta_value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `system_info`
--

INSERT INTO `system_info` (`id`, `meta_field`, `meta_value`) VALUES
(1, 'name', 'Simple ChatBot Application'),
(4, 'intro', 'Hi! I\'m John, a ChatBot of this application. How can I help you?'),
(6, 'short_name', 'ChatBot'),
(10, 'no_result', 'I am sorry. I can\'t understand your question. Please rephrase your question and make sure it is related to this site. Thank you :)'),
(11, 'logo', 'uploads/1620181980_bot2.jpg'),
(12, 'bot_avatar', 'uploads/bot_avatar.jpg'),
(13, 'user_avatar', 'uploads/user_avatar.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `unanswered`
--

CREATE TABLE `unanswered` (
  `id` int(30) NOT NULL,
  `question` text DEFAULT NULL,
  `no_asks` int(30) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `unanswered`
--

INSERT INTO `unanswered` (`id`, `question`, `no_asks`) VALUES
(1, 'what can you do?', 2),
(2, 'what can you do ?', 2),
(3, 'what topic can I ask', 2),
(4, 'chat bot', 2),
(5, 'asdasd', 2),
(6, 'asdaaa', 2),
(7, 'asd', 2),
(9, 'hello', 2),
(10, 'sample', 2),
(11, 'test', 2);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(50) NOT NULL,
  `firstname` varchar(250) NOT NULL,
  `lastname` varchar(250) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `avatar` text DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `username`, `password`, `avatar`, `last_login`, `date_added`, `date_updated`) VALUES
(1, 'Adminstrator', 'Admin', 'admin', '0192023a7bbd73250516f069df18b500', 'uploads/1620201300_avatar.png', NULL, '2021-01-20 14:02:37', '2021-05-05 15:55:28');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `frequent_asks`
--
ALTER TABLE `frequent_asks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `responses`
--
ALTER TABLE `responses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `system_info`
--
ALTER TABLE `system_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `unanswered`
--
ALTER TABLE `unanswered`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `frequent_asks`
--
ALTER TABLE `frequent_asks`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `responses`
--
ALTER TABLE `responses`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `system_info`
--
ALTER TABLE `system_info`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `unanswered`
--
ALTER TABLE `unanswered`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
