-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 24, 2014 at 10:15 AM
-- Server version: 5.6.11
-- PHP Version: 5.5.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `travel_hero`
--
CREATE DATABASE IF NOT EXISTS `travel_hero` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `travel_hero`;

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Delete_Activity`(Id INT)
BEGIN
		DELETE FROM travel_hero.Activity
			WHERE Activity.Id = Id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Delete_Donation`(Id INT)
BEGIN
		DELETE FROM travel_hero.Donation
			WHERE Donation.Id = Id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Delete_QuestCondition`(Id INT)
BEGIN
	DELETE FROM travel_hero.questcondition WHERE VirtualQuestId = Id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Delete_Quiz`(Id INT)
BEGIN
	DELETE FROM travel_hero.quiz
		WHERE quiz.Id = Id;
				
	DELETE FROM travel_hero.choice
		WHERE choice.QuestionId = Id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Delete_VirtualQuest`(Id INT)
BEGIN
	DELETE FROM travel_hero.virtualquest
			WHERE virtualquest.Id = Id;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_Activity`(id INT)
BEGIN
	SELECT activity.*, partner.PartnerName FROM travel_hero.activity, travel_hero.action, travel_hero.partner
		
			
		WHERE
				activity.PartnerId = partner.Id
			AND
				activity.Id = id;
				
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_ActivityList`(IN currentPage INT, IN pageSize INT)
BEGIN
	DECLARE rowNumber INT;
	SET currentPage = currentPage;
	SET rowNumber = currentPage * pageSize;
	
	if (pageSize != 0) 
	then
		SELECT activity.Id, activity.Title, activity.ActionContent, partner.PartnerName, activity.BonusPoint,  activity.IsApproved, activity.CreateDate
		FROM 
				travel_hero.activity,
				travel_hero.partner
		WHERE 
				activity.PartnerId = partner.Id
		LIMIT  rowNumber, pageSize;
	
	else  
		SELECT activity.Id, activity.Title, activity.ActionContent, partner.PartnerName, activity.BonusPoint,  activity.IsApproved, activity.CreateDate
		FROM 
				travel_hero.activity,
				travel_hero.partner
		WHERE 
				activity.PartnerId = partner.Id;
		end if;	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_Donation`(Id INT)
BEGIN
	SELECT donation.Id, donation.Title, donation.Description, donation.PartnerId, partner.PartnerName, donation.RequiredPoint,  donation.IsApproved, donation.CreateDate
		FROM 
				travel_hero.donation,
				travel_hero.partner
		WHERE 
				donation.PartnerId = partner.Id
		AND 	donation.Id = Id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_DonationList`(IN currentPage INT, IN pageSize INT)
BEGIN
	DECLARE rowNumber INT;
	SET currentPage = currentPage;
	SET rowNumber = currentPage * pageSize;
	
	if (pageSize != 0) 
	then
		SELECT donation.Id, donation.Title, partner.PartnerName, donation.RequiredPoint,  donation.IsApproved, donation.CreateDate
		FROM 
				travel_hero.donation,
				travel_hero.partner
		WHERE 
				donation.PartnerId = partner.Id
		LIMIT  rowNumber, pageSize;
	
	else  
		SELECT donation.Id, donation.Title, partner.PartnerName, donation.RequiredPoint,  donation.IsApproved, donation.CreateDate
		FROM 
				travel_hero.donation,
				travel_hero.partner
		WHERE 
				donation.PartnerId = partner.Id;
		END if;	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_PacketList`(IN currentPage INT, IN pageSize INT)
BEGIN
	DECLARE rowNumber INT;
	
	SET currentPage = currentPage;
	SET rowNumber = currentPage * pageSize;
	
	if (pageSize != 0) 
	then	
		SELECT Id, Title FROM travel_hero.packet
		LIMIT rowNumber, pageSize;
	else
		SELECT Id, Title FROM travel_hero.packet;
	END if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_QuestCondition`(Id INT)
BEGIN
	
		SELECT 
			Id, 
			Type, 
			ObjectId,
			Value
		FROM travel_hero.questcondition
		WHERE questcondition.VirtualQuestId = Id;

	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_QuestCondition_before`(Id INT)
