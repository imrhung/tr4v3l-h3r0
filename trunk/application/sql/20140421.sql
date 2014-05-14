-- This file is update change for database from 2014, April 21.
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: localhost    Database: zadmin_heroforzero
-- ------------------------------------------------------
-- Server version	5.1.73

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_Leaderboard`(IN currentPage INT, IN pageSize INT, IN friends NVARCHAR(5000))
BEGIN
	DECLARE rowNumber INT;
	SET @pageSize = pageSize;
	SET @rowNumber = currentPage * pageSize;
	SET @friends = friends; -- List of facebook id in format: "0123, 02343254, 23234"
	SET @getmore = true;
	
	-- we select from user's friend first. If there are no friend, select from all user.
	if (@friends IS NOT NULL OR @friends != '')
	then
		if (pageSize != 0)
		then 
			SET @myquery1 = 
			"SELECT userapplication.UserId as id, user.FullName as name, userapplication.Points as mark, userapplication.FacebookId facebook_id, userapplication.CurrentLevel as current_level
			FROM 
					zadmin_heroforzero.userapplication, zadmin_heroforzero.user
			WHERE userapplication.UserId = user.Id
				AND userapplication.FacebookId IN (";
			set @myquery2 = ")
			order by userapplication.Points DESC
			LIMIT  ?,?";
			set @myquery = CONCAT(@myquery1, @friends, @myquery2);
			PREPARE STMT FROM @myquery;
			EXECUTE STMT USING  @rowNumber, @pageSize;
			DEALLOCATE PREPARE STMT;
		
		else  
			SELECT userapplication.UserId as id, user.FullName as name, userapplication.Points as mark, userapplication.FacebookId facebook_id, userapplication.CurrentLevel as current_level
			FROM 
					zadmin_heroforzero.userapplication, zadmin_heroforzero.user
			WHERE userapplication.UserId = user.Id
			order by userapplication.Points DESC;
		END if;	
		-- Check if is there any result:
		if (FOUND_ROWS() != 0)
		then 
			SET @getmore = false;
		END if;
	END if;
	

	-- If there are no friend, select from all user.
	if (@getmore = true)
	then
		if (pageSize != 0) 
		then
			PREPARE STMT FROM
			"SELECT userapplication.UserId as id, user.FullName as name, userapplication.Points as mark, userapplication.FacebookId facebook_id, userapplication.CurrentLevel as current_level
			FROM 
					zadmin_heroforzero.userapplication, zadmin_heroforzero.user
			WHERE userapplication.UserId = user.Id
			order by userapplication.Points DESC
			LIMIT  ?,?";
			EXECUTE STMT USING @rowNumber, @pageSize;
			DEALLOCATE PREPARE STMT;
		
		else  
			SELECT userapplication.UserId as id, user.FullName as name, userapplication.Points as mark, userapplication.FacebookId facebook_id, userapplication.CurrentLevel as current_level
			FROM 
					zadmin_heroforzero.userapplication, zadmin_heroforzero.user
			WHERE userapplication.UserId = user.Id
			order by userapplication.Points DESC;
		END if;	
	end if;
END

-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_Animation`(id INT)
BEGIN
	SELECT * FROM zadmin_heroforzero.animation			
		WHERE
				animation.Id = id;
				
END$$
DELIMITER ;
-- --
-- Get pagination wrong. Alter the stored procedure:
-- --
USE `zadmin_heroforzero`;
DROP procedure IF EXISTS `sp_Get_QuizList`;

