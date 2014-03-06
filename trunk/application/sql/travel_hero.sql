-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Feb 27, 2014 at 12:27 PM
-- Server version: 5.5.27-log
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `travel_hero`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`user_hau`@`localhost` PROCEDURE `sp_allquestofuseraccept`(IN iUserId INT)
BEGIN
	SELECT * FROM quest
	INNER JOIN user_quest
	ON quest.id = user_quest.quest_id
	WHERE user_quest.user_id = iUserId;
END$$

CREATE DEFINER=`user_hau`@`localhost` PROCEDURE `sp_checksignupwithemailinfo`(iFullName VARCHAR(100),
											iHeroName VARCHAR(100),
											iEmail VARCHAR(100),
											iPhoneNumber VARCHAR(100),
											iPassword VARCHAR(100))
BEGIN
	IF EXISTS(SELECT * FROM user WHERE email = iEmail OR hero_name = iHeroName) THEN
		SELECT -1 AS id;
	ELSE
		INSERT INTO user(full_name, hero_name, email, phone_number, `password`, register_date)
		VALUES(iFullName, iHeroName, iEmail, iPhoneNumber, iPassword, NOW());
		SELECT * FROM user WHERE hero_name = iHeroName;
	END IF;
END$$

CREATE DEFINER=`user_hau`@`localhost` PROCEDURE `sp_checksignupwithfacebookinfo`(IN iFacebookId VARCHAR(100),
												IN iFullName VARCHAR(100),
												IN iHeroName VARCHAR(100),
												IN iEmail VARCHAR(100))
BEGIN

	IF EXISTS(SELECT * FROM user WHERE facebook_id = iFacebookId OR hero_name = iHeroName) THEN
		 SELECT '0' as `code`, user.*, (SELECT COUNT(*) FROM user_quest WHERE user_quest.user_id = (SELECT id FROM user WHERE facebook_id = iFacebookId)) AS quest_count FROM user WHERE facebook_id = iFacebookId;
	ELSE
		INSERT INTO user(full_name, hero_name, email, facebook_id, register_date)
		VALUES(iFullName, iHeroName, iEmail, iFacebookId, NOW());
		SELECT '1' as `code`, user.*, (SELECT COUNT(*) FROM user_quest WHERE user_quest.user_id = (SELECT id FROM user WHERE facebook_id = iFacebookId)) AS quest_count FROM user WHERE facebook_id = iFacebookId;
	END IF;
END$$

CREATE DEFINER=`user_hau`@`localhost` PROCEDURE `sp_getparentquest`(IN iQuestId INT)
BEGIN
	SELECT * FROM quest WHERE id = (SELECT parent_quest_id FROM quest WHERE id = iQuestId);
END$$

CREATE DEFINER=`user_hau`@`localhost` PROCEDURE `sp_getquestrefer`(IN iQuestId INT)
BEGIN
	SELECT * FROM quest WHERE parent_quest_id = (SELECT parent_quest_id FROM quest WHERE id = iQuestId) ORDER BY id ASC;
END$$

CREATE DEFINER=`user_hau`@`localhost` PROCEDURE `sp_getuserdatawithemail`(IN userName VARCHAR(100), IN pass VARCHAR(100))
BEGIN
	DECLARE userId INT;
	SELECT id INTO userId FROM user WHERE email = userName AND `password` = pass;
	SELECT *,(SELECT COUNT(*) FROM user_quest WHERE user_quest.user_id = userId) AS quest_count FROM user WHERE id = userId;
END$$

CREATE DEFINER=`user_hau`@`localhost` PROCEDURE `sp_getuserdatawithfacebook`(IN facebookId VARCHAR(100))
BEGIN
	DECLARE userId INT;
	SELECT id INTO userId FROM user WHERE facebook_id = facebookId;
	SELECT *,(SELECT COUNT(*) FROM user_quest WHERE user_quest.user_id = userId) AS quest_count FROM user WHERE id = userId;
END$$

CREATE DEFINER=`user_hau`@`localhost` PROCEDURE `sp_paginationhotelagodabydistance`(IN currentPage INT
																						, IN pageSize INT
																						, IN iLat FLOAT
																						, IN iLon FLOAT
																						, IN iDistance FLOAT
																						, IN iCountryisocode VARCHAR(2))
BEGIN
	DECLARE rowNumber INT;
	SET currentPage = currentPage + 1;
	SET rowNumber = currentPage * pageSize;
	SELECT *, (((acos(sin((iLat * 0.0174)) 
				* sin((hotel_agoda.latitude * 0.0174))
				+cos((iLat*0.0174)) 
				* cos((hotel_agoda.latitude * 0.0174)) 
				*cos(((iLon- hotel_agoda.longitude)*0.0174))))*57.32484)*111.18957696) as distance
	FROM hotel_agoda 
	WHERE countryisocode = iCountryisocode
	HAVING distance <= iDistance
	ORDER BY distance
	LIMIT rowNumber, pageSize;
