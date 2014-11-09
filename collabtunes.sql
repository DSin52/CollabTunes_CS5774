# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.6.20)
# Database: collabtunes
# Generation Time: 2014-11-09 22:34:53 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table album
# ------------------------------------------------------------

DROP TABLE IF EXISTS `album`;

CREATE TABLE `album` (
  `album_summary` varchar(500) NOT NULL,
  `album_owner` varchar(100) NOT NULL,
  `album_genre` varchar(100) NOT NULL,
  `album_name` varchar(500) NOT NULL,
  `album_image` varchar(200) NOT NULL,
  PRIMARY KEY (`album_owner`,`album_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `album` WRITE;
/*!40000 ALTER TABLE `album` DISABLE KEYS */;

INSERT INTO `album` (`album_summary`, `album_owner`, `album_genre`, `album_name`, `album_image`)
VALUES
	('Test Album','divit52','Rap','Test Album Divit','../uploads/divit52_Test Album Divit.jpg'),
	('Test Album','schadha','Rap','Test Album Sanchit','../uploads/schadha_Test Album Sanchit.jpg'),
	('test','schadha','Rap2','test2','../uploads/schadha_test2.jpg'),
	('Test Album','test','Rap','Test Album Test','../uploads/test_Test Album Test.jpg');

/*!40000 ALTER TABLE `album` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table collaborators
# ------------------------------------------------------------

DROP TABLE IF EXISTS `collaborators`;

CREATE TABLE `collaborators` (
  `friend_one` varchar(100) NOT NULL,
  `friend_two` varchar(100) NOT NULL,
  `status` int(11) NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sent_by` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `collaborators` WRITE;
/*!40000 ALTER TABLE `collaborators` DISABLE KEYS */;

INSERT INTO `collaborators` (`friend_one`, `friend_two`, `status`, `modified`, `id`, `sent_by`)
VALUES
	('schadha','divit52',1,'2014-11-09 14:50:12',7,'schadha'),
	('divit52','schadha',1,'2014-11-09 14:50:12',8,'schadha'),
	('test','divit52',1,'2014-11-09 14:54:15',9,'test'),
	('divit52','test',1,'2014-11-09 14:54:15',10,'test');

/*!40000 ALTER TABLE `collaborators` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `username` varchar(100) NOT NULL,
  `album_name` varchar(500) NOT NULL,
  `text` varchar(500) NOT NULL,
  `album_owner` varchar(100) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;

INSERT INTO `comment` (`username`, `album_name`, `text`, `album_owner`, `created`, `id`)
VALUES
	('schadha','Test Album Sanchit','Test','schadha','2014-11-09 10:56:30',9),
	('schadha','Test Album Sanchit','Test3','schadha','2014-11-09 11:00:30',11),
	('schadha','test2','Testing','schadha','2014-11-09 11:00:56',12),
	('schadha','Test Album Divit','Testing','divit52','2014-11-09 11:01:02',13);

/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table event
# ------------------------------------------------------------

DROP TABLE IF EXISTS `event`;

CREATE TABLE `event` (
  `event_type` varchar(32) DEFAULT NULL,
  `username` varchar(128) DEFAULT NULL,
  `data` varchar(128) DEFAULT NULL,
  `album_name` varchar(128) DEFAULT NULL,
  `when_happened` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;

INSERT INTO `event` (`event_type`, `username`, `data`, `album_name`, `when_happened`)
VALUES
	('add_collaborator1','schadha','divit52','','2014-11-09 08:50:12'),
	('add_collaborator2','divit52','schadha','','2014-11-09 08:50:12'),
	('add_album','divit52','Test Album Divit','Test Album Divit','2014-11-09 08:51:38'),
	('add_album','schadha','Test Album Sanchit','Test Album Sanchit','2014-11-09 08:53:02'),
	('add_album','test','Test Album Test','Test Album Test','2014-11-09 08:53:57'),
	('add_collaborator1','test','divit52','','2014-11-09 08:54:15'),
	('add_collaborator2','divit52','test','','2014-11-09 08:54:15'),
	('add_track','schadha','Test Track','Test Album Sanchit,schadha','2014-11-09 09:39:26'),
	('add_album','schadha','test2','test2','2014-11-09 09:57:03'),
	('add_comment','schadha','11','Test Album Sanchit','2014-11-09 11:00:30'),
	('add_comment','schadha','12','test2','2014-11-09 11:00:56'),
	('add_comment','schadha','13','Test Album Divit','2014-11-09 11:01:03');

/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table track
# ------------------------------------------------------------

DROP TABLE IF EXISTS `track`;

CREATE TABLE `track` (
  `track_name` varchar(200) NOT NULL,
  `track_path` varchar(500) NOT NULL,
  `track_owner` varchar(100) NOT NULL,
  `track_album` varchar(100) NOT NULL,
  `album_owner` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `track` WRITE;
/*!40000 ALTER TABLE `track` DISABLE KEYS */;

INSERT INTO `track` (`track_name`, `track_path`, `track_owner`, `track_album`, `album_owner`)
VALUES
	('Test Track','../uploads/schadha_Test_Album_Sanchit_Test_Track.mp3','schadha','Test Album Sanchit','schadha');

/*!40000 ALTER TABLE `track` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `user_type` int(11) DEFAULT NULL,
  `favorite_genre` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`username`, `email`, `password`, `first_name`, `last_name`, `user_type`, `favorite_genre`)
VALUES
	('divit52','test@test2','$2y$10$1XG/L8sGkh7g1DnkpE2TluJnmpYwTOzoT1UxIG13zec.m.e8NwGz2','Divit','Singh',0,'Rap'),
	('schadha','schadha@vt.edu','$2y$10$XamgzJzAqSrP4KcHm8PvuuRVx0/LI5Hc9N/eEpciyYLqtHpMZrRCi','Sanchit','Chadha',1,'Rap'),
	('test','test@test','$2y$10$ipjezG1iGOY9M/WZTke3nuAfv9M6G7.J6bSDUiUAvcaaLuoQr4j2i','test','test',0,'Rap');

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