DELIMITER $$
USE `zadmin_heroforzero`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_QuizList`(IN currentPage INT, IN pageSize INT)
BEGIN
	DECLARE rowNumber INT;
	
	SET @pageSize = pageSize;
	SET @rowNumber = currentPage * pageSize;
	
	if (pageSize != 0) 
	then	
		PREPARE STMT FROM
		"SELECT quiz.Id, quizcategory.CategoryName, quiz.IsApproved, partner.PartnerName, quiz.CreatedDate  
		FROM 
			 zadmin_heroforzero.quiz,
			 zadmin_heroforzero.partner,
			 zadmin_heroforzero.quizcategory
		WHERE 
			 quiz.PartnerId  = partner.Id
		  AND
			 quiz.CategoryId = quizcategory.Id
		LIMIT ?,?";
		EXECUTE STMT USING @rowNumber, @pageSize;
		DEALLOCATE PREPARE STMT;
	 else
		SELECT quiz.Id, quizcategory.CategoryName, quiz.IsApproved, partner.PartnerName, quiz.CreatedDate  
		FROM 
			 zadmin_heroforzero.quiz,
			 zadmin_heroforzero.partner,
			 zadmin_heroforzero.quizcategory
		WHERE 
			 quiz.PartnerId  = partner.Id
		  AND
			 quiz.CategoryId = quizcategory.Id;
	end if;
	

END$$

DELIMITER ;

-- -
-- Get quiz list by category
-- -
USE `zadmin_heroforzero`;
DROP procedure IF EXISTS `sp_Get_QuizList_ByCategory`;

DELIMITER $$
USE `zadmin_heroforzero`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_QuizList_ByCategory`(IN currentPage INT, IN pageSize INT, IN category INT)
BEGIN
	DECLARE rowNumber INT;
	
	SET @pageSize = pageSize;
	SET @rowNumber = currentPage * pageSize;
	SET @category = category;
	
	if (pageSize != 0) 
	then	
		PREPARE STMT FROM
		"SELECT *   
		FROM 
			 zadmin_heroforzero.quiz
		order by field (CategoryId, ?) desc
		LIMIT ?,?";
		EXECUTE STMT USING @category, @rowNumber, @pageSize;
		DEALLOCATE PREPARE STMT;
	 else
		SELECT *   
		FROM 
			 zadmin_heroforzero.quiz
		WHERE 
			 quiz.CategoryId = @category;
	end if;
END$$

DELIMITER ;

USE `zadmin_heroforzero`;
DROP procedure IF EXISTS `sp_Get_UserMedal`;

DELIMITER $$
USE `zadmin_heroforzero`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_UserMedal`(IN currentPage INT, IN pageSize INT, IN userId INT)
BEGIN
	DECLARE rowNumber INT;
	
	SET @pageSize = pageSize;
	SET @rowNumber = currentPage * pageSize;
	SET @userId = userId;
	
	if (pageSize != 0) 
	then	
		PREPARE STMT FROM
		"SELECT usermedal.Id, usermedal.MedalId, medal.Name, medal.ImageURL FROM usermedal, medal
		WHERE usermedal.UserId = ? AND usermedal.MedalId = medal.Id
		ORDER BY usermedal.Id DESC
		LIMIT ?,?";
		EXECUTE STMT USING @userId, @rowNumber, @pageSize;
		DEALLOCATE PREPARE STMT;
	else
		SELECT usermedal.Id, usermedal.MedalId, medal.Name, medal.ImageURL FROM usermedal, medal
		WHERE usermedal.UserId = @userId AND usermedal.MedalId = medal.Id
		ORDER BY usermedal.Id DESC;
	END if;
END$$

DELIMITER ;




USE `zadmin_heroforzero`;
DROP procedure IF EXISTS `sp_Delete_Partner`;

DELIMITER $$
USE `zadmin_heroforzero`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Delete_Partner`(Id INT)
BEGIN
	SET @Id = Id;

	-- Delete in 4 table:
	DELETE userrole, user, userpartner, partner FROM userrole inner join userpartner inner join user inner join partner
			WHERE userrole.UserId = userpartner.UserId
			AND userpartner.UserId = user.Id
			AND partner.Id = @Id
			and userpartner.PartnerId = @Id ;
END$$

DELIMITER ;

USE `zadmin_heroforzero`;
DROP procedure IF EXISTS `sp_Get_QuizList_Random`;