BEGIN
	DECLARE typeCondition INT;
	SET typeCondition = (SELECT Type FROM travel_hero.questcondition 
								WHERE questcondition.VirtualQuestId = Id);
	
	# Check: if it's quiz
	if(typeCondition = 0) then
		SELECT 
			Id, 
			Type, 
			ObjectId, 
			
			Value
		FROM travel_hero.virtualquest, questcondition
		WHERE questcondition.VirtualQuestId = Id;

	# Check: if it's activity
	elseif(typeCondition = 1) then
		SELECT 
			Id, 
			Type, 
			ObjectId, 
			activity.Title as ObjectName,
			Value
		FROM travel_hero.virtualquest, questcondition, activity
		WHERE 
				questcondition.VirtualQuestId = Id
			AND
				activity.Id = questcondition.ObjectId;

	# Check: if it's donation
	elseif(typeCondition = 2) then
		SELECT 
			Id, 
			Type, 
			ObjectId, 
			donation.Title as ObjectName,
			Value
		FROM travel_hero.virtualquest, questcondition, donation
		WHERE 
				questcondition.VirtualQuestId = Id
			AND
				donation.Id = questcondition.ObjectId;
	END if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_Quiz`(Id Int)
BEGIN
	SELECT quiz.*, quizcategory.CategoryName, choice.Id, choice.Content as answer, partner.PartnerName 
	FROM quizcategory, 
		 quiz,
		 choice, 
		 partner 
	WHERE 	
				quiz.Id 		= Id
		  AND   quiz.CategoryId = quizcategory.Id
		  AND   quiz.Id 		= choice.QuestionId
		  AND   quiz.PartnerId  = partner.Id;
	
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_QuizCategoryList`(IN currentPage INT, IN pageSize INT)
BEGIN
	DECLARE rowNumber INT;
	SET currentPage = currentPage;
	SET rowNumber = currentPage * pageSize;

	if (pageSize != 0) 
	then
		SELECT Id, CategoryName FROM travel_hero.quizcategory
		LIMIT rowNumber, pageSize;
	else
		SELECT Id, CategoryName FROM travel_hero.quizcategory;
	END if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_QuizList`(IN currentPage INT, IN pageSize INT)
BEGIN
	DECLARE rowNumber INT;
	
	SET currentPage = currentPage;
	SET rowNumber = currentPage * pageSize;
	
	if (pageSize != 0) 
	then	
		SELECT quiz.Id, quizcategory.CategoryName, quiz.IsApproved, partner.PartnerName, quiz.CreatedDate  
		FROM 
			 travel_hero.quiz,
			 travel_hero.partner,
			 travel_hero.quizcategory
		WHERE 
			 quiz.PartnerId  = partner.Id
		  AND
			 quiz.CategoryId = quizcategory.Id
		LIMIT rowNumber, pageSize;
	 else
		SELECT quiz.Id, quizcategory.CategoryName, quiz.IsApproved, partner.PartnerName, quiz.CreatedDate  
		FROM 
			 travel_hero.quiz,
			 travel_hero.partner,
			 travel_hero.quizcategory
		WHERE 
			 quiz.PartnerId  = partner.Id
		  AND
			 quiz.CategoryId = quizcategory.Id;
	end if;
	

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_VirtualQuest`(Id INT)
BEGIN
	SELECT 
		virtualquest.Id,
		QuestName,
		partner.PartnerName,
		UnlockPoint,
		CreateDate,
		PacketId,
		packet.Title as 'PacketName',
		questcondition.Id, 
		questcondition.Type, 
		questcondition.ObjectId,
		questcondition.Value
	FROM 
		travel_hero.virtualquest,
		partner, packet, questcondition
	WHERE 
				virtualquest.Id = Id
		AND		virtualquest.PartnerId = partner.Id
		AND		virtualquest.PacketId = packet.Id
		AND     questcondition.VirtualQuestId = Id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_VirtualQuestList`(IN currentPage INT, IN pageSize INT)
BEGIN
	declare rowNumber INT;
	SET currentPage = currentPage;
	SET rowNumber = currentPage * pageSize;

	if (pageSize != 0) 
	then
		SELECT virtualquest.Id, 
		QuestName,
		packet.Title as 'PacketName',
		UnlockPoint,
		CreateDate
				
		FROM travel_hero.virtualquest, packet
		WHERE virtualquest.PacketId = packet.Id
		LIMIT rowNumber, pageSize;
	else
SELECT virtualquest.Id, 
		QuestName,
		packet.Title as 'PacketName',
		UnlockPoint,
		CreateDate
				
		FROM travel_hero.virtualquest, packet
		WHERE virtualquest.PacketId = packet.Id;
	END if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Insert_Activity`(	
	title nvarchar(140),
	description nvarchar(140),
	partner_id int,	
	action_id int,
	action_content nvarchar(140),
	CreateDate datetime
)
BEGIN
	INSERT INTO Activity
				(
					Title,
					Description,
					PartnerId,
					ActionId,
					ActionContent,
					BonusPoint,
					CreateDate
				)
			VALUES
				(
					title,
					description,
					partner_id,
					action_id,
					action_content,
					100,
					CreateDate
				);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Insert_Choice`(
	Content nvarchar(500)
)
BEGIN
	DECLARE QuestionId INT;
	SET QuestionId = (SELECT MAX(quiz.Id) FROM quiz) + 1;
	INSERT INTO Choice(
						QuestionId,
						Content
						)
			VALUES(
					QuestionId,
					Content
					);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Insert_ConditionQuest`(
	type INT,
	objectId INT,
	Id INT
)
BEGIN
	INSERT INTO travel_hero.questcondition
				(
					questcondition.Type,
					ObjectId,
					VirtualQuestId
				)
			VALUES
				(
					type,
					objectId,
					Id
				);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Insert_Donation`(
	title nvarchar(150),
	description nvarchar(140),
	partner_id int,
	create_date datetime
)
BEGIN
	
	INSERT INTO DONATION
				(
					Title,
					Description,
					PartnerId,
					RequiredPoint,
					CreateDate
				)
			VALUES
				(
					title,
					description,
					partner_id,
					100,
					create_date
				);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Insert_Packet`(
	title 		nvarchar(140),
	imageUrl	nvarchar(140),
	partnerId 	int
)
BEGIN
	INSERT INTO travel_hero.packet
				(
					packet.Title,
					packet.ImageURL,
					packet.PartnerId
				)
			VALUES
				(
					title,
					imageUrl,
					PartnerId
				);
			
					
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Insert_Quiz`(
	questCategory 	int,
	questQuestion	nvarchar(140),
	CorrectChoiceId int,
	sharingInfo		nvarchar(8000),
	linkURL	     	nvarchar(200),
	partnerId		int,
	createdDate	  	datetime
)
BEGIN
	

	# Insert infomation into Quiz table
	INSERT INTO quiz(
						CategoryId,
						PartnerId,
                        CreatedDate,
						Content,
						CorrectChoiceId,
						SharingInfo,
						LearnMoreURL,
						BonusPoint
					)
				VALUES(
						questCategory,
						partnerId,
						createdDate,
						questQuestion,
						CorrectChoiceId,
						sharingInfo,
						linkURL,
						100
					);
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Insert_QuizCategory`(category nvarchar(140))
BEGIN
	INSERT INTO travel_hero.quizcategory
				(
					quizcategory.CategoryName
				)
			VALUES
				(
					category
				);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Insert_VirtualQuest`(
	partner_id Int,
	packet_id Int,
	name nvarchar(40),
	point INT,
	create_date datetime
	
)
BEGIN
	INSERT INTO travel_hero.virtualquest
				(
					PacketId,
					PartnerId,
					QuestName,
					UnlockPoint,
					CreateDate
				)
			VALUES
				(
					packet_id,
					partner_id,
					name,
					point,
					create_date
				);
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

CREATE DEFINER=`tan_user`@`localhost` PROCEDURE `sp_paginationquest`(IN currentPage INT, IN pageSize INT)
BEGIN
	DECLARE rowNumber INT;
	SET currentPage = currentPage;
	SET rowNumber = currentPage * pageSize;

	SELECT A.* FROM quest A WHERE !isnull(A.parent_quest_id)
	ORDER BY A.id LIMIT rowNumber, pageSize;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Update_Activity`(
	id INT,
	partner_id INT,
	title nvarchar(140),
	description nvarchar(140),
	action_id INT,
	action_content nvarchar(140),
	bonus_point INT,
	approve BIT
)
BEGIN
	UPDATE travel_hero.activity
			SET 
				activity.PartnerId = partner_id,
				activity.Title = title,
				activity.description = description,
				activity.ActionId = action_id,
				activity.BonusPoint = bonus_point,
				activity.IsApproved = approve,
				activity.ActionContent = action_content
			WHERE
				activity.Id = id;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Update_ActivityApprove`(Id int, IsApproved bit)
BEGIN
		UPDATE travel_hero.activity
		   SET 
				activity.IsApproved = IsApproved
		   WHERE
				activity.Id = Id;	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Update_BonusPoint_Activity`(Id int, point float)
