-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Oct 29, 2012 at 08:22 AM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;


DROP DATABASE cits4230f;
CREATE DATABASE cits4230f;
USE cits4230f;
--
-- Database: `cits4230`
--

-- --------------------------------------------------------
--
-- Table structure for table `users`
--

CREATE TABLE  `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(128) NOT NULL,
  `last_name` varchar(128) NOT NULL,
  `login` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `password` varchar(256) NOT NULL,
  `code` int(8) NOT NULL,
  `registration_token` varchar(256),
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;
-- --------------------------------------------------------

--
-- Table structure for table `album`
--

CREATE TABLE `albums` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `description` varchar(1056) NOT NULL,
  `is_private` tinyint(1) NOT NULL,
  `image_cover_location` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `photo`
--

CREATE TABLE `photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `photo_file_name` varchar(128) NOT NULL,
  `description` varchar(512) NOT NULL,
  `is_private` tinyint(1) NOT NULL,
  `photo_content_type` varchar(128) NOT NULL,
  `photo_file_size` int(11),
  `photo_updated_at` DATE,
  `user_id` int(11) NULL,
  `likes` int(11) default 0,
  PRIMARY KEY (`id`),
  FOREIGN KEY(`user_id`) REFERENCES users(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;


-- --------------------------------------------------------

--
-- Table structure for table `albumphoto`
--

CREATE TABLE `albums_photos` (
  `album_id` int(11) NOT NULL,
  `photo_id` int(11) NOT NULL,
  FOREIGN KEY (album_id) REFERENCES albums(id),
  FOREIGN KEY (photo_id) REFERENCES photos(id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



-- --------------------------------------------------------

--
-- Table structure for table `user_album`
--

CREATE TABLE `users_albums` (
  `user_id` int(11) NOT NULL,
  `album_id` int(11) NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (album_id) REFERENCES albums(id),
  PRIMARY KEY (user_id,album_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `useruser`
--

CREATE TABLE  `users_users` (
  `id_one` int(11) NOT NULL,
  `id_two` int(11) NOT NULL,
  `relationship` int(11) NOT NULL,
  foreign key (id_one) references users(id),
  foreign key (id_two) references users(id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