END$$

CREATE DEFINER=`user_hau`@`localhost` PROCEDURE `sp_paginationquest`(IN currentPage INT, IN pageSize INT)
BEGIN
	DECLARE rowNumber INT;
	SET currentPage = currentPage;
	SET rowNumber = currentPage * pageSize;

	SELECT A.* FROM quest A WHERE !isnull(A.parent_quest_id)
	ORDER BY A.id LIMIT rowNumber, pageSize;
END$$

CREATE DEFINER=`user_hau`@`localhost` PROCEDURE `sp_useracceptquest`(IN iUserId INT, IN iQuestId INT, IN iParentQuestId INT)
BEGIN
	IF NOT EXISTS(SELECT * FROM quest WHERE id = iQuestId AND parent_quest_id = iParentQuestId) THEN
		SELECT 0 AS `code`;
	ELSE
		IF EXISTS(SELECT * FROM user_quest WHERE user_id = iUserId AND quest_id = iQuestId) THEN
			SELECT 0 AS `code`;
		ELSE
			INSERT INTO user_quest(user_id, quest_id, parent_quest_id) VALUES (iUserId, iQuestId, iParentQuestId);
			SELECT 1 AS `code`;
		END IF;
	END IF;
END$$

CREATE DEFINER=`user_hau`@`localhost` PROCEDURE `sp_usercompletequest`(IN iUserId INT, IN iQuestId INT)
BEGIN
	DECLARE parentQuestId INT;
	SELECT parent_quest_id INTO parentQuestId FROM quest WHERE id = iQuestId;

	IF EXISTS(SELECT * FROM user_quest WHERE user_id = iUserId AND quest_id = iQuestId AND status_quest = 0) THEN
		SET SQL_SAFE_UPDATES=0;
		UPDATE user_quest SET status_quest = 1 WHERE user_id = iUserId AND quest_id = iQuestId;
		-- check main quest
		
		SET SQL_SAFE_UPDATES=0;
		UPDATE user SET points = points + (SELECT points FROM quest WHERE id = iQuestId) WHERE id = iUserId;
		
		IF ((SELECT COUNT(*) 
			 FROM quest 
			 WHERE parent_quest_id = parentQuestId) = (SELECT COUNT(*) 
													   FROM user_quest 
													   WHERE user_id = iUserId
															AND parent_quest_id = parentQuestId
															AND status_quest = 1))
		THEN
			SET SQL_SAFE_UPDATES=0;
			UPDATE user SET points = points + (SELECT points FROM quest WHERE id = parentQuestId) WHERE id = iUserId;
			INSERT INTO user_quest VALUES (iUserId, parentQuestId, null, 1);
			SELECT 2 AS `code`, 'Complete Main Quest' AS `message`,  quest.*,reward.* from quest, reward where quest.id = parentQuestId and quest.reward_id = reward.id;
		ELSE
			SELECT 1 AS `code`, 'Complete Quest' AS `message`;
		END IF;
	ELSE
		SELECT 0 AS `code`, 'Fail' AS `message`;
	END IF;
END$$

CREATE DEFINER=`user_hau`@`localhost` PROCEDURE `test`()
BEGIN 
	DECLARE a INT;
	SELECT id INTO a FROM quest WHERE id = 1;
	SELECT a;
END$$

--
-- Functions
--
CREATE DEFINER=`user_hau`@`localhost` FUNCTION `fnc_checkSignUpInfo`(iFullName VARCHAR(100),
									iHeroName VARCHAR(100),
									iEmail VARCHAR(100),
									iPhoneNumber VARCHAR(100),
									iPassword VARCHAR(100)) RETURNS int(11)
BEGIN
	DECLARE count INT;
	DECLARE resultCode INT;
    SELECT COUNT(*) INTO count FROM user WHERE email = iEmail OR hero_name = iHeroName;

	IF count > 0 THEN
		SET resultCode = 0;
	ELSE
		INSERT INTO user
		VALUES(iFullName, iHeroName, iEmail, iPhoneNumber, iPassword, null, null, 1, 1, 0, NOW());
		SET resultCode = 1;
	END IF;
	RETURN resultCode;
END$$

CREATE DEFINER=`user_hau`@`localhost` FUNCTION `fnc_checkSignUpWithFacebookInfo`(iFacebookId VARCHAR(100),
												iFullName VARCHAR(100),
												iHeroName VARCHAR(100)) RETURNS int(11)