BEGIN
	UPDATE activity
	SET
		activity.BonusPoint = point
	WHERE 
		activity.Id = Id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Update_BonusPoint_Quiz`(
	Id INT,
	BonusPoint float
)
BEGIN
	UPDATE  travel_hero.quiz
			SET
				BonusPoint = BonusPoint
			WHERE
				quiz.Id = Id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Update_Choice`(
	Id 		int,
	Content nvarchar(50)
)
BEGIN
	UPDATE choice 
		SET
			choice.Content = Content
		WHERE
			choice.Id = Id;	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Update_ConditionQuest`(
	objectId INT,
	Id INT
)
BEGIN
	UPDATE travel_hero.questcondition
				SET
					ObjectId = objectId 
				WHERE	Id = Id;
				
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Update_Donation`(
	id INT,
	partner_id INT,
	title nvarchar(140),
	description nvarchar(140),
	bonus_point INT,
	approve BIT
)
BEGIN
	UPDATE travel_hero.donation
			SET 
				donation.PartnerId = partner_id,
				donation.Title = title,
				donation.description = description,
				donation.RequiredPoint = bonus_point,
				donation.IsApproved = approve
			WHERE
				donation.Id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Update_DonationApprove`(Id int, IsApproved bit)
BEGIN
	UPDATE travel_hero.donation
		   SET 
				donation.IsApproved = IsApproved
		   WHERE
				donation.Id = Id;	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Update_Quiz`(
	Id 				int,
	questCategory 	int,
	questQuestion 	nvarchar(140),
	CorrectChoiceId int,
	sharingInfo		nvarchar(8000),
	linkURL	      	nvarchar(200),
	createdDate	  	datetime
)
BEGIN
	

	# Update infomation into Quiz table
	UPDATE quiz
		   SET
						quiz.CategoryId = questCategory,
						quiz.CreatedDate = createdDate,
						quiz.Content = questQuestion,
						quiz.CorrectChoiceId = CorrectChoiceId,
						quiz.SharingInfo = sharingInfo,
						quiz.LearnMoreURL = linkURL
			WHERE	
				quiz.Id = Id;
				
				
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Update_QuizApprove`(Id int, IsApproved bit)
BEGIN
			
	UPDATE travel_hero.quiz
		   SET 
				quiz.IsApproved = IsApproved
		   WHERE
				quiz.Id = Id;	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Update_RequiredPoint_Donation`(Id int, point float)
BEGIN
	UPDATE donation
	SET
		donation.RequiredPoint = point
	WHERE 
		donation.Id = Id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Update_VirtualQuest`(
	id INT,
	partner_id INT,
	packet_id INT,
	name nvarchar(140),
	point INT
	
)
BEGIN
	UPDATE travel_hero.virtualquest
				SET
					PacketId = partner_id,
					PartnerId = packet_id,
					QuestName = name,
					UnlockPoint = point
				WHERE  Id = id;
					
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
-- Table structure for table `action`
--

CREATE TABLE IF NOT EXISTS `action` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `action`
--

INSERT INTO `action` (`Id`, `Name`) VALUES
(1, 'Share on their Facebook'),
(2, '2'),
(3, 'Like our facebook pages'),
(4, 'Add to User''s calendar');

-- --------------------------------------------------------

--
-- Table structure for table `activity`
--

CREATE TABLE IF NOT EXISTS `activity` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `PartnerId` int(11) DEFAULT NULL,
  `Title` varchar(140) DEFAULT NULL,
  `Description` varchar(140) DEFAULT NULL,
  `ActionId` int(11) DEFAULT NULL,
  `BonusPoint` int(11) DEFAULT '100',
  `IsApproved` bit(1) DEFAULT NULL,
  `CreateDate` datetime DEFAULT NULL,
  `ActionContent` varchar(140) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `activity`
--

INSERT INTO `activity` (`Id`, `PartnerId`, `Title`, `Description`, `ActionId`, `BonusPoint`, `IsApproved`, `CreateDate`, `ActionContent`) VALUES
(1, 1, 'Sign Up for newsletters', '', 3, 100, b'0', NULL, NULL),
(2, 2, 'ocean4', 'ocean4 team', 1, NULL, NULL, NULL, NULL),
(3, 1, 'hello1', 'hello world1', 1, 100, b'0', '2014-03-21 12:55:42', '2');

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
('5929427b9f850fdc14c490f52782edcc', '::1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36', 1395652063, '');

-- --------------------------------------------------------

--
-- Table structure for table `choice`
--

CREATE TABLE IF NOT EXISTS `choice` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `QuestionId` int(11) DEFAULT NULL,
  `Content` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=138 ;

--
-- Dumping data for table `choice`
--

INSERT INTO `choice` (`Id`, `QuestionId`, `Content`) VALUES
(17, 25, 'a'),
(18, 25, 'b'),
(19, 25, 'c'),
(20, 25, 'ai'),
(22, 27, 'a'),
(23, 27, 'b'),
(28, 30, NULL),
(30, 31, NULL),
(31, 31, NULL),
(32, 31, NULL),
(33, 31, NULL),
(34, 31, NULL),
(35, 31, NULL),
(36, 31, NULL),
(37, 31, NULL),
(38, 31, NULL),
(39, 31, 'fad'),
(40, 32, NULL),
(41, 32, NULL),
(42, 33, NULL),
(43, 33, NULL),
(44, 33, NULL),
(45, 33, NULL),
(46, 34, NULL),
(47, 34, NULL),
(48, 35, NULL),
(49, 35, NULL),
(50, 35, NULL),
(51, 35, NULL),
(52, 36, NULL),
(53, 36, NULL),
(54, 36, NULL),
(55, 36, NULL),
(56, 37, NULL),
(57, 37, NULL),
(58, 38, NULL),
(59, 38, NULL),
(60, 39, NULL),
(61, 39, NULL),
(62, 40, NULL),
(63, 40, NULL),
(64, 41, NULL),
(65, 41, NULL),
(66, 43, 'd'),
(67, 43, 'c'),
(68, 43, 'f'),
(69, 43, 'd'),
(70, 44, 'd'),
(71, 44, 'c'),
(72, 44, 'f'),
(73, 44, 'd'),
(74, 45, 'd'),
(75, 45, 'c'),
(76, 45, 'f'),
(77, 45, 'd'),
(78, 46, 'd'),
(79, 46, 'c'),
(80, 46, 'f'),
(81, 46, 'd'),
(82, 47, 'd'),
(83, 47, 'c'),
(84, 47, 'f'),
(85, 47, 'd'),
(86, 47, 'd'),
(87, 47, 'c'),
(88, 47, 'f'),
(89, 47, 'd'),
(90, 48, 'd'),
(91, 48, 'c'),
(92, 48, 'f'),
(93, 48, 'd'),
(94, 48, 'd'),
(95, 48, 'c'),
(96, 48, 'f'),
(97, 48, 'd'),
(98, 49, 'd'),
(99, 49, 'c'),
(100, 49, 'f'),
(101, 49, 'd'),
(102, 50, 'd'),
(103, 50, 'c'),
(104, 50, 'f'),
(105, 50, 'd'),
(106, 51, 'd'),
(107, 51, 'c'),
(108, 51, 'f'),
(109, 51, 'd'),
(110, 51, 'd'),
(111, 51, 'c'),
(112, 51, 'f'),
(113, 51, 'd'),
(114, 52, 'd'),
(115, 52, 'c'),
(116, 52, 'f'),
(117, 52, 'd'),
(118, 53, 'd'),
(119, 53, 'c'),
(120, 53, 'f'),
(121, 53, 'd'),
(122, 54, 'd'),
(123, 54, 'c'),
(124, 54, 'f'),
(125, 54, 'd'),
(126, 55, 'a'),
(127, 55, 'b'),
(128, 55, 'c'),
(129, 55, 'ai'),
(130, 56, 'a'),
(131, 56, 'b'),
(132, 56, 'c'),
(133, 56, 'd'),
(134, 57, 'a'),
(135, 57, 'b'),
(136, 57, 'c'),
(137, 57, 'd');

-- --------------------------------------------------------

--
-- Table structure for table `donation`
--

CREATE TABLE IF NOT EXISTS `donation` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(150) DEFAULT NULL,
  `Description` varchar(8000) DEFAULT NULL,
  `RequiredPoint` int(11) DEFAULT NULL,
  `MedalId` int(11) DEFAULT NULL,
  `PartnerId` int(11) DEFAULT NULL,
  `IsApproved` bit(1) DEFAULT NULL,
  `CreateDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `donation`
