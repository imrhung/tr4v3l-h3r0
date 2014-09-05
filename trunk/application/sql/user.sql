-- phpMyAdmin SQL Dump
-- version 3.5.8.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 06, 2014 at 12:09 AM
-- Server version: 5.5.37-0ubuntu0.12.04.1
-- PHP Version: 5.3.10-1ubuntu3.11

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `zadmin_heroforzero`
--

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `FullName` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RegisterDate` datetime DEFAULT NULL,
  `PhoneNumber` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Address` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `AvatarId` int(11) DEFAULT '1',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=176 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`Id`, `FullName`, `Email`, `RegisterDate`, `PhoneNumber`, `Address`, `AvatarId`) VALUES
(1, 'Vu Hoang Son', 'gun4boy@yahoo.com', '2014-04-25 00:00:00', '', NULL, 2),
(21, NULL, 'imrhung@yahoo.com', '2014-05-07 02:21:25', '84912880656', NULL, 1),
(24, 'Ngọc Tân', '0', '2014-05-12 00:00:00', '', NULL, 0),
(25, 'Angel Mai Mai', '0', '2014-05-12 00:00:00', '', NULL, 2),
(26, 'Saltilano Chan', 'green.peak93@gmail.com', '2014-05-19 00:00:00', '', NULL, 1),
(32, 'Luan Jenkins', 'luan.jenkins@gmail.com', '2014-06-06 00:00:00', '', NULL, 1),
(33, 'Tuan Anh Do', '0', '2014-06-08 00:00:00', '', NULL, 1),
(34, NULL, 'minhxle@hotmail.com', '2014-06-23 07:53:05', '01677743487', NULL, 1),
(35, 'Mariah Cannon', '0', '2014-06-24 00:00:00', '', NULL, 1),
(36, NULL, 'mariahhcannon@gmail.com', '2014-07-03 04:09:53', '012345678', NULL, 1),
(37, 'Nathan Heffington', '0', '2014-07-12 00:00:00', '', NULL, 1),
(38, NULL, 'Dana@LINvn.org', '2014-07-14 02:05:44', '848-3512-0092', NULL, 1),
(39, NULL, 'contact@thaodan.org.vn', '2014-07-16 04:03:31', '(08)38465410', NULL, 1),
(40, NULL, 'info@luanjenkins.com', '2014-07-21 03:48:39', '0902826031', NULL, 1),
(41, 'Imr Hung', '50901113@stu.hcmut.edu.vn', '2014-07-25 00:00:00', '', NULL, 1),
(42, 'Mã Trung', '0', '2014-07-25 00:00:00', '', NULL, 1),
(43, 'Sky Nguyễn', '0', '2014-07-25 00:00:00', '', NULL, 1),
(44, 'Boynamanh Duc', '0', '2014-07-25 00:00:00', '', NULL, 1),
(45, 'Nam Bui', '0', '2014-07-25 00:00:00', '', NULL, 1),
(46, 'Philip Mai', 'phituanma@yahoo.com', '2014-07-26 00:00:00', '', NULL, 1),
(47, '', NULL, '2014-08-06 00:00:00', NULL, NULL, 1),
(48, 'tan', NULL, '2014-08-07 00:00:00', NULL, NULL, 1),
(49, 'Tan', NULL, '2014-08-08 00:00:00', NULL, NULL, 1),
(50, 'Tan', NULL, '2014-08-08 00:00:00', NULL, NULL, 1),
(51, '0', NULL, '2014-08-10 00:00:00', NULL, NULL, 1),
(52, 'Tan', NULL, '2014-08-11 00:00:00', NULL, NULL, 1),
(53, 'Tan', NULL, '2014-08-11 00:00:00', NULL, NULL, 1),
(54, 'Tan', NULL, '2014-08-11 00:00:00', NULL, NULL, 1),
(55, 'Tan', NULL, '2014-08-13 00:00:00', NULL, NULL, 1),
(56, 'Tan', NULL, '2014-08-13 00:00:00', NULL, NULL, 1),
(57, 'Tan', NULL, '2014-08-14 00:00:00', NULL, NULL, 1),
(58, 'Tan', NULL, '2014-08-14 00:00:00', NULL, NULL, 1),
(59, 'Tan', NULL, '2014-08-14 00:00:00', NULL, NULL, 1),
(60, 'Tan', NULL, '2014-08-14 00:00:00', NULL, NULL, 1),
(61, 'Tan', NULL, '2014-08-14 00:00:00', NULL, NULL, 1),
(62, 'Tan', NULL, '2014-08-14 00:00:00', NULL, NULL, 1),
(63, 'Tan', NULL, '2014-08-14 00:00:00', NULL, NULL, 1),
(64, 'Tan', NULL, '2014-08-14 00:00:00', NULL, NULL, 1),
(65, 'Tan', NULL, '2014-08-14 00:00:00', NULL, NULL, 1),
(66, 'Tan', NULL, '2014-08-15 00:00:00', NULL, NULL, 1),
(67, 'Tan', NULL, '2014-08-15 00:00:00', NULL, NULL, 1),
(68, 'Tan', NULL, '2014-08-15 00:00:00', NULL, NULL, 1),
(69, 'luan', NULL, '2014-08-15 00:00:00', NULL, NULL, 1),
(70, 'hi', NULL, '2014-08-15 00:00:00', NULL, NULL, 1),
(71, 'test', NULL, '2014-08-15 00:00:00', NULL, NULL, 1),
(72, 'zues', NULL, '2014-08-15 00:00:00', NULL, NULL, 1),
(73, 'ust', NULL, '2014-08-15 00:00:00', NULL, NULL, 1),
(74, 'tes', NULL, '2014-08-16 00:00:00', NULL, NULL, 1),
(75, 'tan', NULL, '2014-08-16 00:00:00', NULL, NULL, 1),
(76, 'philip', NULL, '2014-08-16 00:00:00', NULL, NULL, 1),
(77, 'hoang', NULL, '2014-08-16 00:00:00', NULL, NULL, 1),
(78, 'Tan', NULL, '2014-08-18 00:00:00', NULL, NULL, 1),
(79, 'son', NULL, '2014-08-18 00:00:00', NULL, NULL, 1),
(80, 'Tan', NULL, '2014-08-19 00:00:00', NULL, NULL, 1),
(81, 'Philips', NULL, '2014-08-19 00:00:00', NULL, NULL, 1),
(82, 'Tan', NULL, '2014-08-19 00:00:00', NULL, NULL, 1),
(83, 'Ngoctan', NULL, '2014-08-21 00:00:00', NULL, NULL, 1),
(84, 'tan1', NULL, '2014-08-21 00:00:00', NULL, NULL, 1),
(85, 'tan2', NULL, '2014-08-21 00:00:00', NULL, NULL, 1),
(86, 'Philip1', NULL, '2014-08-22 00:00:00', NULL, NULL, 1),
(87, 'Mai Mai', NULL, '2014-08-22 00:00:00', NULL, NULL, 1),
(88, 'tan4', NULL, '2014-08-23 00:00:00', NULL, NULL, 1),
(89, 'tan3', NULL, '2014-08-25 00:00:00', NULL, NULL, 1),
(90, 'tan5', NULL, '2014-08-26 00:00:00', NULL, NULL, 1),
(91, 'hero1', NULL, '2014-08-26 00:00:00', NULL, NULL, 1),
(92, 'hero2', NULL, '2014-08-26 00:00:00', NULL, NULL, 1),
(93, 'tan6', NULL, '2014-08-26 00:00:00', NULL, NULL, 1),
(94, 'hung78', NULL, '2014-08-27 00:00:00', NULL, NULL, 1),
(95, 'tan7', NULL, '2014-08-27 00:00:00', NULL, NULL, 1),
(96, 'tan8', NULL, '2014-08-27 00:00:00', NULL, NULL, 1),
(97, 'tan9', NULL, '2014-08-27 00:00:00', NULL, NULL, 1),
(98, 'tan10', NULL, '2014-08-28 00:00:00', NULL, NULL, 1),
(99, 'tan11', NULL, '2014-08-28 00:00:00', NULL, NULL, 1),
(114, 'tan12', NULL, '2014-08-28 00:00:00', NULL, NULL, 0),
(115, 'philip2', NULL, '2014-08-29 00:00:00', NULL, NULL, 1),
(116, 'philip3', NULL, '2014-08-29 00:00:00', NULL, NULL, 2),
(117, 'Duc', NULL, '2014-08-29 00:00:00', NULL, NULL, 1),
(118, 'Zalo', NULL, '2014-08-29 00:00:00', NULL, NULL, 1),
(119, 'Ducn', NULL, '2014-08-29 00:00:00', NULL, NULL, 1),
(120, 'Ducnm', NULL, '2014-08-29 00:00:00', NULL, NULL, 1),
(121, 'Zalon', NULL, '2014-08-29 00:00:00', NULL, NULL, 1),
(122, 'luanjk', NULL, '2014-08-29 00:00:00', NULL, NULL, 1),
(123, 'luanjk2', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(124, 'đúc', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(125, 'luanjk3', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(126, 'tan13', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(127, 'tan14', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(128, 'tan15', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(129, 'tan16', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(130, 'tan17', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(131, 'tan18', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(132, 'tan19', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(133, 'tan20', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(134, 'tan21', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(135, 'nhỏ tan', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(136, 'ngoctan1', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(137, 'ngoctan2', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(138, 'ngoctan3', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(139, 'ngoctan4', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(140, 'ngoctan5', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(141, 'ngoctan6', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(142, 'ngoctan7', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(143, 'ngoctan8', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(144, 'ngoctan9', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(145, 'ngoctan10', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(146, 'ngoctan11', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(147, 'ngoctan12', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(148, 'ngoctan13', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(149, 'ngoctan14', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(150, 'ngoctan15', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(151, 'ngoctan16', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(152, 'ngoctan17', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(153, 'ngoctan18', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(154, 'ngoctan19', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(155, 'tan22', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(156, 'tan23', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(157, 'tan26', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(158, 'tan27', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(159, 'tan28', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(160, 'tan29', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(161, 'tan30', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(162, 'tan31', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(163, 'tan32', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(164, 'tan33', NULL, '2014-08-30 00:00:00', NULL, NULL, 0),
(165, 'tan34', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(166, 'tan35', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(167, 'tan36', NULL, '2014-08-30 00:00:00', NULL, NULL, 1),
(168, 'sonka', NULL, '2014-08-31 00:00:00', NULL, NULL, 2),
(169, 'tan37', NULL, '2014-09-01 00:00:00', NULL, NULL, 1),
(170, 'ert', NULL, '2014-09-03 00:00:00', NULL, NULL, 1),
(171, 'tan38', NULL, '2014-09-03 00:00:00', NULL, NULL, 1),
(172, 'tan39', NULL, '2014-09-03 00:00:00', NULL, NULL, 1),
(173, 'tan40', NULL, '2014-09-03 00:00:00', NULL, NULL, 1),
(174, 'tan41', NULL, '2014-09-04 00:00:00', NULL, NULL, 1),
(175, 'tan42', NULL, '2014-09-04 00:00:00', NULL, NULL, 1);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