BEGIN
	DECLARE count INT;
	DECLARE resultCode INT;
    

	IF EXISTS(SELECT * FROM user WHERE facebook_id = iFacebookId OR hero_name = iHeroName) THEN
		SET resultCode = 0;
	ELSE
		INSERT INTO user
		VALUES(UUID(), iFullName, iHeroName, null, null, null, null, null, 1, 1, 0, NOW());
		SET resultCode = 1;
	END IF;
	RETURN resultCode;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `app_sessions`
--

CREATE TABLE IF NOT EXISTS `app_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `last_activity_idx` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `app_sessions`
--

INSERT INTO `app_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('cfc9d6a5872fe8ef42945a5794d651de', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.117 Safari/537.36', 1393499953, 'a:6:{s:9:"user_data";s:0:"";s:8:"identity";s:25:"50901113@stu.hcmut.edu.vn";s:8:"username";s:8:"imr.hung";s:5:"email";s:25:"50901113@stu.hcmut.edu.vn";s:7:"user_id";s:1:"8";s:14:"old_last_login";s:10:"1393471035";}');

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `name`, `description`) VALUES
(1, 'admin', 'Administrator'),
(2, 'members', 'General User');

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

CREATE TABLE IF NOT EXISTS `login_attempts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varbinary(16) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `quest`
--

CREATE TABLE IF NOT EXISTS `quest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `latitude` float DEFAULT '0',
  `longitude` float DEFAULT '0',
  `movie_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qrcode_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `quest_owner_id` int(11) DEFAULT '0',
  `parent_quest_id` int(11) DEFAULT NULL,
  `image_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `points` int(11) DEFAULT '0',
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reward_id` int(11) DEFAULT NULL,
  `donate_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` int(11) NOT NULL DEFAULT '0' COMMENT 'Determine the state of this quest: pending, active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=28 ;

--
-- Dumping data for table `quest`
--

INSERT INTO `quest` (`id`, `name`, `description`, `latitude`, `longitude`, `movie_url`, `qrcode_url`, `quest_owner_id`, `parent_quest_id`, `image_url`, `points`, `address`, `reward_id`, `donate_url`, `state`) VALUES
(1, 'Big Quest 0', '', 10.7172, 106.73, '', NULL, 0, NULL, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/1fdac2ef-62c7-4d5e-b7c7-7ddadaa37840.jpg', 200, '1SB1-1 Mỹ Viên, Phú Mỹ Hưng, Tân Phú Ward, District 7, Ho Chi Minh City, Vietnam', 1, NULL, 1),
(2, 'Unicef Fight For Zero', 'UNICEF strives for Zero. That means, zero exploited children, zero abused children, and zero trafficked children.', 10.7739, 106.703, 'https://dl.dropboxusercontent.com/u/3243296/videos/UNICEF.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/497c717d-cc6d-4dfc-b615-90f628d0cb4d.png', 0, 1, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/b0d330a1-9697-4e90-8294-0a521a0a8e49.jpg', 1000, '115 Nguyen Hue, District 1, Ho Chi Minh City, Vietnam', NULL, 'https://unicef.org.vn/donate/', 1),
(3, 'Koto | Know One Teach One', 'Is a vocational training organisation for street and disadvantaged youth in Vietnam. Accepts youth whose backgrounds are primarily orphans, street kids and the poor in both the city and rural communities.', 10.7772, 106.704, 'https://dl.dropboxusercontent.com/u/3243296/videos/KOTO.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/76def669-8511-427f-abf0-e05656f357bb.png', 0, 1, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/5a39b469-601a-4344-be67-0eca9dad7f42.jpg', 1000, '89 Hai Bà Trưng, Bến Nghé Ward, District 1, Ho Chi Minh City, Vietnam', NULL, NULL, 0),
(4, 'Kristina Nobel Foundation', 'Christina Noble Children''s Foundation is an International Partnership of people dedicated to serving underprivileged children in Vietnam and Mongolia with the hope of helping each child maximize their life potential.', 10.7799, 106.686, 'https://dl.dropboxusercontent.com/u/3243296/videos/CNCF.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/d5c4c7ea-7249-4b89-861a-627057d4861e.png', 0, 1, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/dbdd9ed2-9482-426c-9191-0605279b7b79.jpg', 1000, '38 Tu Xuong Street \nDistrict 3 \nHO CHI MINH CITY \nVietnam', NULL, NULL, 0),
(5, 'Big Quest 1', '', 10.7172, 106.73, NULL, NULL, 0, NULL, '', 500, '1SB1-1 Mỹ Viên, Phú Mỹ Hưng, Tân Phú Ward, District 7, Ho Chi Minh City, Vietnam', 1, NULL, 0),
(6, 'American Red Cross in Vietnam', 'the American Red Cross has been working with the Vietnam Red Cross and other partners since early 2008 to improve access to and utilization of HIV information, treatment, care and support services.', 21.0222, 105.843, 'https://dl.dropboxusercontent.com/u/3243296/videos/American%20Red%20Cross_VN.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/5cc4d388-e8a0-4187-9178-f857cebcb0fd.png', 0, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/b7a95302-5f27-4534-8f98-918c2901ffaa.png', 800, '15 Thiền Quang, Hà Nội, Vietnam', NULL, 'https://www.redcross.org/quickdonate/index.jsp', 1),
(7, 'Blue Dragon Children’s Home', 'Blue Dragon Children''s Foundation is an Australian grassroots charity that reaches out to kids in crisis throughout Vietnam.', 21.0259, 105.847, 'https://dl.dropboxusercontent.com/u/3243296/videos/blueDragonChildrensHome.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/a75d1db9-b5b0-4369-85fd-b85cdbaf819a.png', 0, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/a09eeafc-5c08-447b-bc36-b763a016ff40.png', 500, '66 Nghĩa Dũng, Phúc Xá, Ha Noi, Vietnam', NULL, NULL, 1),
(8, 'Care International in Vietnam', 'CARE has worked in Vietnam since 1989. As Vietnam becomes a middle-income country, we are concentrating our work on supporting rights and sustainable development among the most vulnerable groups in Vietnam, for example remote ethnic minorities, poor women and girls, and people vulnerable to climate change.', 21.0681, 105.823, 'https://dl.dropboxusercontent.com/u/3243296/videos/care_international.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/939389c7-3e0f-4071-aa30-9caa2742444d.png', 0, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/d7c7942e-41fe-4d2d-ab7e-b8583e06c3ca.png', 500, '92 Tô Ngọc Vân, Quảng An, Tây Hồ, Hanoi, Vietnam', NULL, NULL, 1),
(9, 'UNICEF Next Generation', 'a group of young entrepreneurs that advocate for UNICEF in the United-States, visited UNICEF projects in Ho Chi Minh City and Dong Thap. UNICEF Next Generation United States members are influential and passionate young adults (age 18-35) who are committed to supporting UNICEF''s mission to fulfill the rights of all children through the deliverance of educational and fundraising programmes', 10.7739, 106.703, 'https://dl.dropboxusercontent.com/u/3243296/videos/UNICEF%20next_genmp4.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/2a6b4946-2c8b-441f-93cd-2c61490d1f32.png', 1, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/49aa2afa-4068-42d8-9401-6113e4fa8065.jpg', 2000, '115 Nguyen Hue, District 1, Ho Chi Minh City, Vietnam', NULL, 'https://unicef.org.vn/donate/', 0),
(10, 'Big Quest 0', '', 10.7172, 106.73, '', NULL, 0, NULL, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/1fdac2ef-62c7-4d5e-b7c7-7ddadaa37840.jpg', 200, '1SB1-1 Mỹ Viên, Phú Mỹ Hưng, Tân Phú Ward, District 7, Ho Chi Minh City, Vietnam', 1, NULL, 1),
(11, 'Unicef Fight For Zero', 'UNICEF strives for Zero. That means, zero exploited children, zero abused children, and zero trafficked children.', 10.7739, 106.703, 'https://dl.dropboxusercontent.com/u/3243296/videos/UNICEF.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/497c717d-cc6d-4dfc-b615-90f628d0cb4d.png', 0, 1, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/b0d330a1-9697-4e90-8294-0a521a0a8e49.jpg', 1000, '115 Nguyen Hue, District 1, Ho Chi Minh City, Vietnam', NULL, 'https://unicef.org.vn/donate/', 1),
(12, 'Koto | Know One Teach One', 'Is a vocational training organisation for street and disadvantaged youth in Vietnam. Accepts youth whose backgrounds are primarily orphans, street kids and the poor in both the city and rural communities.', 10.7772, 106.704, 'https://dl.dropboxusercontent.com/u/3243296/videos/KOTO.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/76def669-8511-427f-abf0-e05656f357bb.png', 0, 1, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/5a39b469-601a-4344-be67-0eca9dad7f42.jpg', 1000, '89 Hai Bà Trưng, Bến Nghé Ward, District 1, Ho Chi Minh City, Vietnam', NULL, NULL, 0),
(13, 'Kristina Nobel Foundation', 'Christina Noble Children''s Foundation is an International Partnership of people dedicated to serving underprivileged children in Vietnam and Mongolia with the hope of helping each child maximize their life potential.', 10.7799, 106.686, 'https://dl.dropboxusercontent.com/u/3243296/videos/CNCF.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/d5c4c7ea-7249-4b89-861a-627057d4861e.png', 0, 1, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/dbdd9ed2-9482-426c-9191-0605279b7b79.jpg', 1000, '38 Tu Xuong Street \nDistrict 3 \nHO CHI MINH CITY \nVietnam', NULL, NULL, 0),
(14, 'Big Quest 1', '', 10.7172, 106.73, NULL, NULL, 0, NULL, '', 500, '1SB1-1 Mỹ Viên, Phú Mỹ Hưng, Tân Phú Ward, District 7, Ho Chi Minh City, Vietnam', 1, NULL, 0),
(15, 'American Red Cross in Vietnam', 'the American Red Cross has been working with the Vietnam Red Cross and other partners since early 2008 to improve access to and utilization of HIV information, treatment, care and support services.', 21.0222, 105.843, 'https://dl.dropboxusercontent.com/u/3243296/videos/American%20Red%20Cross_VN.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/5cc4d388-e8a0-4187-9178-f857cebcb0fd.png', 0, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/b7a95302-5f27-4534-8f98-918c2901ffaa.png', 800, '15 Thiền Quang, Hà Nội, Vietnam', NULL, 'https://www.redcross.org/quickdonate/index.jsp', 0),
(16, 'Blue Dragon Children’s Home', 'Blue Dragon Children''s Foundation is an Australian grassroots charity that reaches out to kids in crisis throughout Vietnam.', 21.0259, 105.847, 'https://dl.dropboxusercontent.com/u/3243296/videos/blueDragonChildrensHome.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/a75d1db9-b5b0-4369-85fd-b85cdbaf819a.png', 0, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/a09eeafc-5c08-447b-bc36-b763a016ff40.png', 500, '66 Nghĩa Dũng, Phúc Xá, Ha Noi, Vietnam', NULL, NULL, 0),
(17, 'Care International in Vietnam', 'CARE has worked in Vietnam since 1989. As Vietnam becomes a middle-income country, we are concentrating our work on supporting rights and sustainable development among the most vulnerable groups in Vietnam, for example remote ethnic minorities, poor women and girls, and people vulnerable to climate change.', 21.0681, 105.823, 'https://dl.dropboxusercontent.com/u/3243296/videos/care_international.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/939389c7-3e0f-4071-aa30-9caa2742444d.png', 0, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/d7c7942e-41fe-4d2d-ab7e-b8583e06c3ca.png', 500, '92 Tô Ngọc Vân, Quảng An, Tây Hồ, Hanoi, Vietnam', NULL, NULL, 0),
(18, 'UNICEF Next Generation', 'a group of young entrepreneurs that advocate for UNICEF in the United-States, visited UNICEF projects in Ho Chi Minh City and Dong Thap. UNICEF Next Generation United States members are influential and passionate young adults (age 18-35) who are committed to supporting UNICEF''s mission to fulfill the rights of all children through the deliverance of educational and fundraising programmes', 10.7739, 106.703, 'https://dl.dropboxusercontent.com/u/3243296/videos/UNICEF%20next_genmp4.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/2a6b4946-2c8b-441f-93cd-2c61490d1f32.png', 1, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/49aa2afa-4068-42d8-9401-6113e4fa8065.jpg', 2000, '115 Nguyen Hue, District 1, Ho Chi Minh City, Vietnam', NULL, 'https://unicef.org.vn/donate/', 0),
(19, 'Big Quest 0', '', 10.7172, 106.73, '', NULL, 0, NULL, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/1fdac2ef-62c7-4d5e-b7c7-7ddadaa37840.jpg', 200, '1SB1-1 Mỹ Viên, Phú Mỹ Hưng, Tân Phú Ward, District 7, Ho Chi Minh City, Vietnam', 1, NULL, 1),
(20, 'Unicef Fight For Zero', 'UNICEF strives for Zero. That means, zero exploited children, zero abused children, and zero trafficked children.', 10.7739, 106.703, 'https://dl.dropboxusercontent.com/u/3243296/videos/UNICEF.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/497c717d-cc6d-4dfc-b615-90f628d0cb4d.png', 0, 1, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/b0d330a1-9697-4e90-8294-0a521a0a8e49.jpg', 1000, '115 Nguyen Hue, District 1, Ho Chi Minh City, Vietnam', NULL, 'https://unicef.org.vn/donate/', 0),
(21, 'Koto | Know One Teach One', 'Is a vocational training organisation for street and disadvantaged youth in Vietnam. Accepts youth whose backgrounds are primarily orphans, street kids and the poor in both the city and rural communities.', 10.7772, 106.704, 'https://dl.dropboxusercontent.com/u/3243296/videos/KOTO.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/76def669-8511-427f-abf0-e05656f357bb.png', 0, 1, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/5a39b469-601a-4344-be67-0eca9dad7f42.jpg', 1000, '89 Hai Bà Trưng, Bến Nghé Ward, District 1, Ho Chi Minh City, Vietnam', NULL, NULL, 0),
(22, 'Kristina Nobel Foundation', 'Christina Noble Children''s Foundation is an International Partnership of people dedicated to serving underprivileged children in Vietnam and Mongolia with the hope of helping each child maximize their life potential.', 10.7799, 106.686, 'https://dl.dropboxusercontent.com/u/3243296/videos/CNCF.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/d5c4c7ea-7249-4b89-861a-627057d4861e.png', 0, 1, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/dbdd9ed2-9482-426c-9191-0605279b7b79.jpg', 1000, '38 Tu Xuong Street \nDistrict 3 \nHO CHI MINH CITY \nVietnam', NULL, NULL, 0),
(23, 'Big Quest 1', '', 10.7172, 106.73, NULL, NULL, 0, NULL, '', 500, '1SB1-1 Mỹ Viên, Phú Mỹ Hưng, Tân Phú Ward, District 7, Ho Chi Minh City, Vietnam', 1, NULL, 0),
(24, 'American Red Cross in Vietnam', 'the American Red Cross has been working with the Vietnam Red Cross and other partners since early 2008 to improve access to and utilization of HIV information, treatment, care and support services.', 21.0222, 105.843, 'https://dl.dropboxusercontent.com/u/3243296/videos/American%20Red%20Cross_VN.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/5cc4d388-e8a0-4187-9178-f857cebcb0fd.png', 0, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/b7a95302-5f27-4534-8f98-918c2901ffaa.png', 800, '15 Thiền Quang, Hà Nội, Vietnam', NULL, 'https://www.redcross.org/quickdonate/index.jsp', 0),
(25, 'Blue Dragon Children’s Home', 'Blue Dragon Children''s Foundation is an Australian grassroots charity that reaches out to kids in crisis throughout Vietnam.', 21.0259, 105.847, 'https://dl.dropboxusercontent.com/u/3243296/videos/blueDragonChildrensHome.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/a75d1db9-b5b0-4369-85fd-b85cdbaf819a.png', 0, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/a09eeafc-5c08-447b-bc36-b763a016ff40.png', 500, '66 Nghĩa Dũng, Phúc Xá, Ha Noi, Vietnam', NULL, NULL, 0),
(26, 'Care International in Vietnam', 'CARE has worked in Vietnam since 1989. As Vietnam becomes a middle-income country, we are concentrating our work on supporting rights and sustainable development among the most vulnerable groups in Vietnam, for example remote ethnic minorities, poor women and girls, and people vulnerable to climate change.', 21.0681, 105.823, 'https://dl.dropboxusercontent.com/u/3243296/videos/care_international.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/939389c7-3e0f-4071-aa30-9caa2742444d.png', 0, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/d7c7942e-41fe-4d2d-ab7e-b8583e06c3ca.png', 500, '92 Tô Ngọc Vân, Quảng An, Tây Hồ, Hanoi, Vietnam', NULL, NULL, 1),
(27, 'UNICEF Next Generation', 'a group of young entrepreneurs that advocate for UNICEF in the United-States, visited UNICEF projects in Ho Chi Minh City and Dong Thap. UNICEF Next Generation United States members are influential and passionate young adults (age 18-35) who are committed to supporting UNICEF''s mission to fulfill the rights of all children through the deliverance of educational and fundraising programmes', 10.7739, 106.703, 'https://dl.dropboxusercontent.com/u/3243296/videos/UNICEF%20next_genmp4.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/2a6b4946-2c8b-441f-93cd-2c61490d1f32.png', 1, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/49aa2afa-4068-42d8-9401-6113e4fa8065.jpg', 2000, '115 Nguyen Hue, District 1, Ho Chi Minh City, Vietnam', NULL, 'https://unicef.org.vn/donate/', 0);

-- --------------------------------------------------------

--
-- Table structure for table `quest_temp`
--

CREATE TABLE IF NOT EXISTS `quest_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `latitude` float DEFAULT '0',
  `longitude` float DEFAULT '0',
  `movie_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qrcode_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `quest_owner_id` int(11) DEFAULT '0',
  `parent_quest_id` int(11) DEFAULT NULL,
  `image_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `points` int(11) DEFAULT '0',
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reward_id` int(11) DEFAULT NULL,
  `donate_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