--

INSERT INTO `donation` (`Id`, `Title`, `Description`, `RequiredPoint`, `MedalId`, `PartnerId`, `IsApproved`, `CreateDate`) VALUES
(1, 'Sign Up for newsletter', '', 100, NULL, 1, b'0', NULL),
(3, 'ocean4', 'ocean4 team', NULL, NULL, 1, NULL, NULL),
(4, 'ocean4', 'ocean4 team', NULL, NULL, 2, NULL, NULL),
(5, 'ocean4', 'ocean4 team', NULL, NULL, 1, NULL, NULL),
(6, 'ocean4', 'ocean4 team', NULL, NULL, 3, NULL, NULL),
(7, '2', '2', 100, NULL, 1, NULL, '2014-03-21 12:44:57');

-- --------------------------------------------------------

--
-- Table structure for table `function`
--

CREATE TABLE IF NOT EXISTS `function` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  `IconURL` varchar(150) DEFAULT NULL,
  `FuncURL` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
-- Table structure for table `medal`
--

CREATE TABLE IF NOT EXISTS `medal` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  `ImageURL` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `organizationtype`
--

CREATE TABLE IF NOT EXISTS `organizationtype` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `TypeName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `packet`
--

CREATE TABLE IF NOT EXISTS `packet` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(140) DEFAULT NULL,
  `ImageURL` varchar(140) DEFAULT NULL,
  `PartnerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `packet`
--

INSERT INTO `packet` (`Id`, `Title`, `ImageURL`, `PartnerId`) VALUES
(1, 'HCM', '', 1),
(2, 'HANOI', 'https://code.google.com/p/tr4v3l-h3r0/wiki/Packet_Category', 1);

-- --------------------------------------------------------

--
-- Table structure for table `partner`
--

CREATE TABLE IF NOT EXISTS `partner` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `PartnerName` varchar(45) DEFAULT NULL,
  `OrganizationTypeId` int(11) DEFAULT NULL,
  `Address` varchar(200) DEFAULT NULL,
  `PhoneNumber` varchar(45) DEFAULT NULL,
  `WebsiteURL` varchar(100) DEFAULT NULL,
  `Latitude` float DEFAULT NULL,
  `Longtitude` float DEFAULT NULL,
  `Description` varchar(140) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `partner`
--

