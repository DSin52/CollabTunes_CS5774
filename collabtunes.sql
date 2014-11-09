-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 09, 2014 at 07:57 AM
-- Server version: 5.6.20
-- PHP Version: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `collabtunes`
--

-- --------------------------------------------------------

--
-- Table structure for table `album`
--

CREATE TABLE IF NOT EXISTS `album` (
  `album_summary` varchar(500) NOT NULL,
  `album_owner` varchar(100) NOT NULL,
  `album_genre` varchar(100) NOT NULL,
  `album_name` varchar(500) NOT NULL,
  `album_image` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `album`
--

INSERT INTO `album` (`album_summary`, `album_owner`, `album_genre`, `album_name`, `album_image`) VALUES
('test', 'test', 'test', 'test', '../uploads/test_test.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `collaborators`
--

CREATE TABLE IF NOT EXISTS `collaborators` (
  `friend_one` varchar(100) NOT NULL,
  `friend_two` varchar(100) NOT NULL,
  `status` int(11) NOT NULL,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
`id` int(11) NOT NULL,
  `sent_by` varchar(100) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE IF NOT EXISTS `comment` (
  `username` varchar(100) NOT NULL,
  `album_name` varchar(500) NOT NULL,
  `text` varchar(500) NOT NULL,
  `album_owner` varchar(100) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
`id` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE IF NOT EXISTS `event` (
  `event_type` varchar(32) DEFAULT NULL,
  `username` varchar(128) DEFAULT NULL,
  `data` varchar(128) DEFAULT NULL,
  `album_name` varchar(128) DEFAULT NULL,
  `when_happened` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `event`
--

INSERT INTO `event` (`event_type`, `username`, `data`, `album_name`, `when_happened`) VALUES
('add_album', 'test', 'test', 'test', '2014-11-09 06:51:12');

-- --------------------------------------------------------

--
-- Table structure for table `track`
--

CREATE TABLE IF NOT EXISTS `track` (
  `track_name` varchar(200) NOT NULL,
  `track_path` varchar(500) NOT NULL,
  `track_owner` varchar(100) NOT NULL,
  `track_album` varchar(100) NOT NULL,
  `album_owner` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `user_type` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`username`, `email`, `password`, `first_name`, `last_name`, `user_type`) VALUES
('divit52', 'test@test2', '$2y$10$1XG/L8sGkh7g1DnkpE2TluJnmpYwTOzoT1UxIG13zec.m.e8NwGz2', 't', 't', 0),
('test', 'test@test', '$2y$10$ipjezG1iGOY9M/WZTke3nuAfv9M6G7.J6bSDUiUAvcaaLuoQr4j2i', 'test', 'test', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `album`
--
ALTER TABLE `album`
 ADD PRIMARY KEY (`album_owner`,`album_name`);

--
-- Indexes for table `collaborators`
--
ALTER TABLE `collaborators`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
 ADD PRIMARY KEY (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `collaborators`
--
ALTER TABLE `collaborators`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `comment`
--
ALTER TABLE `comment`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