--
-- Dumping data for table `quest_temp`
--

INSERT INTO `quest_temp` (`id`, `name`, `description`, `latitude`, `longitude`, `movie_url`, `qrcode_url`, `quest_owner_id`, `parent_quest_id`, `image_url`, `points`, `address`, `reward_id`, `donate_url`, `state`) VALUES
(1, 'Test', 'notest', 10.7767, 106.684, NULL, NULL, 0, 5, NULL, 100, '256 Dien Bien Phu, Quan 3, HCM', NULL, 'http://www.php.net/manual/en/reserved.variables.request.php', 0),
(2, 'Test', 'test', 10.7767, 106.684, NULL, NULL, 0, 1, NULL, 100, '256 Dien Bien Phu, Quan 3, HCM', NULL, 'http://www.php.net/manual/en/reserved.variables.request.php', 0),
(3, 'Test', 'test3', 10.7767, 106.684, NULL, NULL, 0, 1, NULL, 50, '256 Dien Bien Phu, Quan 3, HCM', NULL, 'http://www.php.net/manual/en/reserved.variables.request.php', 0),
(4, 'Test Quest Form', 'The test begin', 10.7861, 106.678, NULL, NULL, 0, NULL, NULL, 50, '47 tran quang dieu', NULL, '', 0),
(5, 'Test', 'test', 10.7767, 106.684, NULL, NULL, 0, 1, 'http://mytempbucket.s3.amazonaws.com/1392013900.jpg', 100, '256 Dien Bien Phu, Quan 3, HCM', NULL, 'http://www.php.net/manual/en/reserved.variables.request.php', 0),
(6, 'Take me inside', 'Give a hand to help a child.', 21.0433, 105.896, NULL, NULL, 0, 5, 'http://mytempbucket.s3.amazonaws.com/1392013900.jpg', 50, '123 Nguyen Van Linh', NULL, 'http://www.php.net/manual/en/reserved.variables.request.php', 0),
(7, 'Take me inside', 'Give a hand to help a child.', 21.0433, 105.896, NULL, NULL, 0, 5, 'http://mytempbucket.s3.amazonaws.com/1392013900.jpg', 50, '123 Nguyen Van Linh', NULL, 'http://www.php.net/manual/en/reserved.variables.request.php', 0);