INSERT INTO `partner` (`Id`, `PartnerName`, `OrganizationTypeId`, `Address`, `PhoneNumber`, `WebsiteURL`, `Latitude`, `Longtitude`, `Description`) VALUES
(1, 'UNICEF', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 'KOTO', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `partnerdonation`
--

CREATE TABLE IF NOT EXISTS `partnerdonation` (
  `DonationId` int(11) NOT NULL AUTO_INCREMENT,
  `PartnerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`DonationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
(1, 'Big Quest 0', '', 10.7172, 106.73, '', NULL, 0, NULL, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/1fdac2ef-62c7-4d5e-b7c7-7ddadaa37840.jpg', 200, '1SB1-1 Mỹ ViA', 1, NULL, 1),
(2, 'Unicef Fight For Zero', 'UNICEF strives for Zero. That means, zero exploited children, zero abused children, and zero trafficked children.', 10.7739, 106.703, 'https://dl.dropboxusercontent.com/u/3243296/videos/UNICEF.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/497c717d-cc6d-4dfc-b615-90f628d0cb4d.png', 0, 1, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/b0d330a1-9697-4e90-8294-0a521a0a8e49.jpg', 1000, '115 Nguyen Hue, District 1, Ho Chi Minh City, Vietnam', NULL, 'https://unicef.org.vn/donate/', 1),
(3, 'Koto | Know One Teach One', 'Is a vocational training organisation for street and disadvantaged youth in Vietnam. Accepts youth whose backgrounds are primarily orphans, street kids and the poor in both the city and rural communities.', 10.7772, 106.704, 'https://dl.dropboxusercontent.com/u/3243296/videos/KOTO.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/76def669-8511-427f-abf0-e05656f357bb.png', 0, 1, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/5a39b469-601a-4344-be67-0eca9dad7f42.jpg', 1000, '89 Hai BA  Trưng, Bến NghA', NULL, NULL, 0),
(4, 'Kristina Nobel Foundation', 'Christina Noble Children''s Foundation is an International Partnership of people dedicated to serving underprivileged children in Vietnam and Mongolia with the hope of helping each child maximize their life potential.', 10.7799, 106.686, 'https://dl.dropboxusercontent.com/u/3243296/videos/CNCF.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/d5c4c7ea-7249-4b89-861a-627057d4861e.png', 0, 1, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/dbdd9ed2-9482-426c-9191-0605279b7b79.jpg', 1000, '38 Tu Xuong Street \nDistrict 3 \nHO CHI MINH CITY \nVietnam', NULL, NULL, 0),
(5, 'Big Quest 1', '', 10.7172, 106.73, NULL, NULL, 0, NULL, '', 500, '1SB1-1 Mỹ ViA', 1, NULL, 0),
(6, 'American Red Cross in Vietnam', 'the American Red Cross has been working with the Vietnam Red Cross and other partners since early 2008 to improve access to and utilization of HIV information, treatment, care and support services.', 21.0222, 105.843, 'https://dl.dropboxusercontent.com/u/3243296/videos/American%20Red%20Cross_VN.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/5cc4d388-e8a0-4187-9178-f857cebcb0fd.png', 0, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/b7a95302-5f27-4534-8f98-918c2901ffaa.png', 800, '15 Thiền Quang, HA  Nội, Vietnam', NULL, 'https://www.redcross.org/quickdonate/index.jsp', 1),
(7, 'Blue Dragon Children’s Home', 'Blue Dragon Children''s Foundation is an Australian grassroots charity that reaches out to kids in crisis throughout Vietnam.', 21.0259, 105.847, 'https://dl.dropboxusercontent.com/u/3243296/videos/blueDragonChildrensHome.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/a75d1db9-b5b0-4369-85fd-b85cdbaf819a.png', 0, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/a09eeafc-5c08-447b-bc36-b763a016ff40.png', 500, '66 Nghĩa Dũng, PhA', NULL, NULL, 1),
(8, 'Care International in Vietnam', 'CARE has worked in Vietnam since 1989. As Vietnam becomes a middle-income country, we are concentrating our work on supporting rights and sustainable development among the most vulnerable groups in Vietnam, for example remote ethnic minorities, poor women and girls, and people vulnerable to climate change.', 21.0681, 105.823, 'https://dl.dropboxusercontent.com/u/3243296/videos/care_international.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/939389c7-3e0f-4071-aa30-9caa2742444d.png', 0, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/d7c7942e-41fe-4d2d-ab7e-b8583e06c3ca.png', 500, '92 TA', NULL, NULL, 1),
(9, 'UNICEF Next Generation', 'a group of young entrepreneurs that advocate for UNICEF in the United-States, visited UNICEF projects in Ho Chi Minh City and Dong Thap. UNICEF Next Generation United States members are influential and passionate young adults (age 18-35) who are committed to supporting UNICEF''s mission to fulfill the rights of all children through the deliverance of educational and fundraising programmes', 10.7739, 106.703, 'https://dl.dropboxusercontent.com/u/3243296/videos/UNICEF%20next_genmp4.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/2a6b4946-2c8b-441f-93cd-2c61490d1f32.png', 1, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/49aa2afa-4068-42d8-9401-6113e4fa8065.jpg', 2000, '115 Nguyen Hue, District 1, Ho Chi Minh City, Vietnam', NULL, 'https://unicef.org.vn/donate/', 0),
(10, 'Big Quest 0', '', 10.7172, 106.73, '', NULL, 0, NULL, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/1fdac2ef-62c7-4d5e-b7c7-7ddadaa37840.jpg', 200, '1SB1-1 Mỹ ViA', 1, NULL, 1),
(11, 'Unicef Fight For Zero', 'UNICEF strives for Zero. That means, zero exploited children, zero abused children, and zero trafficked children.', 10.7739, 106.703, 'https://dl.dropboxusercontent.com/u/3243296/videos/UNICEF.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/497c717d-cc6d-4dfc-b615-90f628d0cb4d.png', 0, 1, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/b0d330a1-9697-4e90-8294-0a521a0a8e49.jpg', 1000, '115 Nguyen Hue, District 1, Ho Chi Minh City, Vietnam', NULL, 'https://unicef.org.vn/donate/', 1),
(12, 'Koto | Know One Teach One', 'Is a vocational training organisation for street and disadvantaged youth in Vietnam. Accepts youth whose backgrounds are primarily orphans, street kids and the poor in both the city and rural communities.', 10.7772, 106.704, 'https://dl.dropboxusercontent.com/u/3243296/videos/KOTO.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/76def669-8511-427f-abf0-e05656f357bb.png', 0, 1, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/5a39b469-601a-4344-be67-0eca9dad7f42.jpg', 1000, '89 Hai BA  Trưng, Bến NghA', NULL, NULL, 0),
(13, 'Kristina Nobel Foundation', 'Christina Noble Children''s Foundation is an International Partnership of people dedicated to serving underprivileged children in Vietnam and Mongolia with the hope of helping each child maximize their life potential.', 10.7799, 106.686, 'https://dl.dropboxusercontent.com/u/3243296/videos/CNCF.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/d5c4c7ea-7249-4b89-861a-627057d4861e.png', 0, 1, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/dbdd9ed2-9482-426c-9191-0605279b7b79.jpg', 1000, '38 Tu Xuong Street \nDistrict 3 \nHO CHI MINH CITY \nVietnam', NULL, NULL, 0),
(14, 'Big Quest 1', '', 10.7172, 106.73, NULL, NULL, 0, NULL, '', 500, '1SB1-1 Mỹ ViA', 1, NULL, 0),
(15, 'American Red Cross in Vietnam', 'the American Red Cross has been working with the Vietnam Red Cross and other partners since early 2008 to improve access to and utilization of HIV information, treatment, care and support services.', 21.0222, 105.843, 'https://dl.dropboxusercontent.com/u/3243296/videos/American%20Red%20Cross_VN.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/5cc4d388-e8a0-4187-9178-f857cebcb0fd.png', 0, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/b7a95302-5f27-4534-8f98-918c2901ffaa.png', 800, '15 Thiền Quang, HA  Nội, Vietnam', NULL, 'https://www.redcross.org/quickdonate/index.jsp', 0),
(16, 'Blue Dragon Children’s Home', 'Blue Dragon Children''s Foundation is an Australian grassroots charity that reaches out to kids in crisis throughout Vietnam.', 21.0259, 105.847, 'https://dl.dropboxusercontent.com/u/3243296/videos/blueDragonChildrensHome.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/a75d1db9-b5b0-4369-85fd-b85cdbaf819a.png', 0, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/a09eeafc-5c08-447b-bc36-b763a016ff40.png', 500, '66 Nghĩa Dũng, PhA', NULL, NULL, 0),
(17, 'Care International in Vietnam', 'CARE has worked in Vietnam since 1989. As Vietnam becomes a middle-income country, we are concentrating our work on supporting rights and sustainable development among the most vulnerable groups in Vietnam, for example remote ethnic minorities, poor women and girls, and people vulnerable to climate change.', 21.0681, 105.823, 'https://dl.dropboxusercontent.com/u/3243296/videos/care_international.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/939389c7-3e0f-4071-aa30-9caa2742444d.png', 0, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/d7c7942e-41fe-4d2d-ab7e-b8583e06c3ca.png', 500, '92 TA', NULL, NULL, 0),
(18, 'UNICEF Next Generation', 'a group of young entrepreneurs that advocate for UNICEF in the United-States, visited UNICEF projects in Ho Chi Minh City and Dong Thap. UNICEF Next Generation United States members are influential and passionate young adults (age 18-35) who are committed to supporting UNICEF''s mission to fulfill the rights of all children through the deliverance of educational and fundraising programmes', 10.7739, 106.703, 'https://dl.dropboxusercontent.com/u/3243296/videos/UNICEF%20next_genmp4.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/2a6b4946-2c8b-441f-93cd-2c61490d1f32.png', 1, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/49aa2afa-4068-42d8-9401-6113e4fa8065.jpg', 2000, '115 Nguyen Hue, District 1, Ho Chi Minh City, Vietnam', NULL, 'https://unicef.org.vn/donate/', 0),
(19, 'Big Quest 0', '', 10.7172, 106.73, '', NULL, 0, NULL, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/1fdac2ef-62c7-4d5e-b7c7-7ddadaa37840.jpg', 200, '1SB1-1 Mỹ ViA', 1, NULL, 1),
(20, 'Unicef Fight For Zero', 'UNICEF strives for Zero. That means, zero exploited children, zero abused children, and zero trafficked children.', 10.7739, 106.703, 'https://dl.dropboxusercontent.com/u/3243296/videos/UNICEF.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/497c717d-cc6d-4dfc-b615-90f628d0cb4d.png', 0, 1, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/b0d330a1-9697-4e90-8294-0a521a0a8e49.jpg', 1000, '115 Nguyen Hue, District 1, Ho Chi Minh City, Vietnam', NULL, 'https://unicef.org.vn/donate/', 0),
(21, 'Koto | Know One Teach One', 'Is a vocational training organisation for street and disadvantaged youth in Vietnam. Accepts youth whose backgrounds are primarily orphans, street kids and the poor in both the city and rural communities.', 10.7772, 106.704, 'https://dl.dropboxusercontent.com/u/3243296/videos/KOTO.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/76def669-8511-427f-abf0-e05656f357bb.png', 0, 1, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/5a39b469-601a-4344-be67-0eca9dad7f42.jpg', 1000, '89 Hai BA  Trưng, Bến NghA', NULL, NULL, 0),
(22, 'Kristina Nobel Foundation', 'Christina Noble Children''s Foundation is an International Partnership of people dedicated to serving underprivileged children in Vietnam and Mongolia with the hope of helping each child maximize their life potential.', 10.7799, 106.686, 'https://dl.dropboxusercontent.com/u/3243296/videos/CNCF.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/d5c4c7ea-7249-4b89-861a-627057d4861e.png', 0, 1, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/dbdd9ed2-9482-426c-9191-0605279b7b79.jpg', 1000, '38 Tu Xuong Street \nDistrict 3 \nHO CHI MINH CITY \nVietnam', NULL, NULL, 0),
(23, 'Big Quest 1', '', 10.7172, 106.73, NULL, NULL, 0, NULL, '', 500, '1SB1-1 Mỹ ViA', 1, NULL, 0),
(24, 'American Red Cross in Vietnam', 'the American Red Cross has been working with the Vietnam Red Cross and other partners since early 2008 to improve access to and utilization of HIV information, treatment, care and support services.', 21.0222, 105.843, 'https://dl.dropboxusercontent.com/u/3243296/videos/American%20Red%20Cross_VN.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/5cc4d388-e8a0-4187-9178-f857cebcb0fd.png', 0, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/b7a95302-5f27-4534-8f98-918c2901ffaa.png', 800, '15 Thiền Quang, HA  Nội, Vietnam', NULL, 'https://www.redcross.org/quickdonate/index.jsp', 0),
(25, 'Blue Dragon Children’s Home', 'Blue Dragon Children''s Foundation is an Australian grassroots charity that reaches out to kids in crisis throughout Vietnam.', 21.0259, 105.847, 'https://dl.dropboxusercontent.com/u/3243296/videos/blueDragonChildrensHome.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/a75d1db9-b5b0-4369-85fd-b85cdbaf819a.png', 0, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/a09eeafc-5c08-447b-bc36-b763a016ff40.png', 500, '66 Nghĩa Dũng, PhA', NULL, NULL, 0),
(26, 'Care International in Vietnam', 'CARE has worked in Vietnam since 1989. As Vietnam becomes a middle-income country, we are concentrating our work on supporting rights and sustainable development among the most vulnerable groups in Vietnam, for example remote ethnic minorities, poor women and girls, and people vulnerable to climate change.', 21.0681, 105.823, 'https://dl.dropboxusercontent.com/u/3243296/videos/care_international.mp4', 'https://s3-us-west-2.amazonaws.com/travelhero/qrcode/939389c7-3e0f-4071-aa30-9caa2742444d.png', 0, 5, 'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/d7c7942e-41fe-4d2d-ab7e-b8583e06c3ca.png', 500, '92 TA', NULL, NULL, 1),
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

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
-- Table structure for table `questcondition`
--

CREATE TABLE IF NOT EXISTS `questcondition` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Type` int(11) DEFAULT NULL,
  `Value` int(11) DEFAULT NULL,
  `VirtualQuestId` int(11) DEFAULT NULL,
  `ObjectId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=110 ;

--
-- Dumping data for table `questcondition`
--

INSERT INTO `questcondition` (`Id`, `Type`, `Value`, `VirtualQuestId`, `ObjectId`) VALUES
(4, 1, NULL, NULL, 1),
(5, 1, NULL, NULL, 2),
(6, 1, NULL, NULL, 3),
(7, 2, NULL, NULL, 1),
(8, 2, NULL, NULL, 2),
(9, 2, NULL, NULL, 3),
(10, 1, NULL, NULL, 1),
(11, 1, NULL, NULL, 2),
(12, 1, NULL, NULL, 3),
(13, 2, NULL, NULL, 1),
(14, 2, NULL, NULL, 2),
(15, 2, NULL, NULL, 3),
(16, 1, NULL, 0, 1),
(17, 1, NULL, 0, 2),
(18, 1, NULL, 0, 3),
(19, 2, NULL, 0, 1),
(20, 2, NULL, 0, 2),
(21, 2, NULL, 0, 3),
(22, 1, NULL, 0, 1),
(23, 1, NULL, 0, 2),
(24, 1, NULL, 0, 3),
(25, 2, NULL, 0, 1),
(26, 2, NULL, 0, 2),
(27, 2, NULL, 0, 3),
(28, 1, NULL, 9, 1),
(29, 1, NULL, 9, 2),
(30, 1, NULL, 9, 3),
(31, 2, NULL, 9, 1),
(32, 2, NULL, 9, 2),
(33, 2, NULL, 9, 3),
(34, 1, NULL, 9, 1),
(35, 1, NULL, 9, 2),
(36, 1, NULL, 9, 3),
(37, 2, NULL, 9, 1),
(38, 2, NULL, 9, 2),
(39, 2, NULL, 9, 3),
(40, 1, NULL, 9, 1),
(41, 1, NULL, 9, 2),
(42, 1, NULL, 9, 3),
(43, 2, NULL, 9, 1),
(44, 2, NULL, 9, 2),
(45, 2, NULL, 9, 3),
(46, 1, NULL, 9, 1),
(47, 1, NULL, 9, 2),
(48, 1, NULL, 9, 3),
(49, 2, NULL, 9, 1),
(50, 2, NULL, 9, 2),
(51, 2, NULL, 9, 3),
(52, 1, NULL, 9, 1),
(53, 1, NULL, 9, 2),
(54, 1, NULL, 9, 3),
(55, 2, NULL, 9, 1),
(56, 2, NULL, 9, 2),
(57, 2, NULL, 9, 3),
(58, 1, NULL, 0, 1),
(59, 1, NULL, 0, 2),
(60, 1, NULL, 0, 3),
(61, 2, NULL, 0, 1),
(62, 2, NULL, 0, 2),
(63, 2, NULL, 0, 3),
(70, 1, NULL, 16, 1),
(71, 1, NULL, 16, 2),
(72, 1, NULL, 16, 3),
(73, 2, NULL, 16, 1),
(74, 2, NULL, 16, 2),
(75, 2, NULL, 16, 3),
(76, 1, NULL, 17, 1),
(77, 1, NULL, 17, 2),
(78, 1, NULL, 17, 3),
(79, 2, NULL, 17, 1),
(80, 2, NULL, 17, 2),
(81, 2, NULL, 17, 3),
(82, 1, NULL, 18, 1),
(83, 1, NULL, 18, 1),
(84, 1, NULL, 18, 2),
(85, 1, NULL, 18, 3),
(86, 2, NULL, 18, 1),
(87, 2, NULL, 18, 2),
(88, 2, NULL, 18, 3),
(89, 0, NULL, 19, 1),
(90, 1, NULL, 19, 1),
(91, 1, NULL, 19, 2),
(92, 1, NULL, 19, 3),
(93, 2, NULL, 19, 1),
(94, 2, NULL, 19, 2),
(95, 2, NULL, 19, 3),
(103, 0, NULL, 15, 1),
(104, 1, NULL, 15, 1),
(105, 1, NULL, 15, 2),
(106, 1, NULL, 15, 3),
(107, 2, NULL, 15, 1),
(108, 2, NULL, 15, 2),
(109, 2, NULL, 15, 3);

-- --------------------------------------------------------

--
-- Table structure for table `quiz`
--

CREATE TABLE IF NOT EXISTS `quiz` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `CategoryId` int(11) DEFAULT NULL,
  `PartnerId` int(11) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `Content` varchar(1000) DEFAULT NULL,
  `BonusPoint` int(11) DEFAULT '100',
  `CorrectChoiceId` int(11) DEFAULT NULL,
  `SharingInfo` varchar(1000) DEFAULT NULL,
  `LearnMoreURL` varchar(500) DEFAULT NULL,
  `ImageURL` varchar(200) DEFAULT NULL,
  `IsApproved` bit(1) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=58 ;

--
-- Dumping data for table `quiz`
--

INSERT INTO `quiz` (`Id`, `CategoryId`, `PartnerId`, `CreatedDate`, `Content`, `BonusPoint`, `CorrectChoiceId`, `SharingInfo`, `LearnMoreURL`, `ImageURL`, `IsApproved`) VALUES
(25, 1, 1, '2014-03-19 03:42:56', 'who?', 1, 20, 'b', 'b', NULL, b'1'),
(27, 1, 2, '2014-03-19 03:42:48', 'who?', NULL, 25, 'b', 'b', NULL, NULL),
(31, 1, 2, '0000-00-00 00:00:00', '1+3=?', NULL, 1, 'b', 'b', NULL, NULL),
(34, 1, 2, '0000-00-00 00:00:00', '1+3=?', NULL, 1, 'b', 'b', NULL, NULL),
(35, 1, 2, '0000-00-00 00:00:00', '1+3=?', NULL, 1, 'b', 'b', NULL, NULL),
(36, 1, 2, '0000-00-00 00:00:00', '1+3=?', NULL, 0, 'b', 'b', NULL, NULL),
(37, 1, 2, '0000-00-00 00:00:00', '1+3=?', NULL, 0, 'b', 'b', NULL, NULL),
(38, 1, 2, '0000-00-00 00:00:00', '1+3=?', NULL, 0, 'b', 'b', NULL, NULL),
(39, 1, 2, '0000-00-00 00:00:00', '1+3=?', NULL, 0, 'b', 'b', NULL, NULL),
(40, 1, 2, '0000-00-00 00:00:00', '1+3=?', NULL, 0, 'b', 'b', NULL, NULL),
(41, 1, 2, '0000-00-00 00:00:00', '1+3=?', NULL, 0, 'b', 'b', NULL, NULL),
(42, 1, 2, '0000-00-00 00:00:00', '1+3=?', NULL, 0, 'b', 'b', NULL, NULL),
(43, 1, 2, '0000-00-00 00:00:00', '1+3=?', NULL, 0, 'b', 'b', NULL, NULL),
(44, 1, 2, '0000-00-00 00:00:00', '1+3=?', NULL, 0, 'b', 'b', NULL, NULL),
(45, 1, 2, '0000-00-00 00:00:00', '1+3=?', NULL, 0, 'b', 'b', NULL, NULL),
(46, 1, 2, '0000-00-00 00:00:00', '1+3=?', NULL, 0, 'b', 'b', NULL, NULL),
(47, 1, 2, '0000-00-00 00:00:00', '1+3=?', NULL, 0, 'b', 'b', NULL, NULL),
(48, 1, 2, '0000-00-00 00:00:00', '1+3=?', NULL, 0, 'b', 'b', NULL, NULL),
(49, 1, 2, '0000-00-00 00:00:00', '1+3=?', NULL, 0, 'b', 'b', NULL, NULL),
(50, 1, 2, '0000-00-00 00:00:00', '1+3=?', NULL, 0, 'b', 'b', NULL, NULL),
(51, 1, 2, '0000-00-00 00:00:00', '1+3=?', NULL, 0, 'b', 'b', NULL, NULL),
(52, 1, 2, '0000-00-00 00:00:00', '1+3=?', NULL, 0, 'b', 'b', NULL, NULL),
(53, 1, 2, '0000-00-00 00:00:00', '1+3=?', NULL, 0, 'b', 'b', NULL, NULL),
(54, 1, 2, '0000-00-00 00:00:00', '1+3=?', NULL, 122, 'b', 'b', NULL, NULL),
(55, 1, 1, '2014-03-12 11:22:42', 'ch? cái ??u tiên trong b?ng ch? cái ti?ng anh', NULL, 129, 'b', 'b', NULL, NULL),
(56, 1, 1, '0000-00-00 00:00:00', '?', NULL, 133, 'b', 'b', NULL, NULL),
(57, 1, 1, '2014-03-14 07:55:11', 'What is this?', NULL, 136, 'b', 'b', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `quizcategory`
--

CREATE TABLE IF NOT EXISTS `quizcategory` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `quizcategory`
--

INSERT INTO `quizcategory` (`Id`, `CategoryName`) VALUES
(1, 'ocean4'),
(2, 'chidrend'),
(3, 'chirdrend Vietnamese');

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
-- Table structure for table `role`
--

CREATE TABLE IF NOT EXISTS `role` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `rolefunction`
--

CREATE TABLE IF NOT EXISTS `rolefunction` (
  `RoleId` int(11) NOT NULL AUTO_INCREMENT,
  `FunctionId` int(11) DEFAULT NULL,
  PRIMARY KEY (`RoleId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `FullName` varchar(45) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `RegisterDate` datetime DEFAULT NULL,
  `PhoneNumber` varchar(45) DEFAULT NULL,
  `Address` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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

-- --------------------------------------------------------

--
-- Table structure for table `userapplication`
--

CREATE TABLE IF NOT EXISTS `userapplication` (
  `UserId` int(11) NOT NULL,
  `FacebookId` int(11) DEFAULT NULL,
  `Points` int(11) DEFAULT NULL,
  `CurrentLevel` int(11) DEFAULT NULL,
  PRIMARY KEY (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `usermedal`
--

CREATE TABLE IF NOT EXISTS `usermedal` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` int(11) DEFAULT NULL,
  `MedalId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `userpartner`
--

CREATE TABLE IF NOT EXISTS `userpartner` (
  `UserId` int(11) NOT NULL AUTO_INCREMENT,
  `PartnerId` int(11) DEFAULT NULL,
  `UserName` varchar(45) DEFAULT NULL,
  `Password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `userrole`
--

CREATE TABLE IF NOT EXISTS `userrole` (
  `UserId` int(11) NOT NULL,
  `RoleId` int(11) DEFAULT NULL,
  PRIMARY KEY (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
(1, '\0\0', 'administrator', '59beecdf7fc966e2f17fd8f65a4a9aeb09d4a3d4', '9462e8eee0', 'admin@admin.com', '', NULL, NULL, '9d029802e28cd9c768e8e62277c0df49ec65c48c', 1268889823, 1393398559, 1, 'Admin', 'istrator', 'ADMIN', '0', 0, '', '', '0000-00-00', '', '', '', '', '', '', 0, 0, b'1', '0000-00-00'),
(5, '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', 'nguyen hung', '972df4edf86993b212e52272d58baac2240e3af3', NULL, 'imrhung3@yahoo.com', NULL, NULL, NULL, '53d06108ae0d58e982780f8633648efbbfb00563', 1393147053, 1393164677, 1, 'Nguyen', 'Hung', 'SEED Inc.', '84912880656', 0, '', '', '0000-00-00', '', '', '', '', '', '', 0, 0, b'1', '0000-00-00'),
(8, '\0\0', 'imr.hung', '025ed971853ccd493bd1a8615f273b16bb786800', NULL, '50901113@stu.hcmut.edu.vn', NULL, NULL, NULL, 'de143548ca32dc28afd51d88d84fe51119a18e62', 1393470989, 1393485901, 1, 'Imr', 'Hung', NULL, NULL, 1, 'https://www.facebook.com/imr.hung', 'I like to smile every time !', '1991-07-14', 'Ho Chi Minh City, Vietnam', '', '', '', '', '', 0, 0, b'1', '0000-00-00');

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
-- Table structure for table `virtualquest`
--

CREATE TABLE IF NOT EXISTS `virtualquest` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `QuestName` varchar(45) DEFAULT NULL,
  `PacketId` int(11) DEFAULT NULL,
  `PartnerId` int(11) DEFAULT NULL,
  `AnimationId` int(11) DEFAULT NULL,
  `UnlockPoint` int(11) DEFAULT NULL,
  `CreateDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Dumping data for table `virtualquest`
--

INSERT INTO `virtualquest` (`Id`, `QuestName`, `PacketId`, `PartnerId`, `AnimationId`, `UnlockPoint`, `CreateDate`) VALUES
(3, 'Nutrition of Chidren', 1, 1, NULL, NULL, NULL),
(4, 'Unicef Next Generation', 2, 1, NULL, 100, NULL),
(5, 'Blue Dragon', 1, 1, NULL, 100, NULL),
(6, 'Blue Dragon', 1, 1, NULL, 100, '2014-03-21 12:35:31'),
(7, 'Blue Dragon', 1, 1, NULL, 100, '2014-03-24 06:02:35'),
(8, 'Blue Dragon', 1, 1, NULL, 100, '2014-03-24 06:03:33'),
(9, 'Blue Dragon', 1, 1, NULL, 100, '2014-03-24 06:08:36'),
(10, 'Blue Dragon', 1, 1, NULL, 100, '2014-03-24 06:10:20'),
(11, 'Blue Dragon', 1, 1, NULL, 100, '2014-03-24 06:13:08'),
(12, 'Blue Dragon', 1, 1, NULL, 100, '2014-03-24 06:13:42'),
(13, 'Blue Dragon', 1, 1, NULL, 100, '2014-03-24 06:18:02'),
(14, 'Blue Dragon', 1, 1, NULL, 100, '2014-03-24 06:20:33'),
(15, 'Blue Dragon', 1, 1, NULL, 100, '2014-03-24 06:23:45'),
(16, 'Blue Dragon', 1, 1, NULL, 100, '2014-03-24 06:26:38'),
(17, 'Blue Dragon', 1, 1, NULL, 100, '2014-03-24 06:26:58'),
(18, 'Blue Dragon', 1, 1, NULL, 100, '2014-03-24 06:38:26'),
(19, 'Blue Dragon', 1, 1, NULL, 100, '2014-03-24 06:38:59');

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
