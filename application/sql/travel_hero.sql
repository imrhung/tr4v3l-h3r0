-- phpMyAdmin SQL Dump
-- version 4.1.6
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 07, 2014 at 12:48 PM
-- Server version: 5.5.36
-- PHP Version: 5.4.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `travel_hero`
--
CREATE DATABASE IF NOT EXISTS `travel_hero` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
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
		DELETE FROM travel_hero.activity
			WHERE activity.Id = Id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Delete_Donation`(Id INT)
BEGIN
		DELETE FROM travel_hero.donation
			WHERE donation.Id = Id;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_PartnerList`(IN currentPage INT, IN pageSize INT)
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
	INSERT INTO activity
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
	INSERT INTO choice(
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
	
	INSERT INTO donation
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Insert_Quiz_Choice`(
	questCategory 	int,
	questQuestion	nvarchar(140),
	correctChoiceId int,
	sharingInfo		nvarchar(8000),
	linkURL	     	nvarchar(200),
	partnerId		int,
	createdDate	  	datetime,
	answerA nvarchar(50),
	answerB nvarchar(50),
	answerC nvarchar(50),
	answerD nvarchar(50)
)
BEGIN
	# Parameter for main Store Proceduce
	declare QuestionId int;
	declare choiceId int;
	
	# Using transaction for query
	DECLARE exit handler for sqlexception
	BEGIN
		-- ERROR
		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
	BEGIN
		-- WARNING
		ROLLBACK;
	END;

	START TRANSACTION;
	
	# Insert infomation into Quiz table
	INSERT INTO quiz(
						CategoryId,
						PartnerId,
                        CreatedDate,
						Content,
						SharingInfo,
						LearnMoreURL,
						BonusPoint
					)
				VALUES(
						questCategory,
						partnerId,
						createdDate,
						questQuestion,
						sharingInfo,
						linkURL,
						100
					);
	
	# Get quiz id insert after
	set QuestionId = (SELECT LAST_INSERT_ID()) ;

	INSERT INTO choice(
						QuestionId,
						Content
						)
			VALUES(
					QuestionId,
					answerA
					);
	INSERT INTO choice(
						QuestionId,
						Content
						)
			VALUES(
					QuestionId,
					answerB
					);
	INSERT INTO choice(
						QuestionId,
						Content
						)
			VALUES(
					QuestionId,
					answerC
					);
	INSERT INTO choice(
						QuestionId,
						Content
						)
			VALUES(
					QuestionId,
					answerD
					);

	# Get choice id insert after
	set choiceId = (select LAST_INSERT_ID()) - 3 + correctChoiceId;
	
	UPDATE travel_hero.quiz
			SET quiz.correctChoiceId = choiceId
			WHERE Id = QuestionId;	
	COMMIT;
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
	UPDATE travel_hero.quiz
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
	UPDATE travel_hero.donation
	SET
		donation.RequiredPoint = point
	WHERE 
		donation.Id = Id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Update_VirtualQuest`(IN `id` INT, IN `partner_id` INT, IN `packet_id` INT, IN `name` nvarchar(140), point INT)
BEGIN
	UPDATE travel_hero.virtualquest
				SET
					virtualquest.PacketId = packet_id,
					virtualquest.QuestName = name,
					virtualquest.UnlockPoint = point
				WHERE  virtualquest.Id = id;
					
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
  `Name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `action`
--

INSERT INTO `action` (`Id`, `Name`) VALUES
(1, 'Share on their Facebook'),
(2, 'Sign up for Your news letter'),
(3, 'Like our facebook pages'),
(4, 'Add to User''s calendar');

-- --------------------------------------------------------

--
-- Table structure for table `activity`
--

CREATE TABLE IF NOT EXISTS `activity` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `PartnerId` int(11) DEFAULT NULL,
  `Title` varchar(140) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Description` varchar(140) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ActionId` int(11) DEFAULT NULL,
  `BonusPoint` int(11) DEFAULT '100',
  `IsApproved` bit(1) DEFAULT NULL,
  `CreateDate` datetime DEFAULT NULL,
  `ActionContent` varchar(140) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=12 ;

--
-- Dumping data for table `activity`
--

INSERT INTO `activity` (`Id`, `PartnerId`, `Title`, `Description`, `ActionId`, `BonusPoint`, `IsApproved`, `CreateDate`, `ActionContent`) VALUES
(2, 5, 'Join NextGen on Facebook ', 'Join NextGen on Facebook to find other 18-35 year old leaders concerned about children!', 1, 100, NULL, '2014-04-07 10:23:41', 'Join NextGen on Facebook to find other 18-35 year old leaders concerned about children!'),
(3, 5, 'Change your profile to “Believe in ZERO”. ', 'Change your profile to “Believe in ZERO”. ', 1, 100, NULL, '2014-04-07 10:23:59', 'Change your profile to “Believe in ZERO”. '),
(4, 5, 'Share this fact about children on your FB ', 'Share this fact about children on your FB – “100 children die every day in Vietnam of preventable causes.”', 1, 100, NULL, '2014-04-07 10:24:34', '100 children die every day in Vietnam of preventable causes.'),
(5, 5, 'Sign up for newsletter to keep updated with UNICEF activities in Vietnam', 'Sign up for newsletter to keep updated with UNICEF activities in Vietnam: partnershipvietnam@unicef.org', 2, 100, NULL, '2014-04-07 10:25:28', 'partnershipvietnam@unicef.org'),
(6, 5, 'Share this fact about children on your FB ', 'Share this fact about children on your FB – “Every hour a child dies in Vietnam of an injury caused by traffic accidents or drowning.”', 1, 100, NULL, '2014-04-07 10:25:55', 'Every hour a child dies in Vietnam of an injury caused by traffic accidents or drowning.'),
(7, 5, 'Volunteer to be a swimming coach and teach kids in the Mekong Delta how to swim!', 'Volunteer to be a swimming coach and teach kids in the Mekong Delta how to swim!', 1, 100, NULL, '2014-04-07 10:26:15', 'Volunteer to be a swimming coach and teach kids in the Mekong Delta how to swim!'),
(8, 6, 'Visit our children’s home in Vung Tau and teach English', 'Visit our children’s home in Vung Tau and teach English', 1, 100, NULL, '2014-04-07 10:33:17', 'Visit our children’s home in Vung Tau and teach English'),
(9, 6, 'Sponsor a child on our website. Achvn.org/sponsor', 'Sponsor a child on our website. Achvn.org/sponsor', 1, 100, NULL, '2014-04-07 10:34:34', 'Sponsor a child on our website. Achvn.org/sponsor'),
(10, 6, 'Like us on facebook and follow our feed.', 'Like us on facebook and follow our feed.', 3, 100, NULL, '2014-04-07 10:35:05', 'Like us on facebook and follow our feed.'),
(11, 6, 'Share us on facebook', 'Just share make different', 1, 100, NULL, '2014-04-07 10:47:05', 'Hero for Zero');

-- --------------------------------------------------------

--
-- Table structure for table `app_sessions`
--

CREATE TABLE IF NOT EXISTS `app_sessions` (
  `session_id` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `ip_address` varchar(45) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `user_agent` varchar(120) CHARACTER SET utf8 NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `last_activity_idx` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `app_sessions`
--

INSERT INTO `app_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('8cbe00d1a71cef5f2a8df314d1e0cd8a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36', 1396867460, 'a:5:{s:9:"user_data";s:0:"";s:7:"islogin";b:1;s:10:"partner_id";i:6;s:4:"role";s:12:"organization";s:8:"language";s:2:"vi";}');

-- --------------------------------------------------------

--
-- Table structure for table `choice`
--

CREATE TABLE IF NOT EXISTS `choice` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `QuestionId` int(11) DEFAULT NULL,
  `Content` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=190 ;

--
-- Dumping data for table `choice`
--

INSERT INTO `choice` (`Id`, `QuestionId`, `Content`) VALUES
(170, 68, '10'),
(171, 68, '100'),
(172, 68, '1000'),
(173, 68, '10000'),
(174, 69, 'Run and Hide'),
(175, 69, 'Ignore it'),
(176, 69, 'Call the 113 or 18001567 hotline to report'),
(177, 69, 'Confront the aggressor'),
(178, 70, 'Government'),
(179, 70, 'Family'),
(180, 70, 'Society'),
(181, 70, 'All correct'),
(182, 71, 'Children with disability'),
(183, 71, 'Street children'),
(184, 71, 'Poor children'),
(185, 71, 'All correct'),
(186, 72, 'Keep it for myself, otherwise other will tease me '),
(187, 72, 'Report to parents or relatives '),
(188, 72, 'Report to the local police, teachers or other trus'),
(189, 72, '2 & 3 correct');

-- --------------------------------------------------------

--
-- Table structure for table `donation`
--

CREATE TABLE IF NOT EXISTS `donation` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Description` varchar(8000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RequiredPoint` int(11) DEFAULT NULL,
  `MedalId` int(11) DEFAULT NULL,
  `PartnerId` int(11) DEFAULT NULL,
  `IsApproved` bit(1) DEFAULT NULL,
  `CreateDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=17 ;

--
-- Dumping data for table `donation`
--

INSERT INTO `donation` (`Id`, `Title`, `Description`, `RequiredPoint`, `MedalId`, `PartnerId`, `IsApproved`, `CreateDate`) VALUES
(11, 'Donate 65 cents ', 'Donate 65 cents – equivalent to the cost one measles vaccine that can save a child’ life', 100, NULL, 5, NULL, '2014-04-07 10:26:39'),
(12, 'Donate 50 dollars ', 'Donate 50 dollars – equivalent to the cost of Emergency support for children victims of abused, and exploitation. ', 100, NULL, 5, NULL, '2014-04-07 10:26:56'),
(13, 'Donate 65 cents ', 'Donate 65 cents – equivalent to the cost one measles vaccine that can save a child’ life', 100, NULL, 6, NULL, '2014-04-07 10:36:05'),
(14, 'Donate 50 dollars ', 'Donate 50 dollars – equivalent to the cost of Emergency support for children victims of abused, and exploitation. ', 100, NULL, 6, NULL, '2014-04-07 10:36:24'),
(15, 'Donate $1', 'Just one dollar to save lives.', 100, NULL, 6, NULL, '2014-04-07 10:45:18'),
(16, 'Donate 2$', 'Just 2 dollars save many lives.', 100, NULL, 6, NULL, '2014-04-07 10:46:15');

-- --------------------------------------------------------

--
-- Table structure for table `function`
--

CREATE TABLE IF NOT EXISTS `function` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IconURL` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FuncURL` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 NOT NULL,
  `description` varchar(100) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

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
  `login` varchar(100) CHARACTER SET utf8 NOT NULL,
  `time` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `medal`
--

CREATE TABLE IF NOT EXISTS `medal` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ImageURL` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `organizationtype`
--

CREATE TABLE IF NOT EXISTS `organizationtype` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `TypeName` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Dumping data for table `organizationtype`
--

INSERT INTO `organizationtype` (`Id`, `TypeName`) VALUES
(1, 'Local Non-profit organization'),
(2, 'International Non-profit organization'),
(3, 'Child Care Center or Shelter'),
(4, 'Mass Organization'),
(5, 'Religious Organization');

-- --------------------------------------------------------

--
-- Table structure for table `packet`
--

CREATE TABLE IF NOT EXISTS `packet` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(140) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ImageURL` varchar(140) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PartnerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `packet`
--

INSERT INTO `packet` (`Id`, `Title`, `ImageURL`, `PartnerId`) VALUES
(1, 'Ho Chi Minh City', '', 1),
(2, 'Ha Noi', '', 1),
(3, 'Da Nang', NULL, 1),
(4, 'Nha Trang', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `partner`
--

CREATE TABLE IF NOT EXISTS `partner` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `PartnerName` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OrganizationTypeId` int(11) DEFAULT NULL,
  `Address` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PhoneNumber` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WebsiteURL` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Latitude` float DEFAULT NULL,
  `Longtitude` float DEFAULT NULL,
  `Description` varchar(140) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IsApproved` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Dumping data for table `partner`
--

INSERT INTO `partner` (`Id`, `PartnerName`, `OrganizationTypeId`, `Address`, `PhoneNumber`, `WebsiteURL`, `Latitude`, `Longtitude`, `Description`, `IsApproved`) VALUES
(3, 'Unicef VietNam', 3, '65/13 Phan Sao Nam', '84912880656', '', NULL, NULL, 'We save the world', b'0'),
(4, 'NamAgape Childrens Home', 3, '65/13 Phan Sao Nam', '84912880656', '', NULL, NULL, 'we help eartn', b'0'),
(5, 'UNICEF Viet Nam', 2, 'Sun Wah Tower, Suite 504, 115 Nguyen Hue, District 1, HCMC', '+84 3821-9413', 'http://www.unicef.org/vietnam', NULL, NULL, 'UNICEFs mission in Vietnam is to fulfill the rights of every child in Vietnam, particularly those most disadvantaged or vulnerable.', b'0'),
(6, 'Agape Childrens Home', 3, '4232 Vermon Ave. S Minneapolis, MN 45234', '01217799140', 'achvn.org', NULL, NULL, 'Agape Childrens Home (ACH) mission is to give hope to the abandoned and impoverished children of Vietnam by providing them with a safe and l', b'0');

-- --------------------------------------------------------

--
-- Table structure for table `partnerdonation`
--

CREATE TABLE IF NOT EXISTS `partnerdonation` (
  `DonationId` int(11) NOT NULL AUTO_INCREMENT,
  `PartnerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`DonationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

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
-- Table structure for table `questcondition`
--

CREATE TABLE IF NOT EXISTS `questcondition` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Type` int(11) DEFAULT NULL,
  `Value` int(11) DEFAULT NULL,
  `VirtualQuestId` int(11) DEFAULT NULL,
  `ObjectId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=187 ;

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
-- Table structure for table `quiz`
--

CREATE TABLE IF NOT EXISTS `quiz` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `CategoryId` int(11) DEFAULT NULL,
  `PartnerId` int(11) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `Content` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BonusPoint` int(11) DEFAULT '100',
  `CorrectChoiceId` int(11) DEFAULT NULL,
  `SharingInfo` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LearnMoreURL` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ImageURL` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IsApproved` bit(1) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=73 ;

--
-- Dumping data for table `quiz`
--

INSERT INTO `quiz` (`Id`, `CategoryId`, `PartnerId`, `CreatedDate`, `Content`, `BonusPoint`, `CorrectChoiceId`, `SharingInfo`, `LearnMoreURL`, `ImageURL`, `IsApproved`) VALUES
(68, 5, 5, '2014-04-07 10:11:19', 'How many children die everyday of preventable causes in Vietnam?', 100, 171, '', '', NULL, b'1'),
(69, 5, 5, '2014-04-07 10:15:36', 'What should you do in Vietnam if you see a child in situation where he/she looks like he/she needs help from an aggressor?', 100, 176, '', '', NULL, b'1'),
(70, 6, 5, '2014-04-07 10:16:13', 'Who is responsible for of the protection of children?', 100, 181, '', '', NULL, NULL),
(71, 6, 5, '2014-04-07 10:17:11', 'Which group of children do you think is vulnerable to abuse?', 100, 185, '', '', NULL, NULL),
(72, 6, 5, '2014-04-07 10:17:58', 'If being abused, what should children do?', 100, 189, '', '', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `quizcategory`
--

CREATE TABLE IF NOT EXISTS `quizcategory` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Dumping data for table `quizcategory`
--

INSERT INTO `quizcategory` (`Id`, `CategoryName`) VALUES
(5, 'Health services'),
(6, 'Protection'),
(7, 'Education'),
(8, 'Nutritions');

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
  `Name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`Id`, `Name`) VALUES
(1, 'hyper-admin'),
(2, 'super-admin'),
(3, 'admin'),
(4, 'ngo'),
(5, 'user');

-- --------------------------------------------------------

--
-- Table structure for table `rolefunction`
--

CREATE TABLE IF NOT EXISTS `rolefunction` (
  `RoleId` int(11) NOT NULL AUTO_INCREMENT,
  `FunctionId` int(11) DEFAULT NULL,
  PRIMARY KEY (`RoleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

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
  `FullName` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RegisterDate` datetime DEFAULT NULL,
  `PhoneNumber` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Address` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`Id`, `FullName`, `Email`, `RegisterDate`, `PhoneNumber`, `Address`) VALUES
(1, NULL, 'imrhung@yahoo.com', '2014-04-02 10:05:53', '84912880656', NULL),
(2, NULL, 'imrhung@yahoo.com', '2014-04-04 02:56:19', '84912880656', NULL),
(3, NULL, 'partnershipvietnam@unicef.org', '2014-04-07 09:59:04', '+84 3821-9413', NULL),
(4, NULL, 'info@achvn.org', '2014-04-07 10:32:43', '01217799140', NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `usermedal`
--

CREATE TABLE IF NOT EXISTS `usermedal` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` int(11) DEFAULT NULL,
  `MedalId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `userpartner`
--

CREATE TABLE IF NOT EXISTS `userpartner` (
  `UserId` int(11) NOT NULL AUTO_INCREMENT,
  `PartnerId` int(11) DEFAULT NULL,
  `UserName` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Password` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`UserId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `userpartner`
--

INSERT INTO `userpartner` (`UserId`, `PartnerId`, `UserName`, `Password`) VALUES
(1, 3, 'unicef', 'e10adc3949ba59abbe56e057f20f883e'),
(2, 4, 'username', 'e10adc3949ba59abbe56e057f20f883e'),
(3, 5, 'unicef_vietnam', 'e10adc3949ba59abbe56e057f20f883e'),
(4, 6, 'agapevn', 'e10adc3949ba59abbe56e057f20f883e');

-- --------------------------------------------------------

--
-- Table structure for table `userrole`
--

CREATE TABLE IF NOT EXISTS `userrole` (
  `UserId` int(11) NOT NULL,
  `RoleId` int(11) DEFAULT NULL,
  PRIMARY KEY (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `userrole`
--

INSERT INTO `userrole` (`UserId`, `RoleId`) VALUES
(1, 3),
(2, 4),
(3, 3),
(4, 4);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varbinary(16) NOT NULL,
  `username` varchar(100) CHARACTER SET utf8 NOT NULL,
  `password` varchar(80) CHARACTER SET utf8 NOT NULL,
  `salt` varchar(40) CHARACTER SET utf8 DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8 NOT NULL,
  `activation_code` varchar(40) CHARACTER SET utf8 DEFAULT NULL,
  `forgotten_password_code` varchar(40) CHARACTER SET utf8 DEFAULT NULL,
  `forgotten_password_time` int(11) unsigned DEFAULT NULL,
  `remember_code` varchar(40) CHARACTER SET utf8 DEFAULT NULL,
  `created_on` int(11) unsigned NOT NULL,
  `last_login` int(11) unsigned DEFAULT NULL,
  `active` tinyint(1) unsigned DEFAULT NULL,
  `first_name` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `last_name` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `company` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `gender` int(1) NOT NULL,
  `url` varchar(256) CHARACTER SET utf8 NOT NULL,
  `bio` text CHARACTER SET utf8 NOT NULL,
  `birthday` date NOT NULL,
  `location` varchar(56) CHARACTER SET utf8 NOT NULL,
  `full_name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `hero_name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `phone_number` varchar(20) CHARACTER SET utf8 NOT NULL,
  `facebook_id` varchar(100) CHARACTER SET utf8 NOT NULL,
  `address` varchar(200) CHARACTER SET utf8 NOT NULL,
  `current_level` int(11) NOT NULL DEFAULT '0',
  `point` int(11) NOT NULL DEFAULT '0',
  `accept_tou` bit(1) NOT NULL DEFAULT b'0',
  `register_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=14 ;

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

-- --------------------------------------------------------

--
-- Table structure for table `virtualquest`
--

CREATE TABLE IF NOT EXISTS `virtualquest` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `QuestName` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PacketId` int(11) DEFAULT NULL,
  `PartnerId` int(11) DEFAULT NULL,
  `AnimationId` int(11) DEFAULT NULL,
  `UnlockPoint` int(11) DEFAULT NULL,
  `CreateDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=20 ;

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
