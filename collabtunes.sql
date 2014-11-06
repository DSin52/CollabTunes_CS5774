-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 06, 2014 at 05:08 AM
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
('This album contains some of the greatest Hip-Hop songs from the early 90''s.', 'divit52', 'Hip-Hop', 'Early 90''s Hits', '../uploads/divit52_Early 90''s Hits.jpg'),
('Kanye & Jay-Z', 'schadha', 'Rap', 'Watch The Throne', '../uploads/schadha_Watch The Throne.jpg'),
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
  `sent_by` varchar(100) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=41 ;

--
-- Dumping data for table `collaborators`
--

INSERT INTO `collaborators` (`friend_one`, `friend_two`, `status`, `modified`, `id`, `sent_by`) VALUES
('test', 'divit52', 0, '2014-11-06 07:11:59', 39, 'test'),
('divit52', 'test', 0, '2014-11-06 07:11:59', 40, 'test');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`username`, `album_name`, `text`, `album_owner`, `created`, `id`) VALUES
('divit52', 'test', 'testing', 'test', '2014-11-06 06:10:44', 10),
('schadha', 'test', 'testing', 'test', '2014-11-06 06:11:16', 11),
('test', 'test', 'testa', 'test', '2014-11-06 06:35:03', 12);

-- --------------------------------------------------------

--
-- Table structure for table `track`
--

CREATE TABLE IF NOT EXISTS `track` (
  `track_name` varchar(200) NOT NULL,
  `track_path` varchar(500) NOT NULL,
  `track_owner` varchar(100) NOT NULL,
  `track_album` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `track`
--

INSERT INTO `track` (`track_name`, `track_path`, `track_owner`, `track_album`) VALUES
('Otis', '../uploads/schadha_Watch_The_Throne_Otis.mp3', 'schadha', 'Watch The Throne'),
('No Church in the Wild', '../uploads/schadha_Watch_The_Throne_No_Church_in_the_Wild.mp3', 'schadha', 'Watch The Throne'),
('Power', '../uploads/test_test_Power.mp3', 'test', 'test'),
('When Thugz Cry', '../uploads/divit52_Early_90''s_Hits_When_Thugz_Cry.mp3', 'divit52', 'Early 90''s Hits');

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
  `collab_count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`username`, `email`, `password`, `first_name`, `last_name`, `collab_count`) VALUES
('divit52', 'divit52@vt.edu', '$2y$10$WbEQHotJq5jhC1uSh/cenOHr9zE9hr4BSV376TU2mFtFxBN/19.py', 'Divit', 'Singh', 0),
('schadha', 'sanchit.chadha@gmail.com', '$2y$10$TkQoKKDX6SPdk5tyKMQcheNnpaOcjPPgXHpnxuODexNm7K9BMAy2K', 'Sanchit', 'Chadha', 0),
('test', 'test@test.com', '$2y$10$La9NdCyuIe8OHtqoIWIHEeDF46by.QlVCRwEnEFdklOZrZzA0Qp5i', 'test', 'test', 0);

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
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=41;
--
-- AUTO_INCREMENT for table `comment`
--
ALTER TABLE `comment`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