DELIMITER $$
USE `zadmin_heroforzero`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_QuizList_Random`(IN pageSize INT)
BEGIN
	
	SET @pageSize = pageSize;
	
	if (pageSize != 0) 
	then	
		PREPARE STMT FROM
		"SELECT *   
		FROM 
			 zadmin_heroforzero.quiz
		order by rand()
		LIMIT ?";
		EXECUTE STMT USING @pageSize;
		DEALLOCATE PREPARE STMT;
	 else
		SELECT *   
		FROM 
			 zadmin_heroforzero.quiz
		order by RAND();
	end if;
END$$

DELIMITER ;

USE `zadmin_heroforzero`;
DROP procedure IF EXISTS `sp_Get_QuizChoiceList_Random`;

DELIMITER $$
USE `zadmin_heroforzero`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_QuizChoiceList_Random`(IN pageSize INT)
BEGIN
	
	SET @pageSize = pageSize;
	
	if (pageSize != 0) 
	then	
		PREPARE STMT FROM
		"SELECT q.*, c.Id as cId, c.Content as answer
		FROM choice c 
		JOIN (SELECT *  FROM  quiz order by RAND() 	LIMIT ?) as q ON q.Id = c.QuestionId";
		EXECUTE STMT USING @pageSize;
		DEALLOCATE PREPARE STMT;
	 else
		SELECT q.*, c.Id as cId, c.Content as answer
		FROM choice c 
		JOIN (SELECT *  FROM  quiz order by RAND()) as q ON q.Id = c.QuestionId;
	end if;
END$$

DELIMITER ;



USE `zadmin_heroforzero`;
DROP procedure IF EXISTS `sp_Get_PacketAvailableList`;

DELIMITER $$
USE `zadmin_heroforzero`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_PacketAvailableList`(IN currentPage INT, IN pageSize INT)
BEGIN
	DECLARE rowNumber INT;
	
	SET @currentPage = currentPage;
	SET @rowNumber = currentPage * pageSize;
	
	if (pageSize != 0) 
	then	
		PREPARE STMT FROM
		"SELECT  * FROM packet p 
		WHERE NOT EXISTS (SELECT PacketId, count from (SELECT PacketId, COUNT(*) as count from virtualquest GROUP BY PacketId) as c where count = 3 AND c.PacketId = p.Id)
		LIMIT ?,?";
		EXECUTE STMT USING @rowNumber, @pageSize;
		DEALLOCATE PREPARE STMT;
	else
		SELECT  * FROM packet p 
		WHERE NOT EXISTS (SELECT PacketId, count from (SELECT PacketId, COUNT(*) as count from virtualquest GROUP BY PacketId) as c where count = 3 AND c.PacketId = p.Id);
	END if;
END$$

DELIMITER ;










-- Facebook id need to be string --
ALTER TABLE `userapplication` CHANGE `FacebookId` `FacebookId` VARCHAR(45) NULL DEFAULT NULL;

ALTER TABLE `zadmin_heroforzero`.`virtualquest` 
CHANGE COLUMN `AnimationId` `AnimationId` INT(11) NULL DEFAULT 1 ;







USE `zadmin_heroforzero`;
DROP procedure IF EXISTS `sp_Get_DonationList`;

DELIMITER $$
USE `zadmin_heroforzero`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_DonationList`(IN currentPage INT, IN pageSize INT)
BEGIN
	DECLARE rowNumber INT;
	SET @currentPage = currentPage;
	SET @rowNumber = currentPage * pageSize;
	
	if (pageSize != 0) 
	then
		PREPARE STMT FROM
		"SELECT donation.Id, donation.Title, partner.PartnerName, donation.RequiredPoint,  donation.IsApproved, donation.CreateDate, medal.ImageURL
		FROM 
				zadmin_heroforzero.donation,
				zadmin_heroforzero.partner,
				zadmin_heroforzero.medal
		WHERE 
				donation.PartnerId = partner.Id
				AND medal.Id = donation.MedalId
		LIMIT  ?,?";
		EXECUTE STMT USING @rowNumber, @pageSize;
		DEALLOCATE PREPARE STMT;
	else  
		SELECT donation.Id, donation.Title, partner.PartnerName, donation.RequiredPoint,  donation.IsApproved, donation.CreateDate, medal.ImageURL
		FROM 
				zadmin_heroforzero.donation,
				zadmin_heroforzero.partner,
				zadmin_heroforzero.medal
		WHERE 
				donation.PartnerId = partner.Id
				AND medal.Id = donation.MedalId;
		END if;	
END$$

DELIMITER ;