-- --------------------------------------------------------

--
-- Table structure for table `reward`
--

CREATE TABLE IF NOT EXISTS `reward` (
  `id` int(11) NOT NULL,
  `reward_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_url` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `reward`
--

INSERT INTO `reward` (`id`, `reward_name`, `image_url`) VALUES
(1, 'Medal of HONOR', 'http://ec2-54-200-123-156.us-west-2.compute.amazonaws.com/travelhero/images/medals/d6cd052f-273b-4192-9af2-5769db01ed04.png'),
(2, 'Trophy of HONOR', 'http://ec2-54-200-123-156.us-west-2.compute.amazonaws.com/travelhero/images/medals/e266579b-df4c-49a4-9146-eba7a8a11961.png');

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE IF NOT EXISTS `test` (
  `id` int(11) NOT NULL DEFAULT '0',
  `fullname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`id`, `fullname`) VALUES
(1, 'a'),
(2, 'b'),
(3, 'c'),
(4, 'd'),
(5, 'e'),
(6, 'f'),
(7, 'g'),
(8, 'h'),
(9, 'i'),
(10, 'j'),
(11, 'k'),
(12, 'l'),
(13, 'm'),
(14, 'n'),
(15, 'o'),
(16, 'p'),
(17, 'q'),
(71, 'a'),
(92, 'b'),
(103, 'c'),
(114, 'd'),
(125, 'e'),
(136, 'f'),
(147, 'g'),
(158, 'h');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hero_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `facebook_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `current_level` int(11) DEFAULT '0',
  `points` int(11) DEFAULT '0',
  `accept_tou` bit(1) DEFAULT b'0',
  `register_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `full_name`, `hero_name`, `email`, `phone_number`, `password`, `facebook_id`, `address`, `current_level`, `points`, `accept_tou`, `register_date`) VALUES
(0, 'Unicef Vietnam', 'UnicefVn', 'contact@unicef.org.vn', '0987654321', '0000', NULL, NULL, 0, 0, '0', '2014-02-17'),
(1, 'Vu Hoang Son', 'vhson', 'gun4boy@yahoo.com', NULL, NULL, '1498934909', NULL, 0, 0, '0', '2013-12-02'),
(5, 'Martial Ganière', 'martialganiere', 'martial.ganiere@gmail.com', NULL, NULL, '841843895', NULL, 0, 0, '0', '2014-01-11'),
(6, 'Keviin Q Nguyen', 'keviin.q.nguyen', 'lqnguyen@live.co.uk', NULL, NULL, '507981927', NULL, 0, 0, '0', '2014-01-12'),
(7, 'Luan Jenkins', 'luanjenkins', 'luan.jenkins@gmail.com', NULL, NULL, '85500069', NULL, 0, 0, '0', '2014-01-24');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varbinary(16) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(80) NOT NULL,
  `salt` varchar(40) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `activation_code` varchar(40) DEFAULT NULL,
  `forgotten_password_code` varchar(40) DEFAULT NULL,
  `forgotten_password_time` int(11) unsigned DEFAULT NULL,
  `remember_code` varchar(40) DEFAULT NULL,
  `created_on` int(11) unsigned NOT NULL,
  `last_login` int(11) unsigned DEFAULT NULL,
  `active` tinyint(1) unsigned DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `gender` int(1) NOT NULL,
  `url` varchar(256) NOT NULL,
  `bio` text NOT NULL,
  `birthday` date NOT NULL,
  `location` varchar(56) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `hero_name` varchar(100) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `facebook_id` varchar(100) NOT NULL,
  `address` varchar(200) NOT NULL,
  `current_level` int(11) NOT NULL DEFAULT '0',
  `point` int(11) NOT NULL DEFAULT '0',
  `accept_tou` bit(1) NOT NULL DEFAULT b'0',
  `register_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `gender`, `url`, `bio`, `birthday`, `location`, `full_name`, `hero_name`, `phone_number`, `facebook_id`, `address`, `current_level`, `point`, `accept_tou`, `register_date`) VALUES
(1, '\0\0', 'administrator', '59beecdf7fc966e2f17fd8f65a4a9aeb09d4a3d4', '9462e8eee0', 'admin@admin.com', '', NULL, NULL, '9d029802e28cd9c768e8e62277c0df49ec65c48c', 1268889823, 1393398559, 1, 'Admin', 'istrator', 'ADMIN', '0', 0, '', '', '0000-00-00', '', '', '', '', '', '', 0, 0, '0', '0000-00-00'),
(5, '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', 'nguyen hung', '972df4edf86993b212e52272d58baac2240e3af3', NULL, 'imrhung3@yahoo.com', NULL, NULL, NULL, '53d06108ae0d58e982780f8633648efbbfb00563', 1393147053, 1393164677, 1, 'Nguyen', 'Hung', 'SEED Inc.', '84912880656', 0, '', '', '0000-00-00', '', '', '', '', '', '', 0, 0, '0', '0000-00-00'),
(8, '\0\0', 'imr.hung', '025ed971853ccd493bd1a8615f273b16bb786800', NULL, '50901113@stu.hcmut.edu.vn', NULL, NULL, NULL, 'de143548ca32dc28afd51d88d84fe51119a18e62', 1393470989, 1393485901, 1, 'Imr', 'Hung', NULL, NULL, 1, 'https://www.facebook.com/imr.hung', 'I like to smile every time !', '1991-07-14', 'Ho Chi Minh City, Vietnam', '', '', '', '', '', 0, 0, '0', '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `users_groups`
--

CREATE TABLE IF NOT EXISTS `users_groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_users_groups` (`user_id`,`group_id`),
  KEY `fk_users_groups_users1_idx` (`user_id`),
  KEY `fk_users_groups_groups1_idx` (`group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `users_groups`
--

INSERT INTO `users_groups` (`id`, `user_id`, `group_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(6, 5, 2),
(13, 8, 2);

-- --------------------------------------------------------

--
-- Table structure for table `user_quest`
--

CREATE TABLE IF NOT EXISTS `user_quest` (
  `user_id` int(11) DEFAULT NULL,
  `quest_id` int(11) DEFAULT NULL,
  `parent_quest_id` int(11) DEFAULT NULL,
  `status_quest` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_quest`
--

INSERT INTO `user_quest` (`user_id`, `quest_id`, `parent_quest_id`, `status_quest`) VALUES
(1, 2, 1, 0),
(27, 8, 5, 0),
(1, 3, 1, 0),
(27, 6, 5, 0),
(27, 9, 5, 0),
(27, 2, 1, 0),
(6, 2, 1, 0),
(1, 7, 5, 0),
(1, 4, 1, 0);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `users_groups`
--
ALTER TABLE `users_groups`
  ADD CONSTRAINT `fk_users_groups_groups1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_users_groups_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
