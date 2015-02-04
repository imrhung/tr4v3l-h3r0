-- phpMyAdmin SQL Dump
-- version 3.5.8.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 03, 2015 at 12:11 AM
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

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_allquestofuseraccept`(IN iUserId INT)
BEGIN
	SELECT * FROM quest
	INNER JOIN user_quest
	ON quest.id = user_quest.quest_id
	WHERE user_quest.user_id = iUserId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_checksignupwithemailinfo`(iFullName VARCHAR(100),
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_checksignupwithfacebookinfo`(IN iFacebookId VARCHAR(100),
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_completeQuestProcess`(IN inUserId INT, IN inQuestId INT)
BEGIN
	DECLARE nextQuestId INT;
	SET @nextQuestId = (SELECT MIN(Id) FROM virtualquest WHERE Id > inQuestId);
	UPDATE uservirtualquest SET `Status` = 2 WHERE UserId = inUserId AND QuestId = inQuestId;
	IF (NOT EXISTS (SELECT * FROM uservirtualquest WHERE UserId = inUserId AND QuestId = @nextQuestId)) THEN
		INSERT INTO uservirtualquest VALUES (inUserId, @nextQuestId, 1);
	END IF;
	SELECT v.Id AS virtualquestId,v.QuestName AS QuestName,v.PacketId AS PacketId,v.PartnerId AS PartnerId,v.AnimationId AS AnimationId, v.UnlockPoint AS UnlockPoint, v.CreateDate AS virtualquestCreateDate, v.ImageURL AS questImageUrl
			,k.Title AS packetTitle,k.ImageURL AS packetImageURL
			,p.PartnerName AS PartnerName, p.OrganizationTypeId AS OrganizationTypeId, p.Address AS partnerAddress, p.PhoneNumber AS PhoneNumber, p.WebsiteURL AS partnerWebsiteUrl, p.Latitude AS Latitude, p.Longtitude AS Longtitude, p.Description AS partnerDescription, p.IsApproved AS partnerIsApproved, p.LogoURL AS partnerLogoUrl, p.IconURL AS partnerIconUrl
			,c.Id AS conditionId, c.Type AS conditionType, c.Value AS conditionValue, c.ObjectId AS ObjectId
			,a.Id AS Id, a.Title AS Title, a.Description AS Description, a.IsApproved AS IsApproved, a.CreateDate AS CreateDate
			, a.ActionId AS activityActionId, a.BonusPoint AS activityBonusPoint, a.ActionContent AS activityActionContent,'' AS donationRequiredPoint, '' AS donationMedalId, '' AS medalImageUrl
			,(SELECT p.WebsiteURL FROM partner p WHERE p.Id = a.PartnerId) AS WebUrl
			,(SELECT p.IconURL FROM partner p WHERE p.Id = a.PartnerId) AS IconUrl
	FROM virtualquest v 
	JOIN partner p ON v.PartnerId = p.Id
	JOIN packet k ON v.PacketId = k.Id 
	JOIN questcondition c ON v.Id = c.VirtualQuestId AND c.`Type` = 1
	JOIN activity a ON a.Id = c.`ObjectId`
	WHERE v.Id = @nextQuestId

	UNION

	SELECT v.Id AS virtualquestId,v.QuestName AS QuestName,v.PacketId AS PacketId,v.PartnerId AS PartnerId,v.AnimationId AS AnimationId, v.UnlockPoint AS UnlockPoint, v.CreateDate AS virtualquestCreateDate, v.ImageURL AS questImageUrl
			,k.Title AS packetTitle,k.ImageURL AS packetImageURL
			,p.PartnerName AS PartnerName, p.OrganizationTypeId AS OrganizationTypeId, p.Address AS partnerAddress, p.PhoneNumber AS PhoneNumber, p.WebsiteURL AS partnerWebsiteUrl, p.Latitude AS Latitude, p.Longtitude AS Longtitude, p.Description AS partnerDescription, p.IsApproved AS partnerIsApproved, p.LogoURL AS partnerLogoUrl, p.IconURL AS partnerIconUrl
			,c.Id AS conditionId, c.Type AS conditionType, c.Value AS conditionValue, c.ObjectId AS ObjectId
			,d.Id AS Id, d.Title AS Title, d.Description AS Description, d.IsApproved AS IsApproved, d.CreateDate AS CreateDate
			,'' AS activityActionId, '' AS activityBonusPoint, '' AS activityActionContent, d.RequiredPoint AS donationRequiredPoint, d.MedalId AS donationMedalId, m.ImageURL AS medalImageUrl
			, (SELECT p.WebsiteURL FROM partner p WHERE p.Id = d.PartnerId) AS WebUrl
			, (SELECT p.IconURL FROM partner p WHERE p.Id = d.PartnerId) AS IconUrl
	FROM virtualquest v 
	JOIN partner p ON v.PartnerId = p.Id
	JOIN packet k ON v.PacketId = k.Id 
	JOIN questcondition c ON v.Id = c.VirtualQuestId AND c.`Type` = 2
	JOIN donation d ON d.Id = c.`ObjectId`
	JOIN medal m ON m.Id = d.MedalId
	WHERE v.Id = @nextQuestId

	UNION

	SELECT v.Id AS virtualquestId,v.QuestName AS QuestName,v.PacketId AS PacketId,v.PartnerId AS PartnerId,v.AnimationId AS AnimationId, v.UnlockPoint AS UnlockPoint, v.CreateDate AS virtualquestCreateDate, v.ImageURL AS questImageUrl
			,k.Title AS packetTitle,k.ImageURL AS packetImageURL
			,p.PartnerName AS PartnerName, p.OrganizationTypeId AS OrganizationTypeId, p.Address AS partnerAddress, p.PhoneNumber AS PhoneNumber, p.WebsiteURL AS partnerWebsiteUrl, p.Latitude AS Latitude, p.Longtitude AS Longtitude, p.Description AS partnerDescription, p.IsApproved AS partnerIsApproved, p.LogoURL AS partnerLogoUrl, p.IconURL AS partnerIconUrl
			,c.Id AS conditionId, c.Type AS conditionType, c.Value AS conditionValue, c.ObjectId AS ObjectId
			,'' AS Id, CONCAT('Earn ', c.`Value`, ' points') AS Title, '' AS Description, '' AS IsApproved, '' AS CreateDate,'' AS activityActionId, '' AS activityBonusPoint, '' AS activityActionContent,'' AS donationRequiredPoint, '' AS donationMedalId, '' AS medalImageUrl
			,'' AS WebUrl, '' AS IconUrl
	FROM virtualquest v 
	JOIN partner p ON v.PartnerId = p.Id
	JOIN packet k ON v.PacketId = k.Id 
	JOIN questcondition c ON v.Id = c.VirtualQuestId AND c.`Type` = 0
	WHERE v.Id = @nextQuestId

	ORDER BY conditionType;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Delete_Activity`(Id INT)
BEGIN
		DELETE FROM activity
			WHERE activity.Id = Id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Delete_Donation`(Id INT)
BEGIN
		DELETE FROM donation
			WHERE donation.Id = Id;
END$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_player`(
	IN id INT
)
BEGIN
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
	
	# Start reset user
	# Delete other quest ID rather than 1 from uservirtualquest.
	DELETE FROM uservirtualquest
		WHERE UserId = id;

	# Delete data from usermedal table
	DELETE from usermedal
		WHERE UserId = id;

	# Delete data from usercondition table
	DELETE from usercondition
		WHERE UserId = id;

	# Reset data in userapplication table
	DELETE from userapplication 
		WHERE UserId = id;

	DELETE from user 
		WHERE user.Id = id;

	# End delete user

	COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Delete_QuestCondition`(Id INT)
BEGIN
	DELETE FROM questcondition WHERE VirtualQuestId = Id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Delete_Quiz`(Id INT)
BEGIN
	DELETE FROM quiz
		WHERE quiz.Id = Id;
				
	DELETE FROM choice
		WHERE choice.QuestionId = Id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Delete_VirtualQuest`(Id INT)
BEGIN
	DELETE FROM virtualquest
			WHERE virtualquest.Id = Id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getActivitiesByPartnerId`(IN partnerId INT)
BEGIN
	SELECT * FROM Activity WHERE PartnerId = partnerId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getDonationBy`(IN currentPage INT, IN pageSize INT)
BEGIN
	DECLARE rowNumber INT;
	SET @currentPage = currentPage + 1;
	SET @rowNumber = currentPage * pageSize;
	SET @pageSize = pageSize;
	#select @currentPage as a, @rowNumber as b, pageSize as c;
	PREPARE STMT FROM
	"SELECT * FROM donation d JOIN medal m ON d.MedalId = m.Id LIMIT ?,?";
	EXECUTE STMT USING @rowNumber, @pageSize;
	DEALLOCATE PREPARE STMT;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getNumberOfChildrenByUserId`()
BEGIN
	SELECT (7000000 - COUNT(QuestId)) AS `numOfChildren` FROM uservirtualquest WHERE Status = 2;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetOrganizationList`(
	IN currentPage INTEGER, 
	IN pageSize INTEGER
)
BEGIN
	SET @_pageSize = pageSize;
	SET @_currentPage = currentPage;
	
	SET @rowNumber = (@_currentPage * @_pageSize); 
	
	if (@_pageSize != 0) 
	then
		PREPARE STMT FROM
		"SELECT partner.*, organizationtype.TypeName, user.Email
		FROM 
			organizationtype,
			partner,
			user,
			userpartner
				
		WHERE 
				organizationtype.Id = partner.OrganizationTypeId
				AND user.Id = userpartner.UserId
				AND userpartner.PartnerId = partner.Id
		ORDER BY partner.Id
		LIMIT ?,?";
		EXECUTE STMT USING @rowNumber, @_pageSize;
		DEALLOCATE PREPARE STMT;
	else  
		SELECT partner.*, organizationtype.TypeName, user.Email
		FROM 
				organizationtype,
				partner,
				user,
				userpartner
		WHERE 
				organizationtype.Id = partner.OrganizationTypeId
				AND user.Id = userpartner.UserId
				AND userpartner.PartnerId = partner.Id
		ORDER BY partner.Id;
		end if;	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getPacketsBy`(IN currentPage INT, IN iPageSize INT)
BEGIN
	DECLARE rowNumber INT;
	SET @currentPage = currentPage;
	SET @rowNumber = currentPage * iPageSize;
	SET @pageSize = iPageSize;
	PREPARE STMT FROM
		"SELECT  
			p.Id AS pId,
			p.Title AS pTitle,
			p.ImageURL AS pImageURL,
			p.PartnerId AS pPartnerId,
			v.Id AS vId,
			v.QuestName AS vQuestName,
			v.PacketId AS vPacketId,
			v.QuestName AS vQuestName,
			v.PacketId AS vPacketId,
			v.PartnerId AS vPartnerId,
			v.AnimationId AS vAnimationId,
			v.UnlockPoint AS vUnlockPoint,
			v.CreateDate AS vCreateDate,
            v.ImageURL AS questImageUrl,
			v.MedalId as medalId,
			c.Id AS cId,
			c.Type AS cType,
			c.Value AS cValue,
			c.VirtualQuestId AS cVirtualQuestId,
			c.ObjectId AS cObjectId
		FROM packet p
		JOIN (SELECT Id FROM packet LIMIT ?, ?) ids ON p.Id = ids.Id
		INNER JOIN virtualquest v 
		ON p.Id = v.PacketId
		INNER JOIN questcondition c
		ON c.VirtualQuestId = v.Id
		ORDER BY pId, vId, cId ASC"; 
		EXECUTE STMT USING @rowNumber, @pageSize;
		DEALLOCATE PREPARE STMT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getparentquest`(IN iQuestId INT)
BEGIN
	SELECT * FROM quest WHERE id = (SELECT parent_quest_id FROM quest WHERE id = iQuestId);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getquestrefer`(IN iQuestId INT)
BEGIN
	SELECT * FROM quest WHERE parent_quest_id = (SELECT parent_quest_id FROM quest WHERE id = iQuestId) ORDER BY id ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getuserdatawithemail`(IN userName VARCHAR(100), IN pass VARCHAR(100))
BEGIN
	DECLARE userId INT;
	SELECT id INTO userId FROM user WHERE email = userName AND `password` = pass;
	SELECT *,(SELECT COUNT(*) FROM user_quest WHERE user_quest.user_id = userId) AS quest_count FROM user WHERE id = userId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getuserdatawithfacebook`(IN facebookId VARCHAR(100))
BEGIN
	DECLARE userId INT;
	SELECT id INTO userId FROM user WHERE facebook_id = facebookId;
	SELECT *,(SELECT COUNT(*) FROM user_quest WHERE user_quest.user_id = userId) AS quest_count FROM user WHERE id = userId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getVirtualQuestForMobile`(IN inId INT)
BEGIN
	SELECT v.Id as vId,v.QuestName as vQuestName,v.PacketId as vPacketId,v.PartnerId as vPartnerId,v.AnimationId as vAnimationId, v.UnlockPoint as vUnlockPoint, v.CreateDate as vCreateDate, v.ImageURL as vImageURL
			,k.Title AS kTitle,k.ImageURL AS kImageURL
			,p.PartnerName as pPartnerName, p.OrganizationTypeId as pOrganizationTypeId, p.Address as pAddress, p.PhoneNumber as pPhoneNumber, p.WebsiteURL as pWebsiteUrl, p.Latitude as pLatitude, p.Longtitude as pLongtitude, p.Description as pDescription, p.IsApproved as pIsApproved, p.LogoURL as pLogoUrl, p.IconURL as pIconUrl
			,c.Id AS cId, c.Type AS cType, c.Value AS cValue, c.ObjectId AS cObjectId
			,a.Id as Id, a.Title as Title, a.Description as Description, a.IsApproved as IsApproved, a.CreateDate as CreateDate
			, a.ActionId as aActionId, a.BonusPoint as aBonusPoint, a.ActionContent as aActionContent,'' as dRequiredPoint, '' as dMedalId, '' as mImageUrl
			,(SELECT p.WebsiteURL FROM partner p WHERE p.Id = a.PartnerId) AS WebUrl
			,(SELECT p.IconURL FROM partner p WHERE p.Id = a.PartnerId) AS IconUrl
	FROM virtualquest v 
	JOIN partner p ON v.PartnerId = p.Id
	JOIN packet k ON v.PacketId = k.Id 
	JOIN questcondition c ON v.Id = c.VirtualQuestId AND c.`Type` = 1
	JOIN activity a ON a.Id = c.`ObjectId`
	WHERE v.Id = inId

	UNION

	SELECT v.Id as vId,v.QuestName as vQuestName,v.PacketId as vPacketId,v.PartnerId as vPartnerId,v.AnimationId as vAnimationId, v.UnlockPoint as vUnlockPoint, v.CreateDate as vCreateDate, v.ImageURL as vImageURL
			,k.Title AS kTitle,k.ImageURL AS kImageURL
			,p.PartnerName as pPartnerName, p.OrganizationTypeId as pOrganizationTypeId, p.Address as pAddress, p.PhoneNumber as pPhoneNumber, p.WebsiteURL as pWebsiteUrl, p.Latitude as pLatitude, p.Longtitude as pLongtitude, p.Description as pDescription, p.IsApproved as pIsApproved, p.LogoURL as pLogoUrl, p.IconURL as pIconUrl
			,c.Id AS cId, c.Type AS cType, c.Value AS cValue, c.ObjectId AS cObjectId
			,d.Id as Id, d.Title as Title, d.Description as Description, d.IsApproved as IsApproved, d.CreateDate as CreateDate
			,'' as aActionId, '' as aBonusPoint, '' as aActionContent, d.RequiredPoint as dRequiredPoint, d.MedalId as dMedalId, m.ImageURL as mImageUrl
			, (SELECT p.WebsiteURL FROM partner p WHERE p.Id = d.PartnerId) AS WebUrl
			, (SELECT p.IconURL FROM partner p WHERE p.Id = d.PartnerId) AS IconUrl
	FROM virtualquest v 
	JOIN partner p ON v.PartnerId = p.Id
	JOIN packet k ON v.PacketId = k.Id 
	JOIN questcondition c ON v.Id = c.VirtualQuestId AND c.`Type` = 2
	JOIN donation d ON d.Id = c.`ObjectId`
	JOIN medal m ON m.Id = d.MedalId
	WHERE v.Id = inId

	UNION

	SELECT v.Id as vId,v.QuestName as vQuestName,v.PacketId as vPacketId,v.PartnerId as vPartnerId,v.AnimationId as vAnimationId, v.UnlockPoint as vUnlockPoint, v.CreateDate as vCreateDate, v.ImageURL as vImageURL
			,k.Title AS kTitle,k.ImageURL AS kImageURL
			,p.PartnerName as pPartnerName, p.OrganizationTypeId as pOrganizationTypeId, p.Address as pAddress, p.PhoneNumber as pPhoneNumber, p.WebsiteURL as pWebsiteUrl, p.Latitude as pLatitude, p.Longtitude as pLongtitude, p.Description as pDescription, p.IsApproved as pIsApproved, p.LogoURL as pLogoUrl, p.IconURL as pIconUrl
			,c.Id AS cId, c.Type AS cType, c.Value AS cValue, c.ObjectId AS cObjectId
			,'' as Id, CONCAT('Earn ', c.`Value`, ' points') as Title, '' as Description, '' as IsApproved, '' as CreateDate,'' as aActionId, '' as aBonusPoint, '' as aActionContent,'' as dRequiredPoint, '' as dMedalId, '' as mImageUrl
			,'' AS WebUrl, '' AS IconUrl
	FROM virtualquest v 
	JOIN partner p ON v.PartnerId = p.Id
	JOIN packet k ON v.PacketId = k.Id 
	JOIN questcondition c ON v.Id = c.VirtualQuestId AND c.`Type` = 0
	WHERE v.Id = inId

	ORDER BY cType;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_Activity`(id INT)
BEGIN
	SELECT activity.*, partner.PartnerName FROM activity, action, partner
		
			
		WHERE
				activity.PartnerId = partner.Id
			AND
				activity.Id = id;
				
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_ActivityList`(IN currentPage INTEGER, IN pageSize INTEGER)
BEGIN
	#DECLARE rowNumber INT;
	SET @_pageSize = pageSize;
	SET @_currentPage = currentPage;
	
	SET @rowNumber = (@_currentPage * @_pageSize);
	
	if (@_pageSize != 0) 
	then
		PREPARE STMT FROM 
		"SELECT activity.Id, activity.Title, activity.ActionContent, partner.PartnerName, activity.BonusPoint,  activity.IsApproved, activity.CreateDate, partner.IconURL, activity.Description, activity.ActionId, partner.WebsiteUrl
		FROM 
				activity,
				partner
		WHERE 
				activity.PartnerId = partner.Id
		ORDER BY activity.CreateDate DESC
		LIMIT ?,?";
		EXECUTE STMT USING @rowNumber, @_pageSize;
		DEALLOCATE PREPARE STMT;
	else  
		SELECT activity.Id, activity.Title, activity.ActionContent, partner.PartnerName, activity.BonusPoint,  activity.IsApproved, activity.CreateDate, partner.IconURL, activity.Description, activity.ActionId, partner.WebsiteUrl
		FROM 
				activity,
				partner
		WHERE 
				activity.PartnerId = partner.Id
		ORDER BY activity.CreateDate DESC;
		end if;	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_ActivityListByOrganization`(IN currentPage INTEGER, IN pageSize INTEGER, partnerId INT)
BEGIN
	#DECLARE rowNumber INT;
	SET @_pageSize = pageSize;
	SET @_currentPage = currentPage;
	SET @partnerId = partnerId;

	SET @rowNumber = (@_currentPage * @_pageSize);
	  
	if (@_pageSize != 0) 
	then
		PREPARE STMT FROM
		"SELECT activity.Id, activity.Title, activity.ActionContent, partner.PartnerName, activity.BonusPoint,  activity.IsApproved, activity.CreateDate, partner.IconURL, activity.Description, activity.ActionId, partner.WebsiteUrl
		FROM 
				activity,
				partner
		WHERE 
				activity.PartnerId = partner.Id
				AND activity.PartnerId = ? 
				AND activity.IsApproved = 1
		ORDER BY activity.CreateDate DESC
		LIMIT ?,?";
		EXECUTE STMT USING @partnerId, @rowNumber, @_pageSize;
		DEALLOCATE PREPARE STMT;
	else  
		SELECT activity.Id, activity.Title, activity.ActionContent, partner.PartnerName, activity.BonusPoint,  activity.IsApproved, activity.CreateDate, partner.IconURL, activity.Description, activity.ActionId, partner.WebsiteUrl
		FROM 
				activity,
				partner
		WHERE 
				activity.PartnerId = partner.Id
				AND activity.PartnerId = partnerId 
				AND activity.IsApproved = 1
		ORDER BY activity.CreateDate DESC;
		end if;	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_Animation`(id INT)
BEGIN
	SELECT * FROM animation			
		WHERE
				animation.Id = id;
				
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_Donation`(Id INT)
BEGIN
	SELECT donation.Id, donation.Title, donation.Description, donation.PartnerId, partner.PartnerName, donation.RequiredPoint,  donation.IsApproved, donation.CreateDate
		FROM 
				donation,
				partner
		WHERE 
				donation.PartnerId = partner.Id
		AND 	donation.Id = Id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_DonationList`(IN currentPage INT, IN pageSize INT)
BEGIN
	DECLARE rowNumber INT;
	SET @currentPage = currentPage;
	SET @rowNumber = currentPage * pageSize;
	
	SET @pageSize = pageSize; 
	if (pageSize != 0) 
	then
		PREPARE STMT FROM
		"SELECT donation.Id, donation.Title, partner.PartnerName, donation.RequiredPoint,  donation.IsApproved, donation.CreateDate, medal.ImageURL, donation.Description, donation.MedalId
		FROM 
				donation,
				partner,
				medal
		WHERE 
				donation.PartnerId = partner.Id
				AND medal.Id = donation.MedalId
		ORDER BY donation.CreateDate DESC
		LIMIT  ?,?";
		EXECUTE STMT USING @rowNumber, @pageSize;
		DEALLOCATE PREPARE STMT;
	else  
		SELECT donation.Id, donation.Title, partner.PartnerName, donation.RequiredPoint,  donation.IsApproved, donation.CreateDate, medal.ImageURL, donation.Description, donation.MedalId
		FROM 
				donation,
				partner,
				medal
		WHERE 
				donation.PartnerId = partner.Id
				AND medal.Id = donation.MedalId
		ORDER BY donation.CreateDate DESC;
		END if;	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_DonationListByOrganization`(IN currentPage INT, IN pageSize INT, partnerId INT)
BEGIN
	DECLARE rowNumber int;
	SET @currentPage = currentPage;
	SET @rowNumber = currentPage * pageSize;
	 
	SET @pageSize = pageSize;
	SET @partnerId = partnerId;
	if (pageSize != 0) 
	then
		PREPARE STMT FROM
		"SELECT donation.Id, donation.Title, partner.PartnerName, donation.RequiredPoint,  donation.IsApproved, donation.CreateDate, medal.ImageURL, donation.Description, donation.MedalId
		FROM 
				donation,
				partner,
				medal
		WHERE 
				donation.PartnerId = partner.Id
				AND medal.Id = donation.MedalId
				AND donation.PartnerId = ? 
				AND donation.IsApproved = 1
		ORDER BY donation.CreateDate DESC
		LIMIT  ?,?";
		EXECUTE STMT USING @partnerId, @rowNumber, @pageSize;
		DEALLOCATE PREPARE STMT;
	else  
		SELECT donation.Id, donation.Title, partner.PartnerName, donation.RequiredPoint,  donation.IsApproved, donation.CreateDate, medal.ImageURL, donation.Description, donation.MedalId
		FROM 
				donation,
				partner,
				medal
		WHERE 
				donation.PartnerId = partner.Id
				AND medal.Id = donation.MedalId
				AND donation.PartnerId = partnerId
				AND donation.IsApproved = 1
		ORDER BY donation.CreateDate DESC;
		END if;	
END$$

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
			"SELECT userapplication.UserId as id, user.FullName as name, user.AvatarId as avatar, userapplication.Points as mark, userapplication.FacebookId facebook_id, userapplication.CurrentLevel as current_level, @curRank := @curRank+1 as rank
			FROM 
					userapplication, user,
					(SELECT @curRank := 0) r
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
			SELECT userapplication.UserId as id, user.FullName as name, user.AvatarId as avatar, userapplication.Points as mark, userapplication.FacebookId facebook_id, userapplication.CurrentLevel as current_level, @curRank := @curRank+1 as rank
			FROM 
					userapplication, user,
					(SELECT @curRank := 0) r
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
			"SELECT userapplication.UserId as id, user.FullName as name, user.AvatarId as avatar, userapplication.Points as mark, userapplication.FacebookId facebook_id, userapplication.CurrentLevel as current_level, @curRank := @curRank+1 as rank
			FROM 
					userapplication, user,
					(SELECT @curRank := 0) r
			WHERE userapplication.UserId = user.Id
			order by userapplication.Points DESC
			LIMIT  ?,?";
			EXECUTE STMT USING @rowNumber, @pageSize;
			DEALLOCATE PREPARE STMT;
		
		else  
			SELECT userapplication.UserId as id, user.FullName as name, user.AvatarId as avatar, userapplication.Points as mark, userapplication.FacebookId as facebook_id, userapplication.CurrentLevel as current_level, @curRank := @curRank+1 as rank
			FROM 
					userapplication, user,
					(SELECT @curRank := 0) r
			WHERE userapplication.UserId = user.Id
			order by userapplication.Points DESC;
		END if;	
	end if;
END$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_PacketList`(IN currentPage INT, IN pageSize INT)
BEGIN
	DECLARE rowNumber INT;
	
	SET @currentPage = currentPage;
	SET @rowNumber = currentPage * pageSize;
	
	if (pageSize != 0) 
	then	
		PREPARE STMT FROM
		"SELECT * FROM packet
		LIMIT ?,?";
		EXECUTE STMT USING @rowNumber, @pageSize;
		DEALLOCATE PREPARE STMT;
	else
		SELECT * FROM packet;
	END if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_Partner`(IN Id INT)
BEGIN
	SELECT user.*, partner.*, userpartner.UserName, partner.PhoneNumber as phone
		FROM 
				user,
				userpartner,
				partner
		WHERE 
				partner.Id = Id
		AND		partner.Id = userpartner.PartnerId
		AND 	userpartner.UserId = user.Id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_PartnerList`(IN currentPage INT, IN pageSize INT)
BEGIN
	DECLARE rowNumber INT;
	SET @currentPage = currentPage;
	SET @rowNumber = currentPage * pageSize;
	
	if (pageSize != 0) 
	then
		PREPARE STMT FROM
		"SELECT partner.Id, partner.PartnerName, partner.OrganizationTypeId, partner.Address,  partner.PhoneNumber, partner.WebsiteURL, partner.Latitude, partner.Longtitude, partner.Description, partner.IsApproved
		FROM 
				partner
		order by partner.Id DESC
		LIMIT  ?,?";
		EXECUTE STMT USING @rowNumber, @_pageSize;
		DEALLOCATE PREPARE STMT;
	
	else  
		SELECT partner.Id, partner.PartnerName, partner.OrganizationTypeId, partner.Address,  partner.PhoneNumber, partner.WebsiteURL, partner.Latitude, partner.Longtitude, partner.Description, partner.IsApproved
		FROM 
				partner
		order by partner.Id DESC;
	END if;	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_QuestCondition`(Id INT)
BEGIN
	
		SELECT 
			Id, 
			Type, 
			ObjectId,
			Value
		FROM questcondition
		WHERE questcondition.VirtualQuestId = Id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_QuestCondition_before`(Id INT)
BEGIN
	DECLARE typeCondition INT;
	SET typeCondition = (SELECT Type FROM questcondition 
								WHERE questcondition.VirtualQuestId = Id);
	
	if(typeCondition = 0) then
		SELECT 
			Id, 
			Type, 
			ObjectId, 
			
			Value
		FROM virtualquest, questcondition
		WHERE questcondition.VirtualQuestId = Id;

	elseif(typeCondition = 1) then
		SELECT 
			Id, 
			Type, 
			ObjectId, 
			activity.Title as ObjectName,
			Value
		FROM virtualquest, questcondition, activity
		WHERE 
				questcondition.VirtualQuestId = Id
			AND
				activity.Id = questcondition.ObjectId;

	elseif(typeCondition = 2) then
		SELECT 
			Id, 
			Type, 
			ObjectId, 
			donation.Title as ObjectName,
			Value
		FROM virtualquest, questcondition, donation
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
	SET @currentPage = currentPage;
	SET @rowNumber = currentPage * pageSize;

	if (pageSize != 0) 
	then
		PREPARE STMT FROM
		"SELECT Id, CategoryName FROM quizcategory
		LIMIT ?,?";
		EXECUTE STMT USING @rowNumber, @pageSize;
		DEALLOCATE PREPARE STMT;
	else
		SELECT Id, CategoryName FROM quizcategory;
	END if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_QuizChoiceList`(IN currentPage INT, IN pageSize INT)
BEGIN
	DECLARE rowNumber INT;
	
	SET @pageSize = pageSize;
	SET @rowNumber = currentPage * pageSize;
	
	if (pageSize != 0) 
	then	
		PREPARE STMT FROM
		"SELECT q.*, c.Id as cId, c.Content as answer
		FROM choice c 
		JOIN (
			SELECT quiz.*, quizcategory.CategoryName, partner.PartnerName 
				FROM  quiz, quizcategory, partner
				WHERE quiz.PartnerId  = partner.Id
				  AND
					 quiz.CategoryId = quizcategory.Id
				ORDER BY quiz.CreatedDate DESC
				LIMIT ?, ?) as q
		ON q.Id = c.QuestionId";
		EXECUTE STMT USING @rowNumber, @pageSize;
		DEALLOCATE PREPARE STMT;
	 else
		SELECT q.*, c.Id as cId, c.Content as answer
		FROM choice c 
		JOIN (
			SELECT quiz.*, quizcategory.CategoryName, partner.PartnerName 
				FROM  quiz, quizcategory, partner
				WHERE quiz.PartnerId  = partner.Id
				  AND
					 quiz.CategoryId = quizcategory.Id 
				) as q  
		ON q.Id = c.QuestionId
		ORDER BY q.CreatedDate DESC;
	end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_QuizChoiceList_Random`(IN pageSize INT)
BEGIN
	
	SET @pageSize = pageSize;
	
	if (pageSize != 0) 
	then	
		PREPARE STMT FROM
		"SELECT q.*, c.Id as cId, c.Content as answer 
		FROM choice c 
		JOIN (SELECT *  FROM  quiz WHERE quiz.IsApproved=1 order by RAND() 	LIMIT ?) as q ON q.Id = c.QuestionId";
		EXECUTE STMT USING @pageSize;
		DEALLOCATE PREPARE STMT;
	 else
		SELECT q.*, c.Id as cId, c.Content as answer
		FROM choice c 
		JOIN (SELECT *  FROM  quiz  WHERE quiz.IsApproved=1 order by RAND()) as q ON q.Id = c.QuestionId;
	end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_QuizChoiceList_Random_Cate`(IN pageSize INT, IN category INT)
BEGIN
	
	SET @pageSize = pageSize;
	SET @category = category; 
	
	if (pageSize != 0) 
	then	
		PREPARE STMT FROM
		"SELECT q.*, c.Id as cId, c.Content as answer
		FROM choice c 
		JOIN (SELECT *  FROM  quiz WHERE quiz.CategoryId = ? AND quiz.IsApproved=1 order by RAND() 	LIMIT ?) as q ON q.Id = c.QuestionId";
		EXECUTE STMT USING @category, @pageSize;
		DEALLOCATE PREPARE STMT; 
	 else
		SELECT q.*, c.Id as cId, c.Content as answer
		FROM choice c 
		JOIN (SELECT *  FROM  quiz WHERE quiz.CategoryId = @category AND quiz.IsApproved=1 order by RAND()) as q ON q.Id = c.QuestionId;
	end if;
END$$

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
			 quiz,
			 partner,
			 quizcategory
		WHERE 
			 quiz.PartnerId  = partner.Id
		  AND
			 quiz.CategoryId = quizcategory.Id
		ORDER BY quiz.CreatedDate DESC
		LIMIT ?,?";
		EXECUTE STMT USING @rowNumber, @pageSize;
		DEALLOCATE PREPARE STMT;
	 else
		SELECT quiz.Id, quizcategory.CategoryName, quiz.IsApproved, partner.PartnerName, quiz.CreatedDate  
		FROM 
			 quiz,
			 partner, 
			 quizcategory
		WHERE 
			 quiz.PartnerId  = partner.Id
		  AND
			 quiz.CategoryId = quizcategory.Id
		ORDER BY quiz.CreatedDate DESC;
	end if;
	

END$$

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
			 quiz
		order by field (CategoryId, ?) desc
		LIMIT ?,?";
		EXECUTE STMT USING @category, @rowNumber, @pageSize;
		DEALLOCATE PREPARE STMT;
	 else
		SELECT *   
		FROM 
			 quiz
		WHERE 
			 quiz.CategoryId = @category;
	end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_QuizList_Random`(IN pageSize INT)
BEGIN
	
	SET @pageSize = pageSize;
	
	if (pageSize != 0) 
	then	
		PREPARE STMT FROM
		"SELECT *   
		FROM 
			 quiz
		order by rand()
		LIMIT ?";
		EXECUTE STMT USING @pageSize;
		DEALLOCATE PREPARE STMT;
	 else
		SELECT *   
		FROM 
			 quiz
		order by RAND();
	end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_QuizList_Random_Cate`(IN pageSize INT, IN category INT)
BEGIN
	
	SET @pageSize = pageSize;
	SET @category = category; 
	
	if (pageSize != 0) 
	then	
		PREPARE STMT FROM
		"SELECT *   
		FROM 
			 quiz
		WHERE quiz.CategoryId = ?
		order by rand()
		LIMIT ?";
		EXECUTE STMT USING @category, @pageSize;
		DEALLOCATE PREPARE STMT;
	 else
		SELECT *   
		FROM 
			 quiz
		WHERE quiz.CategoryId = @category
		order by RAND();
	end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_UserMedal`(IN currentPage INT, IN pageSize INT, IN userId INT)
BEGIN
	DECLARE rowNumber INT;
	
	SET @pageSize = pageSize;
	SET @rowNumber = currentPage * pageSize;
	SET @userId = userId;
	
	if (pageSize != 0) 
	then	
		PREPARE STMT FROM
		"SELECT usermedal.Id, usermedal.MedalId, medal.Name, medal.ImageURL
		FROM usermedal, medal
		WHERE usermedal.UserId = ? AND usermedal.MedalId = medal.Id
		ORDER BY usermedal.Id DESC
		LIMIT ?,?";
		EXECUTE STMT USING @userId, @rowNumber, @pageSize;
		DEALLOCATE PREPARE STMT;
	else
		SELECT usermedal.Id, usermedal.MedalId, medal.Name, medal.ImageURL 
		FROM usermedal, medal
		WHERE usermedal.UserId = @userId AND usermedal.MedalId = medal.Id 
		ORDER BY usermedal.Id DESC;
	END if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_VirtualQuest`(Id INT)
BEGIN
	SELECT 
		virtualquest.Id,
		QuestName,
		partner.PartnerName,
		UnlockPoint,
		CreateDate,
		AnimationId,
		virtualquest.ImageURL, 
		PacketId,
		packet.Title as 'PacketName',
		questcondition.Id, 
		questcondition.Type, 
		questcondition.ObjectId,
		questcondition.Value
	FROM 
		virtualquest,
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
	SET @currentPage = currentPage;
	SET @rowNumber = currentPage * pageSize;

	if (pageSize != 0) 
	then
		PREPARE STMT FROM
		"SELECT virtualquest.Id, 
		QuestName,
		packet.Title as 'PacketName',
		UnlockPoint,
		CreateDate
				
		FROM virtualquest, packet
		WHERE virtualquest.PacketId = packet.Id
		LIMIT ?,?";
		EXECUTE STMT USING @rowNumber, @pageSize;
		DEALLOCATE PREPARE STMT;
	else
SELECT virtualquest.Id, 
		QuestName,
		packet.Title as 'PacketName',
		UnlockPoint,
		CreateDate
				
		FROM virtualquest, packet
		WHERE virtualquest.PacketId = packet.Id;
	END if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertMedal`(
	userId INT, 
	medalId INT
)
BEGIN
	DECLARE iStatus INT;
	SET iStatus = 0;
		IF not exists(SELECT Id FROM usermedal WHERE usermedal.UserId = userId AND usermedal.MedalId = medalId)
		THEN
			INSERT INTO usermedal(
														UserId,
														MedalId
													)
											VALUES(
														userId,
														medalId
													);
			
		ELSE
			SET iStatus = 1;
		END IF; 
		SELECT iStatus;
	  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertUserFb`(IN iFullName VARCHAR(100),IN iEmail VARCHAR(100), IN iPhone VARCHAR(45), IN iFacebookId VARCHAR(45))
BEGIN
	DECLARE userId INT;

	BEGIN 
		-- ERROR
		ROLLBACK;
	END;

	BEGIN
		-- WARNING
		ROLLBACK;
	END;
	
	IF EXISTS(SELECT * FROM userapplication WHERE FacebookId = iFacebookId) THEN
	
		SELECT '0' as `code`, 'User is Exist' as 'message',
			s.FullName as uUserName,
			s.AvatarId as uAvatar,
			u.UserId AS uUserId,
			u.FacebookId AS uFacebookId,
			u.Points AS uPoints,
			u.CurrentLevel AS uCurrentLevel,
			v.Id AS vId,
			v.QuestName AS vQuestName,
			v.PacketId AS vPacketId,
			v.QuestName AS vQuestName,
			v.PacketId AS vPacketId,
			v.PartnerId AS vPartnerId,
			v.AnimationId AS vAnimationId,
			v.UnlockPoint AS vUnlockPoint,
			v.CreateDate AS vCreateDate,
			q.Status AS qStatus,
			c.Id AS cId,
			c.Type AS cType,
			c.Value AS cValue,
			c.VirtualQuestId AS cVirtualQuestId,
			c.ObjectId AS cObjectId,
			IF( EXISTS (SELECT * FROM usercondition WHERE UserId = u.UserId AND ConditionId = c.Id), 1, 0 ) AS  'is_completed'
			
		FROM userapplication u
		JOIN uservirtualquest q ON u.UserId = q.UserId
		JOIN virtualquest v ON q.QuestId = v.Id
		JOIN questcondition c ON c.VirtualQuestId = v.Id
		join user s on s.Id = u.UserId
		WHERE FacebookId = iFacebookId AND device_id IS NULL;

	ELSE
		START TRANSACTION;
			
			INSERT INTO user(Fullname, Email, RegisterDate, PhoneNumber, AvatarId) VALUES(iFullName, iEmail, curdate(), iPhone, 0);
		
			set @userId = (SELECT LAST_INSERT_ID());
			
			INSERT INTO userapplication(UserId, FacebookId, Points, CurrentLevel) VALUES(@userId, iFacebookId, 0, 0);
			
			INSERT INTO uservirtualquest(UserId, QuestId, Status) VALUES (@userId, (SELECT Id FROM virtualquest LIMIT 1), 1);
			
			SELECT '1' as `code`, 'Regist successful' as 'message', 
				s.FullName as uUserName,
				s.AvatarId as uAvatar,
				u.UserId AS uUserId,
				u.FacebookId AS uFacebookId,
				u.Points AS uPoints,
				u.CurrentLevel AS uCurrentLevel,
				v.Id AS vId,
				v.QuestName AS vQuestName,
				v.PacketId AS vPacketId,
				v.PartnerId AS vPartnerId,
				v.AnimationId AS vAnimationId,
				v.UnlockPoint AS vUnlockPoint,
				v.CreateDate AS vCreateDate,
				q.Status AS qStatus,
				c.Id AS cId,
				c.Type AS cType,
				c.Value AS cValue,
				c.VirtualQuestId AS cVirtualQuestId, 
				c.ObjectId AS cObjectId,
				IF( EXISTS (SELECT * FROM usercondition WHERE UserId = u.UserId AND ConditionId = c.Id), 1, 0 ) AS  'is_completed'

			FROM userapplication u
			JOIN uservirtualquest q ON u.UserId = q.UserId
			JOIN virtualquest v ON q.QuestId = v.Id 
			JOIN questcondition c ON c.VirtualQuestId = v.Id
			join user s on s.Id = u.UserId
			WHERE u.UserId = @userId;

		COMMIT;
			
	END IF;
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
	INSERT INTO questcondition
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
	INSERT INTO packet
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
	ImageURL		nvarchar(200),
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
						BonusPoint,
						ImageURL
					)
				VALUES(
						questCategory,
						partnerId,
						createdDate,
						questQuestion,
						CorrectChoiceId,
						sharingInfo,
						linkURL,
						100,
						ImageURL
					);
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Insert_QuizCategory`(category nvarchar(140))
BEGIN
	INSERT INTO quizcategory
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
	imageURL		nvarchar(200),
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
						BonusPoint,
						ImageURL
					)
				VALUES(
						questCategory,
						partnerId,
						createdDate,
						questQuestion,
						sharingInfo,
						linkURL,
						1,
						imageURL
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
	
	UPDATE quiz
			SET quiz.correctChoiceId = choiceId
			WHERE Id = QuestionId;	
	COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_user`(
				IN userName varchar (100), 
				IN deviceID varchar (100)
)
BEGIN
	DECLARE userId INT;
 
	BEGIN
		-- ERROR
		ROLLBACK;
	END;

	BEGIN
		-- WARNING
		ROLLBACK;
	END;
	
	IF EXISTS (SELECT Id FROM user, userapplication WHERE user.FullName = userName and userapplication.device_id = deviceID and user.Id = userapplication.UserId) THEN 

-- SELECT UserId, (SELECT Id FROM user WHERE FullName = userName) FROM userapplication WHERE device_id = deviceID) THEN
		SELECT '0' as `code`, 'User is Exist' as 'message',
			s.FullName as uUserName,
			s.AvatarId as uAvatar,
			u.UserId AS uUserId,
			u.FacebookId AS uFacebookId,
			u.device_id as device_id,
			u.Points AS uPoints,
			u.CurrentLevel AS uCurrentLevel,
			v.Id AS vId,
			v.QuestName AS vQuestName,
			v.PacketId AS vPacketId,
			v.QuestName AS vQuestName,
			v.PacketId AS vPacketId,
			v.PartnerId AS vPartnerId,
			v.AnimationId AS vAnimationId,
			v.UnlockPoint AS vUnlockPoint,
			v.CreateDate AS vCreateDate,
			q.Status AS qStatus,
			c.Id AS cId,
			c.Type AS cType,
			c.Value AS cValue,
			c.VirtualQuestId AS cVirtualQuestId, 
			c.ObjectId AS cObjectId,
			IF( EXISTS (SELECT * FROM usercondition WHERE UserId = u.UserId AND ConditionId = c.Id), 1, 0 ) AS  'is_completed'
			
		FROM userapplication u
		JOIN uservirtualquest q ON u.UserId = q.UserId
		JOIN virtualquest v ON q.QuestId = v.Id
		JOIN questcondition c ON c.VirtualQuestId = v.Id
		join user s on s.Id = u.UserId
		WHERE device_id = deviceID and FullName = userName;

	ELSE
		START TRANSACTION;
			
			INSERT INTO user(Fullname, RegisterDate) VALUES(userName, curdate());
		 
			set @userId = (SELECT LAST_INSERT_ID());
			
			INSERT INTO userapplication(UserId, Points, CurrentLevel, device_id) VALUES(@userId, 0, 0, deviceID);
			
			INSERT INTO uservirtualquest(UserId, QuestId, Status) VALUES (@userId, (SELECT Id FROM virtualquest LIMIT 1), 1);
			
			SELECT '1' as `code`, 'Regist successful' as 'message', 
				s.FullName as uUserName,
				s.AvatarId as uAvatar,
				u.UserId AS uUserId,
				u.FacebookId AS uFacebookId,
				u.device_id as device_id,
				u.Points AS uPoints,
				u.CurrentLevel AS uCurrentLevel,
				v.Id AS vId,
				v.QuestName AS vQuestName,
				v.PacketId AS vPacketId,
				v.PartnerId AS vPartnerId,
				v.AnimationId AS vAnimationId,
				v.UnlockPoint AS vUnlockPoint,
				v.CreateDate AS vCreateDate,
				q.Status AS qStatus,
				c.Id AS cId,
				c.Type AS cType,
				c.Value AS cValue,
				c.VirtualQuestId AS cVirtualQuestId,
				c.ObjectId AS cObjectId,
				IF( EXISTS (SELECT * FROM usercondition WHERE UserId = u.UserId AND ConditionId = c.Id), 1, 0 ) AS  'is_completed'

			FROM userapplication u
			JOIN uservirtualquest q ON u.UserId = q.UserId
			JOIN virtualquest v ON q.QuestId = v.Id
			JOIN questcondition c ON c.VirtualQuestId = v.Id
			join user s on s.Id = u.UserId
			WHERE u.UserId = @userId; 

		COMMIT;
			
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Insert_VirtualQuest`(
	partner_id Int,
	packet_id Int,
	name nvarchar(40),
	point INT,
	create_date datetime,
	animation int,
	image_url nvarchar(200)
	
)
BEGIN
	INSERT INTO virtualquest
				(
					PacketId,
					PartnerId,
					QuestName,
					UnlockPoint,
					CreateDate,
					AnimationId,
					ImageURL
				)
			VALUES
				(
					packet_id,
					partner_id,
					name,
					point,
					create_date,
					animation ,
					image_url
				);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_paginationhotelagodabydistance`(IN currentPage INT
																						, IN pageSize INT
																						, IN iLat FLOAT
																						, IN iLon FLOAT
																						, IN iDistance FLOAT
																						, IN iCountryisocode VARCHAR(2))
BEGIN
	DECLARE rowNumber INT;
	SET @currentPage = currentPage + 1;
	SET @rowNumber = currentPage * pageSize;
	PREPARE STMT FROM
	"SELECT *, (((acos(sin((iLat * 0.0174)) 
				* sin((hotel_agoda.latitude * 0.0174))
				+cos((iLat*0.0174)) 
				* cos((hotel_agoda.latitude * 0.0174)) 
				*cos(((iLon- hotel_agoda.longitude)*0.0174))))*57.32484)*111.18957696) as distance
	FROM hotel_agoda 
	WHERE countryisocode = iCountryisocode
	HAVING distance <= iDistance
	ORDER BY distance
	LIMIT ?,?";
		EXECUTE STMT USING @rowNumber, @pageSize;
		DEALLOCATE PREPARE STMT;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_paginationquest`(IN currentPage INT, IN pageSize INT)
BEGIN
	DECLARE rowNumber INT;
	SET @currentPage = currentPage;
	SET @rowNumber = currentPage * pageSize;
	PREPARE STMT FROM
	"SELECT A.* FROM quest A WHERE !isnull(A.parent_quest_id)
	ORDER BY A.id LIMIT ?,?";
	EXECUTE STMT USING @rowNumber, @pageSize;
	DEALLOCATE PREPARE STMT;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reset_player`(
	id INT
)
BEGIN
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
	
	# Start reset user
	# Delete other quest ID rather than 1 from uservirtualquest.
	DELETE FROM uservirtualquest
		WHERE UserId = id
			AND QuestId != 1;
	# Reset the status
	UPDATE uservirtualquest
		set Status = 1
		WHERE UserId = id;

	# Delete data from usermedal table
	DELETE from usermedal
		WHERE UserId = id;

	# Delete data from usercondition table
	DELETE from usercondition
		WHERE UserId = id;

	# Reset data in userapplication table
	UPDATE userapplication
		SET Points = 0 
		WHERE UserId = id;

	# End reset user

	COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_saveGame`(IN inUserId INT, IN score INT, IN inConditionId INT)
BEGIN
	DECLARE tmpScore INT;

	SELECT Points INTO @tmpScore FROM userapplication WHERE UserId = inUserId;
	SET @tmpScore = @tmpScore + score;
	UPDATE userapplication SET Points = @tmpScore WHERE UserId = inUserId;
	
	SET @tmpScore = 0; 
	SELECT AchievingPoints INTO @tmpScore FROM usercondition WHERE UserId = inUserId AND ConditionId = inConditionId;
	#SELECT @tmpScore IS NOT NULL;
	IF exists(SELECT AchievingPoints FROM usercondition WHERE UserId = inUserId AND ConditionId = inConditionId)
	THEN
		SET @tmpScore = @tmpScore + score;
		UPDATE usercondition SET AchievingPoints = @tmpScore WHERE UserId = inUserId AND ConditionId = inConditionId;
		#SELECT @tmpScore AS col;
	ELSE
		INSERT INTO `zadmin_heroforzero`.`usercondition`(`UserId`,`ConditionId`,`AchievingPoints`)VALUES (inUserId, InConditionId, score);
		#SELECT @tmpScore AS COLNULL;
	END IF;

	SELECT a.Points AS UserApplicationPoints, c.AchievingPoints AS UserConditionPoints
	FROM userapplication a 
	JOIN  usercondition c 
	ON a.UserId = c.UserId AND c.ConditionId = inConditionId 
	WHERE a.UserId = inUserId;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UpdateQuestStatus`(userId INT, questId INT, questStatus INT)
BEGIN

		IF not exists (SELECT QuestId FROM uservirtualquest WHERE uservirtualquest.UserId = userId AND uservirtualquest.QuestId = (questId + 1))
		THEN 
			BEGIN 
				INSERT INTO uservirtualquest(
												UserId,
												QuestId,
												Status
											)
							VALUES(
									userId,
									(questId + 1),
									1
									);
			END;
		END IF;
	
		UPDATE uservirtualquest SET uservirtualquest.Status = 2
								WHERE uservirtualquest.UserId = userId AND 
									  uservirtualquest.QuestId = questId;
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
	UPDATE activity
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
		UPDATE activity
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
	UPDATE  quiz
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
	UPDATE questcondition
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
	UPDATE donation
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
	UPDATE donation
		   SET 
				donation.IsApproved = IsApproved
		   WHERE
				donation.Id = Id;	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Update_Partner_IsApproved`(Id int, IsApproved bit)
BEGIN
			
	UPDATE partner
		   SET 
				partner.IsApproved = IsApproved
		   WHERE
				partner.Id = Id;	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Update_Quiz`(
	Id 				int,
	questCategory 	int,
	questQuestion 	nvarchar(140),
	ImageURL		nvarchar(200),
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
						quiz.ImageURL = ImageURL,
						quiz.CorrectChoiceId = CorrectChoiceId,
						quiz.SharingInfo = sharingInfo,
						quiz.LearnMoreURL = linkURL
			WHERE	
				quiz.Id = Id;
				
				
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Update_QuizApprove`(Id int, IsApproved bit)
BEGIN
			
	UPDATE quiz
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Update_VirtualQuest`(IN `id` INT, IN `partner_id` INT, IN `packet_id` INT, IN `name` nvarchar(140), point INT, animation INT, imageURL nvarchar(100))
BEGIN
	UPDATE virtualquest
				SET
					virtualquest.PacketId = packet_id,
					virtualquest.QuestName = name,
					virtualquest.UnlockPoint = point,
					virtualquest.AnimationId = animation,
					virtualquest.ImageURL = imageURL
				WHERE  virtualquest.Id = id;
					
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_useracceptquest`(IN iUserId INT, IN iQuestId INT, IN iParentQuestId INT)
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usercompletequest`(IN iUserId INT, IN iQuestId INT)
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `test`()
BEGIN 
	DECLARE a INT;
	SELECT id INTO a FROM quest WHERE id = 1;
	SELECT a;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `test_proc`(IN con int)
BEGIN
  SELECT * FROM userapplication
  WHERE UserId = con;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `fnc_checkSignUpInfo`(iFullName VARCHAR(100),
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

CREATE DEFINER=`root`@`localhost` FUNCTION `fnc_checkSignUpWithFacebookInfo`(iFacebookId VARCHAR(100),
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
  `action_image` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `action`
--

INSERT INTO `action` (`Id`, `Name`, `action_image`) VALUES
(1, 'Share on their Facebook', NULL),
(2, 'Sign up for Your news letter', NULL),
(3, 'Like our facebook pages', NULL),
(4, 'Add to User''s calendar', NULL);

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
  `IsApproved` bit(1) DEFAULT b'0',
  `CreateDate` datetime DEFAULT NULL,
  `ActionContent` varchar(140) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=31 ;

--
-- Dumping data for table `activity`
--

INSERT INTO `activity` (`Id`, `PartnerId`, `Title`, `Description`, `ActionId`, `BonusPoint`, `IsApproved`, `CreateDate`, `ActionContent`) VALUES
(1, 5, 'Join NextGen on Facebook ', 'Join NextGen on Facebook to find other 18-35 year old leaders concerned about children!', 4, 2, b'1', '2014-04-07 10:23:41', '2014/06/02'),
(3, 5, 'Like Unicef Vietnam on Facebook.', 'Like Unicef Vietnam on Facebook.', 3, 2, b'1', '2014-04-07 10:23:59', 'https://www.facebook.com/unicefnextgenvn'),
(4, 5, 'Share this fact about children on your FB ', 'Share this fact about children on your FB – “100 children die every day in Vietnam of preventable causes.”', 1, 2, b'1', '2014-04-07 10:24:34', '100 children die every day in Vietnam of preventable causes.'),
(5, 5, 'Sign up for newsletter to keep updated with UNICEF activities in Vietnam', 'Sign up for newsletter to keep updated with UNICEF activities in Vietnam: partnershipvietnam@unicef.org', 2, 2, b'1', '2014-04-07 10:25:28', 'unicef.org/vietnam/vi/'),
(6, 5, 'Share this fact about children on your FB ', 'Share this fact about children on your FB – “Every hour a child dies in Vietnam of an injury caused by traffic accidents or drowning.”', 1, 2, b'1', '2014-04-07 10:25:55', 'Every hour a child dies in Vietnam of an injury caused by traffic accidents or drowning.'),
(7, 5, 'Volunteer to be a swimming coach and teach kids in the Mekong Delta how to swim!', 'Volunteer to be a swimming coach and teach kids in the Mekong Delta how to swim!', 4, 2, b'1', '2014-04-07 10:26:15', '2014/06/02'),
(12, 19, 'Working as a volunteer to raise funds.', 'Working as a volunteer to raise funds ( writing a proposal, making an event, finding sponsors,…)', 1, 2, b'1', '2014-04-24 03:35:39', 'Working as a volunteer to raise funds ( writing a proposal, making an event, finding sponsors,…)'),
(13, 19, 'Helping young children to revise or prepare lessons at home', 'Helping young children to revise or prepare lessons at home', 1, 2, b'1', '2014-04-24 03:35:52', 'Helping young children to revise or prepare lessons at home'),
(15, 19, 'Helping staff in using IT / Internet', 'Helping staff in using IT / Internet', 1, 2, b'1', '2014-04-24 03:36:18', 'Helping staff in using IT / Internet'),
(17, 22, 'Volunteer your time', 'Participating in volunteer activities to look after and orient the children at the center. ', 1, 2, b'1', '2014-04-28 16:00:58', 'Participating in volunteer activities to look after and orient the children at the center. '),
(23, 25, 'Introducing Little Rose Story Warm Shelter', 'Introducing Little Rose Story Warm Shelter  to those who interest', 3, 2, b'1', '2014-05-29 03:30:00', 'https://www.facebook.com/TheLittleRoseShelter.vn'),
(24, 25, 'Volunteering', 'Volunteering to raise fund for the Shelter ', 1, 2, b'1', '2014-05-29 03:30:22', 'Volunteering to raise fund for the Shelter '),
(26, 30, 'Share Hero For Zero on Facebook', 'I am playing Hero for Zero where I can try to save children''s lives.', 1, 2, b'1', '2014-07-21 03:53:26', 'I started playing Hero for Zero App brought to you by UNICEF  in Vietnam. Look for it on iOS and App Store.'),
(27, 31, 'Visit Childern', 'Visit the children in Way Hong ', 4, 2, b'1', '2014-09-06 11:06:02', '2014/09/19'),
(29, 24, 'Visit an orphanage', 'This Sunday, 02/11/2014', 1, 100, b'0', '2014-11-01 02:51:32', 'Join with us'),
(30, 5, 'test activity', 'Ha ha', 1, 100, b'0', '2014-11-01 03:32:44', 'sdfsf');

-- --------------------------------------------------------

--
-- Table structure for table `animation`
--

CREATE TABLE IF NOT EXISTS `animation` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `time` float NOT NULL,
  `HeroAnimWalking` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `HeroAnimStandby` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `MonsterAnim` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `KidFrame` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `ColorR` int(11) NOT NULL,
  `ColorG` int(11) NOT NULL,
  `ColorB` int(11) NOT NULL,
  `ScreenShotURL` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10 ;

--
-- Dumping data for table `animation`
--

INSERT INTO `animation` (`Id`, `time`, `HeroAnimWalking`, `HeroAnimStandby`, `MonsterAnim`, `KidFrame`, `ColorR`, `ColorG`, `ColorB`, `ScreenShotURL`) VALUES
(1, 60, 'walking', 'standby', 'death_walking', 'sick-boy-1.png', 242, 156, 51, 'http://heroforzero.be/assets/img/animation/1.png'),
(2, 60, 'cook_walking', 'cook_standby', 'death_walking', 'sick-boy-1.png', 41, 180, 115, 'http://heroforzero.be/assets/img/animation/2.png'),
(3, 60, 'teacher_walking', 'teacher_standby', 'prisoner_walking', 'schoolgirl-1.png', 17, 152, 195, 'http://heroforzero.be/assets/img/animation/3.png'),
(4, 60, 'boyC_walking', 'boyC_standby', 'death_walking', 'training-cape.png', 91, 189, 121, 'http://heroforzero.be/assets/uploads/6039e670c77c5f277a82f38727e6f91f.png'),
(5, 60, 'boyB_walking', 'boyB_standby', 'death_walking', 'training-shield.png', 32, 162, 132, 'http://heroforzero.be/assets/uploads/f98df41b4d85add2efc6b72d2413ed49.png'),
(6, 60, 'boyA_walking', 'boyA_standby', 'death_walking', 'training-sword.png', 25, 185, 154, 'http://heroforzero.be/assets/uploads/a5389e84c24d5433d0a29f2cd9c0d536.png'),
(7, 60, 'boyD_walking', 'boyD_standby', 'wolf_walking', 'protection-abusedgirl.png', 194, 132, 76, 'http://heroforzero.be/assets/uploads/e42dc539f483b65fbc6fa20457735759.png'),
(8, 60, 'boyD_walking', 'boyD_standby', 'wolf_walking', 'protection-crippledboy.png', 194, 132, 76, 'http://heroforzero.be/assets/uploads/874d8bddf08c65d6b1b6c30a8758b063.png'),
(9, 60, 'boyD_walking', 'boyD_standby', 'prisoner_walking', 'loto-girl-1.png', 194, 132, 76, 'http://heroforzero.be/assets/uploads/065c63b68f431ed3ed41cfc365cfce25.png');

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
('005660bb413c2f73acdfe944351843d0', '42.119.159.117', 'Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.93 Safari/537.36', 1422780469, ''),
('005a60845f21de12c8f5c04e9c7cd85c', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422816370, ''),
('00d4a63e97629c21a61104dcb3c84065', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422834386, ''),
('01673bf97cd1d7ec894a040e45a8a10c', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422728768, ''),
('018a8da84a9fe3ba1b0b3edb2f025654', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422784872, ''),
('019c186cc0acbcd091ee8be28e45495b', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422767769, ''),
('01f1aae742293a82ae0467eac11e62bb', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422857770, ''),
('02347f0178819af8803d4830318396a7', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422732370, ''),
('0264341281b2fb0da7db671c659f6939', '84.101.245.66', 'HEROforZERO 1.0.0 rv:1.0 (iPhone; iPhone OS 8.1.2; en_US)', 1422802435, ''),
('0281de60f9ea14f0ff896968325190ed', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422824300, ''),
('02b13dc3c0f2d902eb1e39ca273eaf65', '113.165.62.133', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.93 Safari/537.36', 1422797089, ''),
('02e93c0550a05e5c147dc9b2c59a6fca', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422791470, ''),
('032e2c113922bffa0fbb0faece31bd13', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422780186, ''),
('035502397dba5771ff0db178e3bd22ba', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422785470, ''),
('03920fbe32d0a114519072b507603793', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422780971, ''),
('04afc2c6acbbcded06006a5951dc2915', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422845769, ''),
('04d6d5b91d1cfa23bc3789303bca1968', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422743769, ''),
('058017d9b0343015137ae41ab1178bc2', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422848611, ''),
('058b3de0fbd1fabd946652e9ccdb3dcf', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422853570, ''),
('05906c61341c276644ddf1e730d7f8c0', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422874269, ''),
('0625e252a429277a83352cdefc50f9c3', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422855801, ''),
('0628f714e7fd3f380da5793c2526dada', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422758768, ''),
('062fe7983d996427f9cd6e56fab8f533', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422761330, ''),
('06f90d22ee7955e8e6ac959a8548554b', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422736869, ''),
('076aa7a6328bc1b967953429af100b31', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422860288, ''),
('07ae2da2da00a4504a7e3aabaa095545', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422861969, ''),
('07dc7a5103842a8b326370dc3eb3dc5b', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422800470, ''),
('08242ed9ee4c4cc9585421c87f7f86e4', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422825070, ''),
('083824eba7ccd0b580f89825b7ea0900', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422769268, ''),
('0878f23a175db19cd3ab1cc6ef14dd23', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422825970, ''),
('0886ff8568611c0410edfe0c38107442', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422753969, ''),
('08afa49a654ed8516aa06b0bb86cb43d', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422775870, ''),
('08ed2b94eeed2a05945cfb180b7f46a8', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422856271, ''),
('091e958d0fc7cb47a6158880e0c01d3e', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422858970, ''),
('09485d256bbfe0f7f8bab25d8cd2c2db', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422844569, ''),
('0a0069d478cf996eeee00a70e39a615c', '27.2.151.141', 'HEROforZERO 1.0.0 rv:1.0 (iPhone; iPhone OS 7.1.2; en_US)', 1422762185, ''),
('0a0b5aa4a7d1ea1d1f9307b7f7600455', '42.119.159.117', 'Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.93 Safari/537.36', 1422780434, ''),
('0a374c6253dbee9f685872ab944f9bb3', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422789971, ''),
('0a6fb1c7cce3f230dd37d787e0885912', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422818470, ''),
('0a9fcf8982249034f19d8c0e2874ffe2', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422766270, ''),
('0b15132002f2ccf13dec8f1553c4cb1a', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422839303, ''),
('0b9dcd39173903ddf0cd2f8e770faa0b', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422777532, ''),
('0bb2c3233adcaa913a754472d4d2341c', '66.249.92.13', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422894980, ''),
('0c165820069ba683f85cd9103554ed33', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422742268, ''),
('0c67edad8d9a00aad5732f380d59c456', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422782470, ''),
('0d2fcc13515b3852b6e45825e16ac3b9', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422870069, ''),
('0d671e25535259f878af80a3e7862222', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422763569, ''),
('0de501391d0536c249a8ce32ca9d0df8', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422733084, ''),
('0e1d117ec0a2890c11c1a8f6bd3e5228', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422731470, ''),
('0e7b2ffd44018ebdd428a382ad8c2d57', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422786220, ''),
('0e9fef1ae9b3e283f2ef6be1af726f55', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422833472, ''),
('0ec326a4b5b3050a22a4ce18f2755c1c', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422816671, ''),
('0ef660849e46f5e19ba2ffa9133e2ff8', '182.211.58.226', 'HEROforZERO 1.0.0 rv:1.0 (iPhone; iPhone OS 8.1.3; ko_KR)', 1422877837, ''),
('0ffa11e8b005ea5c75c20d74b4029588', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422730423, ''),
('102c4cf597b42c9fa0f41bb70857add1', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422779470, ''),
('107800333659bbb5edf178c97ccdf0dc', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422876886, ''),
('10cc7874341006c2e46dc77601b8a17c', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422883280, ''),
('10cf8768856083f40e1f501ae6d3b5ea', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422792070, ''),
('117596b23e3587642598d5e1a96a0693', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422872470, ''),
('11860703c639cc2fc656f0a3355cf753', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422861070, ''),
('121c808870955740a819d2b9ea8badb6', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422818169, ''),
('1245d9b22e25db6066e7943617fc5e5d', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422873808, ''),
('126a5a96614e8ad7b25ed1145d267196', '180.76.4.179', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)', 1422831328, ''),
('12927764b38b5cfe86e769ba3920163b', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422726369, ''),
('130b95ee1ecd9294f4155d4a46a14d0b', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422765510, ''),
('13a1a899bd7189ea6635abff058ff6ca', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422850868, ''),
('13dad22687e59812d128a3234c32dc8d', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422803001, ''),
('149cf2c5591b40047339618b0b955334', '1.52.63.235', 'HEROforZERO 1.0.0 rv:1.0 (iPhone Simulator; iPhone OS 8.1; en_US)', 1422784700, ''),
('1615df287b488b1ce7d16bf1a0891bee', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422859871, ''),
('16359d25b540eaa57c074234e32c8f6d', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422865570, ''),
('170926ec390280c8b3d2a3eac7d90177', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422832569, ''),
('171677ff6e8b7ee3206e8ee0cbc30113', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422790270, ''),
('18ce617d93c579eac206a9529eebfba3', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422727869, ''),
('19f567ec226bd0279945927ca28f7449', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422739568, ''),
('1aab0ae2c65ec0e8ee4074d28c1133b4', '66.249.92.2', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422892878, ''),
('1afa481d782cf92477b5f56b3a0e9c16', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422813069, ''),
('1b487fe68a4ce45bedcc8db84a23458f', '27.2.151.141', 'HEROforZERO 1.0.0 rv:1.0 (iPhone; iPhone OS 7.1.2; en_US)', 1422762210, ''),
('1c6b1e43bfaa25e61990c682206f7fa7', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422729070, ''),
('1c84cb1b69f27e3e8c6d30ca666495bb', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422800769, ''),
('1cd9db2177cf656d69d373f513cbdc66', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422856570, ''),
('1d9a8f6b0243799a03545b1c1fde97ee', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422778700, ''),
('1da237051ea792b867c8c07bd5ee8e75', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422770889, ''),
('1e8a092bc173cfc2d966d5b25c4991cb', '1.53.187.89', 'Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.93 Safari/537.36', 1422891518, ''),
('1eee8cd194cbfd66a6c45b3564641470', '27.2.151.141', 'HEROforZERO 1.0.0 rv:1.0 (iPhone; iPhone OS 7.1.2; en_US)', 1422762210, ''),
('20fcf7626135cf1fb57002e849f1ad43', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422831969, ''),
('212d5dedc975199bc9dad83c060e5452', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422783842, ''),
('21998abc3963a6a0661e4d16188f2153', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422817872, ''),
('21eaed7da4c9815193ea862cc48ce90e', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422860469, ''),
('21f103fc1d4802f20a56456dc459789a', '66.249.92.13', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422894677, ''),
('22742b9a078eb06932ac2dba79f424d4', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422877870, ''),
('229d3240e72465e333f02e8515bb875d', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422859569, ''),
('24e803c928fd369f42d8a261ae772393', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422867970, ''),
('256d1ff131ff7d3a4865dc40fa512887', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422770031, ''),
('25f69bc0f4cc56ac532cbaa5f0b9f29c', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422762508, ''),
('2657df6e2b2ab169a427abc3963399b9', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422772269, ''),
('274dc49a6ed2538061fa23abb0886fdc', '1.52.63.235', 'HEROforZERO 1.0.0 rv:1.0 (iPhone Simulator; iPhone OS 8.1; en_US)', 1422784765, ''),
('28121576418df6edf176b0fb703c83b6', '66.249.73.235', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 1422782687, ''),
('28916561443094c74a51cb5b76ff0ea3', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422736685, ''),
('28d6c2428f20328bf38d5b042c28d841', '66.249.92.7', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422896812, ''),
('29ef29da9d91e75e4bb18c76360f1f28', '1.52.63.235', 'HEROforZERO 1.0.0 rv:1.0 (iPhone Simulator; iPhone OS 8.1; en_US)', 1422785550, ''),
('2a8fffc4fceee7bcca85829f980f0fc9', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422749469, ''),
('2afd05c518b24d7d8d8a53406d6dfeeb', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422741517, ''),
('2b622e1f628659fa8f9f7399fcfb8c37', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422814870, ''),
('2bb7053634cc99794ea67ca7d95f370f', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422829870, ''),
('2be9d7cc1ab5c86b2bd55fb685b40759', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422804669, ''),
('2c691a7204390016d8eec44409af81bd', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422873070, ''),
('2c786e9be3600d33192ec297133f2eff', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422799271, ''),
('2cbc9e4439dcfa64326bae8e0cb70df1', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422881181, ''),
('2cf0a7bd156682b46ec55d4b85a21210', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422843070, ''),
('2df181f99328339180210af4bf30192a', '66.249.92.7', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422896191, ''),
('2edb42dabf7f5d8debba5522e0d779c4', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422783369, ''),
('2f22574242ee4aa54482dc21fec8ec0e', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422852369, ''),
('30752ef272fb172aa8ea6c84a805fc0d', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422843369, ''),
('314890e6d0f5ae793e6477d5c74f013e', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422849669, ''),
('31dc46ab1f5ad16f86ccb111704e1586', '82.145.208.224', 'Opera/9.80 (iPhone; Opera Mini/7.0.5/35.6998; U; vi) Presto/2.8.119 Version/11.10', 1422888222, ''),
('3269740422125736b823c1d644d84ced', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422795970, ''),
('3283f68b313960c444d3d9839f504761', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422797170, ''),
('335d3105ca5648e08de33a2c979d575e', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422870969, ''),
('3377b938fc38f708bc617632d176ff69', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422831371, ''),
('34410c1e4f83f3cdf03a196931cc22f3', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422737894, ''),
('344e775d094e6fd6914fd4891b50e605', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422809470, ''),
('34edccec403bc0c8e70e0183f0ce7350', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422794770, ''),
('351ad56e9841de2567e932827483310d', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422874870, ''),
('3565b690d20d76c4175a69a09506b41f', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422863470, ''),
('356ddc1a3ca63d1971210a6c59492038', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422776307, ''),
('359f1732d9683e68efa95e0e9b656951', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422750538, ''),
('35de720f6e265cd56ae86e0d58d18ab7', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422742124, ''),
('36b624060b63aec0c967f4e0fe8ccf49', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422780671, ''),
('36f3292419ae8440c7a9b4e3cf411bdf', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422812170, ''),
('371020e072d1a793d572bd5b5bad7183', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422727269, ''),
('383b392d9aaba5979f4d97cc479b7eb3', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422805869, ''),
('388d6971b16ca229d24a6644d9adfea4', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422829569, ''),
('38c4291dd8d25d4e42a6a82e9eaf1ce8', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422793269, ''),
('38c6d846d7a79796c37777da9da6fbca', '195.241.175.137', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/600.3.18 (KHTML, like Gecko) Version/7.1.3 Safari/537.85.12', 1422888415, ''),
('3908c5e4e5abcf913c9c48ee0cfc579c', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422761928, ''),
('3a49c09d93d0878318ce689554ea24dc', '72.14.199.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422889282, ''),
('3a60b85c19965889268e4c959703b994', '66.249.92.13', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422888374, ''),
('3b54c938ddb586c5c0b1b837c024dfe6', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422880296, ''),
('3b5526d3040da5d5ed119060fa5c76a7', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422882981, ''),
('3b7a81e67534f8dbf713788c8d3c9868', '66.249.92.7', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422887077, ''),
('3c19b44ce5ddfa393245ae0259b6d876', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422792369, ''),
('3c363ce55cf00d62b1d3310025da5f67', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422840369, ''),
('3ceb6087b878ccb2d84dcaa99a9bfb77', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422732668, ''),
('3d233d0ec0bffdc422297c6f9463dfea', '27.2.151.141', 'HEROforZERO 1.0.0 rv:1.0 (iPhone; iPhone OS 7.1.2; en_US)', 1422762530, ''),
('3d2fe5ab1728561c8d2ee7c733b95d5a', '84.101.245.66', 'HEROforZERO 1.0.0 rv:1.0 (iPhone; iPhone OS 8.1.2; en_US)', 1422802431, ''),
('3d725aa45ddc69e2019638eaea8ec6b7', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422839469, ''),
('3d9ac1f729a8b5c3e33ef833e0e6b8fc', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422756970, ''),
('3dc466e248aa1d1d6e1e328342473458', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422731011, ''),
('3e3b4c24a55f0746e07ed1d035d8c4ed', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422873970, ''),
('3e721059b8ea1dda288d6f6b44cf1961', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422846070, ''),
('3ef506bbe0a351b5351e38cac003d832', '73.19.40.174', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/600.3.18 (KHTML, like Gecko) Version/8.0.3 Safari/600.3.18', 1422851766, ''),
('3f4628ba14a56b98b181c63b2c16b355', '1.52.63.235', 'HEROforZERO 1.0.0 rv:1.0 (iPhone Simulator; iPhone OS 8.1; en_US)', 1422785842, ''),
('3fcd1e560bc0c3e606a921955a37d91e', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422798671, ''),
('40080857b0e6ddb1ff8bca6e601fd017', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422774969, ''),
('41779af6ded208c6a9858901a39ec5d9', '115.77.49.147', 'Mozilla/5.0 (iPad; CPU OS 8_1_2 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12B440 Safari/', 1422760092, ''),
('421d0da94aa1c545c5b33ee2af1efed6', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422835871, ''),
('42ad92ec8a1ee7ff058f5450883304a3', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422797470, ''),
('430084385ed6e32ee45da2804f2055b1', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422825803, ''),
('436ecd2c1c36fd60b6143fc4735efb72', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422784418, ''),
('44fb702f855cdc0d9be641a2c65e3880', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422807370, ''),
('450064f0ea3f357685ce0043aaed779f', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422753369, ''),
('454d4984e0dac29878d19ea04a5f4b42', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422731769, ''),
('459ca1440dab4887ad933a0a3cafd516', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422826270, ''),
('45af00ce3a0f490d7b4c3b6128f774a4', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422725169, ''),
('46f64cb39ac662bc2f5bd0c01a91b26f', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422827170, ''),
('47373c462687bc440ccf88c475027079', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422805139, ''),
('47643a9d2d3eba8cce5e67a778dba986', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422810227, ''),
('4772f477a7f5269d458dfc577b187c2a', '66.249.92.7', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422895877, ''),
('48427bc0bd96d94629cf512085effc0a', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422751400, ''),
('4862ffeac3dc76ce02634b7afd3f3d4d', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422781570, ''),
('48c2a13bb00e466a1a67f65058fea36f', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422804370, ''),
('48fd8175f5b99056af956c337017d1d7', '27.2.151.141', 'Mozilla/5.0 (iPhone; CPU iPhone OS 7_1_2 like Mac OS X) AppleWebKit/537.51.2 (KHTML, like Gecko) Version/7.0 Mobile/11D2', 1422758940, ''),
('493133b54a43614c20cfd6b55dcb7b1d', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422740900, ''),
('49d6df3e4e2810f2f30d765f7439e0f3', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422835270, ''),
('4a23594cbcc910f2f0322864672a7263', '72.14.199.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422889577, ''),
('4a28fd279f3a0a5db7cf22fa85965d1b', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422807070, ''),
('4adc5eb074f75676a17acfbbdaa42fef', '27.2.151.141', 'HEROforZERO 1.0.0 rv:1.0 (iPhone; iPhone OS 7.1.2; en_US)', 1422767057, ''),
('4b77846beacef6f31cc53b9f5d752325', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422771370, ''),
('4cdac123df418ccc476014fefae4c7c0', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422880879, ''),
('4d0a8e45e257704ed2bfb1f1c1782314', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422794170, ''),
('4d89d16a9220974433545633c463e2d3', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422833170, ''),
('4db786f4285469fc46b2306690371816', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422817733, ''),
('4e50f592bd59c2b193b2f23e7b960bf4', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422852670, ''),
('4f4364fd7d02c61cdd46b4a36860c567', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422734169, ''),
('4f6ee21b89530f7f45aa2eb4af40a187', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422789072, ''),
('4f9043cc2ecad6a3b5b60064dbbb17bf', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422857309, ''),
('515166b1db4e2a69dbd1fba23f3e4715', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422776469, ''),
('516b8fbf175c6b5f2d0e17b5c4eeee0c', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422772868, ''),
('51acee457f59c91342efc43eb981b523', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422806770, ''),
('5216ac292ca1eda8ba03e8183773bad8', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422805269, ''),
('538b0fa5b57b05a4f4b04406285aa434', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422826694, ''),
('53da9d10a78a53fb81ea87ad81eb1260', '180.76.4.47', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)', 1422896207, ''),
('53fb063857585c3e9e7fced7bd78132c', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422800170, ''),
('5422cc60f2f2b4be4a21e0ec8139e5ce', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422858069, ''),
('54d3bca754565be580e46abc9267c36e', '66.249.92.13', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422891678, ''),
('558575d8452d6e03749857c7efc0920c', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422850847, ''),
('55e32fa4469b705310c513ddd6d3173c', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422829109, ''),
('5608d7c5648f5e64c21b421cfcb888a8', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422753070, ''),
('56178a0d0b519d2ab37fc80d0b0fdd50', '195.241.175.137', 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_1_2 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12B44', 1422839188, ''),
('579b62bb2a84d2bb9f48cb5fbd45dfff', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422786369, ''),
('57efd83a8ae489f38dade137c055931e', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422852069, ''),
('57f5352a39eaa4a8d3df3659b6b112f6', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422874698, ''),
('583ba20709297ee84ef3f14727bcb686', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422752313, ''),
('589c85d8a893c558d2706eeb65637417', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422748722, ''),
('5987f3830b237c6a224bc98472916d7f', '66.249.92.7', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422890779, ''),
('5a335cd6f25505fe2c82112f0190b6e6', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422773769, ''),
('5a60aa83cd60b52cf6330ed01448d167', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422798970, ''),
('5a7611fb27120087904485e4e86ce9aa', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422733568, ''),
('5a8a800cce7fce4dba430ff3db2a195c', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422828671, ''),
('5b32d108230e68429acc78487bdf5a2a', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422886753, ''),
('5b95754f1311a5e2e32698fdaae7c4b3', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422864370, ''),
('5c73b828cc31c533de835cbd1d83196d', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422861826, ''),
('5c81babaea551778a218780053fd57fc', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422727138, ''),
('5df6fd020eccffbcaa22f18f1df3c0b8', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422872770, ''),
('5e0e4766f46aae5e1a4ae080ff454a3b', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422837969, ''),
('5e5a0ff704813fec19f8dd23eaa5b01d', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422740470, ''),
('5eb019bb192ef3c6bbe1f26d0e9ee56b', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422771068, ''),
('5f021931d3bb8a77ef120aeb359b39ed', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422742695, ''),
('5f587d9a05e94d020f2efb2b85fe0518', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422755026, ''),
('5f9136c7ae9a73c3483b1190763e2017', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422747369, ''),
('5fa0fb2b1e6ebc1ee4fb7aa30b2021d2', '66.249.92.13', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422887182, ''),
('5fdcdab58b96b630118d9ff0b8505338', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422756069, ''),
('60357bf2c3e3aa3fa30e2f8d545cc561', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422724869, ''),
('60a6486da3f628b2878de0e6e0c338ad', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422821770, ''),
('60d85e11da6533e75090bc3e55ed5e60', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422864070, ''),
('61188e817fd9a672799b7a0118bc4850', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422850269, ''),
('61216f7402b6226f7937e1e36fd6fc8d', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422735200, ''),
('618d75e928ede147a6cc43005f2b8e30', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422837070, ''),
('61f6142bf37f3d1456ed4de1c7c497c3', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422837369, ''),
('620239b6e0f3b45c66b94ce529d2c51e', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422830170, ''),
('623bf9e35f04543e80eadf676102c114', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422787427, ''),
('62b0411d138248e4d7713af11a310112', '66.249.92.7', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422893478, ''),
('62ce4df030bbc31cc6b9ee61c23a31a7', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422815171, ''),
('62f5f49fe65332fbb5ec6a2fdf2f8d9e', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422879073, ''),
('631bb005837ed7a82a1a11659decdac7', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422862427, ''),
('631fef1e75770f194d2d962e610492f4', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422884179, ''),
('6321bf34a98fa97efa71a97d7bc2cd14', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422754440, ''),
('632d12a23f9c60697e746cd052d4071d', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422875472, ''),
('6332a44f8f00a9a1f2a38ceacb06dbe3', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422757698, ''),
('6404bcb559c216899a2a28e8df33701b', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422745269, ''),
('6432315b71debaca2bc82088afa056cf', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422724568, ''),
('646319eb7c876e17f1c818949bbdb6f4', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422851469, ''),
('65219ce43356018fa041f61c079f0e07', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422871269, ''),
('65415498282bbe42ed6d728945b4d3b2', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422858370, ''),
('655a510c782600a4430a5a369a005f9f', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422759368, ''),
('65605b9779a05e47568c7b9d8d010e0f', '27.69.122.103', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) coc_coc_browser/45.0 Chrome/39.0.2171.107 Safari/537', 1422880597, ''),
('658bd48066ac0adfef5dbdae15203372', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422798070, ''),
('65c35caa58f216673b7dd787675f5981', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422877294, ''),
('662600531b3369b582640b6fa270a847', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422785319, ''),
('66331cd0fc455219d9cddd39a554b637', '1.52.63.235', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:28.0) Gecko/20100101 Firefox/28.0', 1422796944, ''),
('671bf07f7ca20a85af2576b664aace9e', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422762670, ''),
('67e818359475c6211040e39fd1f6c1c1', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422725471, ''),
('682b3146ff2dfc63e38fc3c75ac3a411', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422734016, ''),
('68739a4214f087b9afbdc970e48f2ad4', '180.76.4.160', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)', 1422781065, ''),
('68a6e91ebf9c6a709283a91462a627c5', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422762969, ''),
('68a917d67ebbf03b8747ac41aa157b69', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422854470, ''),
('68de9b87a1f3306fc02e8258ea13dd51', '1.52.63.235', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:28.0) Gecko/20100101 Firefox/28.0', 1422844218, ''),
('68f383a1f59e3de77fe1c52beb5c7feb', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422810970, ''),
('691e1fd3fbf57eca94d7aa4e11488d77', '66.249.67.91', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 1422814689, ''),
('6966cb7a14d4261ce1918d3c5668f855', '42.119.159.117', 'Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.93 Safari/537.36', 1422778677, ''),
('6977da93d8ac6290c6bdcf0b229105bf', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422755470, ''),
('6b85d05f64e0369c022f055452df64d7', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422772104, ''),
('6bd3b2a4c7cdd54ab8228dbef2b81507', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422792971, ''),
('6d24f53de258232c598180923ff69730', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422782770, ''),
('6d4fdae5b45c452fd1598ebf2e63227c', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422754682, ''),
('6dad7c7774c4b3e3467d7e742e9952cf', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422881784, ''),
('6f25a13d98f4a136489f9debc2c3e609', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422765968, ''),
('6f59ea3830e9481171cb9023dc533bce', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422851172, ''),
('6ff5cd62c5d55d57e12b67779b995958', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422729968, ''),
('7023efe8bb97cffb96c26d75a563bb5e', '66.249.92.7', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422888680, ''),
('705cf8bfa3f12d7fbd1754002da2d60c', '66.249.92.2', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422895274, ''),
('7092b0cde0fe5db6d54412248a78a235', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422788169, ''),
('70a9e82cbf6f27b149a6cf8618cb6992', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422871870, ''),
('717a48fc7cf12050f00cac05392030d3', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422820870, ''),
('71c48a3a7928c720fbab73eadd525132', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422764768, ''),
('71d70bd9628c0797de1799b55ccc2392', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422759970, ''),
('71e75245c774bec6905e1d86db78b00a', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422760871, ''),
('724329e948a9c35829d5151c4b8b5353', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422755768, ''),
('7284cac7ab276281b32006b8e41486a9', '42.119.159.117', 'Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.93 Safari/537.36', 1422780453, ''),
('729b1921bff3ba9c254bb317605e2dfb', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422836300, ''),
('72ca48ba3d00b18f4cdb71c3ae9a9b5d', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422845470, ''),
('735944972d588b36994a9ea3720bb857', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422878469, ''),
('73624ff6c50352c3238403d23887c843', '66.249.92.7', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422891079, ''),
('73a607f8789ab8fa67ff0c457d386f71', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422741215, ''),
('7477aa93a776ed6c420018e551a1def7', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422865870, ''),
('751629ca40243469a864cecfcd0659d1', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422863770, ''),
('75521def3d1b92c64105869206bfbde3', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422851900, ''),
('75a98ad137591b9dd910feba7009aa20', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422839434, ''),
('7605c6f00b46bf4493bb7ec39bea720f', '27.2.151.141', 'HEROforZERO 1.0.0 rv:1.0 (iPhone; iPhone OS 7.1.2; en_US)', 1422762184, ''),
('76e57a797b20479cfb7610ff1c0c8145', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422778870, ''),
('7755639a2ec2a559abbc0d2b7209ccb5', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422855069, ''),
('77ad6d1410c219ef662d07e13c32ef36', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422749168, ''),
('787ce56cf045627d9ae44b4f4fd46a0a', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422830470, ''),
('78853012a2c66536de6bedcba1a23dee', '66.249.92.2', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422893186, ''),
('7895e1897221f6539526d76fe07b08fc', '1.52.63.235', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.101 Safari/537.36', 1422842715, ''),
('78a746853ec4e9f62e4ce0a66f2a28ae', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422876069, ''),
('7977908e4cf1594d3194d95f28df0e60', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422849969, ''),
('7ab6d2eabb6f39e1ab414aefe30fd6e2', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422729670, ''),
('7adf83d4bdd4c3fac559e4c3f84b4ff8', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422819370, ''),
('7b14ddf5a3c9961293c6b568bd39fec3', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422750969, ''),
('7b1520d714d72ea313790d1bc89784e0', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422810670, ''),
('7bd1bac94ccfe1fadced04d894098279', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422738792, ''),
('7c0a851daa038c3416ca7e8f183b4d66', '42.119.159.117', 'Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.93 Safari/537.36', 1422780454, ''),
('7c24eaaff7e3a7655be1839ba4e12ccd', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422870372, ''),
('7c8614a86ae4d34b66f6868cc0096ccb', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422762068, ''),
('7d63f7f113b8213a63fa3e2a0b07cbe6', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422748436, ''),
('7d6d1fc5a76a68b5850d4ce6a60a0a33', '113.185.6.130', 'Mozilla/5.0 (iPad; CPU OS 8_1_2 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12B440 Safari/', 1422766881, ''),
('7d7771561f3b9afcb918a4ed31b14b76', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422828370, ''),
('7de669d326fe5c2f167d69567c42f57e', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422787570, ''),
('7e32fb9d680a869142c8ebd5e9f45d6f', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422796570, ''),
('7e59ef0e87328ee68f1bb88d7be345f9', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422879974, ''),
('7e5de9bde866d6114e5c4cff11a43a4a', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422823269, ''),
('7e812736120a62b5672370b284482c87', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422859269, ''),
('7fc96a823077aedd6416e907fa73064b', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422830769, ''),
('7fd5880fa1b927550ffecd1e87920c82', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422733416, ''),
('80b740934485c90619175c61439d6134', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422861923, ''),
('80e92906948557cc0f65a453aa2da553', '27.69.122.103', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) coc_coc_browser/45.0 Chrome/39.0.2171.107 Safari/537', 1422880314, ''),
('81ae6f81db99261e764072cbcb3dc706', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422829270, ''),
('8245e8bcd046862da0f29ef7ce25e7bc', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422810369, ''),
('827811686801bd1f6fa63f96d6abc198', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422768970, ''),
('830ee1cb4e5fcad75cff35f67b00b72c', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422801370, ''),
('830f3ad6c4de58d39b3e17531edb3809', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422809771, ''),
('83aa6d182a795a35255dece4a46d5efd', '84.101.245.66', 'HEROforZERO 1.0.0 rv:1.0 (iPhone; iPhone OS 8.1.2; en_US)', 1422802432, ''),
('841e96c6d3c1255b27d2da9ad1f04521', '115.77.49.147', 'HEROforZERO 1.0.0 rv:1.0 (iPad; iPhone OS 8.1.2; vi_VN)', 1422760319, ''),
('841fc49f68e3d3f56a0be5460e7141d3', '27.33.123.110', 'HEROforZERO 1.0.0 rv:1.0 (iPhone; iPhone OS 8.1.1; en_AU)', 1422751975, ''),
('847d46f18b9810aff7e7754425fc25a6', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422795369, ''),
('866bf88f2c19f6685afd449b51bb7ac5', '66.249.92.7', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422893783, ''),
('869d8f1b01eb7daa3e9a1436be6a449d', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422737468, ''),
('86ac824c022bd82e7e0903819a02463d', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422827620, ''),
('8709d0f22f930ece570e4ec3f77ade02', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422769569, ''),
('8726ae537ee749a11c21543648f43c61', '1.52.63.235', 'HEROforZERO 1.0.0 rv:1.0 (iPhone Simulator; iPhone OS 8.1; en_US)', 1422785551, ''),
('873e5b707328b506376d9f127c6b4767', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422803470, ''),
('8765f8615f07c75cce040c75e511d273', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422847270, ''),
('87a8736ac5dc76d85e1a72f746f472a7', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422879843, ''),
('87f2fa874204243195b41b558ec6e962', '180.76.4.9', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)', 1422852840, ''),
('883e7f896f17439769ba960160dccf7e', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422844270, ''),
('889b321df938a548ef57f7c916943f1c', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422731168, ''),
('88e2c52d5713c0ba05b728e789bee7a6', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422766869, ''),
('89a6859e48d85f464e2cf958cd777166', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422757869, ''),
('8a11bbfee661ba021798a9a472157d5f', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422746902, ''),
('8a46763fd20f7377f52797d0fd67d6f2', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422878325, ''),
('8a46fa0dc91bce163c653ff3e7149aca', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422768069, ''),
('8a594f9cd41461dd2f96f65c63a2cc61', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422768371, ''),
('8ad8e827cd8b1fbbbf0390ffcea3d9b1', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422884481, ''),
('8b5eec1e66eee97ee1983a5bc77e9e7e', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422771669, ''),
('8dcd352c14f0e9af540cdc3007436468', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422755169, ''),
('8e0b85d78c2a20fd38cab947112964f9', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422737321, ''),
('8e3a7ad48444b3f39eb228ce2956a5e1', '27.2.151.141', 'HEROforZERO 1.0.0 rv:1.0 (iPhone; iPhone OS 7.1.2; en_US)', 1422762184, ''),
('8edac287ddebedbf8f3629da80d588b6', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422791170, ''),
('8f4292c69e58a3c0757519c67af4eacb', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422873369, ''),
('8fd1b0e6104b9f9299df8589de9aad4d', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422735968, ''),
('9055f8ff35a92590786260d666fa1742', '117.0.29.143', 'HEROforZERO 1.0.0 rv:1.0 (iPad; iPhone OS 7.1.2; en_US)', 1422777375, ''),
('905b82fb7d5ee9eaab60f6bf45071599', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422793569, ''),
('90dafd4ac8dfa0aabf96bb7ba079f5ce', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422839022, ''),
('9138eb1807e6e08e0f65018aa53596e5', '180.76.4.100', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)', 1422766743, ''),
('915546f355aeab434e354a2a928c56eb', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422745695, ''),
('9195b595852f8e7d15845ce9613b64fb', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422732069, ''),
('91b47817fb868c83d98feebc8da55c37', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422819671, ''),
('9247bc26054e527726ffd3a80f8eeeb7', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422869771, ''),
('92b57fb4607bea723d0580f724abebcc', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422740168, ''),
('930666765ebec9c376f415c82b447aa0', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422833769, ''),
('936be4fa5485e8b844e373059b8f99bb', '66.249.92.2', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422892279, ''),
('9456248d31d7e2fdc75f61cc63c11113', '116.100.128.107', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.91 Safari/537.36 OPR/27.0.1689.54', 1422768343, ''),
('951023f53fee36b3460b3725707d3cc0', '66.249.92.7', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422897080, ''),
('95310d6517ddbecfe821b5ba63da070b', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422783714, ''),
('9596f1905fbc33a5ca021da808a9ab26', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422877741, ''),
('9603fd486b8df8b4e49071263e7d762a', '27.2.151.141', 'HEROforZERO 1.0.0 rv:1.0 (iPhone; iPhone OS 7.1.2; en_US)', 1422762218, ''),
('96bff32a5b6320980ccef31832af891a', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422862872, ''),
('96e2cb854e1c1536d451a5272fbcce5d', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422777068, ''),
('96f18f6a48ef55a702e68eab2d070eb7', '66.249.92.2', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422892748, ''),
('9768de200698240d903a4bba0e07a413', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422840070, ''),
('97a7732772b33ecce0b3b4f5a79cd81c', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422783214, ''),
('97b415110cc376483457261394d8834a', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422774670, ''),
('97dfef0f646a146de0815b411ff78041', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422808132, ''),
('9809caac6fe69c52bf711325c0e54886', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422747783, ''),
('982fae450bbf4d71796924c0f03b52a8', '195.241.175.137', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/600.3.18 (KHTML, like Gecko) Version/7.1.3 Safari/537.85.12', 1422887999, ''),
('984ded7fa533be764f70a0174a69bbc4', '66.249.92.2', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422891974, ''),
('98843276abc270b2741c0202138fa790', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422879673, ''),
('989f9389b11fa08f7f3360079521236b', '116.100.23.77', 'HEROforZERO 1.0.0 rv:1.0 (iPad; iPhone OS 8.1.2; vi_VN)', 1422854152, ''),
('9971a12c6ce6023468fdb7b4eedb8de7', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422761468, ''),
('99d7cebe6469463077325f9b9e86611e', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422728169, ''),
('9a489446ca9d700b5ae5e4752e4f35c8', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422852970, ''),
('9a85549a9389ca7431e5747293b19592', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422844871, ''),
('9aba9f6c515e16eff67b0effc6d4b042', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422765670, ''),
('9adc992695d8830b896edbeb48f9e05c', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422839769, ''),
('9b18de621593dfbc09691f69d5a5f168', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422812470, ''),
('9b7d9ef979df9cf3d2cfed849d814d6b', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422819070, ''),
('9b9939dd4b1b78a59ce4a9b5baaa5c08', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422801214, ''),
('9be70d569cc174a15fe0583ffe97524e', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422819972, ''),
('9c3b5e17643592d71efcc6bc4d82c112', '71.46.80.132', 'HEROforZERO 1.0.0 rv:1.0 (iPhone; iPhone OS 6.0.1; en_US)', 1422855299, ''),
('9c7e6fcd666b217ada7de05f8a196465', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422867194, ''),
('9c8c212a169c5731d280b222894fd5b5', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422858814, ''),
('9d10e819e402edede40a148ac3afa5ee', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422876716, ''),
('9d323916a0b377a2cb28b3634f79202c', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422786307, ''),
('9e411d99de89a4e4881a9ce1130e2f1b', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422823570, ''),
('9e5f3955a1dc94c4f047864752a0cfbe', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422751869, ''),
('9e9df597a388917a56e6d1a94bf8c76c', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422831670, ''),
('9ed256525d79fd6ca3bea8a990acf2cc', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422885660, ''),
('9f39c8055a882fb6e51478b318612b78', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422739870, ''),
('9f9054b83c8085e65ac3dc3f57488484', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422726669, ''),
('a056faf049fc037fb28ba2f873dd0d76', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422876953, ''),
('a0957cc97b6a5468c71d57a74367dc1e', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422744368, ''),
('a0dba82b6004a7179fcfbd05b89f07ed', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422795240, ''),
('a15984c7b8273f10f79184c1c207c95f', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422793870, ''),
('a1893e361dea737a09b2f8d0afbb9b56', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422752470, ''),
('a18de4626c359de4cbdc602ef20aead3', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422796869, ''),
('a218fcd75739921a41195a8a1007ac43', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422758170, ''),
('a2a5dcaa190152799c50e91928190017', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422791769, ''),
('a2c5e30db1a872a8aa1d0e3439d32585', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422855369, ''),
('a32cc95acae3c0924cc04093a25102a5', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422813971, ''),
('a41f922624fbe418f9c302fefbeac19c', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422842769, ''),
('a4256f4444d5fae8386fa8614429d755', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422808216, '');
INSERT INTO `app_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('a508069503ce8a5b779b84baa1aa2a32', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422846970, ''),
('a5595be2b51a7ace695bd32dfd9bb598', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422774368, ''),
('a5973810ad91b8ceae259f69c3becdf7', '203.205.28.43', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.94 Safari/537.36', 1422802040, ''),
('a5ab3f565fbc2792eda8965f9b799160', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422813371, ''),
('a6a1f17322de9a47c9c7ac67d0c0efeb', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422882680, ''),
('a7180349359dd5b89e10a68935000415', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422786970, ''),
('a7209e5baf7b6e76cb3367c9f2fddb53', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422759790, ''),
('a72a035689ba8ffcae16f96e3e96974a', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422848170, ''),
('a74a2c10f8e28277c712d0224e04f50a', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422789369, ''),
('a74d6bae630d59c86ff120052a9882cf', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422782462, ''),
('a79f5895c990d9617896dd1136c2d76e', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422834970, ''),
('a7fa06baa5a7d16514fbc0dadd360f97', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422739271, ''),
('a888fe3e6d7b161a37b63fb546c069a5', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422836469, ''),
('a8997a7365846576608fb1154ea6421c', '66.249.92.2', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422888978, ''),
('a8cdedf0945e57c59bb0466c65592b4b', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422801970, ''),
('a8eeed9501766c6dd5336be4192a5279', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422849070, ''),
('a97319781e0925ea9855f2e34bdbb81b', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422838270, ''),
('a977c63c8c7a61ad2ff58d04f9c3cc03', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422790870, ''),
('a9a55ef0c50056b87b1590f1819e01c8', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422811870, ''),
('a9d2ab57481f5771b89cce872f10ef5c', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422824771, ''),
('aa3b90b41ff66a4a95e650e62d79d83a', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422772570, ''),
('aabeccd5915f39c08ddf9e600e370cef', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422774191, ''),
('ab0b691a9098a9619f9ebfca5e5e36a1', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422783332, ''),
('ab13bff5d13b715de7577a0182fac75f', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422822370, ''),
('abf0cb64095beba25e4f872dcba1ddbe', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422863169, ''),
('ad1d654758cc3ad42e32cf4a97d8e0d6', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422872170, ''),
('ad9f7187f1aaad703320ce6ca5964c2e', '66.249.92.7', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422891378, ''),
('ae220802464f8030905de2a4780a9dbd', '116.100.23.77', 'HEROforZERO 1.0.0 rv:1.0 (iPhone; iPhone OS 7.1; en_US)', 1422878141, ''),
('ae62fa92faa524393be83bd954d0984f', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422756522, ''),
('aeaddf1757911858bcdcbe84c371b25c', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422797899, ''),
('aeb52321845472621c6ba1acdbc363b1', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422767470, ''),
('aedcce569e0fb98cdfe0965e8a054ef9', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422770598, ''),
('afef7a3a70d3963b0a6317df961ad4bd', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422743287, ''),
('b09653dfc0348a7716796e2861fa96d3', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422728618, ''),
('b09afbad0a3c7fd7ad0607f40b2f5ca7', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422862570, ''),
('b1e828ed6817391a5ee7749d6f40f811', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422730569, ''),
('b2bf00a4fb7b319d03846e17fe5ca280', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422811400, ''),
('b2c70ca39291f07a107bcdd752331932', '84.101.245.66', 'HEROforZERO 1.0.0 rv:1.0 (iPhone; iPhone OS 8.1.2; en_DE)', 1422742794, ''),
('b323da82dc7357a92210110ed9866d7b', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422816069, ''),
('b3aed269510391454efe7c05853043af', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422887005, ''),
('b4588e45ac4b9c31280b100fb65bda9c', '66.249.92.2', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422894378, ''),
('b465f57fb56a550b826aa393c2ed57c3', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422726069, ''),
('b47a371a528f828060d2a688f4882c9c', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422850740, ''),
('b4b25a9654eeeeaa4b99cd14a83379b9', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422814269, ''),
('b4ca164038d4ce1e425fc6914c401f62', '1.53.187.89', 'Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.93 Safari/537.36', 1422891517, ''),
('b5b067c313ea0d08bbcefc2c95cd087d', '116.100.23.77', 'Mozilla/5.0 (iPhone; CPU iPhone OS 7_1 like Mac OS X) AppleWebKit/537.51.2 (KHTML, like Gecko) Version/7.0 Mobile/11D169', 1422883390, ''),
('b6598c0c98d7b7cf67755ba041fa526f', '1.52.63.235', 'HEROforZERO 1.0.0 rv:1.0 (iPhone Simulator; iPhone OS 8.1; en_US)', 1422784824, ''),
('b65bed59dc2b54856beb493bcd5723ed', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422748083, ''),
('b6906264fc1be5ca21eba7bacf1e296a', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422803313, ''),
('b7454d96d17699b32a491081d27e4995', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422853270, ''),
('b76d63227164e867803a7ab0277a216a', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422773469, ''),
('b7cd0fcc7b5727ed86442013e2dceb50', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422782463, ''),
('b8768a4af11da2faf5dbb2bf3335acd3', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422866607, ''),
('b91f41a48034f01dfadf2b95160ee462', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422747068, ''),
('b950ef42675b1daae49ae76f267be2ed', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422843670, ''),
('b95f2dcdee21fe6e74ee11505eaf9237', '180.76.4.183', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)', 1422824483, ''),
('b9c12f2764d02970f3219cdbfd44049b', '180.76.4.144', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)', 1422759582, ''),
('b9eca8caaec762554fb1a27a6c33adc2', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422857469, ''),
('ba3571e9fb0978461aa373436f6fbea0', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422867371, ''),
('baa7198e268a12d04e46e11115479a0d', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422734637, ''),
('bad24dfa669235195796d88decd87cd5', '192.99.107.100', 'Mozilla/5.0 (compatible; meanpathbot/1.0; +http://www.meanpath.com/meanpathbot.html)', 1422787121, ''),
('bcb320759047662eabd9cbbb703f12b0', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422751737, ''),
('be25479df0a35cc6329863b9cb6232b3', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422866169, ''),
('be6c0b83a6cac41a76863d61a16f1a6e', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422764470, ''),
('becc9b283f700dbd1706cbdb970bd56f', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422735369, ''),
('becf7b247c1e784d7744720be51c8f74', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422738969, ''),
('bed190744fb3505d3f28f4c83fc268c5', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422814691, ''),
('bf720da30738e59f0d23ccb889afb7b3', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422866770, ''),
('bf99d682285521ac45ee1f844e180b75', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422831069, ''),
('bfc811f0f1adb584fc56949c2f013c5a', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422878787, ''),
('bfe31088a7a29759f0abfd96472d1df3', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422748990, ''),
('c009ad140b1ebe9840357af8e816fb56', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422775722, ''),
('c0354de5c035f4db8c1a021bed38119b', '180.76.4.151', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)', 1422817156, ''),
('c0553290aa93278c98eefe40c7544278', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422807670, ''),
('c089d36c4af6b21237a511025c6a4c34', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422743638, ''),
('c22034284fd6b7cd2e5c04ec0ee72d2c', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422777969, ''),
('c27e2f0e83cbed34db218c65b70a4840', '1.52.63.235', 'HEROforZERO 1.0.0 rv:1.0 (iPhone Simulator; iPhone OS 8.1; en_US)', 1422785550, ''),
('c29589c03fa03b28c19e1238b8c3f967', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422856870, ''),
('c2993078831e74c8bca66dd2da0d7628', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422799869, ''),
('c2da4be54c2a34dbfdd6cfd3b728e078', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422775269, ''),
('c2e23f0a68b34a371624fd01a9e16156', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422864669, ''),
('c2e6d2d42d2ec704c35abc36f7e211ed', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422803770, ''),
('c33789b0f454d555d934bb109fa73c8f', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422813669, ''),
('c34eac51a0ff5ac6cfee0756a11be788', '115.77.49.147', 'HEROforZERO 1.0.0 rv:1.0 (iPad; iPhone OS 8.1.2; vi_VN)', 1422761083, ''),
('c3ef085958eab7a4c47c0d6af367c6f8', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422861920, ''),
('c43026996cfc11a8d886ea8cedd16279', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422883580, ''),
('c455d7bf72a68fcb25358c67d00ef72a', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422815769, ''),
('c48b3deb23e231d8f1e45f331b033f80', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422777814, ''),
('c49f98abab5daec8c280cc228fccc8e8', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422744237, ''),
('c559d254066b437198f908bcc4df8fad', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422753669, ''),
('c57464412af31ab1fae36291da92ca3e', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422783969, ''),
('c631108ab4a79ab5fa54a48ffb505173', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422880582, ''),
('c6b03ce366bf8e4955ea3025fce1be28', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422781423, ''),
('c7201e3eba9dc3cbf1c0d0692cf2df6c', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422749770, ''),
('c770abe2064fb0e4f39a01bb2c07b0c7', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422806170, ''),
('c78ce69a3ad55c3d04961c56f3881729', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422768668, ''),
('c7a71d92837fb7026643f4be6859a681', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422854769, ''),
('c7e98c2e895df079800836b0773e321e', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422808269, ''),
('c7efe3f47d3781266467cd8fc76c1a32', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422822671, ''),
('c8c2f69572972ef31c9e8bc057dde4dd', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422802270, ''),
('c8e75ec9ade4747eb9113987c8906f5c', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422879380, ''),
('c912e3ad015864a4d1d15bfd6d18360d', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422746169, ''),
('c972e0fe6f434012c8f4118fe80ebfcc', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422845169, ''),
('c98026f94a1f55e6852d37b67300306a', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422842311, ''),
('ca1ab9a05354fb17cb0400a30e63027a', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422865435, ''),
('ca56f4f2d681b86deb1703760862a699', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422745868, ''),
('ca5c2a7ecc0640636f82f6d88fd19a62', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422750069, ''),
('cb0e325878191f1de42ea0bd063987b3', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422735670, ''),
('cb0e60b09904ec296cf2e247cc8a8700', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422886648, ''),
('ccb732a5f1df141d72293e6f8cea2e14', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422868570, ''),
('cd00824477f5746a51f0b316fbd5a5a0', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422743028, ''),
('cd8c76771a6005fb5576379943d889c4', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422818770, ''),
('cdbd2d2757d3af253fe1434f7288910c', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422806470, ''),
('cddc4a7b88c009ecbda7dc507b3d6192', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422727698, ''),
('cde9258fc039c4fbd5fdf36d9ca5f173', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422840969, ''),
('ce09ac0199088ab6e197f27c1f8e4af5', '66.249.92.2', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422895575, ''),
('ce11e171f0c3cd6e084567ec0ab51b2f', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422795313, ''),
('ce93da8dad34377e3dc28b3e568e8746', '195.241.175.137', 'Mozilla/5.0 (iPad; CPU OS 8_1_3 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12B466 Safari/', 1422888035, ''),
('cee83542d61bdf8a1c4817a99e33160a', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422815469, ''),
('cf9b4f0e6327dd603fa0583504bfe1d6', '84.101.245.66', 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_1_2 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12B44', 1422804782, ''),
('cfe95d555e1175266cf58dda81f8474f', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422787869, ''),
('d086420344634c34b80a8bb68b93ae32', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422825370, ''),
('d08719a02f5c98001f3a9949fbb5d009', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422875769, ''),
('d09307a2ecf2813ab0b944d99c484739', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422725769, ''),
('d102d7b4b8cf949924131eef4475b018', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422834670, ''),
('d148d9168628f507d7b9ede9439fbc2a', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422758470, ''),
('d1970891a2ff63337cad11ad49a918e3', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422877014, ''),
('d1f12bcde2c62e7fbc31bbd25b24a5fa', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422811570, ''),
('d233ffc2519926d296e9fe46912e1198', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422764169, ''),
('d23fd91c9570c6d46d1328ad285a4ec2', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422781869, ''),
('d2ed6520ae5b8a8461bc697369194d35', '72.14.199.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422890178, ''),
('d3023877fa2be999571660294421fb43', '66.249.92.7', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422894078, ''),
('d3584ff3d6d396e746a90128ee0acb16', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422763403, ''),
('d35ec8e25291ef4a321b52af374960af', '66.249.92.7', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422888078, ''),
('d4f4b75996721adb7ada26cc5e5e90d9', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422756669, ''),
('d52bbf3f299c471ed0f4bddce1d987f5', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422869619, ''),
('d57b59710fe2ed6d1c2c52d4960bda81', '66.249.92.13', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422896478, ''),
('d5f427e426cab4151a273217aa950484', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422861371, ''),
('d6097ae5f0a2a2c2a077b9eba33e2f40', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422779769, ''),
('d64760c86e732a21457231abfd186c06', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422796393, ''),
('d6bdeeb9be592f97856c6d7296eabe8b', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422841723, ''),
('d6e976bbaa6988ea07d3c7367a66971a', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422882079, ''),
('d75fe7929db0ee30fb0dfd3be9832349', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422786306, ''),
('d7782050d0c45d0b22d5a5cbc13127af', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422881479, ''),
('d7c4b7282f6f1c5246dc73b9f9b6326a', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422738068, ''),
('d7c737220e973c291a01b6d469bc84eb', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422884776, ''),
('d807c6d121d666ea20269e966aae810e', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422835569, ''),
('d810491b2a5d0e2dd4b582aa7470dd6b', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422765069, ''),
('d81ad23ea970ae49a8f48dbf31d33771', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422808571, ''),
('d82ccfc5a69a7618f5e2e704e10a12d6', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422882380, ''),
('d854b1e5a0b1b7b68cc527fc277cbfad', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422752768, ''),
('d86f2bc7a3846d39e9ca2666240f52da', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422808995, ''),
('d8fedbc60d86caa6ed1f370debead601', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422875169, ''),
('d9312a5a2c01a5ab7215175dc4d41167', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422827769, ''),
('d98d5fe50dba07ea5b8a7ca51e1d37d8', '182.211.58.226', 'HEROforZERO 1.0.0 rv:1.0 (iPhone; iPhone OS 8.1.3; ko_KR)', 1422877837, ''),
('da0aa967bca679f88f67e40db1b0b087', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422853869, ''),
('da3abd6cb5bc63c1848426cb7550b6c3', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422729369, ''),
('da4c85ae15f4d818a39b2376991fcdcd', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422847703, ''),
('db094686429805a47b57ead89ee13ba6', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422836771, ''),
('dbd8733c1b075f883841b5b73d7320d7', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422780370, ''),
('dbeb7e89cb2b098e40afb93958c4a9fb', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422817270, ''),
('dc1b88a7c1426d8642ebe5361c95b194', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422799570, ''),
('dcc8f6e84723c33b390b173ff8d09c25', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422820270, ''),
('ddedfcd188dfc67eaf059685ee7bc533', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422776882, ''),
('df8b22f073f56638cbba838001e7746c', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422802571, ''),
('dfb537c4b21761e55dddfa4146d7f41d', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422855970, ''),
('dfc994bdfa0c9302b7aec86925c13672', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422869169, ''),
('dfdbff778e4004d4c9e2b754e7138da1', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422879512, ''),
('e09837ffa3875c75778b4496ffae8537', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422767287, ''),
('e0af02bbb12ec57d574a08c537f33fb0', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422841270, ''),
('e11af9002a55f657ccb56542d0bdd95e', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422843969, ''),
('e18af705ca86f8553ffe1e44f2e0a14a', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422885080, ''),
('e1bd367f5ef23ddb9e6eecc0989d1565', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422788769, ''),
('e1f8b0b56122a1f010f692a2a694872d', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422809315, ''),
('e20515925ad8253415ae6ad16b0c0d60', '72.14.199.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422889879, ''),
('e25afd919d0f5c1af7c659e708fefee8', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422801670, ''),
('e3083243dca04fa941a98628ad350bfa', '66.249.92.2', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422892707, ''),
('e30d764ec29d33b3cc8d91e459aa07f6', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422826870, ''),
('e32d7f14e0ce08f32c488f0ad3e90cf3', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422849370, ''),
('e34f20d6356388e5e830364afb4b8225', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422766569, ''),
('e386b9fe366e412475f7e72f29aece74', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422822070, ''),
('e42647d122aa3c3db13bb58876c6db09', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422773286, ''),
('e5526848184247d955b2f3d2cd5c9787', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422846669, ''),
('e593216a4dc7eaf17e4fd0ee61a2ab23', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422821313, ''),
('e6bad1d4226221245c3fd6da9fac4e91', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422886884, ''),
('e6db74a8621b0ceab02564ce3e81176c', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422838706, ''),
('e735143dc58c93025c98f4a2cd338811', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422784569, ''),
('e760e8e0ecf2158d438731615a30bca7', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422736269, ''),
('e7e3faf9e40e8fdb94134c267966b681', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422876369, ''),
('e902a859514a965b83381e8d5a9f5a3e', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422886251, ''),
('e9d1abe77fb37b3ef0031f68f2f8b9d5', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422790569, ''),
('ea32c5cb0954435beb2c3a802ee2e484', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422846370, ''),
('ea9420fb85e8a4aebaa0eab953a70890', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422822971, ''),
('eaf5b5f65fcce635b18f7dcdf1ea3ddd', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422770169, ''),
('eb144a59cef894716154f3d486180e3a', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422834069, ''),
('eb584921c064c7a71ec254ca183a43db', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422847869, ''),
('ec0b3ebd31ab3fb85edd23319dc18833', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422782307, ''),
('ec15a61603560b3a86743ba33ee8f724', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422860936, ''),
('ec165650d8ce46497a48f6abcdabdcbd', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422883880, ''),
('ec4bfed9f264d70c66b3cf98bcaecbbe', '66.249.92.2', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422890481, ''),
('eca837602bcd84c44588fac593761ad7', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422867670, ''),
('ecd67582f4254c09c7f6629152d193d3', '116.100.23.77', 'Mozilla/5.0 (iPhone; CPU iPhone OS 7_1 like Mac OS X) AppleWebKit/537.51.2 (KHTML, like Gecko) Version/7.0 Mobile/11D169', 1422877495, ''),
('eceae2c87a990e67f3f6a0b8ab786f57', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422745129, ''),
('eceed7748e4666fc4db0082db65efc74', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422750669, ''),
('ed3cb0b88213a212ca17be50fafcf5f1', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422779192, ''),
('ed407cadba3c71b5a3a4becfe81249a8', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422821469, ''),
('ed8eb19c009f0507353d91640474a774', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422850846, ''),
('edb809d416ff903326748bff6c4d7070', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422823871, ''),
('edea9d659912f02bf673cb82fc3ee7d5', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422840670, ''),
('ee0b77dd456694cbfd74b816e2cd5491', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422812770, ''),
('ee2b99e968b91eeb5cc1d22e9afe798c', '93.146.86.184', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.143 Safari/537.36', 1422887351, ''),
('ee33d7d300f048a11ebf09dc3f6d9e81', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422848770, ''),
('eec046c5487fb50ed5383bf3495ca910', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422734768, ''),
('eee6e54f0751d675366dbeca61fae94c', '1.55.153.91', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) coc_coc_browser/45.0 Chrome/39.0.2171.107 Safari/537', 1422869691, ''),
('ef4f7f0ebdc60d9b6a88a79d262e3299', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422837670, ''),
('f0044e773d51469b9c9b4abd3a3934a1', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422795805, ''),
('f00736a33c798e302950dbb77d84c82e', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422820570, ''),
('f1bd7c55e0a8dc807af47d1609485b8f', '42.119.159.117', 'Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.93 Safari/537.36', 1422778652, ''),
('f26fe26f1f41f149911fd03a46704fb2', '42.119.159.117', 'Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.93 Safari/537.36', 1422778672, ''),
('f2bf2af7f7a616d9a102f5e568451634', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422842031, ''),
('f2dd9058762d62542e336c64a7dd70e5', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422738537, ''),
('f3894d3294f2f9f67763ddbf20a729e6', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422824470, ''),
('f418de28a4a4330cc8512a191cf422b5', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422804196, ''),
('f44211bd9654b17180595b231da6fa95', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422816970, ''),
('f46c824b0655c8dc5d0f8a245df31b28', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422832269, ''),
('f46e2ce5e5d467304fd850487d84e8c1', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422868270, ''),
('f4753a2e04b39a5b32aa7f7f387c1431', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422785770, ''),
('f491ea0385c6310294befad0682c5481', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422789670, ''),
('f4c07fb4c452b7974757a153b18e4052', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422741668, ''),
('f69002fa49714777e15fa04044b1aa52', '116.100.23.77', 'HEROforZERO 1.0.0 rv:1.0 (iPhone; iPhone OS 7.1; en_US)', 1422878793, ''),
('f694c895c665bb32fe18fc6b933f22a8', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422842469, ''),
('f6a59210151150767d21deba697688e5', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422828069, ''),
('f6f8047c6b3c32d2e8aaed2e517a6374', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422869002, ''),
('f7333043577b20b75b0d2ef21283fdf3', '195.241.175.137', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/600.3.18 (KHTML, like Gecko) Version/7.1.3 Safari/537.85.12', 1422888658, ''),
('f91fd52fa48a0dd2e8d25425cdc07dad', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422877615, ''),
('f9355d11ae8ff9a06c10c92e6a1dc56d', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422744823, ''),
('f93e0f8fc836066e4741dc5e5eb38e09', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422757269, ''),
('f95452bd5b21fe1481db9ed8b72eaec5', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422746468, ''),
('fa22e439d5e998eca00b4fa463e5cf4d', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422788470, ''),
('fa72a2dde4531a82a72a82e5da907a6a', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422833011, ''),
('fa77cf6a82808bafb26cffdf042b266c', '209.85.238.109', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422760570, ''),
('fa8cf71a6b8e6bb6618ff3adc692fed8', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422786669, ''),
('fb5e5217b5c601cd063396ac6e542bf2', '209.85.238.118', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422763870, ''),
('fbfc903baf06bde8c1acb55792d63898', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422870669, ''),
('fc7eaaa9786b80fc0c28ce15d3608914', '66.249.92.67', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422805570, ''),
('fcb15062c9eccb0d6b98c80614538289', '66.249.92.79', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422864971, ''),
('fcc10a25e46c3056f59cb7242e23ac00', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422854170, ''),
('fccf1195e33ae350f0d8e70c1af8edbc', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422794469, ''),
('fd4a86f1619a37cc96c0a6c8ffffc1dd', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422778271, ''),
('fdc3ec25c99db4f4b155eb27fe249b00', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422760268, ''),
('fdd482c8a09b6d898de01ced84d2f0de', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422792669, ''),
('ff0c41595bb255c2a109846390f8630a', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422759070, ''),
('ff3941e541bf234b22d8a2d9e4955cea', '209.85.238.100', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422783331, ''),
('ff892940d6dc8b1996d77921338cd74a', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422871569, ''),
('ffb7b4904d6f31bc456eb7158d21ed27', '66.249.92.73', 'Mozilla/5.0 (compatible; Google-Apps-Script)', 1422798370, '');

-- --------------------------------------------------------

--
-- Table structure for table `choice`
--

CREATE TABLE IF NOT EXISTS `choice` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `QuestionId` int(11) DEFAULT NULL,
  `Content` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1866 ;

--
-- Dumping data for table `choice`
--

INSERT INTO `choice` (`Id`, `QuestionId`, `Content`) VALUES
(174, 69, 'Run and Hide'),
(175, 69, 'Ignore it'),
(176, 69, 'Call children''s help hotlines '),
(177, 69, 'Confront the aggressor'),
(178, 70, 'Government'),
(179, 70, 'Family'),
(180, 70, 'Society'),
(181, 70, 'All are correct'),
(182, 71, 'Children with disabilities'),
(183, 71, 'Street children'),
(184, 71, 'Poor children'),
(185, 71, 'All are correct'),
(186, 72, 'They should keep it to themselves'),
(187, 72, 'To parents, relatives, teachers or police'),
(188, 72, 'Their friends'),
(189, 72, 'Their abuser'),
(198, 75, '2014-04-15 08:18:31'),
(199, 75, '111'),
(200, 75, '112'),
(201, 75, '113'),
(202, 76, '2014-04-15 08:21:52'),
(203, 76, '115'),
(204, 76, ''),
(205, 76, ''),
(210, 78, '1'),
(211, 78, '2'),
(212, 78, '3'),
(213, 78, '4'),
(214, 79, '2'),
(215, 79, '2'),
(216, 79, '2'),
(217, 79, ''),
(222, 81, '18'),
(223, 81, 'Over 16'),
(224, 81, '16 and under'),
(225, 81, '14'),
(226, 82, 'A police officer'),
(227, 82, 'A teacher'),
(228, 82, 'A doctor'),
(229, 82, 'A person who is responsible for protection.'),
(234, 84, '5'),
(235, 84, '3'),
(236, 84, '4'),
(237, 84, '6'),
(238, 85, 'Abandoned or orphaned children'),
(239, 85, 'Disabled children'),
(240, 85, 'Children from rural local areas'),
(241, 85, 'All of the above'),
(250, 88, 'Abandoned or orphaned children. '),
(251, 88, 'Disabled children. '),
(252, 88, 'Immigrant children from other local areas. '),
(253, 88, 'All are correct.'),
(262, 91, '52 years'),
(263, 91, '72 years'),
(264, 91, '92 years'),
(265, 91, '42 years'),
(266, 92, 'Eating healthy'),
(267, 92, 'Physical activity'),
(268, 92, 'Drying stagnant pools of water'),
(269, 92, 'Avoiding contact with animals'),
(270, 93, '2.000'),
(271, 93, '10.000'),
(272, 93, '18.000'),
(273, 93, '25.000'),
(274, 94, 'World Health Organisation'),
(275, 94, 'Unicef'),
(276, 94, 'World Bank'),
(277, 94, 'North Atlantic Treaty Organisation'),
(278, 95, 'Heart Attacks and Diabetes'),
(279, 95, 'Malnutrition and apendicitis'),
(280, 95, 'Cogenital abnormalities and pneunomia'),
(281, 95, 'HIV and Malaria'),
(282, 96, '10'),
(283, 96, '20'),
(284, 96, '17'),
(285, 96, '2'),
(286, 97, 'The cost of treatment'),
(287, 97, 'The closest hospital is too far away'),
(288, 97, 'They do not feel sick “enough”'),
(289, 97, 'It is too expensive and/or too far away'),
(290, 98, 'There is no statutory quality control.'),
(291, 98, 'There aren''t prescriptions for certain medicine'),
(292, 98, 'They are all homeopathic.'),
(293, 98, 'both quality control and lack of medicine'),
(294, 99, 'The staff is friendlier'),
(295, 99, 'The salary is higher'),
(296, 99, 'They get the chance to treat more people'),
(297, 99, 'They don''t have to wear white coats'),
(298, 100, '5'),
(299, 100, '10'),
(300, 100, '20'),
(301, 100, '50'),
(302, 101, 'Solely public institutions.'),
(303, 101, 'Solely private institutions.'),
(304, 101, 'Public and private institutions.'),
(305, 101, ' There is no health system in Vietnam.'),
(306, 102, 'Big cities, like HCMC'),
(307, 102, 'Coastal cities, like Nha Trang'),
(308, 102, 'Central Highlands, like Kon Tum province'),
(309, 102, 'Big cities and Coastal cities'),
(310, 103, 'Cover your skin and use sun block'),
(311, 103, 'Drink carrot juice for its beta carotene'),
(312, 103, 'Use sun block.'),
(313, 103, 'Only go out at midday when the sun is the farthest'),
(314, 104, 'Stop at red lights'),
(315, 104, 'Use turn indicators'),
(316, 104, 'Respect speed limits'),
(317, 104, 'All are correct.'),
(318, 105, 'Hepatitis A'),
(319, 105, 'Typhoid'),
(320, 105, 'Yellow fever'),
(321, 105, 'Routine vaccines, e.g. diphtheria-tetanus-pertussi'),
(322, 106, 'Colds and flus'),
(323, 106, 'Gastrointestinal illnesses'),
(324, 106, 'Circulatory problems'),
(325, 106, 'All correct'),
(326, 107, 'Cover exposed skin'),
(327, 107, 'Avoid sharing body fluids'),
(328, 107, 'Select safe transportation '),
(329, 107, ' All correct '),
(330, 108, 'Eat solely raw food'),
(331, 108, 'Do not wash your food before eating.'),
(332, 108, 'Eat food that is cooked and served hot'),
(333, 108, 'Drink as much tap water as possible'),
(334, 109, 'Prescription medicines you usually take.'),
(335, 109, 'Personalized antibiotic prescriptions'),
(336, 109, 'Strong drugs like Morphine'),
(337, 109, 'Bandages to treat small wounds'),
(338, 110, 'Cognitive development'),
(339, 110, 'Stunted growth '),
(340, 110, 'Organ damage'),
(341, 110, 'All are correct'),
(342, 111, '29'),
(343, 111, '35'),
(344, 111, '42'),
(345, 111, '50'),
(346, 112, '1,85'),
(347, 112, '4,25'),
(348, 112, '0,20'),
(349, 112, '6,54'),
(350, 113, '10 %'),
(351, 113, '25 %'),
(352, 113, '3 %'),
(353, 113, '47 %'),
(354, 114, '0 %'),
(355, 114, '25 %'),
(356, 114, '52 %'),
(357, 114, '66 %'),
(358, 115, 'Nhi Dong 2 Hospital'),
(359, 115, 'Hung Vuong Hospital'),
(360, 115, 'Cho Ray Hospital'),
(361, 115, 'An Sinh Hospital'),
(362, 116, 'It only treats child cancer patients'),
(363, 116, 'It only treats adult cancer patients'),
(364, 116, ' It is the largest public cancer hospital in Vietn'),
(365, 116, 'All are correct'),
(366, 117, '3 No Trang Long Street, Binh Thanh District'),
(367, 117, '201B Nguyen Chi Thanh Street, District 5'),
(368, 117, '106 Cong Quynh Street, District 1'),
(369, 117, '280 Dien Bien Phu Street, District 3'),
(374, 119, 'A police officer'),
(375, 119, 'A teacher'),
(376, 119, 'A doctor'),
(377, 119, 'Someone who is responsible for child protection'),
(382, 121, 'Keep it to themselves'),
(383, 121, 'Report to parents or relatives'),
(384, 121, 'Report to local police, teachers or social work'),
(385, 121, 'Report to parents,relatives, police, teachers or s'),
(386, 122, 'Effective child protection system'),
(387, 122, 'Professional social work'),
(388, 122, 'Building more youth centers'),
(389, 122, 'All are correct'),
(390, 123, 'Civil Law'),
(391, 123, 'Common Law'),
(392, 123, 'Sharia Law'),
(393, 123, 'Civil and Common Law'),
(394, 124, '16 years'),
(395, 124, '18 years'),
(396, 124, '21 years'),
(397, 124, 'There are no elections in VN.'),
(398, 125, 'Every 2nd year'),
(399, 125, 'Every 3rd year'),
(400, 125, 'Every 5th year'),
(401, 125, 'Twice a year'),
(402, 126, 'Petty crimes, such as pick-pocketing'),
(403, 126, 'Armed robbery'),
(404, 126, 'Murder'),
(405, 126, 'Kidnapping'),
(406, 127, 'Police of VN'),
(407, 127, 'People''s Public Security of Vietnam'),
(408, 127, 'There is no police in VN'),
(409, 127, 'People''s Police'),
(410, 128, 'Blue'),
(411, 128, 'Brown'),
(412, 128, 'Pink'),
(413, 128, 'Green'),
(414, 129, '5.000'),
(415, 129, '500'),
(416, 129, '120.000'),
(417, 129, '12.000'),
(418, 130, 'China, Myanmar'),
(419, 130, 'China, Malaysia'),
(420, 130, 'China, Cambodia'),
(421, 130, 'China, Malaysia, Cambodia'),
(422, 131, 'Marriage'),
(423, 131, 'Labor exploitation'),
(424, 131, 'Sex work and adoption'),
(425, 131, 'All are correct'),
(426, 132, '50%'),
(427, 132, '60%'),
(428, 132, '70%'),
(429, 132, '80%'),
(430, 133, 'They want a happier life'),
(431, 133, 'They feel that they need finacial support'),
(432, 133, 'They lack education'),
(433, 133, 'All are correct'),
(434, 134, 'Connections to the friends & families of victims'),
(435, 134, 'Connections to the victims directly'),
(436, 134, 'Connections to local governments'),
(437, 134, 'Connection to victims and friends/families of vict'),
(438, 135, 'Under age of 15'),
(439, 135, 'Under age of 16'),
(440, 135, 'Under age of 17'),
(441, 135, 'Under age of 18'),
(442, 136, 'Cleaner'),
(443, 136, 'Souvenir Seller'),
(444, 136, 'Lottery Ticket Seller'),
(445, 136, ' All are correct'),
(446, 137, '35%'),
(447, 137, '40%'),
(448, 137, '45%'),
(449, 137, '50%'),
(450, 138, 'Long hours'),
(451, 138, 'Low wages'),
(452, 138, 'Poor facilities'),
(453, 138, 'All are correct'),
(454, 139, 'About 12,000 children'),
(455, 139, 'About 23,000 children'),
(456, 139, 'About 50,000 children'),
(457, 139, ' About 250,000 children'),
(458, 140, 'Broken family'),
(459, 140, 'Mindset problem'),
(460, 140, 'Economic migration'),
(461, 140, 'All are correct'),
(462, 141, '12'),
(463, 141, '13'),
(464, 141, '14'),
(465, 141, '15'),
(466, 142, 'Provide a loving home for children'),
(467, 142, 'Provide schools for children that are illiterate'),
(468, 142, 'Provide financial support for children'),
(469, 142, 'Provide children with schools and financial suppor'),
(470, 143, '1967'),
(471, 143, '1977'),
(472, 143, '1987'),
(473, 143, '1997'),
(474, 144, '6-8'),
(475, 144, '8-10'),
(476, 144, '10-12'),
(477, 144, 'One mother takes care of only one child'),
(478, 145, '2'),
(479, 145, '13'),
(480, 145, '80'),
(481, 145, '52'),
(482, 146, 'General knowledge and Vocational training'),
(483, 146, 'Math training'),
(484, 146, 'Science skills'),
(485, 146, 'Computer skills'),
(486, 147, '5 or 6'),
(487, 147, '9 or 10 '),
(488, 147, '3 or 4'),
(489, 147, 'None of the answers are correct'),
(490, 148, 'Physical Education'),
(491, 148, 'Military and Security Education'),
(492, 148, 'Home Economics '),
(493, 148, 'History'),
(494, 149, 'American pedagogy, interaction and debate'),
(495, 149, 'British pedagogy, interaction and debate '),
(496, 149, 'Confucian pedagogy, passively attentive'),
(497, 149, 'None of the answers are correct'),
(498, 150, 'Australia, USA, China'),
(499, 150, 'Germany, Japan, Singapore'),
(500, 150, 'The Netherlands, Thailand, China'),
(501, 150, 'France, USA, China'),
(502, 151, 'Not enough money for school supplies and unifor'),
(503, 151, 'Necessity of earning money for the family'),
(504, 151, 'School is too far away'),
(505, 151, 'Not enough money and they must earn money'),
(506, 152, 'French'),
(507, 152, 'Japanese'),
(508, 152, 'English'),
(509, 152, 'Chinese'),
(510, 153, '6 per cent'),
(511, 153, '10 per cent'),
(512, 153, '25 per cent'),
(513, 153, '0 per cent'),
(514, 154, 'Democracy'),
(515, 154, 'Communism'),
(516, 154, 'Socialism'),
(517, 154, 'Communism and Socialism'),
(518, 155, 'Buddhist'),
(519, 155, 'Catholic'),
(520, 155, 'Muslim'),
(521, 155, 'There is no predominant religion'),
(522, 156, '22'),
(523, 156, '30'),
(524, 156, '18'),
(525, 156, '28'),
(526, 157, '20 % of GDP'),
(527, 157, '6,3 % of GDP'),
(528, 157, '0,5 % of GDP'),
(529, 157, 'Governmental expenditures on education are 0'),
(530, 158, 'No children are working'),
(531, 158, 'Around 2 million'),
(532, 158, 'Around 10 million'),
(533, 158, 'Around 500.000'),
(534, 159, 'University/College Test VN'),
(535, 159, 'National Graduation Examination'),
(536, 159, 'SAT'),
(537, 159, 'GMAT'),
(538, 160, '50:50'),
(539, 160, '10:90'),
(540, 160, '0:100'),
(541, 160, '100:0'),
(542, 161, 'Primary school'),
(543, 161, 'Secondary school'),
(544, 161, 'High school'),
(545, 161, 'All  are correct'),
(546, 162, 'They improve community feeling'),
(547, 162, 'They decrease peer pressure'),
(548, 162, 'They are easier to clean'),
(549, 162, 'Teachers will not judge students'' clothing'),
(550, 163, '8 years'),
(551, 163, '10 years'),
(552, 163, '12 years'),
(553, 163, '13 years'),
(554, 164, '4'),
(555, 164, '5'),
(556, 164, '6'),
(557, 164, '7'),
(558, 165, 'A focus on creativity'),
(559, 165, 'Practical training rather than theory'),
(560, 165, 'Student-oriented teaching'),
(561, 165, 'A lack of science and math'),
(562, 166, 'Studious and passively attentive'),
(563, 166, 'Interactive and communicative'),
(564, 166, 'Creative and Questioning'),
(565, 166, 'Interactive and Creative'),
(566, 167, '60 to 100 USD per month'),
(567, 167, '80 to 120 USD per month'),
(568, 167, '100  to 140 USD per month'),
(569, 167, '120 to 160 USD per month'),
(570, 168, 'Give extra classes at their houses'),
(571, 168, 'Get another job'),
(572, 168, 'Monthly salary is enough for their living'),
(573, 168, 'Home classes or get another job'),
(574, 169, '3'),
(575, 169, '4'),
(576, 169, '5'),
(577, 169, '4 or 5'),
(578, 170, 'Mathematics and Vietnamese literature  '),
(579, 170, 'Mathematics and Physics'),
(580, 170, 'Mathematics and English'),
(581, 170, 'Vietnamese literature and English'),
(582, 171, 'In late April or early May'),
(583, 171, 'In late May or early June'),
(584, 171, 'Early January'),
(585, 171, 'Any time'),
(586, 172, '20 October'),
(587, 172, '25 October'),
(588, 172, '20 November'),
(589, 172, '25 November'),
(590, 173, 'Visit their teachers’ house'),
(591, 173, 'Give gifts to their teachers'),
(592, 173, 'Do not weara  uniform to school'),
(593, 173, 'Visit and give their teacher gifts'),
(594, 174, '65%'),
(595, 174, '70%'),
(596, 174, '75%'),
(597, 174, '80%'),
(598, 175, 'In early January'),
(599, 175, 'In late June'),
(600, 175, 'In early July'),
(601, 175, 'In late September'),
(606, 177, 'Group A'),
(607, 177, 'Group B'),
(608, 177, 'Group C'),
(609, 177, 'Group D'),
(610, 178, 'Mathematics, Physics, Chemistry'),
(611, 178, 'Mathematics, Physics, Biology'),
(612, 178, 'Mathematics, Biology, Chemistry'),
(613, 178, 'Mathematics, Biology, Physics'),
(614, 179, 'High infant mortality rate'),
(615, 179, 'Old/wrong hospital equipment'),
(616, 179, 'Child obesity'),
(617, 179, 'All  are correct'),
(618, 180, '2007'),
(619, 180, '2008'),
(620, 180, '2009'),
(621, 180, '2010'),
(622, 181, 'USD 2.000'),
(623, 181, 'USD 10.000'),
(624, 181, 'USD 950'),
(625, 181, 'University is free of charge '),
(626, 182, '1,5 million'),
(627, 182, '5,3 million'),
(628, 182, '3,2 million'),
(629, 182, 'None are correct'),
(630, 183, 'Being able to read and write'),
(631, 183, 'Minimum age of 15'),
(632, 183, 'Being enrolled in a school'),
(633, 183, 'Being able to read at 3 book a day'),
(634, 184, '50:1'),
(635, 184, '15:1'),
(636, 184, ' 25:1'),
(637, 184, '10:1'),
(638, 185, 'Underweight'),
(639, 185, 'Stunted growth'),
(640, 185, 'Undeveloped bones'),
(641, 185, 'All are correct'),
(642, 186, 'The central highlands'),
(643, 186, 'Big cities'),
(644, 186, 'Coastal areas'),
(645, 186, 'All areas suffer equally'),
(646, 187, 'Generally females are favoured over males'),
(647, 187, 'Limited economic opportunities'),
(648, 187, 'Public Policy'),
(649, 187, 'A and B are correct'),
(650, 188, 'Eating various kinds of food'),
(651, 188, 'Avoiding salty food'),
(652, 188, 'Breastfeeding babies'),
(653, 188, 'All are correct'),
(654, 189, 'Excellence in many subjects'),
(655, 189, 'Respect for teachers and promotion of learning'),
(656, 189, 'Overseas study'),
(657, 189, 'Practical over theory'),
(658, 190, 'Wheat allergy'),
(659, 190, 'Lactose intolerance'),
(660, 190, 'Gluten intolerance'),
(661, 190, 'Pork intolerance'),
(662, 191, 'Grammar and reading comprehension'),
(663, 191, 'Listening and reading comprehension'),
(664, 191, 'Speaking and listening comprehension'),
(665, 191, 'Writing and speaking'),
(666, 192, 'Asia'),
(667, 192, 'Latin Caribbean'),
(668, 192, 'Africa'),
(669, 192, 'Middle East'),
(670, 193, '30-40%'),
(671, 193, '40-50%'),
(672, 193, '50-60%'),
(673, 193, '60-70%'),
(674, 194, 'In the summer'),
(675, 194, ' In the summer and winter'),
(676, 194, 'In the winter and spring'),
(677, 194, 'During the fall'),
(682, 196, 'Registration office'),
(683, 196, 'The groom’s house'),
(684, 196, 'The bride’s backyard'),
(685, 196, 'Local Department of Justice'),
(686, 197, '12'),
(687, 197, '16'),
(688, 197, '18'),
(689, 197, '20'),
(690, 198, '1,5 USD per day'),
(691, 198, '2 USD per day'),
(692, 198, '1,25 USD per day'),
(693, 198, '10 USD per day'),
(694, 199, 'Reducing world hunger'),
(695, 199, 'Achieving primary education'),
(696, 199, 'Ensuring environmental sustainability'),
(697, 199, 'Protecting endangered species'),
(698, 200, 'A combination of life expectancy, education, and i'),
(699, 200, 'GDP development over the last five years'),
(700, 200, 'Growth of a country’s population'),
(701, 200, 'Ratio between young and old people'),
(702, 201, 'Hanoi'),
(703, 201, 'HCMC'),
(704, 201, 'Hanoi and HCMC'),
(705, 201, 'Beijing'),
(706, 202, 'Black pepper'),
(707, 202, 'Rice'),
(708, 202, 'Cashew nuts'),
(709, 202, 'All correct'),
(714, 204, 'Receive lucky money'),
(715, 204, 'Put on new clothes'),
(716, 204, 'Play games'),
(717, 204, 'Receive money and new clothes'),
(718, 205, 'Self-confidence and self-esteem'),
(719, 205, 'Obedience and self-esteem'),
(720, 205, 'Self-confidence and respect'),
(721, 205, 'Obedience and respect'),
(722, 206, 'Change their life through education'),
(723, 206, 'Education is highly valued in Vietnamese’s culture'),
(724, 206, 'Education is a means of family advancement'),
(725, 206, 'All are correct'),
(730, 208, 'Give their parents money to take care themselves'),
(731, 208, 'Build a house for their parents'),
(732, 208, 'Send their parents to nursing homes'),
(733, 208, 'Take care of their parents in their own home'),
(734, 209, 'Hanoi'),
(735, 209, 'HCMC'),
(736, 209, 'Hanoi and HCMC'),
(737, 209, 'Beijing'),
(738, 210, 'USA'),
(739, 210, 'Russia'),
(740, 210, 'China'),
(741, 210, 'Cambodia'),
(746, 212, 'Lunar New Year Celebration'),
(747, 212, 'Independence Day'),
(748, 212, 'National Resting Day'),
(749, 212, 'Unification Day'),
(750, 213, 'Receive lucky money and wear new clothes'),
(751, 213, 'Play games'),
(752, 213, 'Go to their friends houses'),
(753, 213, 'Go to school'),
(754, 214, 'Self-confidence and self-esteem'),
(755, 214, 'Obedience and self-esteem'),
(756, 214, 'Self-confidence and respect'),
(757, 214, 'Obedience and respect'),
(758, 215, 'Discipline or punish them physically'),
(759, 215, 'Allow children to do anything they want'),
(760, 215, 'Give them verbal commands'),
(761, 215, 'Give them time outs'),
(766, 217, 'Take care of children and grandchildren'),
(767, 217, 'Perform all household tasks'),
(768, 217, 'Make the final decisions of the family'),
(769, 217, 'Take care of children and household'),
(770, 218, 'Cat and mouse'),
(771, 218, 'Cat and goat'),
(772, 218, 'Cat and tiger'),
(773, 218, 'Duck and Goose'),
(774, 219, 'To help families and people.'),
(775, 219, 'To educate, connect, and activate people'),
(776, 219, 'To make money'),
(777, 219, 'To encourage people to travel to Vietnam'),
(782, 221, '4,000,000'),
(783, 221, '43,770'),
(784, 221, '7,000,000'),
(785, 221, '6,900,999'),
(790, 223, 'Take a quiz to gain knowledge.'),
(791, 223, 'Activity such as teaching English to children. '),
(792, 223, 'Sharing important information on Facebook'),
(793, 223, 'All answers are correct'),
(794, 224, 'Nothing'),
(795, 224, 'The game will be finished. We will have won.'),
(796, 224, 'We do a dance'),
(797, 224, 'Keep playing'),
(798, 225, 'You can add a heart'),
(799, 225, 'You have found your soulmate'),
(800, 225, 'You need to see a doctor'),
(801, 225, 'Someone close to you likes you'),
(802, 226, 'You got a brand new car!'),
(803, 226, 'Add time to your quiz'),
(804, 226, 'Big Ben is coming to get you!'),
(805, 226, 'A steering wheel'),
(806, 227, 'This is the Loch Mess Monster'),
(807, 227, 'Ability to skip ONE question'),
(808, 227, 'Skipping rocks'),
(809, 227, 'Hopscotch'),
(810, 228, 'Tap on the avatar in the top left corner'),
(811, 228, 'I don''t know'),
(812, 228, 'There is no user''s profile'),
(813, 228, 'None of the above'),
(814, 229, '130.000'),
(815, 229, '260.000'),
(816, 229, '950.000'),
(817, 229, '2,5 million'),
(818, 230, 'Blood'),
(819, 230, 'Semen and vaginal fluid'),
(820, 230, 'Breast milk'),
(821, 230, 'Saliva (spit)'),
(822, 231, '110 million'),
(823, 231, '35 million'),
(824, 231, '7 million'),
(825, 231, '83 million'),
(826, 232, 'Reduce the number of people you have sex with'),
(827, 232, 'Use condoms consistently and correctly'),
(828, 232, 'Ask your partner to get tested for STIs'),
(829, 232, 'All are correct'),
(830, 233, '10%'),
(831, 233, '20%'),
(832, 233, '30%'),
(833, 233, '40%'),
(834, 234, 'Take antiviral medications during pregnancy'),
(835, 234, 'Deliver the baby through caesarean (C-section)'),
(836, 234, 'Avoid breastfeeding'),
(837, 234, 'All are correct'),
(838, 235, '2%'),
(839, 235, '5%'),
(840, 235, '7%'),
(841, 235, '10%'),
(842, 236, 'Human Infectious Virus'),
(843, 236, 'Human Immudeficiency Virus'),
(844, 236, 'Heart Infection Virus'),
(845, 236, 'Hepatitis Inert Virus'),
(846, 237, 'Advanced Immune Disease State'),
(847, 237, 'Acquired Immune Disease Syndrome'),
(848, 237, 'Acquired Inert Deficiency State'),
(849, 237, 'Acquired Immune Deficiency Syndrome'),
(850, 238, '25%'),
(851, 238, '17%'),
(852, 238, '12%'),
(853, 238, '8%'),
(858, 240, '48%'),
(859, 240, '3%'),
(860, 240, '35%'),
(861, 240, '11%'),
(862, 241, '380'),
(863, 241, '2.040'),
(864, 241, '10.360'),
(865, 241, '76.570'),
(866, 242, 'Quảng Trị'),
(867, 242, 'Bình Thuận'),
(868, 242, 'Vĩnh Long'),
(869, 242, 'Ho Chi Minh'),
(870, 243, 'Setting up water filter tanks in slums'),
(871, 243, 'Bio-fertilizers'),
(872, 243, 'Waste collection campaigns'),
(873, 243, 'All received grants'),
(874, 244, 'A website about mental health in Vietnam'),
(875, 244, 'A website for youth in Vietnam on climate change'),
(876, 244, 'A website for educators in Vietnam'),
(877, 244, 'A website where you can watch animated films'),
(878, 245, '23%'),
(879, 245, '37%'),
(880, 245, '42%'),
(881, 245, '9%'),
(882, 246, '45%'),
(883, 246, '53%'),
(884, 246, '68%'),
(885, 246, '97%'),
(886, 247, '0,2%'),
(887, 247, '1,4%'),
(888, 247, '2,3%'),
(889, 247, '4,7%'),
(890, 248, '78% in males and 76% in females'),
(891, 248, '82.5% in males and 80.1% in females'),
(892, 248, '96.7 % in males and 97.5% in females'),
(893, 248, '97.5% in males and 96.7% in females'),
(894, 249, 'Mother passes the parasite to an unborn child'),
(895, 249, 'Blood transfusions'),
(896, 249, 'Sharing needles'),
(897, 249, 'All are ways the disease can be passed on'),
(898, 250, 'Brain'),
(899, 250, 'Liver'),
(900, 250, 'Intestines'),
(901, 250, 'None of these places'),
(902, 251, 'Malaria'),
(903, 251, 'Rubella'),
(904, 251, 'Yellow Fever'),
(905, 251, 'Hepatitis A'),
(906, 252, 'Spray the home against mosquitos'),
(907, 252, 'Sleep under a mosquito net'),
(908, 252, 'All answers are correct'),
(909, 252, 'Spray clothing and skin with repellent'),
(910, 253, 'Drug resistant strains of the parasite'),
(911, 253, 'Lack in research funding'),
(912, 253, 'Shortages in medications'),
(913, 253, 'Expense of the medications'),
(914, 254, 'The type of parasite'),
(915, 254, 'The severity of symptoms'),
(916, 254, 'Age'),
(917, 254, 'All are correct'),
(918, 255, 'Cerebral malaria'),
(919, 255, 'Breathing problems'),
(920, 255, 'Organ failure'),
(921, 255, 'All answers are correct'),
(922, 256, 'Polio is a bacterial infection'),
(923, 256, 'Most infected people never know they are infected'),
(924, 256, 'Those who show symptoms always become paralyzed'),
(925, 256, 'There is no vaccine for polio'),
(926, 257, 'Paralysis'),
(927, 257, 'Muscle atrophy for  up to 35 years later'),
(928, 257, 'Sleep apnea and/or depression'),
(929, 257, 'They are all possible symptoms'),
(930, 258, '13-15 years'),
(931, 258, '5-7 years'),
(932, 258, 'up to 1 year'),
(933, 258, 'up to 4 months'),
(934, 259, 'Cough, runny nose, inflamed eyes, sore throat'),
(935, 259, 'Tiny white spots inside the mouth'),
(936, 259, 'A skin rash of large, flat blotches'),
(937, 259, 'All are symptoms of measles'),
(938, 260, 'There is no treatment'),
(939, 260, 'Immune serum globulin'),
(940, 260, 'Post-exposure vaccination within 72 hours'),
(941, 260, 'Antibiotics'),
(942, 261, 'To help families and children'),
(943, 261, 'To educate, connect, and activate people '),
(944, 261, 'To make money'),
(945, 261, 'To encourage people to travel to Vietnam'),
(946, 262, 'UNICEF'),
(947, 262, 'UNICEF, NGOs, Non-profits, and You'),
(948, 262, 'The Justice League'),
(949, 262, 'The Major League'),
(954, 264, 'You must complete a quest'),
(955, 264, 'You must only complete a quiz'),
(956, 264, 'You must only complete an activity'),
(957, 264, 'You must only donate'),
(958, 265, 'Yes'),
(959, 265, 'No'),
(960, 265, 'No, but you will get an award for spending points'),
(961, 265, 'None of these'),
(962, 266, '2%'),
(963, 266, '16%'),
(964, 266, '38%'),
(965, 266, '53%'),
(966, 267, '5/1000'),
(967, 267, '16/1000'),
(968, 267, '23/1000'),
(969, 267, '34/1000'),
(970, 268, '32%'),
(971, 268, '61%'),
(972, 268, '94%'),
(973, 268, '97%'),
(974, 269, '4%'),
(975, 269, '13%'),
(976, 269, '21%'),
(977, 269, '26%'),
(978, 270, '75 years'),
(979, 270, '69 years'),
(980, 270, '62 years'),
(981, 270, '57 years'),
(982, 271, '4%'),
(983, 271, '7%'),
(984, 271, '10%'),
(985, 271, '15%'),
(986, 272, '15%'),
(987, 272, '30%'),
(988, 272, '45%'),
(989, 272, '60%'),
(990, 273, '1 in 10'),
(991, 273, '1 in 5'),
(992, 273, '1 in 4'),
(993, 273, '1 in 3'),
(994, 274, '4'),
(995, 274, '5'),
(996, 274, '6'),
(997, 274, '7'),
(998, 275, '15%'),
(999, 275, '30%'),
(1000, 275, '45%'),
(1001, 275, '6%'),
(1002, 276, '1 in 10'),
(1003, 276, '1 in 5'),
(1004, 276, '1 in 4'),
(1005, 276, '1 in 3'),
(1006, 277, '4'),
(1007, 277, '5'),
(1008, 277, '6'),
(1009, 277, '7'),
(1010, 278, 'Anyone under 18'),
(1011, 278, '15 - 18 year olds'),
(1012, 278, '10 - 19 year olds'),
(1013, 278, '18 - 30 year olds'),
(1014, 279, 'Anyone under the age of 18'),
(1015, 279, 'Girls and boys have not finished growing'),
(1016, 279, 'Anyone under the age of 15'),
(1017, 279, 'Anyone under the age of 10'),
(1018, 280, 'Direct bullying through chat and messaging'),
(1019, 280, 'Posting a harassing message on an email list'),
(1020, 280, 'Creating a website to make fun of the victim'),
(1021, 280, 'All of the above'),
(1022, 281, 'Assaulting a child you care for'),
(1023, 281, 'Process to lure children into sexual behavior '),
(1024, 281, 'Teaching children how to care for themselves'),
(1025, 281, 'Maintaining a safe play environment for children'),
(1026, 282, 'Informative Commercial Technologies'),
(1027, 282, 'Integrative Community Techniques'),
(1028, 282, 'Information and Communication Technologies '),
(1029, 282, 'Information and Communication Techniques'),
(1030, 283, 'Any representation of a child engaged in sex'),
(1031, 283, 'Children filmed or photographed against their will'),
(1032, 283, 'Videos of children filmed in real or simulated sex'),
(1033, 283, 'Any representation of a child engaged in real sex'),
(1034, 284, 'Donate your points'),
(1035, 284, 'Save a child and donate points'),
(1036, 284, 'Give money'),
(1037, 284, 'There is no donation'),
(1038, 285, 'United States of America'),
(1039, 285, 'China '),
(1040, 285, 'Vietnam'),
(1041, 285, 'Russia'),
(1042, 286, 'You run out of time'),
(1043, 286, 'You run out of hearts'),
(1044, 286, 'You answer 4 questions incorrectly'),
(1045, 286, 'All are possible ways to lose a quiz'),
(1046, 287, 'Volunteer your time by participating in activities'),
(1047, 287, 'Spread NGOs'' messages on social media'),
(1048, 287, 'Donate money on NGOs websites.'),
(1049, 287, 'All of the above'),
(1058, 290, 'You can volunteer your time to support NGOs'),
(1059, 290, 'Your donated points teach you the importance of do'),
(1060, 290, 'You can spread NGOs messages through social media'),
(1061, 290, 'All of the above'),
(1062, 291, 'Vy, a minority girl who is in need of food '),
(1063, 291, 'Son, a street boy who must sell items from his car'),
(1064, 291, 'Linh, a street girl who sells lottery tickets'),
(1065, 291, 'All of the above'),
(1066, 292, '1'),
(1067, 292, '4'),
(1068, 292, '1000'),
(1069, 292, 'Unlimited'),
(1074, 294, 'United Nations International Children’s Education '),
(1075, 294, 'United Nations International Children''s Encouragem'),
(1076, 294, 'United Nations International Children''s Emergency '),
(1077, 294, 'United Nations International Children''s Equality F'),
(1078, 295, '01 June 1940'),
(1079, 295, '01 June 1946'),
(1080, 295, 'A3. 11 December 1940'),
(1081, 295, '11 December 1946'),
(1082, 296, 'Girls'' education and gender equality:'),
(1083, 296, 'Enhancing quality in primary and secondary educati'),
(1084, 296, 'Education in emergencies and post-crisis transitio'),
(1085, 296, 'All are correct'),
(1086, 297, 'unicef.org'),
(1087, 297, 'un.org'),
(1088, 297, 'unicef-irc.org'),
(1089, 297, 'unicefinnovation.org'),
(1090, 298, 'Jackie Chan'),
(1091, 298, 'David Beckham'),
(1092, 298, 'Orlando Bloom'),
(1093, 298, 'Angelina Jolie'),
(1094, 299, 'Reduce number of children vaccinated to ZERO'),
(1095, 299, 'Reduce number of daily preventable deaths to ZERO'),
(1096, 299, 'Reduce number of malnourish children to ZERO'),
(1097, 299, 'Reduce number of illiterate children to ZERO'),
(1098, 300, 'Network of young adults raising funds for children'),
(1099, 300, 'Develop the next generation to help UNICEF'),
(1100, 300, 'Create a world where kids realize their potential'),
(1101, 300, 'All of the Above'),
(1102, 301, 'All children in developing countries'),
(1103, 301, 'Preschool-aged children'),
(1104, 301, 'Primary school-aged children (6-11)'),
(1105, 301, 'Orphaned children'),
(1106, 302, 'Eastern and Southern Africa'),
(1107, 302, 'South Asia'),
(1108, 302, 'West Asia'),
(1109, 302, 'Sub-Saharan Africa'),
(1110, 303, 'eradicate poverty/hunger & universal primary edu'),
(1111, 303, 'universal primary edu & gender equality'),
(1112, 303, 'gender equality & global partnership & development'),
(1113, 303, 'eradicate poverty & global partnership/development'),
(1114, 304, '3'),
(1115, 304, '4'),
(1116, 304, '5'),
(1117, 304, '6'),
(1118, 305, 'Yes'),
(1119, 305, 'No'),
(1120, 305, 'It depends on each child’s specific case'),
(1121, 305, 'Children from rich families have to complete al'),
(1122, 306, 'Permanent household income'),
(1123, 306, 'Parental education'),
(1124, 306, 'Teachers education and experience'),
(1125, 306, 'All of the above'),
(1126, 307, 'Tuition fee'),
(1127, 307, 'Other indirect expenses (uniforms, tutoring, etc.)'),
(1128, 307, 'Bullying'),
(1129, 307, 'All of the above'),
(1130, 308, '9 years'),
(1131, 308, '10 years'),
(1132, 308, '11 years'),
(1133, 308, '12 years'),
(1138, 310, 'A high fever'),
(1139, 310, 'Red and watery eyes'),
(1140, 310, 'Small white spots'),
(1141, 310, 'A skin rash'),
(1142, 311, 'Adult'),
(1143, 311, 'Children'),
(1144, 311, 'Unvaccinated young children'),
(1145, 311, 'Pregnant women'),
(1146, 312, 'Less than 1 dollar'),
(1147, 312, 'More than 1 dollar'),
(1148, 312, 'More than 1 dollar'),
(1149, 312, 'More than 10 dollar'),
(1150, 313, 'Vitamin B supplements'),
(1151, 313, 'Vitamin A supplements'),
(1152, 313, 'Vitamin D supplements'),
(1153, 313, 'Vitamin C supplements'),
(1154, 314, 'Close contact with infected nasal secretions'),
(1155, 314, 'Coughing and sneezing'),
(1156, 314, 'close contact, coughing and sneezing upon'),
(1157, 314, 'All are incorrect'),
(1158, 315, 'Measles is a human disease'),
(1159, 315, 'Measles is known to occur in animals'),
(1160, 315, 'Measles causes death'),
(1161, 315, 'There is a vaccine against Measles'),
(1162, 316, 'Malaria – Mumps - Rubella'),
(1163, 316, 'Measles – Mumps - Rotavirus'),
(1164, 316, 'Measles – Mumps – Rubella'),
(1165, 316, 'None of above'),
(1166, 317, 'Vaccine against Hepatitis B'),
(1167, 317, 'Vaccine against Measles'),
(1168, 317, 'Vaccine against Influenza'),
(1169, 317, 'None of the above.'),
(1170, 318, 'Good hygiene'),
(1171, 318, 'Keeping food at a safe temperature'),
(1172, 318, 'Using clean water and trusted raw materials'),
(1173, 318, 'None of the above.'),
(1174, 319, 'Under 1 year'),
(1175, 319, 'Under 3 years old'),
(1176, 319, 'Under 10 years old'),
(1177, 319, '5 years old or less'),
(1178, 320, 'Know – Request – Protect'),
(1179, 320, 'Know – Check – Protect'),
(1180, 320, 'Know – Check – Protect'),
(1181, 320, 'Know – Check – Protect'),
(1182, 321, '20%'),
(1183, 321, '30%'),
(1184, 321, '40%'),
(1185, 321, '50%'),
(1186, 322, 'UNICEF'),
(1187, 322, 'WHO'),
(1188, 322, 'UNESCO'),
(1189, 322, 'UNDP'),
(1190, 323, '4'),
(1191, 323, '5'),
(1192, 323, '6'),
(1193, 323, '7'),
(1194, 324, 'Nine Dragon River Delta'),
(1195, 324, 'North Central Region'),
(1196, 324, 'Northeast Region'),
(1197, 324, 'Central Highlands.'),
(1198, 325, '17,000'),
(1199, 325, '18,000'),
(1200, 325, '19,000'),
(1201, 325, '20,000'),
(1202, 326, '90'),
(1203, 326, '110'),
(1204, 326, '122'),
(1205, 326, '138'),
(1206, 327, '2 million'),
(1207, 327, '3 million'),
(1208, 327, '4 million'),
(1209, 327, 'None of the Above'),
(1210, 328, 'Private or public hospitals'),
(1211, 328, '(Nearby) local health centers'),
(1212, 328, 'Private clinics (run by a single or group of docto'),
(1213, 328, 'hospitals and health centers'),
(1214, 329, 'First week of June'),
(1215, 329, 'Second week of February'),
(1216, 329, 'Third week of November'),
(1217, 329, 'Last week of April'),
(1218, 330, '“Are you vaccinated?”'),
(1219, 330, '“Are you up-to-date?”'),
(1220, 330, '"Protect your world – get vaccinated"'),
(1221, 330, '“Get vaccinated”'),
(1222, 331, 'Eye care'),
(1223, 331, 'Vitamin K'),
(1224, 331, 'Birth dose of OPV and Hepatitis B vaccine'),
(1225, 331, 'All of above'),
(1226, 332, 'The majority of mothers around the world'),
(1227, 332, 'The majority of newborns around the world'),
(1228, 332, 'mothers & newborn in low/middle income countries'),
(1229, 332, 'none of the above'),
(1230, 333, 'Newborns that are born prematurely'),
(1231, 333, 'Newborns that have low birth weight.'),
(1232, 333, 'Newborns born to HIV-infected mothers.'),
(1233, 333, 'All of above'),
(1234, 334, 'Women with complications of pregnancy.'),
(1235, 334, 'Children with severe anemia'),
(1236, 334, 'People with severe trauma after accidents, surgery'),
(1237, 334, 'All of above'),
(1238, 335, 'When they are three years old'),
(1239, 335, 'During the first month of life'),
(1240, 335, 'During the third month of life'),
(1241, 335, 'During the six month of life'),
(1242, 336, 'Neonatal deaths'),
(1243, 336, 'Measles'),
(1244, 336, 'Phneumonia'),
(1245, 336, 'Malaria'),
(1246, 337, 'Southern Africa'),
(1247, 337, 'North America and South America'),
(1248, 337, 'Southeast Asia'),
(1249, 337, 'Europe'),
(1250, 338, 'Viruses'),
(1251, 338, 'Bacteria'),
(1252, 338, 'Fungi'),
(1253, 338, 'Viruses, Bacteria, Fungi'),
(1254, 339, 'Diarrheal disease can spread from person-to-person'),
(1255, 339, 'It disease can be aggravated by poor person hygien'),
(1256, 339, 'it can be spread from person-to-person and '),
(1257, 339, ''),
(1258, 340, 'It can spread from person-to-person'),
(1259, 340, 'It can be aggravated by poor personal hygiene'),
(1260, 340, 'Both answers are correct'),
(1261, 340, 'Non are correct'),
(1262, 341, 'Labour'),
(1263, 341, 'Birth'),
(1264, 341, 'Immediate postnatal'),
(1265, 341, 'All of above'),
(1266, 342, 'Lipotropic Vitamin B12'),
(1267, 342, 'Insulin'),
(1268, 342, 'Natriclorid'),
(1269, 342, 'Oral Rehydration Salts (ORS)'),
(1270, 343, 'Vaccinations'),
(1271, 343, 'Hand washing with soap'),
(1272, 343, 'Reducing household air pollution.'),
(1273, 343, 'All of above'),
(1274, 344, 'Nigeria, Pakistan and Afghanistan'),
(1275, 344, 'South Africa, Slovenia, Indonesia'),
(1276, 344, 'Sudan, China, Portugal'),
(1277, 344, 'Vietnam, Thailand, Cambodia'),
(1278, 345, 'There is no cure for polio, it can only be prevent'),
(1279, 345, 'The polio vaccine, given multiple times, can prote'),
(1280, 345, 'Both answers are correct'),
(1281, 345, 'None are correct'),
(1282, 346, 'Tuberculosis is caused by bacteria (Mycobacterium '),
(1283, 346, 'Tuberculosis most often affects the lungs'),
(1284, 346, 'Tuberculosis is curable and preventable.'),
(1285, 346, 'All of above'),
(1286, 347, 'Cough, fever, night sweats, weight loss'),
(1287, 347, 'Headache, cough, fever'),
(1288, 347, 'Weight loss, insomina, runny nose'),
(1289, 347, 'No evident symptoms'),
(1290, 348, 'Treating measles'),
(1291, 348, 'Treating the yellow fever'),
(1292, 348, 'Treating tuberculosis'),
(1293, 348, 'Treating diarrhea'),
(1294, 349, '16 per 1000 live births'),
(1295, 349, '17 per 1,000 live births'),
(1296, 349, '18 per 1,000 live births'),
(1297, 349, '19 per 1,000 live births'),
(1298, 350, '68 per 100,000 live births'),
(1299, 350, '69 per 100,000 live births'),
(1300, 350, '70 per 100,000 live births'),
(1301, 350, '71 per 100,000 live births'),
(1302, 351, '15 October'),
(1303, 351, '21 February'),
(1304, 351, '30 November'),
(1305, 351, '22 March'),
(1306, 352, '16 000'),
(1307, 352, '17 000'),
(1308, 352, '18 000'),
(1309, 352, '19 000'),
(1310, 353, 'Breast-feeding'),
(1311, 353, 'Feeding children with various kinds of food'),
(1312, 353, 'Keeping children in good hygienic conditions'),
(1313, 353, 'Both breast-feeding and various food'),
(1314, 354, '20.2%'),
(1315, 354, '32.2%'),
(1316, 354, '14.1%'),
(1317, 354, '21.1%'),
(1318, 355, '4 out of 6 children'),
(1319, 355, '3 out of 6 children'),
(1320, 355, '2 out of 6 children'),
(1321, 355, '1 out of 6 children'),
(1322, 356, 'Diarrhea'),
(1323, 356, 'Fever'),
(1324, 356, 'Measles'),
(1325, 356, 'Mumps'),
(1326, 357, 'Three months (90 days)'),
(1327, 357, 'Six months (180 days)'),
(1328, 357, 'Twelve months (1 years)'),
(1329, 357, 'Twenty-four months (2 years)'),
(1330, 358, 'Informative Commercial Technologies'),
(1331, 358, 'Integrative Community Techniques'),
(1332, 358, 'Information and Communication Technologies'),
(1333, 358, 'Information and Communication Techniques'),
(1334, 359, 'More than a half'),
(1335, 359, 'More than one third'),
(1336, 359, 'Less than a half'),
(1337, 359, 'Less than one third'),
(1338, 360, 'Mother has better health and well-being'),
(1339, 360, 'Children perform better in intelligence tests'),
(1340, 360, 'It reduces the risk of ovarian and breast cancer i'),
(1341, 360, 'All of above'),
(1342, 361, 'Vegetable'),
(1343, 361, 'Cereals'),
(1344, 361, 'Breastmilk'),
(1345, 361, 'Fish or meat gruel'),
(1346, 362, 'the age 6 - 36 months'),
(1347, 362, 'the age 4 - 24 months'),
(1348, 362, 'the age 1 - 12 months'),
(1349, 362, 'the age 12 - 24 months'),
(1350, 363, '25%'),
(1351, 363, '50%'),
(1352, 363, '75%'),
(1353, 363, '100%'),
(1354, 364, 'Vitamin A deficiency (VAD)'),
(1355, 364, 'Vitamin C deficiency (VCD)'),
(1356, 364, 'B Vitamin C deficiency (VCD)  Vitamin D deficiency'),
(1357, 364, 'Lack of breastmilk'),
(1358, 365, '34%'),
(1359, 365, '81%'),
(1360, 365, '52%'),
(1361, 365, '18%'),
(1362, 366, 'Visual impairment and blindness'),
(1363, 366, 'Increased risk of severe illness'),
(1364, 366, 'Death'),
(1365, 366, 'All of above'),
(1366, 367, '30%'),
(1367, 367, '40%'),
(1368, 367, '50%'),
(1369, 367, '60%'),
(1370, 368, 'Medicine'),
(1371, 368, 'Breastfeeding'),
(1372, 368, 'Vaccines'),
(1373, 368, 'None of the above.'),
(1374, 369, '15%'),
(1375, 369, '23%'),
(1376, 369, '53%'),
(1377, 369, '76%'),
(1378, 370, '1 December'),
(1379, 370, '3 July'),
(1380, 370, '20 December'),
(1381, 370, '11 July'),
(1382, 371, '5-10 years'),
(1383, 371, '10-15 years'),
(1384, 371, '15-25 years'),
(1385, 371, '1-5 years'),
(1386, 372, 'Parents have less understanding of the internet'),
(1387, 372, 'There is more convergence of internet and mobiles'),
(1388, 372, 'More children now have private access to internet '),
(1389, 372, 'All make parental oversight more difficult'),
(1390, 373, 'Cancer'),
(1391, 373, 'Tuberculosis'),
(1392, 373, 'Pneumonia'),
(1393, 373, 'None of the above.'),
(1394, 374, 'June 01'),
(1395, 374, 'May 5'),
(1396, 374, 'November 20'),
(1397, 374, 'The first Sunday in June'),
(1398, 375, 'Weight/ Height'),
(1399, 375, 'Height/ Weight'),
(1400, 375, 'Weight/ (Height)2'),
(1401, 375, '(Weight)2/ Height'),
(1402, 376, 'Below 18.5'),
(1403, 376, '18.5-24.9'),
(1404, 376, '25-29'),
(1405, 376, '>30'),
(1406, 377, '20 March'),
(1407, 377, '21 March'),
(1408, 377, '22 March'),
(1409, 377, '23 March'),
(1410, 378, 'Socializing Up National Movement'),
(1411, 378, 'Speaking Up National Movement'),
(1412, 378, 'Socializing Up Nutrition Movement'),
(1413, 378, 'Scaling Up Nutrition Movement'),
(1414, 379, '43th'),
(1415, 379, '44th'),
(1416, 379, '45th'),
(1417, 379, '46th'),
(1418, 380, 'Police of Vietnam'),
(1419, 380, 'People''s Public Security of Vietnam'),
(1420, 380, 'There are no police in Vietnam'),
(1421, 380, 'None of the above'),
(1422, 381, '19 August'),
(1423, 381, '22 March'),
(1424, 381, '1 May'),
(1425, 381, '1 August'),
(1426, 382, 'UNs International Children''s Education Fund'),
(1427, 382, 'UNs International Children''s Encouragement Fund'),
(1428, 382, 'UNs International Children''s Emergency Fund'),
(1429, 382, 'UNs International Children''s Equality Fund'),
(1430, 383, '1 million'),
(1431, 383, '6 million'),
(1432, 383, '10 million'),
(1433, 383, '2 million'),
(1434, 384, '01 June 1940'),
(1435, 384, '01 June 1946'),
(1436, 384, '11 December 1940'),
(1437, 384, '11 December 1946'),
(1438, 385, '5'),
(1439, 385, '6'),
(1440, 385, '7'),
(1441, 385, '8'),
(1442, 386, 'www.unicef.org'),
(1443, 386, 'http://www.un.org'),
(1444, 386, 'www.unicef-irc.org'),
(1445, 386, 'www.unicefinnovation.org'),
(1446, 387, '1985'),
(1447, 387, '1989'),
(1448, 387, '1990'),
(1449, 387, '1992'),
(1450, 388, '1989'),
(1451, 388, '1990'),
(1452, 388, '1991'),
(1453, 388, '1992'),
(1454, 389, '190'),
(1455, 389, '192'),
(1456, 389, '194'),
(1457, 389, '195'),
(1458, 390, 'Girls'' education and gender equality'),
(1459, 390, 'Enhancing quality in primary education'),
(1460, 390, 'Education in emergencies and post-crisis'),
(1461, 390, 'All are correct'),
(1462, 391, 'Afghanistan, Iraq and Iran'),
(1463, 391, 'Afghanistan, Zimbabwe and Somalia'),
(1464, 391, 'Somalia, the United States and South Sudan'),
(1465, 391, 'Iran, Zimbabwe and Uganda'),
(1466, 392, 'School'),
(1467, 392, 'Family'),
(1468, 392, 'Community'),
(1469, 392, 'Society'),
(1474, 394, '15'),
(1475, 394, '16'),
(1476, 394, '18'),
(1477, 394, '20'),
(1478, 395, 'The right to education'),
(1479, 395, 'The right to play'),
(1480, 395, 'The right to disobey parents'),
(1481, 395, 'All of the above'),
(1482, 396, 'Respect for their views'),
(1483, 396, 'Freedom of association'),
(1484, 396, 'Right to access information'),
(1485, 396, 'All of the above'),
(1486, 397, 'Number of children who have not been vaccinated'),
(1487, 397, 'Reduce number of daily preventable deaths of child'),
(1488, 397, 'Number of children suffering from malnourishment'),
(1489, 397, 'Reduce the number of illiterate children to zero'),
(1490, 398, 'Letting the child always decide'),
(1491, 398, 'Children can represent themselves in court '),
(1492, 398, 'Letting children express their views'),
(1493, 398, 'Involving the child in decisions that affect them'),
(1494, 399, 'Create a network of adults that support UNICEF'),
(1495, 399, 'Develop the next generation of UNICEF supporters'),
(1496, 399, 'Create a world where all children survive'),
(1497, 399, 'All of the above'),
(1498, 400, 'Non-discrimination'),
(1499, 400, 'Best interests of the child'),
(1500, 400, 'Right to life, survival and development'),
(1501, 400, 'Right to play'),
(1502, 401, 'Emotional and physical abuse'),
(1503, 401, 'Neglect or negligent treatment'),
(1504, 401, 'Sexual exploitation and abuse of children'),
(1505, 401, 'All of above'),
(1510, 403, 'All children in developing countries'),
(1511, 403, 'Preschool-aged children'),
(1512, 403, 'Primary school-aged children'),
(1513, 403, 'Orphaned children'),
(1514, 404, 'Support parents in taking care of their children'),
(1515, 404, 'Teach children life skills'),
(1516, 404, 'Strengthen policies and laws that protect children'),
(1517, 404, 'All of the above'),
(1518, 405, 'Eastern and Southern Africa'),
(1519, 405, 'Southeast Asia'),
(1520, 405, 'South America'),
(1521, 405, 'Sub-Saharan Africa'),
(1522, 406, '3.5 million'),
(1523, 406, '4.3 million'),
(1524, 406, '4.7 million'),
(1525, 406, '5.5 million'),
(1526, 407, 'lifelong physical and mental health problems'),
(1527, 407, 'anti-social behaviour'),
(1528, 407, 'Slow economic and social development'),
(1529, 407, 'All of above.'),
(1530, 408, 'Goal 1: eradicate extreme poverty and hunger'),
(1531, 408, 'Goal 3: gender equality'),
(1532, 408, 'Goal 2: universal primary education'),
(1533, 408, 'Goal 2 and Goal 3'),
(1534, 409, 'Yes, they do'),
(1535, 409, 'No, they don''t'),
(1536, 409, 'It depends on each child''s case'),
(1537, 409, 'Only children of rich families need to complete'),
(1542, 411, 'Tuition fee'),
(1543, 411, 'School expenses (uniforms, books, boarding, etc)'),
(1544, 411, 'Bullying'),
(1545, 411, 'All are correct'),
(1546, 412, '9 years'),
(1547, 412, '10 years'),
(1548, 412, '11 years'),
(1549, 412, '12 years'),
(1550, 413, '94% of 6 to 12-year-olds'),
(1551, 413, '96% of 6 to 11-year-olds'),
(1552, 413, '94% of 7 to 12-year-olds'),
(1553, 413, '96% of 7 to 12-year-olds'),
(1554, 414, 'A high fever'),
(1555, 414, 'Red and watery eyes'),
(1556, 414, 'Small white spots'),
(1557, 414, 'A skin rash'),
(1558, 415, 'Adults'),
(1559, 415, 'Chilren'),
(1560, 415, 'Unvaccinated young children'),
(1561, 415, 'Pregnant women'),
(1562, 416, 'Less and 1 dollar'),
(1563, 416, 'More than 1 dollar'),
(1564, 416, 'More than 10 dollars'),
(1565, 416, 'Less than 10 dollars'),
(1566, 417, 'Vitamin A supplements'),
(1567, 417, 'Vitamin B supplements'),
(1568, 417, 'Vitamin C supplements'),
(1569, 417, 'Vitamin D supplements'),
(1570, 418, 'Direct contact with bodily fluids'),
(1571, 418, 'Coughing and sneezing'),
(1572, 418, 'Contact with infected animals'),
(1573, 418, 'Bodily fluids, coughing, and sneezing'),
(1574, 419, 'Cigarette smoking and unhealthy eating'),
(1575, 419, 'Alcohol and drug abuse'),
(1576, 419, 'Depression and attempted suicide'),
(1577, 419, 'All of the above'),
(1578, 420, 'Loss of productivity'),
(1579, 420, 'Disability'),
(1580, 420, 'Decreased quality of life'),
(1581, 420, 'All of the above'),
(1582, 421, 'Body ownership'),
(1583, 421, 'How to recognize an abusive situation and say “NO”'),
(1584, 421, 'How to disclose abuse to a trusted adult'),
(1585, 421, 'All of the above'),
(1586, 422, 'Physical health problems: brain injuries, bruises.'),
(1587, 422, 'Difficulties in dealing with other people.'),
(1588, 422, 'Learning problems.'),
(1589, 422, 'All of the above'),
(1590, 423, 'Physical and/or emotional ill-treatment'),
(1591, 423, 'Sexual abuse'),
(1592, 423, 'Labour exploitation'),
(1593, 423, 'All of the above'),
(1594, 424, '100%'),
(1595, 424, '75%'),
(1596, 424, '50%'),
(1597, 424, '30%'),
(1598, 425, 'Kicking, shaking, or throwing the child'),
(1599, 425, 'Pinching or pulling the hair'),
(1600, 425, 'Burning or scarring the child'),
(1601, 425, 'All of the above'),
(1602, 426, 'Measles is a human disease'),
(1603, 426, 'Measles is known to occur in animals'),
(1604, 426, 'Measles causes death'),
(1605, 426, 'There is a vaccine against Measles'),
(1606, 427, 'Show and tell what they should do'),
(1607, 427, 'Try to say ‘yes’ and ‘well done’'),
(1608, 427, 'Rely on rewards like hugs & jokes, not punishments'),
(1609, 427, 'All of the above'),
(1610, 428, 'Malaria-Mumps-Rubella'),
(1611, 428, 'Measles-Mumps-Rotavirus'),
(1612, 428, 'Measles-Mumps-Rubella'),
(1613, 428, 'None of the above'),
(1614, 429, 'Attention seeking behaviors'),
(1615, 429, 'Fear of new situations'),
(1616, 429, 'Both answers are correct'),
(1617, 429, 'None are correct'),
(1618, 430, '2 times'),
(1619, 430, '3 times'),
(1620, 430, '4 times'),
(1621, 430, '6 times'),
(1622, 431, '1 million'),
(1623, 431, '1.5 million'),
(1624, 431, '2 million'),
(1625, 431, '2.5 million'),
(1626, 432, '10%'),
(1627, 432, '15%'),
(1628, 432, '30%'),
(1629, 432, '25%'),
(1630, 433, 'Vaccine against Hepatitis B'),
(1631, 433, 'Vaccine against Measles'),
(1632, 433, 'Vaccine against Influenza'),
(1633, 433, 'None of the above'),
(1634, 434, 'Provide a safe environment '),
(1635, 434, 'Tell the child it was not his/her fault'),
(1636, 434, 'Listen & document the child’s exact quotes'),
(1637, 434, 'All of the above '),
(1638, 435, 'Investigate'),
(1639, 435, 'Ask leading questions'),
(1640, 435, 'Make promises that you cannot keep.'),
(1641, 435, 'All of the above'),
(1642, 436, '3'),
(1643, 436, '5'),
(1644, 436, '7'),
(1645, 436, '10'),
(1646, 437, '1.5 million'),
(1647, 437, '2.2 million'),
(1648, 437, '3.3 million'),
(1649, 437, '4 million'),
(1654, 439, '50 million'),
(1655, 439, '100 million'),
(1656, 439, '200 million'),
(1657, 439, '300 million'),
(1658, 440, 'A. Genes provide blueprints for brain development'),
(1659, 440, 'B. Environment shapes genes.'),
(1660, 440, 'C. Nature'),
(1661, 440, 'D. Both A and B are correct.'),
(1662, 441, 'In the first few years of life'),
(1663, 441, 'Between the ages of 5-10'),
(1664, 441, 'Between the ages of 10-15'),
(1665, 441, 'Between the ages of 15-25'),
(1666, 442, 'When a child is under 5 years of age'),
(1667, 442, 'From 5 years old to puberty'),
(1668, 442, 'During puberty'),
(1669, 442, 'In adulthood'),
(1670, 443, 'Nutrition that feeds the brain'),
(1671, 443, 'Healthy interactions that reduce illness'),
(1672, 443, 'Protection from stress'),
(1673, 443, 'All of the answers are correct'),
(1674, 444, '25%'),
(1675, 444, '50%'),
(1676, 444, 'Between 50 and 75%'),
(1677, 444, '80%'),
(1678, 445, 'Body is unable to metabolize key nutrients'),
(1679, 445, 'Lowers absorption capacity of vital organs'),
(1680, 445, 'Decreases the effectiveness of supplements '),
(1681, 445, 'All are correct'),
(1682, 446, 'Body stress caused by poisonous chemicals'),
(1683, 446, 'Stress of experiencing violence, abuse, neglect'),
(1684, 446, 'Low levels of the hormone cortisol'),
(1685, 446, 'Body stressed caused by obesity'),
(1686, 447, 'A good teacher'),
(1687, 447, 'Classroom supplies'),
(1688, 447, 'Going to school 6 days a week'),
(1689, 447, 'Interactions between a child and his/her caregiver'),
(1690, 448, 'After puberty'),
(1691, 448, 'By six years of age'),
(1692, 448, 'Up until puberty'),
(1693, 448, 'The foundation is always changing. '),
(1694, 449, 'In mothers breastfeeding encourages bonding'),
(1695, 449, 'Better nutrition leads to better brain development'),
(1696, 449, 'It provides stimulation and nuturing'),
(1697, 449, 'All answers are correct'),
(1698, 450, '1 out of 4'),
(1699, 450, '1 out of 3'),
(1700, 450, '2 out of 5'),
(1701, 450, '1 out of 2'),
(1702, 451, 'It is only half full'),
(1703, 451, 'It is half the size of an adult brain'),
(1704, 451, 'It is twice the size of an adult brain'),
(1705, 451, 'It has twice as much information as an adult''s'),
(1706, 452, '23%'),
(1707, 452, '56%'),
(1708, 452, '71%'),
(1709, 452, '87%'),
(1710, 453, 'Under 1 year'),
(1711, 453, 'Under 3 years'),
(1712, 453, 'Under 10 years'),
(1713, 453, '5 years old or younger'),
(1714, 454, '20%'),
(1715, 454, '30%'),
(1716, 454, '40%'),
(1717, 454, '50%'),
(1718, 455, 'UNICEF'),
(1719, 455, 'WHO'),
(1720, 455, 'UNESCO'),
(1721, 455, 'UNDP'),
(1722, 456, '17,000'),
(1723, 456, '18,000'),
(1724, 456, '19,000'),
(1725, 456, '20,000'),
(1726, 457, '52'),
(1727, 457, '96'),
(1728, 457, '122'),
(1729, 457, '153'),
(1730, 458, '1 million'),
(1731, 458, '3 million'),
(1732, 458, '10 million'),
(1733, 458, '20 million'),
(1734, 459, 'A. Private and public hospitals'),
(1735, 459, 'B. (Nearby) local health centers'),
(1736, 459, 'C. Local government offices'),
(1737, 459, 'A and B are correct'),
(1738, 460, 'First week of June'),
(1739, 460, 'First week of January'),
(1740, 460, 'Last week in April'),
(1741, 460, 'Last week in December'),
(1742, 461, 'Are you up to date?'),
(1743, 461, 'Are you vaccinated?'),
(1744, 461, 'Protect your world--get vacinnated'),
(1745, 461, 'Get Vaccinated'),
(1746, 462, 'The majority of mothers around the world'),
(1747, 462, 'The majority of newborns around the world'),
(1748, 462, 'Mothers and newborns in low-middle income countrie'),
(1749, 462, 'None of the above'),
(1798, 475, 'With history of violence among parents'),
(1799, 475, 'Of low educated parents'),
(1800, 475, 'With economic difficulties'),
(1801, 475, 'All of the answeres are correct'),
(1802, 476, 'With economic difficulties'),
(1803, 476, 'Of divorced parents/no biological parents'),
(1804, 476, 'In rural/remote areas'),
(1805, 476, 'All of the answers are correct'),
(1806, 477, '500'),
(1807, 477, '2,000'),
(1808, 477, '5,600'),
(1809, 477, '7,000'),
(1810, 478, '1/4'),
(1811, 478, '1/5'),
(1812, 478, '1/10'),
(1813, 478, '1/20'),
(1814, 479, 'January 01'),
(1815, 479, 'June 01'),
(1816, 479, 'September 01'),
(1817, 479, 'November 01'),
(1818, 480, '5%'),
(1819, 480, '18%'),
(1820, 480, '26%'),
(1821, 480, '50%'),
(1822, 481, '5%'),
(1823, 481, '17%'),
(1824, 481, '32%'),
(1825, 481, '57%'),
(1826, 482, 'Poorer sections of the population'),
(1827, 482, 'Wealthier sections of the population'),
(1828, 482, 'There is no difference between wealthy and poor'),
(1829, 482, 'It depends on the country'),
(1830, 483, 'No education'),
(1831, 483, 'Primary school education'),
(1832, 483, 'Secondary school education'),
(1833, 483, 'University/College education'),
(1834, 484, '12%'),
(1835, 484, '26%'),
(1836, 484, '45%');
INSERT INTO `choice` (`Id`, `QuestionId`, `Content`) VALUES
(1837, 484, '53%'),
(1838, 485, '1/10'),
(1839, 485, '1/5'),
(1840, 485, '1/4'),
(1841, 485, '1/3'),
(1842, 486, 'Early pregnancy and social isolation'),
(1843, 486, 'Interrupts her schooling'),
(1844, 486, 'Limits her career and vocational options'),
(1845, 486, 'All are negative affects of child marriage'),
(1846, 487, '150 million'),
(1847, 487, '100 million'),
(1848, 487, '50 million'),
(1849, 487, '25 million'),
(1850, 488, 'A. They cannot receive healthcare '),
(1851, 488, 'B. They cannot obtain an education'),
(1852, 488, 'C. They might be hired or conscripted before legal'),
(1853, 488, 'A, B and C'),
(1854, 489, 'A. They cannot obtain healthcare'),
(1855, 489, 'B. They cannot obtain an education'),
(1856, 489, 'C. They might be conscripted or hired under age'),
(1857, 489, 'A, B, and C'),
(1858, 490, '50 million'),
(1859, 490, '100 million'),
(1860, 490, '230 million'),
(1861, 490, '500 million'),
(1862, 491, '5%'),
(1863, 491, '20%'),
(1864, 491, '30%'),
(1865, 491, '45%');

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
  `IsApproved` bit(1) DEFAULT b'0',
  `CreateDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=34 ;

--
-- Dumping data for table `donation`
--

INSERT INTO `donation` (`Id`, `Title`, `Description`, `RequiredPoint`, `MedalId`, `PartnerId`, `IsApproved`, `CreateDate`) VALUES
(11, 'Heart Refills', 'Spend 10 points to get one extra heart during a quiz.', 10, 0, 5, b'1', '2014-04-07 10:26:39'),
(12, 'Add more time', 'Spend 10 points to be able to give yourself more time during a quiz.', 10, 1, 5, b'1', '2014-04-07 10:26:56'),
(13, 'Skip the question', 'Spend 10 points to be able to skip one question during a quiz.', 10, 2, 6, b'1', '2014-04-07 10:36:05'),
(15, 'Donate 10 points to complete the Training', 'You will donate 10 points from your total points and you will receive an award for successfully completing your Hero Training. Now you are ', 10, 17, 6, b'1', '2014-04-07 10:45:18'),
(17, 'We need 3 new bicycles', 'We need 3 new bicycles (US 50 each) for older boys to go to school/ vocational training outside', 10, 18, 19, b'1', '2014-04-24 03:36:42'),
(18, 'A roof of the house for boys here need replacing', 'A roof of the house for boys here need replacing as soon as possible (US1,0  00)', 10, 19, 19, b'1', '2014-04-24 03:37:04'),
(19, 'Nutritional care', 'Nutritional care: 30,000 VND/child/day.', 10, 20, 22, b'1', '2014-04-28 16:01:51'),
(20, 'Health care', 'Health care: 200,000 VND/child/month.', 10, 21, 22, b'1', '2014-04-28 16:02:09'),
(21, 'Educational expense', 'Educational expense: 500,000 VND/child/month.', 10, 22, 22, b'1', '2014-04-28 16:02:27'),
(22, 'The regular expense of a child', 'The regular expense of a child:\n-	Nutritional care: 30,000 VND/child/day.\n-	Health care: 200,000 VND/child/month.\n-	Educational expense: 500', 10, 23, 22, b'1', '2014-04-28 16:02:53'),
(23, '$250 for the operational expense of a KNS course for children.  ', '$250 for the operational expense of a KNS course for children.  ', 10, 24, 23, b'1', '2014-04-28 16:32:54'),
(24, '$50 for the financial aid of vocational training for children.', '$50 for the financial aid of vocational training for children.', 10, 25, 23, b'1', '2014-04-28 16:33:00'),
(25, '$2 for the financial aid of a child’s study. ', '$2 for the financial aid of a child’s study. ', 10, 26, 23, b'1', '2014-04-28 16:33:05'),
(27, 'Breakfasts ', '10USD for breakfasts for 20 kids/day (20 * 10.000vnd)', 10, 27, 25, b'1', '2014-05-29 03:31:00'),
(28, 'School uniforms', '800USD for school uniforms for 20 kids (20 kids * 2uniforms/each * 400.000vnd/each)', 10, 28, 25, b'1', '2014-05-29 03:31:23'),
(29, 'Donate 10 points to get Training Award', 'You will give 10 of your total points you have earned, and you will receive an award for successfully completing your training. Congratulati', 10, 29, 6, b'1', '2014-06-11 04:25:15'),
(30, 'Test', 'Test', 100, 29, 30, b'1', '2014-10-29 06:02:58'),
(31, 'Donate your point to help children', 'Donate your point will show us how much you care about this project.', 100, 29, 24, b'1', '2014-11-01 02:52:12'),
(32, 'Test donation', 'Just do it', 100, 29, 24, b'1', '2014-11-01 02:55:31'),
(33, 'sdfsfd', 'sdfdsfdf', 100, NULL, 5, b'0', '2014-11-01 03:36:59');

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
-- Stand-in structure for view `leaderboard`
--
CREATE TABLE IF NOT EXISTS `leaderboard` (
`id` int(11)
,`name` varchar(45)
,`avatar` int(11)
,`mark` int(11)
,`facebook_id` varchar(45)
,`current_level` int(11)
,`rank` bigint(22)
);
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
  `Type` int(11) NOT NULL DEFAULT '0' COMMENT 'NOT IN USE. 0: quest, 1: Activity, 2: Donation.',
  `ObjectId` int(11) NOT NULL DEFAULT '0' COMMENT 'NOT IN USE. The id of quest if this is quest medal.',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=37 ;

--
-- Dumping data for table `medal`
--

INSERT INTO `medal` (`Id`, `Name`, `ImageURL`, `Type`, `ObjectId`) VALUES
(0, 'Heart Refills', 'http://heroforzero.be/assets/img/profile/05_Donations/buy-heart-icon@2x.png', 2, 11),
(1, 'Add more time', 'http://heroforzero.be/assets/img/profile/05_Donations/buy-skip-icon@2x.png', 2, 12),
(2, 'Skip the question', 'http://heroforzero.be/assets/img/profile/05_Donations/buy-time-icon@2x.png', 2, 13),
(3, 'Guardian Angel', 'http://heroforzero.be/assets/img/profile/05_Donations/donate-guaridan-icon@2x.png', 2, 0),
(4, 'Earn a sword', 'http://heroforzero.be/assets/img/quest/training-sword.png', 0, 1),
(5, 'Earn a shield', 'http://heroforzero.be/assets/img/quest/training-shield.png', 0, 2),
(6, 'Earn a cape', 'http://heroforzero.be/assets/img/quest/training-cape.png', 0, 3),
(7, 'Save Vy from hunger', 'http://heroforzero.be/assets/img/quest/nutrition-minority.png', 0, 5),
(8, 'Help Lau find food', 'http://heroforzero.be/assets/img/quest/nutrition-buddist.png', 0, 6),
(9, 'Give to help Minh eat', 'http://heroforzero.be/assets/img/quest/nutrition-streetkid.png', 0, 14),
(10, 'Help Son get an education', 'http://heroforzero.be/assets/img/quest/education-streetworker.png', 0, 7),
(11, 'Help Mai go to shool', 'http://heroforzero.be/assets/img/quest/education-minority.png', 0, 8),
(12, 'Give Linh sholarships', 'http://heroforzero.be/assets/img/quest/education-lottogirl.png', 0, 9),
(13, 'Save Mai from the wolf', 'http://heroforzero.be/assets/img/quest/3.png', 0, 10),
(14, 'Save Lac from abuse', 'http://heroforzero.be/assets/img/quest/protection-abused.png', 0, 15),
(15, 'Help Wie get treatment', 'http://heroforzero.be/assets/img/quest/health-sick.png', 0, 11),
(16, 'Disease', 'http://heroforzero.be/assets/img/quest/2.png', 0, 12),
(17, 'Donate 10 points to complete the Training', 'http://heroforzero.be/assets/img/awards/award_donations@2x.png', 2, 0),
(18, 'We need 3 new bicycles', 'http://heroforzero.be/assets/img/awards/award_donations2@2x.png', 2, 0),
(19, 'A roof of the house for boys here need replac', 'http://heroforzero.be/assets/img/awards/award_roof@2x.png', 2, 0),
(20, 'Nutritional care', 'http://heroforzero.be/assets/img/awards/award_food@2x.png', 2, 0),
(21, 'Health care', 'http://heroforzero.be/assets/img/awards/award_medical@2x.png', 2, 0),
(22, 'Educational expense', 'http://heroforzero.be/assets/img/awards/award_educational@2x.png', 2, 0),
(23, 'The regular expense of a child', 'http://heroforzero.be/assets/img/awards/award_donations@2x.png', 2, 0),
(24, '$250 for the operational expense of a KNS cou', 'http://heroforzero.be/assets/img/awards/award_donations@2x.png', 2, 0),
(25, '$50 for the financial aid of vocational train', 'http://heroforzero.be/assets/img/awards/award_vocational@2x.png', 2, 0),
(26, '$2 for the financial aid of a child’s study.', 'http://heroforzero.be/assets/img/awards/award_educational@2x.png', 2, 0),
(27, 'Breakfasts', 'http://heroforzero.be/assets/img/awards/award_food@2x.png', 2, 0),
(28, 'School uniforms', 'http://heroforzero.be/assets/img/awards/award_donations@2x.png', 2, 0),
(29, 'Donate 10 points to get Training Award', 'http://heroforzero.be/assets/img/awards/award_donations@2x.png', 2, 0),
(30, 'School uniforms', 'http://heroforzero.be/assets/img/awards/award_donations@2x.png', 2, 0),
(31, 'Help Tu get treatment', 'http://heroforzero.be/assets/img/quest/nutrition-minority.png', 0, 4),
(32, 'General Health', 'http://heroforzero.be/assets/img/quest/3.png', 0, 13),
(33, 'Help Ty away from school bully', 'http://heroforzero.be/assets/img/quest/nutrition-streetkid.png', 0, 0),
(34, 'Help Ty', 'http://heroforzero.be/assets/img/quest/training-sword.png', 0, 0),
(35, 'Help Ty away from school bullying', 'http://heroforzero.be/assets/img/quest/nutrition-streetkid.png', 0, 0),
(36, 'Help Ty away from school bullying', 'http://heroforzero.be/assets/img/quest/nutrition-streetkid.png', 0, 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Dumping data for table `packet`
--

INSERT INTO `packet` (`Id`, `Title`, `ImageURL`, `PartnerId`) VALUES
(1, 'Hero Training', 'http://mytempbucket.s3.amazonaws.com/1400216231.jpg', 5),
(2, 'Nutrition', 'http://mytempbucket.s3.amazonaws.com/1400226009.jpg', 5),
(3, 'Education', 'http://mytempbucket.s3.amazonaws.com/1400226826.jpg', 5),
(4, 'Protection', 'http://mytempbucket.s3.amazonaws.com/1400225850.jpg', 5),
(6, 'Health', 'http://mytempbucket.s3.amazonaws.com/1400227503.jpg', 5),
(8, '', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `partner`
--

CREATE TABLE IF NOT EXISTS `partner` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `PartnerName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OrganizationTypeId` int(11) DEFAULT NULL,
  `Address` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PhoneNumber` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WebsiteURL` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Latitude` float DEFAULT NULL,
  `Longtitude` float DEFAULT NULL,
  `Description` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IsApproved` bit(1) NOT NULL DEFAULT b'0',
  `LogoURL` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IconURL` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `AdminName` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=38 ;

--
-- Dumping data for table `partner`
--

INSERT INTO `partner` (`Id`, `PartnerName`, `OrganizationTypeId`, `Address`, `PhoneNumber`, `WebsiteURL`, `Latitude`, `Longtitude`, `Description`, `IsApproved`, `LogoURL`, `IconURL`, `AdminName`) VALUES
(5, 'UNICEF Viet Nam', 2, 'Sun Wah Tower, Suite 504, 115 Nguyen Hue, District 1, HCMC', '+84 3821-9413', 'http://www.unicef.org/vietnam', NULL, NULL, 'UNICEFs mission in Vietnam is to fulfill the rights of every child in Vietnam, particularly those most disadvantaged or vulnerable.', b'1', 'http://www.unicef.org/vietnam/unicef-logo.gif', 'https://dl.dropboxusercontent.com/u/64958885/HeroForZero/Image/activity/avatar-unicef-big%402x.png', 'Lara Vu'),
(6, 'Agape Childrens Home', 3, '4232 Vermon Ave. S Minneapolis, MN 45234', '01217799140', 'achvn.org', NULL, NULL, 'Agape Childrens Home (ACH) mission is to give hope to the abandoned and impoverished children of Vietnam by providing them with a safe and l', b'1', '', 'https://dl.dropboxusercontent.com/u/64958885/HeroForZero/Image/activity/avatar-agape%402x.png', NULL),
(19, 'CHILDREN’S HOUSE DISTRICT 8', 3, '73/10 Duong Ba Trac street, Ward 1, District 8, HCMC', '+84  08-38502088', 'http://www.unicef.org/vietnam', NULL, NULL, 'Contributing to improve the life of children/ adolescents who are in a street situation through social and professional integration.', b'1', '0', 'http://heroforzero.be/assets/uploads/4a6550e58c22e5516eb9605147fd5c3b.png', 'Children'),
(22, 'Buddhist Social Charity Center of Ky Quang Pa', 5, '154/4A Lê Hoàng Phái, P.17, Q. Gò Vấp, Tp. HCM', '+84.38951014 – 0938.456.215 – 0903.005.442', '', NULL, NULL, 'Buddhist Social Charity Center of Ky Quang Pagoda II is a center whose aims are to raise, educate and orient orphaned, disabled children and', b'1', '0', 'http://heroforzero.be/assets/uploads/68630e640ba1734ede90bfb44c555938.png', 'Buddist'),
(23, 'Vietnam Association for Protection of Childre', 1, '181 Nguyễn Cư Trinh, Quận 1, TP HCM', '(+84) 838 388 872 – (+84) 913 639 386', 'www.treemviet.com.vn', NULL, NULL, '-	Ủng hộ và thúc đẩy quyền trẻ em.\n-	Thực hiện giám sát và báo cáo về những hành vi xâm phạm quyền trẻ em về cơ quan nhà nước.\n-	Bồi dưỡng n', b'1', '0', 'http://heroforzero.be/assets/uploads/a6966a3440ac1069059fbc8c715abfee.png', 'Lien He'),
(24, 'Ocean 4', 1, 'My Vien, Q7', '84912880656', '', NULL, NULL, 'We build things to help people.', b'0', 'http://heroforzero.be/assets/uploads/d24be3da4852a4474d48d5780c44d015.png', 'http://heroforzero.be/assets/uploads/d24be3da4852a4474d48d5780c44d0151.png', 'Tan'),
(25, 'Little Rose Story Warm Shelter', 3, '30/31 Lâm Văn Bền- Phường Tân Kiểng- Quận 7- TPHCM', '(+84) 38. 720. 308', '', NULL, NULL, 'Little Rose Story Warm Shelter were established in 1992, under the HCMC Child Welfare Association to provide care and support girls who are victims or at risk of being sexual abused, exploited. Moreover, the shelter also conduct educational and awareness raising activities on “prevention of child sexual abuse” to improve community knowledge and awareness about girls as victims.', b'1', '0', 'http://heroforzero.be/assets/uploads/bd9c54cbcac7e91e4117212b25a7e9ab.png', 'Rose'),
(27, 'UNICEF Vietnam in Ho Chi Minh', 1, 'SunWah Tower, Ho Chi Minh', '012345678', '', NULL, NULL, 'UNICEF', b'1', 'http://heroforzero.be/assets/uploads/a3b438a4e293d0ac08a4e04b4533ac15.png', 'http://heroforzero.be/assets/uploads/3b2d73e6c8d0d8f3ac405c08fb67b579.png', 'Mariah Cannon'),
(28, 'LIN Center for Community Development', 1, '180/47 Nguyen Huu Canh, P.22, Q. Binh Thanh, Tp.HCM', '848-3512-0092', 'www.LINvn.org', NULL, NULL, 'LIN''s mission is to provide support services to local NPOs, skilled volunteers  and donors who are committed  to building strong communities.', b'1', 'http://heroforzero.be/assets/uploads/34fc9841ec5ca739ecaecfc76bb9a740.png', 'http://heroforzero.be/assets/uploads/0f81111d161e2d484f383e4046d19a0a.png', 'Dana'),
(29, 'Cơ sở bảo trợ xã hội Thảo Đàn', 1, '451/1 Hai Bà Trưng, P8,Q3, TPHCM', '(08)38465410', 'thaodan.org.vn', NULL, NULL, 'Thảo Đàn góp phần xây dựng một xã hội nơi mà mọi trẻ sống hạnh phúc và phát triển trong một môi trường an toàn và lành mạnh.', b'1', '0', 'http://heroforzero.be/assets/uploads/bd1b68b26af49b9bc17e8560f8cd249d.png', 'Thao Dan'),
(30, 'HEROforZERO', 1, '115 Nguyen Hue Bolevard, District 1 HCMC', '0902826031', 'heroforzero.be', NULL, NULL, 'Hero For Zero sets out to educate, activate, and procure an online community through gamification of volunteering process.', b'1', 'http://heroforzero.be/assets/uploads/bb96a6adf814a460e7367c8d49c00581.png', 'http://heroforzero.be/assets/uploads/bb96a6adf814a460e7367c8d49c005811.png', 'Luan Jenkins'),
(32, 'KOTO', 1, '710B Lac Long Quan Street, Tay Ho District, Ha Noi, Vietnam', '+84 4 3718 4573', 'http://www.koto.com.au/', NULL, NULL, 'KOTO is a vocational training organization for street and disadvantaged youth in Vietnam. It accepts youth whose backgrounds are primarily orphans, street kids and the poor in both the city and rural communities.\n', b'1', 'http://heroforzero.be/assets/uploads/c510747f57ac5cf0c228a7009bd931dc.png', 'http://heroforzero.be/assets/uploads/1d48e9cec0b2b5c2017350ed8a5c391a.png', 'KOTO'),
(33, 'Operation Smile', 1, '5th Floor, Hung Vuong plaza, 126 Hung Vuong Street, District 5, Ho Chi Minh City', '(84) 8 2222 1008', 'http://www.operationsmile.org.vn/', NULL, NULL, 'Operation Smile is an international children''s medical charity that performs safe, effective cleft lip and cleft palate surgery, and delivers postoperative and ongoing medical therapies to children in low and middle income countries.', b'1', 'http://heroforzero.be/assets/uploads/8ce88aedf971436dc2a39a8422702fa1.png', 'http://heroforzero.be/assets/uploads/8ce88aedf971436dc2a39a8422702fa11.png', 'Operation Smile'),
(34, 'SOS Children''s Villages International', 2, 'SOS Children''s Villages Vietnam, Alley 1, Pham Van Dong Road, Mai Dich Ward, Cau Giay District, Hanoi', '+84.4.37644019/ 37641229/ 37641233', 'http://www.sosvietnam.org/Home/tabid/39/language/en-US/Default.aspx', NULL, NULL, 'We enable children who have lost the care of their parents to become again part of a family and to grow-up in the most natural way possible. We support these children to become independent, responsible and contributing members of society. ', b'1', 'http://heroforzero.be/assets/uploads/74f6264165d8d3f71720d99ade07695c.png', 'http://heroforzero.be/assets/uploads/74f6264165d8d3f71720d99ade07695c1.png', 'SOS Villages'),
(35, 'Heartbeat Vietnam', 1, '24 Nguyen Thai Binh Street District 1 Ho Chi Minh City Vietnam', '+84.3827.8787', 'http://vinacapitalfoundation.org/our-programs/heartbeat-vietnam/', NULL, NULL, 'With matching funds from provincial government organizations, and insurance coverage, the cost to a donor to save a child’s life with heart surgery is just $1,000.', b'1', 'http://heroforzero.be/assets/uploads/a62d97cde70f45e2f0e6979a93c59b97.png', 'http://heroforzero.be/assets/uploads/a9341c9240c7a440f25a4577b06d2f2a.png', 'N/A'),
(36, 'Tester Organization', 1, '12A Tester street', '0176455232', 'www.tester.org', NULL, NULL, 'None', b'0', '0', '0', 'Molly Kelly'),
(37, 'UNICEF Viet Nam', 2, 'Sun Wah Tower, 115 Nguyen Hue, District 1, HCMC', '0902501279', 'www.unicef.org/vietnam', NULL, NULL, 'Unite for Children', b'0', '0', '0', 'Minh Tri');

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
-- Table structure for table `partner_ext`
--

CREATE TABLE IF NOT EXISTS `partner_ext` (
  `partner_id` int(11) NOT NULL,
  `fanpage` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `donation_message` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `donation_link` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `donation_paypal` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `donation_address` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Additional information for Partner.';

--
-- Dumping data for table `partner_ext`
--

INSERT INTO `partner_ext` (`partner_id`, `fanpage`, `donation_message`, `donation_link`, `donation_paypal`, `donation_address`) VALUES
(5, 'https://www.facebook.com/unicefnextgenvn', 'Donate to Unicef Vietnam', 'https://secure.supportunicef.org/site/c.dvKUI9OWInJ6H/b.7640413/k.2B2B/Donate_now/apps/ka/sd/donor.asp?c=dvKUI9OWInJ6H&b=7640413&en=4nJxEFPfH3IGIPOiF2LDJLPsGnJKJINoGjKNIROsEaJIISNuHrF', '', 'Unit 507, Suh Wah Tower,  115 Nguyen Hue Bolevard, Distric'),
(19, 'https://www.facebook.com/ChiaSeMoiNgayMotYTuong', 'You can come and help us at any time', 'https://unicef.org.vn/donate', 'https://www.paypal.com/vn/webapps/mpp/pay-online', 'Unit 507, Suh Wah Tower,  115 Nguyen Hue Bolevard, District 1,  Ho Chi Minh City - Viet Nam'),
(22, '', '', '', '', ''),
(23, '', '', '', '', 'Tổ 50 Mai Dịch, Cầu Giấy, Hà Nội'),
(24, 'www.facebook.com/achvn', 'Donate and help us.', 'www.kickstarter.com', 'www.paypal.com/luanjenkins', '56/39 Duong Ba Trac, Phuong 2, Quan 8, TP HCM'),
(25, 'https://www.facebook.com/TheLittleRoseShelter.vn', 'Donate to us', '', 'https://www.paypal.com/dk/cgi-bin/webscr?cmd=_flow&SESSION=c_g60C6VRGbnltsFSOHa1HX5oeMZN71GEszose2q0OQmIPBook6b9VAck_y&dispatch=5885d80a13c0db1f8e263663d3faee8d66f31424b43e9a70645c907a6cbd8fb4', '30/31 Lam Van Ben Street, Tan Kieng Ward, District 7,HCM City.'),
(27, 'https://www.facebook.com/unicefnextgenvn', 'Donate to Unicef Vietnam HCMC', 'http://www.unicef.org.vn/donate/', '', 'Sun Wah Tower, Suite 504, 115 Nguyen Hue, District 1, HCMC'),
(28, 'https://www.facebook.com/LINCenter', 'Donate to us', 'http://www.linvn.org/get-involved/donate', '', 'LIN Center for Community Development  - TRUNG TÂM HỖ TRỢ PHÁT TRIỂN CỘNG ĐỒNG LIN'),
(29, '', 'Donate to us', 'http://thaodan.org.vn/vi/dong-gop.html', '', '451/1 Hai Bà Trưng, P.8, Q.3 TP. Hồ Chí Minh, Việt Nam Tel:  (+84.8) 38.465.410 '),
(30, 'www.facebook.com/achvn', 'Donate to our cause.', 'www.kickstarter.com', 'www.paypal.com/luanjenkins', '56/39 Duong Ba Trac, Phuong 2, Quan 8, TP HCM '),
(32, 'https://www.facebook.com/know.one.teach.one', '', 'http://www.koto.com.au/sponsor-and-donate/donate-information', '', '710B Lac Long Quan Street, Tay Ho District, Ha Noi, Vietnam'),
(33, 'https://www.facebook.com/operationsmilevietnam', 'Donate to us', 'https://secure.operationsmile.org/site/Donation2?df_id=2460&2460.donation=form1', '', ''),
(34, 'https://www.facebook.com/soschildrensvillagesVietnam', 'Donate to Us', 'http://www.sosvietnam.org/userpages/intro/Whyweareneed/tabid/94/language/en-US/userpages/DonateNow/tabid/93/language/en-US/Default.aspx', '', 'SOS Children''s Villages Vietnam Alley 1, Pham Van Dong Road, Mai Dich Ward, Cau Giay District, Hanoi '),
(35, '', 'Donate to Us', 'http://vinacapitalfoundation.org/get-involved/donate/', '', '24 Nguyen Thai Binh Street District 1 Ho Chi Minh City Vietnam');

-- --------------------------------------------------------

--
-- Table structure for table `player_avatar`
--

CREATE TABLE IF NOT EXISTS `player_avatar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar_url` varchar(100) COLLATE utf8_unicode_ci DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Avatar for play to view in their profile' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `player_avatar`
--

INSERT INTO `player_avatar` (`id`, `name`, `avatar_url`) VALUES
(1, 'Boy Hero', 'http://www.heroforzero.be/assets/img/player/boy_hero@2x.png'),
(2, 'Girl Hero', 'http://www.heroforzero.be/assets/img/player/girl_hero@2x.png');

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
  `Value` int(11) DEFAULT '0',
  `VirtualQuestId` int(11) DEFAULT NULL,
  `ObjectId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=753 ;

--
-- Dumping data for table `questcondition`
--

INSERT INTO `questcondition` (`Id`, `Type`, `Value`, `VirtualQuestId`, `ObjectId`) VALUES
(693, 0, 20, 17, 6),
(717, 0, 10, 2, 1),
(718, 1, 0, 2, 26),
(724, 0, 20, 4, 8),
(725, 0, 20, 5, 8),
(726, 1, 0, 5, 1),
(727, 1, 0, 5, 1),
(728, 1, 0, 5, 1),
(733, 0, 20, 13, 5),
(734, 0, 20, 14, 5),
(735, 0, 20, 15, 5),
(736, 0, 40, 6, 8),
(737, 1, 0, 6, 1),
(738, 1, 0, 6, 1),
(739, 1, 0, 6, 1),
(740, 0, 20, 7, 7),
(741, 0, 20, 8, 7),
(742, 0, 20, 9, 7),
(743, 2, 0, 9, 21),
(744, 2, 0, 9, 19),
(745, 0, 20, 10, 6),
(746, 1, 0, 10, 17),
(747, 2, 0, 10, 12),
(748, 2, 0, 10, 22),
(749, 0, 20, 11, 6),
(750, 0, 20, 12, 6),
(751, 0, 10, 1, 9),
(752, 0, 20, 3, 1);

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
  `BonusPoint` int(11) DEFAULT '1',
  `CorrectChoiceId` int(11) DEFAULT NULL,
  `SharingInfo` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LearnMoreURL` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ImageURL` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IsApproved` bit(1) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=492 ;

--
-- Dumping data for table `quiz`
--

INSERT INTO `quiz` (`Id`, `CategoryId`, `PartnerId`, `CreatedDate`, `Content`, `BonusPoint`, `CorrectChoiceId`, `SharingInfo`, `LearnMoreURL`, `ImageURL`, `IsApproved`) VALUES
(69, 6, 5, '2014-08-28 09:01:02', 'What should you do in Vietnam if you see a child in situation where he/she looks like he/she needs help from an aggressor?', 1, 176, 'Help hotlines in Vietnam  are 113 or 18001567.', '', '', b'1'),
(70, 6, 5, '2014-07-07 05:16:25', 'Who is responsible for of the protection of children?', 1, 181, 'The family carries the main responsibility for its children. However, governmental institutions like schools or hospitals should pay attention to children''s well-being. Furthermore the society should protect its youngest members.  ', '', NULL, b'1'),
(71, 6, 5, '2014-07-07 05:14:30', 'Which group of children is most vulnerable to abuse?', 1, 185, '', 'http://www.unicef.org/vietnam/protection.html', NULL, b'1'),
(72, 6, 5, '2014-08-28 08:37:44', 'If children are being abused to whom should they report?', 1, 187, '', '', '', b'1'),
(81, 6, 19, '2014-11-28 16:52:23', 'According to the Vietnamese Law on Protection, Care ad Education of children , what age is considered a child?', 1, 224, '', 'http://www.unicef.org/vietnam/protection.html', '', b'1'),
(82, 6, 19, '2014-07-07 05:08:56', 'When you see something wrong happening in a shelter, to whom should you report it?', 1, 229, '', '', '', b'1'),
(84, 7, 20, '2014-07-03 04:17:35', 'How many different types of schools does the Vietnamese school system consist of? ', 1, 236, 'The Vietnamese school system consists of four different types of school: Preschool, Primary School, Secondary School, High School. ', 'http://vietnam.angloinfo.com/family/schooling-education/school-system/', '', b'1'),
(85, 1, 22, '2014-07-07 05:06:32', 'Which group of children can be found in Buddhist Pagoda Shelters? ', 1, 241, 'Some Buddhist communities in Vietnam offer orphanages, schools or other kinds of shelter to underprivileged children. ', '', '', b'1'),
(88, 6, 22, '2014-07-10 06:23:39', 'Children found at pagodas fall into what category?', 1, 253, '', '', '', b'1'),
(91, 5, 24, '2014-07-10 06:25:08', 'What’s the average life expectancy in Vietnam?', 1, 263, '', '', '', b'1'),
(92, 5, 24, '2014-10-27 05:31:46', 'In Vietnam, Malaria is still a serious problem. What helps prevent this disease?\n', 1, 268, 'Combating malaria is one of the country''s Millenium Development Goals, set by the United Nations.', 'http://www.unicef.org/vietnam/overview_20392.html', '', b'1'),
(93, 5, 24, '2014-10-27 05:31:23', 'How many people in Vietnam die each year from AIDS?\n', 1, 271, 'Around 100,000 Vietnamese are infected with HIV annually. In around 15,000 cases HIV becomes AIDS, and around 10,000 people die each year.', 'http://www.unaids.org.vn/index.php?option=com_content&view=category&layout=blog&id=13&Itemid=27&lang=en', '', b'1'),
(94, 5, 24, '2014-07-07 05:05:18', 'Which of these Institution does NOT deal with health care?\n', 1, 277, 'The North Atlantic Treaty Organization (NATO) is a military alliance which operates mostly in Euorpe and North America. ', 'http://www.google.com.vn/url?sa=t&rct=j&q=&esrc=s&source=web&cd=17&cad=rja&uact=8&ved=0CFkQFjAQ&url=http%3A%2F%2Fwww.nato.int%2Fnato-welcome%2F&ei=CBGYU--9H5Dh8AWRmoKADg&usg=AFQjCNFueu0iKzsuTxyccNxPfg', '', b'1'),
(95, 5, 24, '2014-07-15 05:02:25', 'What are the main causes of death for Vietnamese children under 5 years?\n', 1, 280, '', '', '', b'1'),
(96, 1, 24, '2014-07-15 05:00:24', 'What is the annual birth rate per 1.000 people in Vietnam?\n', 1, 284, '', '', '', b'1'),
(97, 5, 24, '2014-08-28 08:07:35', 'What is the main reason Vietnamese do not go to a hospital when ill?\n', 1, 289, '', '', '', b'1'),
(98, 5, 24, '2014-09-16 03:43:48', 'What is the main issue with Vietnamese medications?\n', 1, 293, '', '', '', b'1'),
(99, 5, 24, '2014-07-15 04:56:30', 'Why do some doctors prefer to work in private hospitals rather than public hospitals?', 1, 295, '', '', '', b'1'),
(100, 5, 24, '2014-07-15 04:55:37', 'How many public hospitals are located in Vietnam’s capital Hanoi?\n', 1, 300, '', '', '', b'1'),
(101, 5, 24, '2014-07-15 04:55:06', 'What does the Vietnamese health system look like?\n', 1, 304, '', '', '', b'1'),
(102, 5, 24, '2014-10-27 05:28:07', 'Which of these areas in Vietnam are supposed to be Malaria free?\n', 1, 309, '', '', '', b'1'),
(103, 5, 24, '2014-08-28 08:54:56', 'How can you protect your skin from intense sun exposure?', 1, 310, '', '', '', b'1'),
(104, 1, 24, '2014-07-15 04:52:26', 'What can you do to avoid traffic accidents?', 1, 317, '', '', '', b'1'),
(105, 1, 24, '2014-10-27 05:31:08', 'Which of these vaccines is not obligatory for travelers to Vietnam?', 1, 320, '', '', '', b'1'),
(106, 5, 24, '2014-07-15 04:51:15', 'What are the health problems most travelers have to deal with in Vietnam?', 1, 325, '', '', '', b'1'),
(107, 5, 24, '2014-07-15 04:50:40', 'How can you prevent bug bites?', 1, 326, '', '', '', b'1'),
(108, 5, 24, '2014-07-15 04:50:01', 'How can gastrointestinal illness be avoided while traveling?', 1, 332, '', '', '', b'1'),
(109, 5, 24, '2014-07-15 04:46:45', 'What does a good travel health kit NOT include?', 1, 336, '', '', '', b'1'),
(110, 5, 24, '2014-07-15 04:43:07', 'What negative affects can malnutrition have?', 1, 341, '', '', '', b'1'),
(111, 1, 24, '2014-07-15 04:34:27', 'What is the median age of Vietnamese?', 1, 342, '', '', '', b'1'),
(112, 5, 24, '2014-07-15 04:33:56', 'What is the fertility rate per woman in VN?\n', 1, 346, '', '', '', b'1'),
(113, 5, 24, '2014-07-15 04:29:36', 'What percentage of Vietnamese DO NOT have access to clean drinking water?', 1, 350, '', '', '', b'1'),
(114, 5, 24, '2014-07-15 04:28:08', 'What percentage of Vietnamese DO NOT have access to improved sanitation facilities?', 1, 357, '', '', '', b'1'),
(115, 5, 24, '2014-07-15 04:25:42', 'Which hospital is one of two public children''s hospitals in HCMC?\n', 1, 358, '', '', '', b'1'),
(116, 5, 24, '2014-07-15 04:24:51', 'What is correct about the Ho Chi Minh Ung Buou Cancer Hospital?', 1, 364, '', '', '', b'1'),
(117, 5, 24, '2014-07-15 04:20:44', 'Where is the Ho Chi Minh Ung Buou Cancer Hospital?', 1, 366, '', '', '', b'1'),
(119, 6, 24, '2014-07-15 04:20:02', 'When you see something wrong happening in a shelter, to whom should you report?', 1, 377, '', '', '', b'1'),
(121, 6, 24, '2014-09-16 03:18:37', 'If they are being abused, what should children do?\n', 1, 385, '', '', '', b'1'),
(122, 6, 24, '2014-07-15 03:46:25', 'What could reduce the youth crime rate in Vietnam?', 1, 389, '', '', '', b'1'),
(123, 1, 24, '2014-09-16 03:20:55', 'What legal system prevails in VN?\n', 1, 390, '', '', '', b'1'),
(124, 1, 24, '2014-07-15 03:35:04', 'What is the legal voting age in Vietnam?', 1, 395, '', '', '', b'1'),
(125, 1, 24, '2014-07-15 03:33:36', 'How often are Vietnamese government elections held?\n', 1, 400, '', '', '', b'1'),
(126, 1, 24, '2014-07-15 03:29:59', 'What are the most common crimes tourists have to deal with while traveling in VN?\n', 1, 402, '', '', '', b'1'),
(127, 6, 24, '2014-07-15 03:29:18', 'What is the name of the main police and security force in VN?\n', 1, 407, '', '', '', b'1'),
(128, 1, 24, '2014-07-15 03:28:14', 'What color are the VN police uniforms?\n', 1, 413, '', '', '', b'1'),
(129, 1, 24, '2014-07-15 03:27:08', 'How many traffic accident related deaths does VN count per year?', 1, 417, '', '', '', b'1'),
(130, 6, 24, '2014-09-16 03:23:24', 'Where are the main destinations of trafficked Vietnamese?', 1, 420, '', '', '', b'1'),
(131, 6, 24, '2014-07-15 03:24:20', 'What are Vietnamese women, children and newborn babies trafficked for?\n', 1, 425, '', '', '', b'1'),
(132, 6, 24, '2014-07-15 03:11:22', 'What percent of Vietnamese trafficking victims are children? (according to UK’s National Referral Mechanism record)', 1, 428, '', '', '', b'1'),
(133, 6, 24, '2014-07-15 03:10:48', 'Why are girls easily trafficked?', 1, 433, '', '', '', b'1'),
(134, 6, 24, '2014-09-16 03:22:36', 'How do sex traffickers recruit victims?', 1, 437, '', '', '', b'1'),
(135, 6, 24, '2014-07-15 03:06:46', 'From what age does Vietnamese law prohibit the employment of children?\n', 1, 438, '', '', '', b'1'),
(136, 6, 24, '2014-08-28 09:00:27', 'What is the typical job of a child laborer?', 1, 445, 'The International Labour Organisation (ILO) defines child labour as "work that deprives children of their childhood, their potential and their dignity, and that is harmful to physical and mental development." ', 'http://www.ilo.org/ipec/facts/lang--en/index.htm', '', b'1'),
(137, 6, 24, '2014-07-15 03:06:22', 'What percent of child laborers in manufacturing factories are under the age of 15?\n', 1, 449, '', '', '', b'1'),
(138, 6, 24, '2014-09-16 03:21:14', 'How is the working environment in manufacturing factories?\n', 1, 453, '', '', '', b'1'),
(139, 6, 24, '2014-07-07 04:54:33', 'According to a Human Rights Watch Report on Street Children in Vietnam published in 2006, how many street children were living in Vietnam?', 1, 455, 'In Vietnam street children are called "bui doi", which means "Children of the Dust". In 2006, Human Rights Watch published a report on the situation of "bui doi" throughout the whole country. ', 'http://www.hrw.org/reports/2006/vietnam1106/2.htm', '', b'1'),
(140, 6, 24, '2014-07-15 03:04:55', 'What is the main cause of street children in Vietnam?', 1, 461, '', '', '', b'1'),
(141, 1, 24, '2014-07-07 04:58:21', 'How many SOS Children’s Villages are there  in Vietnam?\n', 1, 463, 'In 2014, there are thirteen SOS Children''s Villages, ten SOS Youth Facilities, eleven SOS Hermann Gmeiner Schools, twelve SOS Kindergartens, two SOS Vocational Training Centres, five SOS Social Centres and one SOS Medical Centre. ', 'http://www.sos-childrensvillages.org/where-we-help/asia/vietnam', '', b'1'),
(142, 6, 24, '2014-09-16 03:47:01', 'What is the function of SOS children’s villages in Vietnam?\n', 1, 466, '', '', '', b'1'),
(143, 1, 24, '2014-07-07 04:59:37', 'When was SOS Children’s Villages Vietnam established?\n', 1, 470, 'In Vietnam, SOS Children''s Villages started in 1967. However,  nine years of hard work they had to stop their services. In 1987 they were finally able to continue their activities.', 'http://www.sos-childrensvillages.org/where-we-help/asia/vietnam', '', b'1'),
(144, 6, 24, '2014-11-20 09:02:21', 'How many children does a "mother” take care of in SOS village?\n', 1, 475, 'The SOS mother builds a close relationship with every child entrusted to her, and provides security, love and  stability for each child.', 'http://www.sos-childrensvillages.org/getmedia/57e18754-f07c-45e6-b9a3-176359847fbc/SOS-CV-MissionStatement-EN.pdf?ext=.pdf', '', b'1'),
(145, 1, 24, '2014-07-07 05:01:14', 'How many SOS Children''s Villages are located in Vietnam (2014)?', 1, 479, 'SOS Children''s Villages help children who are orphaned, neglected or abandoned. Their goal is to integrate children in need into a family. In Vietnam SOS Children''s  Villages began in 1967. ', 'http://www.sos-childrensvillages.org/where-we-help/asia/vietnam', '', b'1'),
(146, 7, 24, '2014-08-25 03:23:00', 'What are the main education goals in Vietnam?\n', 1, 482, '', '', '', b'1'),
(147, 7, 24, '2014-07-13 12:58:11', 'How old are Vietnamese children when they enter primary school?', 1, 486, '', '', '', b'1'),
(148, 7, 24, '2014-07-15 02:43:42', 'Which is NOT a school subject in Vietnam?\n', 1, 492, '', '', '', b'1'),
(149, 7, 24, '2014-07-15 02:44:17', 'Which teaching method is practiced in VN universities?\n', 1, 496, '', '', '', b'1'),
(150, 7, 24, '2014-07-15 02:45:50', 'What are the three most popular foreign countries for Vietnamese to study abroad?\n', 1, 498, '', '', '', b'1'),
(151, 7, 24, '2014-09-16 03:26:34', 'What are the main reasons Vietnamese drop out of school?\n', 1, 505, '', '', '', b'1'),
(152, 7, 24, '2014-07-15 02:47:53', 'What is the most popular foreign language taught in Vietnamese schools?\n', 1, 508, '', '', '', b'1'),
(153, 7, 24, '2014-07-15 02:49:32', 'What is the illiteracy rate among Vietnamese 15 years and older?', 1, 510, '', '', '', b'1'),
(154, 1, 24, '2014-09-16 03:50:39', 'What form of state prevails in VN?\n', 1, 517, '', '', '', b'1'),
(155, 1, 24, '2014-07-15 02:50:28', 'What is the predominant religion in Vietnam?\n', 1, 521, '', '', '', b'1'),
(156, 5, 24, '2014-07-15 02:51:10', 'What’s the average age at first birth of Vietnamese women?\n', 1, 522, '', '', '', b'1'),
(157, 7, 24, '2014-08-28 08:30:10', 'What are the Vietnamese government’s education expenditures?\n', 1, 527, '', '', '', b'1'),
(158, 6, 24, '2014-08-28 08:30:27', 'How many Vietnamese children (5-14 years) are working?\n', 1, 531, '', '', '', b'1'),
(159, 7, 24, '2014-07-15 02:54:02', 'What is the test that enables Vietnamese students to attend Colleges and Universities?\n', 1, 535, '', '', '', b'1'),
(160, 7, 24, '2014-07-15 02:54:34', 'What is the estimated ratio between government and private kindergartens?', 1, 538, '', '', '', b'1'),
(161, 7, 24, '2014-07-13 12:41:12', 'What  school levels are compulsory in VN?\n', 1, 542, '', '', '', b'1'),
(162, 7, 24, '2014-08-28 08:31:46', 'What is NOT a benefit of school uniforms?\n', 1, 548, '', '', '', b'1'),
(163, 7, 24, '2014-07-11 09:52:23', 'How many years is formal Vietnamese education?\n', 1, 552, '', '', '', b'1'),
(164, 7, 24, '2014-07-10 06:21:00', 'How many subjects are on the National High Graduation Examination?', 1, 556, '', '', '', b'1'),
(165, 7, 24, '2014-08-28 07:58:18', 'What does the Vietnamese education system lack?\n', 1, 559, '', '', '', b'1'),
(166, 7, 24, '2014-09-16 03:27:32', 'How are Vietnamese students expected to act in class?', 1, 562, '', '', '', b'1'),
(167, 7, 24, '2014-07-10 06:15:02', 'What is the average monthly salary of local Vietnamese public teachers?\n', 1, 566, '', '', '', b'1'),
(168, 7, 24, '2014-09-16 03:28:29', 'What can a teacher do to earn more money to make his/her living besides a monthly salary?\n', 1, 573, '', '', '', b'1'),
(169, 7, 24, '2014-08-28 08:32:12', 'How many basic groups can the students choose to take for their university entrance exams?', 1, 575, '', '', '', b'1'),
(170, 7, 24, '2014-07-10 05:47:12', 'Which fixed subjects are included in the National High Graduation Examination?\n', 1, 578, '', '', '', b'1'),
(171, 7, 24, '2014-08-28 08:32:46', 'When is the National High Graduation Examination held?\n', 1, 583, '', '', '', b'1'),
(172, 7, 24, '2014-07-10 05:45:31', 'When is Vietnamese Teacher’s Day?\n', 1, 588, '', '', '', b'1'),
(173, 7, 24, '2014-09-16 03:51:25', 'What do students usually do on Teacher’s day?\n', 1, 593, '', '', '', b'1'),
(174, 7, 24, '2014-07-10 05:33:39', 'According to the World Bank, in 2010 what was the gross enrollment rate at upper-secondary schools in Vietnam?', 1, 594, '', '', '', b'1'),
(175, 7, 24, '2014-07-10 05:26:46', 'When is the Vietnamese University entrance examination held?\n', 1, 600, '', '', '', b'1'),
(177, 7, 24, '2014-08-28 08:33:38', 'If they want to enter the University of Technology in HCM, what subjects must students take exams in?', 1, 606, '', '', '', b'1'),
(178, 7, 24, '2014-07-10 05:10:40', 'What subjects does group A consist of?', 1, 610, '', '', '', b'1'),
(179, 5, 24, '2014-08-28 08:34:00', 'What are the main health problems Vietnamese children deal with today?', 1, 617, '', '', '', b'1'),
(180, 7, 24, '2014-07-10 05:08:55', 'When did Vietnam’s Ministry of Education and Training start to use the multiple choice exam format for the entrance exam for several subject', 1, 618, '', '', '', b'1'),
(181, 7, 24, '2014-07-10 05:07:54', 'How high are the average annual university fees in VN?\n', 1, 624, '', '', '', b'1'),
(182, 8, 24, '2014-08-28 08:33:00', 'How many children under the age of 5 suffer from malnutrition?', 1, 628, '', '', '', b'1'),
(183, 7, 24, '2014-09-16 03:31:19', 'What is the definition of literacy?', 1, 630, '', '', '', b'1'),
(184, 7, 24, '2014-07-10 05:04:44', 'What is Vietnam’s average pupil:teacher ratio?\n', 1, 636, '', '', '', b'1'),
(185, 8, 24, '2014-07-10 05:02:24', 'What are possible symptoms of chronic malnutrition?', 1, 641, '', '', '', b'1'),
(186, 8, 24, '2014-07-13 13:20:49', 'Which areas of VN suffer the most from malnutrition?', 1, 642, '', '', '', b'1'),
(187, 7, 24, '2014-09-16 03:33:38', 'What are the main educational barriers for VN children?', 1, 649, '', '', '', b'1'),
(188, 8, 24, '2014-07-10 04:59:42', 'How can malnutrition be avoided?', 1, 653, '', '', '', b'1'),
(189, 7, 24, '2014-08-28 08:36:05', 'What is a traditional Vietnamese value in education?', 1, 655, '', '', '', b'1'),
(190, 8, 24, '2014-07-10 04:56:52', 'Which food intolerance do most Asians and Africans suffer from?', 1, 659, '', '', '', b'1'),
(191, 7, 24, '2014-07-10 04:55:06', 'Which English skills do Vietnamese schools focus on?\n', 1, 662, '', '', '', b'1'),
(192, 8, 24, '2014-07-10 04:54:33', 'What parts of the world have the highest malnutrition rates?', 1, 668, '', '', '', b'1'),
(193, 7, 24, '2014-07-10 04:54:07', 'What percent of children in rural areas do not continue education after they reach age of 14?', 1, 671, '', '', '', b'1'),
(194, 7, 24, '2014-08-28 08:36:31', 'When do students take vacation?', 1, 674, '', '', '', b'1'),
(196, 1, 24, '2014-07-10 04:51:55', 'Where do Vietnamese civil weddings take place?', 1, 685, '', '', '', b'1'),
(197, 1, 24, '2014-10-29 04:37:36', 'What’s the minimum age a Vietnamese man can get married?', 1, 689, 'A Vietnamese female can legally get married at 18. A Vietnamese male must be 20 or older to legally get married. ', '', '', b'1'),
(198, 1, 24, '2014-07-10 04:48:05', 'How high is the NEW international poverty line determined by the World Bank?', 1, 692, '', '', '', b'1'),
(199, 1, 24, '2014-07-10 04:46:05', 'Which one is NOT a UN Millennium Development Goal?', 1, 697, '', '', '', b'1'),
(200, 1, 24, '2014-07-10 04:47:05', 'What does the Human Development Index measure?', 1, 698, '', '', '', b'1'),
(201, 1, 24, '2014-07-10 04:42:22', 'What is VN’s biggest city?', 1, 703, '', '', '', b'1'),
(202, 1, 24, '2014-07-10 04:41:12', 'What are VN’s main export goods?', 1, 709, '', '', '', b'1'),
(204, 1, 24, '2014-09-16 03:37:45', 'What do children usually do during the Tet holiday?', 1, 717, '', '', '', b'1'),
(205, 1, 24, '2014-07-10 04:35:57', 'What traditional values are children taught in their families?', 1, 721, '', '', '', b'1'),
(206, 7, 24, '2014-08-28 09:01:27', 'Why do Vietnamese parents encourage their children study and excel in their education?', 1, 725, '', '', '', b'1'),
(208, 1, 24, '2014-07-10 04:33:10', 'What are children expected to do when their parents grow old?', 1, 733, '', '', '', b'1'),
(209, 1, 24, '2014-07-10 04:32:11', 'What is VN’s largest city?', 1, 735, '', '', '', b'1'),
(210, 1, 24, '2014-07-10 04:37:28', 'Which country has a population greater than 1 billion? ', 1, 740, '', '', '', b'1'),
(212, 1, 24, '2014-08-28 08:52:16', 'What is the Tet holiday?', 1, 746, '', '', '', b'1'),
(213, 1, 24, '2014-08-28 08:53:14', 'What do children usually do during the Tet holiday?', 1, 750, '', '', '', b'1'),
(214, 1, 24, '2014-07-07 05:29:28', 'What are traditional values children are taught in their families?', 1, 757, '', '', '', b'1'),
(215, 1, 24, '2014-09-16 03:41:44', 'What are parents allowed to do when children are disobedient?', 1, 758, '', '', '', b'1'),
(217, 1, 24, '2014-09-16 03:35:47', ' What is the traditional role of the wife in the family?', 1, 769, '', '', '', b'1'),
(218, 1, 24, '2014-08-28 09:02:14', 'Which is a traditional Vietnamese game?', 1, 770, '', '', '', b'1'),
(219, 9, 6, '2014-10-29 04:33:18', 'What is the mission of the HEROforZERO app?', 1, 775, 'In collaboration with UNICEF Vietnam, HEROforZERO aims to help reduce the number of children dying preventable deaths to ZERO. ', 'http://www.unicef.org/vietnam/', '', b'1'),
(221, 9, 6, '2014-10-29 03:42:24', 'What is the total number of virtual children under 5 that must be saved in the HEROforZERO app?', 1, 784, 'It is estimated that in Vietnam there are 7,000,000 under 5 years old in need of health care, nutritious food, protection, and education. ', '', '', b'1'),
(223, 1, 6, '2014-10-29 03:44:03', 'In the HEROforZERO app, how do you earn points? ', 1, 793, 'There are still many more ways to earn points. Some of these include: sign up for a newsletter, like a facebook page and donate your time. ', '', '', b'1'),
(224, 9, 6, '2014-10-29 04:25:22', 'In the HEROforZERO app what happens after we reach Zero virtual children in need?', 1, 795, 'The mission of the game is to work together as a global group of people and organizations to help children. ', '', '', b'1'),
(225, 9, 6, '2014-10-29 04:26:08', 'During a quiz in the HEROforZERO app what does the image below mean?', 1, 798, 'During the quiz game if you have lost a heart you can recover it by hitting the heart icon in the middle. This will help you to stay alive longer.', '', 'http://heroforzero.be/assets/uploads/1bab4b074975dc2b23788620610c8e63.png', b'1'),
(226, 9, 6, '2014-10-29 04:26:25', 'During a quiz in HEROforZERO, what does the image below mean?', 1, 803, 'During the quiz game if you need more time you can slow down the enemy by hitting the stop watch icon in the middle. This will help you to stay alive longer.', '', 'http://heroforzero.be/assets/uploads/78910cc38354c492c52329c09b420d10.png', b'1'),
(227, 9, 6, '2014-10-29 04:23:40', 'During a quiz in the HEROforZERO app, what does the image below mean?', 1, 807, 'During the quiz game if you don''t know the answer to a question you can skip it by hitting this icon and you won''t be penalized.', '', 'http://heroforzero.be/assets/uploads/49c5c38135d580727e85dbdd1871eb44.png', b'1'),
(228, 9, 6, '2014-10-29 03:45:15', 'In the HEROforZERO app, how do you access the user''s profile?', 1, 810, 'The user''s profile is located on the left side with the Facebook photo of the user and a blue arrow. If the user taps the photo, she will be taken to a list of other functions she can perform such as ranking, awards and settings.', '', '', b'1'),
(229, 5, 27, '2014-10-27 05:39:47', 'How many people at living with HIV/AIDS in Vietnam? (2012)', 1, 815, '', 'UNAIDS.org', '', b'1'),
(230, 5, 27, '2014-10-27 05:40:02', 'Which is not a way to transmit HIV?', 1, 821, '', 'UNAIDS.org', '', b'1'),
(231, 5, 27, '2014-10-27 05:40:16', 'How many people worldwide are currently living with HIV/ADS?', 1, 823, '', 'UNAIDS.org', '', b'1'),
(232, 5, 27, '2014-10-27 05:32:56', 'What are ways to prevent HIV transmission?', 1, 829, '', 'http://www.cdc.gov/hiv/basics/index.html', '', b'1'),
(233, 5, 27, '2014-10-27 05:33:39', 'What percent risk is there that a pregnant woman will pass HIV to her baby? ', 1, 831, '', 'http://www.cdc.gov/hiv/basics/index.html', '', b'1'),
(234, 5, 27, '2014-10-27 05:40:31', 'How can a pregnant woman prevent passing HIV to her baby?\n', 1, 837, '', '', '', b'1'),
(235, 5, 27, '2014-10-27 05:40:47', 'If pregnant women receive the appropriate treatment what chance is there that they will pass HIV to their babies?', 1, 838, '', '', '', b'1'),
(236, 5, 27, '2014-10-27 05:40:59', 'What does HIV stand for?', 1, 843, '', 'http://www.cdc.gov/hiv/basics/index.html', '', b'1'),
(237, 5, 27, '2014-10-27 05:34:08', 'What does AIDS stand for?', 1, 849, '', 'http://www.cdc.gov/hiv/basics/index.html', '', b'1'),
(238, 8, 27, '2014-07-15 05:19:24', 'What percent of children were severely to moderately underweight in Vietnam in 2008-2012?', 1, 852, '', 'http://www.unicef.org/vietnam/overview.html', '', b'1'),
(240, 14, 27, '2014-07-15 10:33:07', 'What percent of rice crops in the Mekong Delta could be lost due to a 30 centimeter rise in sea level?', 1, 861, 'The	 Asian	Development	Bank	(ADB)	estimates	that	the	number	of	people	living	in	cities	in	Asia	at	risk	 of coastal	flooding	will	 increase	from	300	to	410	million	by	2025.	A	30	centimetre	sea	level	rise 	in	Vietnam’s	\nMekong	Delta,	a	global	rice	producing	area,	could	see	the	loss	of	around	11%	of	crop	production	and	 subsequent	rises	in	food	prices.	\n', 'http://plan-international.org/files/Asia/publications/act-to-adapt', '', b'1'),
(241, 7, 27, '2014-07-15 07:16:54', 'Upon the request of the Vietnamese Ministry of Education, how many teachers were trained in climate change education material?', 1, 862, 'These include teacher manuals and student books, cartoons and animation films,	and	games. The materials have been widely adopted by governments and other	organisations.	For	example, upon request of the Vietnamese Ministry of Education, over 380 teachers from almost 250 schools were trained on the climate change education material using explorative teaching methods.	\n', 'http://plan-international.org/files/Asia/publications/act-to-adapt', '', b'1'),
(242, 14, 27, '2014-07-15 07:25:17', 'In which Vietnamese province will “Climate Change Communicators”-- a group of trained children-- train other children in climate change?', 1, 866, 'In Quang Tri province in Vietnam, ‘Climate Change Communicators’ – a group	 of trained	children – will	lead and train other children on climate change adaptation and mitigation through games and films and other communication activities.', 'http://plan-international.org/files/Asia/publications/act-to-adapt', '', b'1'),
(243, 14, 27, '2014-08-28 08:03:51', 'What type of child-centered adaptation projects received seed grants?\n', 1, 873, '', '', '', b'1'),
(244, 1, 27, '2014-09-16 03:10:40', 'What is the website: thehexanh.net?', 1, 875, 'http://www.thehexanh.net/index.asp?lang=1', 'http://plan-international.org/files/Asia/publications/act-to-adapt', '', b'1'),
(245, 8, 27, '2014-07-15 07:19:32', 'What percentage of Vietnamese children suffer from stunting (2008-2012)?', 1, 878, '', 'http://www.unicef.org/vietnam/overview.html', '', b'1'),
(246, 5, 27, '2014-10-27 05:34:35', 'What percentage of children in Vietnam have had a polio vaccine?', 1, 885, '', 'http://www.unicef.org/vietnam/overview.html', '', b'1'),
(247, 5, 27, '2014-10-27 05:41:11', 'What is the prevalence of HIV among 15-24 year olds in Vietnam?', 1, 886, '', 'http://www.unicef.org/vietnam/overview.html', '', b'1'),
(248, 7, 27, '2014-07-15 07:14:21', 'What is the literacy rate of youth (15-24 year olds) in Vietnam?', 1, 893, '', 'http://www.unicef.org/vietnam/overview.html', '', b'1'),
(249, 5, 27, '2014-10-27 05:35:03', 'What are ways other than a mosquito bite to catch malaria?', 1, 897, 'Because the parasites that cause malaria affect red blood cells, people can also catch malaria from exposures to infected blood, including:\n\nFrom mother to unborn child\nThrough blood transfusions\nBy sharing needles used to inject drugs', 'http://www.mayoclinic.org/diseases-conditions/malaria/basics/causes/con-20013734', '', b'1'),
(250, 5, 27, '2014-10-27 05:35:23', 'Malaria is a parasite that lives in your........?', 1, 899, '', 'http://www.mayoclinic.org/diseases-conditions/malaria/basics/causes/con-20013734', '', b'1'),
(251, 5, 27, '2014-10-27 05:35:48', 'For which of these diseases is there not a vaccine?', 1, 902, 'Scientists around the world are trying to develop a safe and effective vaccine for malaria. As of yet, however, there is still no malaria vaccine approved for human use.', 'http://www.mayoclinic.org/diseases-conditions/malaria/basics/prevention/con-20013734', '', b'1'),
(252, 5, 27, '2014-10-27 05:36:14', 'How can you prevent the spread of malaria?', 1, 908, 'In countries where malaria is common, prevention also involves keeping mosquitoes away from humans. Strategies include:\nSpraying your home. Treating your home''s walls with insecticide can help kill adult mosquitoes that come inside.\nSleeping under a net. Bed nets, particularly those treated with insecticide, are especially recommended for pregnant women and young children.\nCovering your skin. During active mosquito times, usually from dusk to dawn, wear pants and long-sleeved shirts.\nSpraying clothing and skin. Sprays containing permethrin are safe to use on clothing, while sprays containing DEET can be used on skin.', 'http://www.mayoclinic.org/diseases-conditions/malaria/basics/prevention/con-20013734', '', b'1'),
(253, 5, 27, '2014-10-27 05:36:50', 'What is a growing problem in malaria treatment?', 1, 910, 'The history of antimalarial medicine has been marked by a constant struggle between evolving drug-resistant parasites and the search for new drug formulations. In many parts of the world, for instance, resistance to chloroquine has rendered the drug ineffective.', 'http://www.mayoclinic.org/diseases-conditions/malaria/basics/treatment/con-20013734', '', b'1'),
(254, 5, 27, '2014-10-27 05:37:08', 'What characteristics determine the treatment of malaria?', 1, 917, 'The types of drugs and the length of treatment will vary, depending on:\n\nWhich type of malaria parasite you have\nThe severity of your symptoms\nYour age\nWhether you''re pregnant', 'http://www.mayoclinic.org/diseases-conditions/malaria/basics/treatment/con-20013734', '', b'1'),
(255, 5, 27, '2014-10-27 05:43:02', 'Malaria can be fatal. What complications usually cause death?', 1, 921, 'In most cases, malaria deaths are related to one or more of these serious complications:\n\nCerebral malaria. If parasite-filled blood cells block small blood vessels to your brain (cerebral malaria), swelling of your brain or brain damage may occur. Cerebral malaria may cause coma.\nBreathing problems. Accumulated fluid in your lungs (pulmonary edema) can make it difficult to breathe.\nOrgan failure. Malaria can cause your kidneys or liver to fail, or your spleen to rupture. Any of these conditions can be life-threatening.\nSevere anemia. Malaria damages red blood cells, which can result in severe anemia.\nLow blood sugar. Severe forms of malaria itself can cause low blood sugar, as can quinine — one of the most common medications used to combat malaria. Very low blood sugar can result in coma or death.', 'http://www.mayoclinic.org/diseases-conditions/malaria/basics/complications/con-20013734', '', b'1'),
(256, 5, 27, '2014-10-27 05:42:46', 'Which statement about polio is true?', 1, 923, 'Although polio can cause paralysis and death, the vast majority of people who are infected with the poliovirus don''t become sick and are never aware they''ve been infected with polio.', 'http://www.mayoclinic.org/diseases-conditions/polio/basics/symptoms/con-20030957', '', b'1'),
(257, 5, 27, '2014-10-27 05:42:30', 'Which isn''t a symptom of polio?', 1, 929, 'Post-polio syndrome is a cluster of disabling signs and symptoms that affect some people several years — an average of 35 years — after they had polio. Common signs and symptoms include:\n\nProgressive muscle or joint weakness and pain\nGeneral fatigue and exhaustion after minimal activity\nMuscle atrophy\nBreathing or swallowing problems\nSleep-related breathing disorders, such as sleep apnea\nDecreased tolerance of cold temperatures\nCognitive problems, such as concentration and memory difficulties\nDepression or mood swings', 'http://www.mayoclinic.org/diseases-conditions/polio/basics/symptoms/con-20030957', '', b'1'),
(258, 5, 27, '2014-10-27 05:41:52', 'How long can malaria remain dormant (no symptom) in the human body?', 1, 933, 'For most people, symptoms begin 10 days to 4 weeks after infection, although a person may feel ill as early as 7 days or as late as 1 year later. Two kinds of malaria, P. vivax and P. ovale, can occur again (relapsing malaria). In P. vivax and P. ovale infections, some parasites can remain dormant in the liver for several months up to about 4 years after a person is bitten by an infected mosquito.', 'http://www.cdc.gov/malaria/about/faqs.html', '', b'1'),
(259, 5, 27, '2014-10-27 05:41:40', 'What are the signs and symptoms of measles?', 1, 937, 'Measles signs and symptoms appear 10 to 14 days after exposure to the virus. Signs and symptoms of measles typically include:\n\nFever\nDry cough\nRunny nose\nSore throat\nInflamed eyes (conjunctivitis)\nTiny white spots with bluish-white centers on a red background found inside the mouth on the inner lining of the cheek — also called Koplik''s spots\nA skin rash made up of large, flat blotches that often flow into one another.', 'http://www.mayoclinic.org/diseases-conditions/measles/basics/symptoms/con-20019675', '', b'1'),
(260, 5, 27, '2014-10-27 05:41:23', 'What treatment can get rid of an established measles infection?', 1, 938, 'No treatment can get rid of an established measles infection. However, some measures can be taken to protect vulnerable individuals who have been exposed to the virus.', 'http://www.mayoclinic.org/diseases-conditions/measles/basics/treatment/con-20019675', '', b'1'),
(261, 9, 27, '2014-10-29 03:47:21', 'What is the mission of HEROforZERO?', 1, 943, 'In collaboration with UNICEF Vietnam, HEROforZERO aims to help reduce the number of children dying of preventable causes to 0. \n', 'http://www.unicef.org/vietnam/', '', b'1'),
(262, 9, 27, '2014-10-29 03:51:47', 'Who has HEROforZERO worked in collaboration with to accomplish it’s mission?', 1, 947, 'HEROforZERO is  supported by UNICEF but depends on the collaboration of many NGOS, Non-profits and You to accomplish its mission.\n', '', '', b'1'),
(264, 9, 27, '2014-10-29 03:54:08', 'In the HEROforZERO app, how can you save a virtual child?', 1, 954, 'In the HEROforZERO app to save a child you must complete a quest in one of several categories, such as health, protection or nutrition. \n', '', '', b'1'),
(265, 9, 27, '2014-10-29 04:04:17', 'In the HEROforZERO app, do I have to spend money to donate? ', 1, 960, 'The purpose of donation in the app is not to raise money but to educate people about how much impact small amounts of money can have. ', '', '', b'1'),
(266, 6, 27, '2014-07-22 16:43:44', 'What percent of females in Vietnam believe that a husband is justified in beating his wife in certain circumstances (2002-2010)?', 1, 965, 'UNICEF The State of the World’s Children (2012): Children in an Urban World', '', '', b'1'),
(267, 1, 27, '2014-08-28 08:17:41', 'What is the under five mortality rate in Vietnam out of 1000 live births (2010)?', 1, 968, 'UNICEF The State of the World’s Children (2012): Children in an Urban World', '', '', b'1'),
(268, 6, 27, '2014-07-22 16:43:13', 'What percentage of children in Vietnam ages 2-14 years old experience violent discipline (2010)?', 1, 972, 'UNICEF The State of the World’s Children (2012): Children in an Urban World', '', '', b'1'),
(269, 1, 27, '2014-07-16 03:26:14', 'What percent of the population in Vietnam lives under the poverty line ($1.25/day, 2002-2009)?\n', 1, 975, 'UNICEF The State of the World’s Children (2012): Children in an Urban World', '', '', b'1'),
(270, 1, 27, '2014-07-16 03:46:45', 'What is the life expectancy at birth in Vietnam (2010)?', 1, 978, 'Life expectancy at birth - The number of years newborn children would live if subject to the mortality risks prevailing for the cross-section of population at the time of their birth..', 'http://www.unicef.org/infobycountry/stats_popup1.html', '', b'1'),
(271, 8, 27, '2014-07-16 03:44:15', 'What is the percentage of under-fives in Vietnam that suffer from wasting (2010)?\n', 1, 984, 'Wasting, or low weight for height, is a strong predictor of mortality among children under five. It is usually the result of acute significant food shortage and/or disease. ', 'http://www.unicef.org/sowc2012/', '', b'1'),
(272, 1, 27, '2014-08-28 08:18:08', 'What percentage of the Vietnamese population lives in an urban setting?', 1, 987, '', 'http://www.unicef.org/sowc2012/', '', b'1'),
(273, 1, 27, '2014-07-16 03:42:16', 'What portion of  people living in cities live in slums?', 1, 993, 'Children''s health primarily determined by the socio-economic conditions in which they are born, grow, and live, and these are in turn shaped by the distribution of power and resources. The consequences of having too little of both are most readily evident in informal settlements and slums, where roughly 1.4 billion people will live by 2020. ', 'http://www.unicef.org/sowc2012/', '', b'1'),
(274, 1, 27, '2014-07-16 03:38:28', 'In 2050, how many people out of 10 will live in urban areas?', 1, 997, 'By 2050, 7 in 10 people will live in urban areas. Every year, the world''s population increases by approximately 60 million people. Most of this growth is taking place in low- and middle-income countries.', 'http://www.unicef.org/sowc2012/', '', b'1'),
(275, 1, 27, '2014-08-04 09:45:57', 'What percentage of the Vietnamese population lives in an urban setting?', 1, 999, 'UNICEF The State of the World’s Children (2012): Children in an Urban World\n', 'http://www.unicef.org/sowc2012/pdfs/SOWC%202012-Executive%20Summary_EN_13Mar2012.pdf', '', b'1'),
(276, 1, 27, '2014-08-04 09:47:34', 'What portion of the people living in cities live in slums?', 1, 1005, 'About one third of the world''s urban population lives in slum conditions. Some 1.4 billion people will live in informal settlements and slums by 2020.The difficulties the poor face are exacerbated by such factors as illegality, limited voice in decision-making and lack of secure tenure and legal protection.', 'http://www.unicef.org/sowc2012/pdfs/SOWC%202012-Executive%20Summary_EN_13Mar2012.pdf', '', b'1'),
(277, 1, 27, '2014-08-04 09:42:05', 'In 2050, how many people out of 10 will live in urban areas?', 1, 1009, 'By 2050, 7 in 10 people will live in urban areas, Every year, the world''s urban population increases by approximately 60 million people. Asia is home to half of the world''s urban population.', 'http://www.unicef.org/sowc2012/', '', b'1'),
(278, 6, 27, '2014-08-04 09:41:48', 'How does UNICEF define an adolescent?', 1, 1012, 'UNICEF and partners define adolescents as people between the ages of 10 and 19. : The United Nations define youth as persons between the ages of 15 and 24.\n', 'http://www.itu.int/osg/csd/cybersecurity/gca/cop/', '', b'1'),
(279, 6, 27, '2014-08-04 09:41:33', 'How does UNICEF define a child?', 1, 1014, 'The Convention on the Rights of the Child, defines a child as every human being below the age of 18 \nyears unless, under the country-specific law applicable to the child, majority is attained earlier.', 'http://www.itu.int/osg/csd/cybersecurity/gca/cop/', '', b'1'),
(280, 6, 27, '2014-08-04 09:41:13', 'What is cyberbullying?', 1, 1021, '', 'http://www.itu.int/osg/csd/cybersecurity/gca/cop/', '', b'1'),
(281, 6, 27, '2014-08-04 09:40:52', 'What is grooming?', 1, 1023, 'Both adults and young people can use the Internet to seek out children or other young people who are vulnerable. Frequently their goal is to convince them that they have a meaningful relationship but the underlying purpose is to manipulate them into performing sexual or other abusive acts either in real life following a meeting, or online using a web cam or some other recording device. This process is often referred to as grooming. ', 'http://www.itu.int/osg/csd/cybersecurity/gca/cop/', '', b'1'),
(282, 6, 27, '2014-07-22 17:27:11', 'What does ICT stand for?', 1, 1028, 'Over the past twenty years, new information and communication technologies (ICTs) have profoundly \nchanged the ways in which today’s young people interact with and participate in the world around them. \nThe proliferation of Internet access points, mobile technology and the growing array of Internet-enabled \ndevices combined with the immense resources to be found in cyberspace provide children and young \npeople with unprecedented opportunities to learn, share and communicate. ', 'http://business-humanrights.org/sites/default/files/media/documents/itu-unicef-guidelines-child-online-protection.pdf', '', b'1'),
(283, 6, 27, '2014-07-22 17:36:20', 'How is ‘child pornography’ defined?\n', 1, 1030, 'The Optional Protocol to the Convention on the Rights of the Child on the sale of children, child prostitution \nand child pornography defines child abuse material as any representation, by whatever means, of a child\nengaged in real or simulated explicit sexual activities or any representation of the sexual parts of a child for \nprimarily sexual purposes.', 'http://www.itu.int/osg/csd/cybersecurity/gca/cop/', '', b'1'),
(284, 9, 30, '2014-10-29 03:55:41', 'In the HEROforZERO app, how do you earn awards?', 1, 1035, 'In the HEROforZERO app, virtual donations are used to help you understand the needs of NGOs. ', '', '', b'1'),
(285, 9, 30, '2014-10-29 03:56:43', 'The HEROforZERO app was developed in what country?', 1, 1040, 'The HEROforZERO app was developed by a team of developers in Vietnam in collaboration with UNICEF.', '', '', b'1'),
(286, 9, 30, '2014-10-29 03:58:35', 'In the HEROforZERO app, how can you lose a quiz?', 1, 1045, '', '', '', b'1'),
(287, 9, 30, '2014-10-29 04:01:32', 'In the HEROforZERO app, how can you help NGOs help children?', 1, 1049, '', '', '', b'1'),
(290, 9, 30, '2014-10-29 04:02:39', 'How does playing HEROforZERO make you a hero in real life?', 1, 1061, '', '', '', b'1'),
(291, 9, 30, '2014-10-29 04:03:08', 'In the HEROforZERO app, who are examples of some of the children you must save?', 1, 1065, '', '', '', b'1'),
(292, 9, 30, '2014-10-29 03:57:26', 'How many lives do I have in the HEROforZERO app?', 1, 1069, '', '', '', b'1'),
(294, 1, 27, '2014-09-16 04:07:26', 'What does UNICEF stand for?', 1, 1076, 'http://www.unicef.org/ourstory2013/', 'http://unicef.org', '', NULL),
(295, 1, 27, '2014-09-16 04:12:53', 'When was UNICEF established?', 1, 1081, 'On 11 December 1946, the global community establishing the UNICEF to respond to the the millions of displaced and refugee children.', '', '', NULL),
(296, 1, 27, '2014-09-16 04:14:12', 'Which objectives are UNICEF’s priorities?', 1, 1085, '', 'http://www.unicef.org/education/bege_61625.html', '', NULL),
(297, 1, 27, '2014-09-16 04:15:27', 'What is the official website of UNICEF?', 1, 1086, '', 'unicef.org', '', NULL),
(298, 1, 27, '2014-09-16 09:40:07', 'Which celebrity was NOT a UNICEF Goodwill Ambassador?', 1, 1093, '', 'http://www.unicef.org/people/people_ambassadors_international.html', '', NULL),
(299, 9, 27, '2014-10-29 04:36:47', 'UNICEF''s Next Generation shares a commitment to UNICEF''s future and a belief in ZERO.  What does ZERO initially mean?', 1, 1094, 'UNICEF''s NextGen aims to help reduce the number of children in Vietnam dying of preventable deaths to ZERO.', 'http://www.unicefusa.org/supporters/donors/nextgen', '', b'1'),
(300, 1, 27, '2014-09-16 09:51:29', 'What is the mission of the UNICEF Next Generation Vietnam?', 1, 1098, '', '', '', NULL),
(301, 7, 27, '2014-09-16 09:56:41', 'UNICEF has partnered with the Child-to-Child Trust to develop Getting Ready for School Which child group has the program targeted?', 1, 1103, 'Learn more about the about the benefits of ''Child-to-Child'' program at this website: unicef.org/education/bege_61646.html', 'http://www.unicef.org/education/bege_61646.html', '', NULL),
(302, 7, 27, '2014-09-16 09:58:33', 'There are currently an estimated 57 million primary school-age children who are not in school. Which children worldwide?\n', 1, 1109, 'There are currently an estimated 57 million primary school-age children who are not in school.  Learn more at: unicef.org/education/bege_616', 'http://www.unicef.org/education/bege_61657.html', '', NULL),
(303, 7, 27, '2014-09-16 10:10:07', 'UNICEF’s education programs are working to progress towards the achievement of two of the Millennium Development Goals. What are they? ', 1, 1111, '', 'http://www.unicef.org/education/bege_61721.html', '', NULL),
(304, 7, 27, '2014-09-16 10:10:58', 'How many general levels is the Vietnamese educational system divided into?', 1, 1114, 'Source: Vietnam Report: High Quality Education For All By 2020', '', '', NULL),
(305, 7, 27, '2014-09-16 10:11:57', 'Do Vietnamese children have to complete all the educational levels?', 1, 1119, '', '', '', NULL),
(306, 7, 27, '2014-09-16 10:12:29', 'What factors contribute to children’s educational performance?', 1, 1125, '', '', '', NULL),
(307, 7, 27, '2014-09-16 10:14:03', 'What factors can constrain children’s educational performance?', 1, 1129, 'Source: Vietnam Report: High Quality Education For All By 2020', '', '', NULL),
(308, 7, 27, '2014-09-16 10:15:11', 'On average how long does a girl’s education last in Vietnam?\n', 1, 1131, 'Source: http://www.savethechildren.org/site/c.8rKLIXMGIpI4E/b.6150551/k.C9F9/Vietnam.htm', 'http://www.savethechildren.org/site/c.8rKLIXMGIpI4E/b.6150551/k.C9F9/Vietnam.htm', '', NULL),
(310, 5, 27, '2014-09-16 10:16:25', 'What is usually the first sign of measles?', 1, 1138, '', '', '', NULL),
(311, 5, 27, '2014-09-16 10:17:02', 'Who is mostly at risk of getting measles?', 1, 1144, '', '', '', NULL),
(312, 5, 27, '2014-09-16 10:17:46', 'How much does a measles vaccine cost?', 1, 1146, '', '', '', NULL),
(313, 5, 27, '2014-09-16 10:18:36', 'What kind of vitamin supplements has been shown to reduce the number of deaths from measles by 50%?', 1, 1151, '', '', '', NULL),
(314, 5, 27, '2014-09-16 10:20:18', 'How is the measles virus transmitted?', 1, 1156, '', '', '', NULL),
(315, 5, 27, '2014-09-16 10:20:56', 'What is FALSE about measles?', 1, 1159, '', '', '', NULL),
(316, 5, 27, '2014-09-16 10:22:19', 'What is the MMR vaccine?', 1, 1164, 'Source: WHO (http://www.who.int/mediacentre/factsheets/fs286/en/)', 'http://www.who.int/mediacentre/factsheets/fs286/en/', '', NULL),
(317, 5, 27, '2014-09-16 10:23:08', 'What vaccine does an infant receive within the first 24 hours after birth?', 1, 1166, 'Source: http://ivac.com.vn/tin-tuc/2/16/12-loai-vacxin-can-tiem-cho-tre/vien-vac-xin.html', '', '', NULL),
(318, 5, 27, '2014-09-16 10:23:51', 'What is NOT a key principle to safer food?', 1, 1173, '(Source: http://www.wpro.who.int/vietnam/topics/food_safety/factsheet/en/)', 'http://www.wpro.who.int/vietnam/topics/food_safety/factsheet/en/', '', NULL),
(319, 5, 27, '2014-09-16 10:24:40', 'At what age do children most commonly become infected with Hand, Foot and Mouth Disease (HFMD)?', 1, 1174, '(Source: http://www.wpro.who.int/vietnam/topics/hand_foot_mouth/factsheet/en/)', 'http://www.wpro.who.int/vietnam/topics/hand_foot_mouth/factsheet/en/', '', NULL),
(320, 5, 27, '2014-09-16 10:26:47', 'What are the three steps of protection, all of which have been proposed by World Immunization Week 2014 of WHO?', 1, 1179, 'Source: http://www.wpro.who.int/vietnam/mediacentre/events/world_immunization_week/en/', 'http://www.wpro.who.int/vietnam/mediacentre/events/world_immunization_week/en/', '', NULL),
(321, 5, 27, '2014-09-16 10:27:47', 'In developing countries, what percentage of mothers and newborns do not receive skilled care during and immediately after birth?', 1, 1185, '(Source: http://www.wpro.who.int/vietnam/topics/newborn_health/factsheet/en/)', ' http://www.wpro.who.int/vietnam/topics/newborn_health/factsheet/en/', '', NULL),
(322, 5, 27, '2014-09-16 10:28:33', 'Who is the world’s largest buyer of vaccines?', 1, 1186, 'Source: http://www.unicefusa.org/mission/survival/immunization', 'http://www.unicefusa.org/mission/survival/immunization', '', NULL),
(323, 5, 27, '2014-09-16 10:31:14', 'Around the world, 1 in...... children under five remain unvaccinated.', 1, 1191, '(Source: http://www.unicefusa.org/mission/survival/immunization)', 'http://www.unicefusa.org/mission/survival/immunization', '', NULL),
(324, 5, 27, '2014-09-16 10:31:55', 'Where do most cases and deaths of malaria occur in Vietnam?', 1, 1197, '(Source: http://www.wpro.who.int/vietnam/topics/malaria/factsheet/en/)', 'http://www.wpro.who.int/vietnam/topics/malaria/factsheet/en/', '', NULL),
(325, 5, 27, '2014-09-16 10:32:35', 'On average, how many newborn babies die in Vietnam every year?', 1, 1199, '(Source: http://www.wpro.who.int/vietnam/topics/newborn_health/factsheet/en/)', 'http://www.wpro.who.int/vietnam/topics/newborn_health/factsheet/en/', '', NULL),
(326, 5, 27, '2014-09-16 10:33:58', 'Since 1988, UNICEF has eradicated polio in ______ countries.', 1, 1204, '(Source: http://www.unicefusa.org/mission/survival/immunization)', 'http://www.unicefusa.org/mission/survival/immunization', '', NULL),
(327, 5, 27, '2014-09-16 10:35:12', 'How many Vietnamese children don’t have access to clean water?', 1, 1207, '(Source: UNICEF Next Generation Vietnam: http://www.unicef.org/vietnam/media_20690.html', 'http://www.unicef.org/vietnam/media_20690.html', '', NULL),
(328, 5, 27, '2014-09-16 10:36:19', 'Where can a child/infant receive proper vaccines?', 1, 1213, '', '', '', NULL),
(329, 5, 27, '2014-10-27 05:24:47', 'When does World Immunization Week take place every year?', 1, 1217, 'immunization averts 2-3 million deaths each year from diseases such as diphtheria,\nmeasles, pertussis, pneumonia, polio, rotavirus, etc..', 'http://www.who.int/campaigns/immunization-week/2014/overview/en/', '', b'1'),
(330, 5, 27, '2014-09-16 10:40:27', 'What is the slogan for World Immunization Week 2014?', 1, 1219, 'Past theme: 2014: “Are you up-to-date?”, 2013: "Protect your world – get vaccinated", 2012: "Protect your world – get vaccinated".', 'http://en.wikipedia.org/wiki/World_Immunization_Week', '', NULL),
(331, 5, 27, '2014-10-27 05:25:16', 'What should newborns receive after the first hour of life?', 1, 1225, '', '', '', b'1'),
(332, 5, 27, '2014-09-16 10:42:38', 'Who does not receive optimal care during labour, birth and the immediate postnatal period?', 1, 1228, '', '', '', NULL),
(333, 5, 27, '2014-09-16 10:43:06', 'Which newborns should receive special attention?', 1, 1233, '', '', '', NULL),
(334, 5, 27, '2014-09-17 03:10:34', 'Who needs blood transfusions?', 1, 1237, 'Source: http://www.who.int/features/qa/61/en', 'http://www.who.int/features/qa/61/en', '', NULL),
(335, 5, 27, '2014-10-27 05:26:27', 'When are children at the greatest risk for death?', 1, 1239, 'Newborns are at the greatest risk of death. ', 'http://www.who.int/features/qa/13/en', '', b'1'),
(336, 5, 27, '2014-10-27 05:26:53', 'What is the main cause of death in children under-five in Southeast Asia (2010)?', 1, 1242, 'Neonatal deaths (52%), Measles (3%), Phneumonia (15%), Malaria (1%): Source: WHO. Global Health Observatory (http://www.who.int/gho/child_he', 'http://www.who.int/gho/child_he', '', b'1');
INSERT INTO `quiz` (`Id`, `CategoryId`, `PartnerId`, `CreatedDate`, `Content`, `BonusPoint`, `CorrectChoiceId`, `SharingInfo`, `LearnMoreURL`, `ImageURL`, `IsApproved`) VALUES
(337, 5, 27, '2014-09-17 03:17:10', 'Where do one third of all child deaths occur?', 1, 1248, '', '', '', NULL),
(338, 5, 27, '2014-09-17 03:17:54', 'What causes pneumonia?', 1, 1253, '', '', '', NULL),
(339, 5, 27, '2014-09-17 03:19:21', 'What is TRUE about diarrheal disease?', 1, 1254, '', '', '', NULL),
(340, 5, 27, '2014-09-17 03:20:43', 'What is TRUE about diarrheal disease?', 1, 1260, '', '', '', NULL),
(341, 5, 27, '2014-09-17 03:21:09', 'What are the most critical periods for newborn and maternal survival?', 1, 1265, '', '', '', NULL),
(342, 5, 27, '2014-09-17 03:21:30', 'What type of liquid helps to treat diarrhea?', 1, 1269, '', '', '', NULL),
(343, 5, 27, '2014-09-17 03:21:53', 'How can you prevent pneumonia?', 1, 1273, '', '', '', NULL),
(344, 5, 27, '2014-09-17 03:22:31', 'Which group of countries has never stopped the transmission of polio?', 1, 1274, 'Source: http://www.who.int/features/qa/07/en', 'http://www.who.int/features/qa/07/en', '', NULL),
(345, 5, 27, '2014-09-17 03:23:11', 'What TRUE about polio?', 1, 1280, 'Source: http://www.who.int/features/qa/07/en', 'http://www.who.int/features/qa/07/en', '', NULL),
(346, 5, 27, '2014-09-17 03:23:54', 'What is TRUE about tuberculosis (TB)?', 1, 1285, 'Source: http://www.who.int/features/qa/08/en', 'http://www.who.int/features/qa/08/en', '', NULL),
(347, 5, 27, '2014-09-17 03:24:24', 'What are the symptoms of tuberculosis?', 1, 1286, '', '', '', NULL),
(348, 5, 27, '2014-09-17 03:24:46', 'What is the yellow fever 17D vaccine for?', 1, 1291, '', '', '', NULL),
(349, 5, 27, '2014-09-17 03:25:21', 'What is the mortality rate of newborns in VN? (2009)', 1, 1294, 'Source: http://www.un.org.vn/vi/about-viet-nam/basic-statistics.html', 'http://www.un.org.vn/vi/about-viet-nam/basic-statistics.html', '', NULL),
(350, 5, 27, '2014-09-17 03:25:51', 'What is childbirth mortality rate of mothers in VN ? (2009)', 1, 1299, '', '', '', NULL),
(351, 5, 27, '2014-09-17 03:26:47', 'What day is Global Handwashing Day?', 1, 1302, '21 Feb: International Mother Language Day\n\n30 November: World AIDS Day\n\n22 Macrh: World Water Day', '', '', NULL),
(352, 8, 27, '2014-09-17 03:27:39', 'Every day, approximately................children die from starvattion and malnutrition.', 1, 1306, 'Source: http://30hourfamine.org/hunger-facts/?\n\ncons_id=0&ts=1400942956&signature=b1e84c539cec5784c6271a12918826ee', ' http://30hourfamine.org/hunger-facts/?  cons_id=0&ts=1400942956&signature=b1e84c539cec5784c6271a12918826ee', '', NULL),
(353, 8, 27, '2014-09-17 03:28:39', 'How can childhood malnutrition be avoided?', 1, 1313, '', '', '', NULL),
(354, 8, 27, '2014-09-17 03:29:01', 'What percent of children are underweight in VN?', 1, 1314, '', '', '', NULL),
(355, 8, 27, '2014-09-17 03:29:34', 'Out of every 6 children in Vietnam, how many of them don’t drink pure water?', 1, 1321, 'Source: UNICEF NEXT GENERATION VN', '', '', NULL),
(356, 8, 27, '2014-09-17 03:30:01', 'What common illness contributes to malnutrition?', 1, 1322, 'Source: http://www.un.org.vn/vi/feature-articles-press-centre-submenu-252/339-dinh-dung-\nba-m-va-tr-em--vit-nam.html', '', '', NULL),
(357, 8, 27, '2014-09-17 03:30:40', 'At what\n\nmilk?', 1, 1327, 'WHO recommends that infants start receiving complementary foods at\n\nsix months (180 days) of age in addition to breast milk', 'http://www.who.int/features/qa/21/en', '', NULL),
(358, 6, 27, '2014-09-17 03:31:09', 'What does ICT stand for?', 1, 1332, '', 'http://business-humanrights.org/sites/default/files/media/documents/itu-unicef-guidelines-child-online-protection.pdf', '', NULL),
(359, 8, 27, '2014-09-17 03:31:14', 'Malnutrition is responsible for what portion of all child deaths?', 1, 1335, '', '', '', NULL),
(360, 8, 27, '2014-09-17 03:31:37', 'What are the benefits of breast feeding?', 1, 1341, '', '', '', NULL),
(361, 8, 27, '2014-09-17 03:32:05', 'Which is the first natural food for babies?', 1, 1344, '', '', '', NULL),
(362, 8, 27, '2014-09-17 03:33:05', 'Which age group receives Vitamin A supplement in VN?', 1, 1346, 'Source: http://www.un.org.vn/vi/feature-articles-press-centre-submenu-252/339-dinh-dung-\nba-m-va-tr-em--vit-nam.html', 'http://www.un.org.vn/vi/feature-articles-press-centre-submenu-252/339-dinh-dung- ba-m-va-tr-em--vit-nam.html', '', NULL),
(363, 8, 27, '2014-09-17 03:33:40', 'What percent of mothers use a Vitamin A supplement after giving birth in VN?', 1, 1352, 'Source: http://www.un.org.vn/vi/feature-articles-press-centre-submenu-252/339-dinh-dung-\nba-m-va-tr-em--vit-nam.html', 'http://www.un.org.vn/vi/feature-articles-press-centre-submenu-252/339-dinh-dung- ba-m-va-tr-em--vit-nam.html', '', NULL),
(364, 8, 27, '2014-09-17 03:34:07', 'What is the leading cause of preventable blindness in children?', 1, 1354, '', '', '', NULL),
(365, 6, 27, '2014-09-17 03:34:23', 'What percent of child pornography victims are under the age of 10?', 1, 1359, '81 per cent of child victims are 10 years or under and 53 percent of the images depicted sexual activity between adults and children.', 'http://business-humanrights.org/sites/default/files/media/documents/itu-unicef-guidelines-child-online-protection.pdf', '', NULL),
(366, 8, 27, '2014-09-17 03:34:30', 'What effect does VAD (Vitamin A deficiency) have in children?', 1, 1365, '', '', '', NULL),
(367, 8, 27, '2014-09-17 03:34:53', 'What percent of children are breastfed within the 1 first hour of life?', 1, 1368, '', '', '', NULL),
(368, 8, 27, '2014-09-17 03:35:21', 'What helps to prevent diarrhea among newborns?', 1, 1371, 'Source: http://www.who.int/features/qa/13/en', ' http://www.who.int/features/qa/13/en', '', NULL),
(369, 6, 27, '2014-09-17 03:36:12', 'What percentage of the pornographic images depict a child with an adult?', 1, 1376, '53 per cent of the images depicted sexual activity between adults and children including rape and sexual torture. ', 'http://business-humanrights.org/sites/default/files/media/documents/itu-unicef-guidelines-child-online-protection.pdf', '', NULL),
(370, 5, 27, '2014-10-27 05:23:44', 'When is World AIDS Day?', 1, 1379, 'Share link: http://www.worldaidsday.org/', 'http://www.worldaidsday.org/', '', b'1'),
(371, 5, 27, '2014-10-27 05:23:29', 'How long does it take for a person infected with HIV to develop AIDS?', 1, 1383, 'The majority of people infected with HIV will develop signs of HIV-related illness within 5–10 years, although this can be shorter.', 'http://www.who.int/features/qa/71/en/', '', NULL),
(372, 6, 27, '2014-09-17 03:39:42', 'What makes online parental oversight difficult?', 1, 1389, 'Convergence of mobile phones and Internet services makes parental oversight much more difficult. Industry can work with governments, adults ', 'http://business-humanrights.org/sites/default/files/media/documents/itu-unicef-guidelines-child-online-protection.pdf', '', NULL),
(373, 5, 27, '2014-10-27 05:23:02', 'What is the most common life-threatening opportunistic infection affecting people?\n\nliving with HIV/AIDS?', 1, 1391, 'Tuberculosis (TB) kills nearly a quarter of a million people living with HIV each\n\nyear.', 'http://www.who.int/features/qa/71/en/', '', NULL),
(374, 1, 27, '2014-09-17 03:40:35', 'The United Nations'' (UN) Universal Children''s Day, which was established in 1954,\n\ncelebrates and promotes international togetherness, child', 1, 1396, 'Share link: http://www.un.org/en/events/childrenday/', ' http://www.un.org/en/events/childrenday/', '', NULL),
(375, 1, 27, '2014-09-17 03:41:04', 'Body mass index (BMI) is a measure of body fat based on height and weight that \n\napplies to adult men and women. How is BMI calculated?', 1, 1400, '', '', '', NULL),
(376, 5, 27, '2014-10-27 05:20:12', 'What is the normal range for Body Mass Index (BMI) for adult males and females?', 1, 1403, 'Share link: http://www.nhlbi.nih.gov/guidelines/obesity/BMI/bmicalc.htm', 'http://www.nhlbi.nih.gov/guidelines/obesity/BMI/bmicalc.htm', '', b'1'),
(377, 1, 27, '2014-09-17 03:42:17', 'What day is the International Day of Happiness?', 1, 1406, 'Link: https://www.facebook.com/unicefvietnam', 'https://www.facebook.com/unicefvietnam', '', NULL),
(378, 8, 27, '2014-09-17 07:05:49', 'What does the SUN Movement stand for?', 1, 1413, 'Scaling Up Nutrition, or SUN, is a unique Movement founded on the principle that all people have a right to food and good nutrition. ', 'http://scalingupnutrition.org/', '', b'1'),
(379, 1, 27, '2014-09-17 07:03:48', 'What is Vietnam’s ranking among SUN countries?', 1, 1417, 'Scaling Up Nutrition, or SUN, is a unique Movement founded on the principle that all people have a right to food and good nutrition. ', 'http://scalingupnutrition.org/', '', b'1'),
(380, 1, 27, '2014-09-17 03:44:24', 'What is the name of the main police and security force in VN?', 1, 1419, '', '', '', b'1'),
(381, 1, 27, '2014-09-17 07:01:47', 'What is the date of World Humanitarian Day?', 1, 1422, 'Link: https://www.facebook.com/unicefvietnam', 'https://www.facebook.com/unicefvietnam', '', b'1'),
(382, 1, 27, '2014-09-17 03:45:33', 'What does UNICEF stand for?', 1, 1428, '', '', '', b'1'),
(383, 5, 27, '2014-09-17 06:48:43', 'How many people worldwide die from tobacco-related illnesses each year?', 1, 1431, '', '', '', b'1'),
(384, 1, 27, '2014-09-17 06:47:45', 'When was UNICEF established?', 1, 1437, '', '', '', b'1'),
(385, 1, 27, '2014-09-17 06:45:00', 'How many Millennium Development Goals (MDGs) are there?', 1, 1441, '', '', '', b'1'),
(386, 1, 27, '2014-09-17 06:44:14', 'What is the official website of UNICEF?', 1, 1442, '', 'www.unicef.org', '', b'1'),
(387, 6, 27, '2014-09-17 03:48:44', 'When did all the countries in the United Nations General Assembly agree on the\n\nConvention on the Rights of the Child?', 1, 1447, '', '', '', b'1'),
(388, 6, 27, '2014-09-17 03:49:09', 'When did the Vietnamese Government signthe Convention on the Rights of the Child?', 1, 1451, '', '', '', b'1'),
(389, 6, 27, '2014-09-17 03:49:48', 'To date, how many countries have signed the Convention on the Rights of the Child?', 1, 1456, '', '', '', b'1'),
(390, 1, 27, '2014-09-17 03:50:14', 'Which objectives are UNICEF''s priorities?', 1, 1461, '', 'http://www.unicef.org/education/bege_61625.html', '', b'1'),
(391, 6, 27, '2014-09-17 06:40:40', 'Which are the three countries in the world that have not yet signed the Convention on the Rights of the Child?', 1, 1464, '', '', '', b'1'),
(392, 6, 27, '2014-09-17 03:51:13', 'Which is best place for a child to grow up?', 1, 1467, '', '', '', NULL),
(394, 1, 27, '2014-10-15 06:19:51', 'A child under the Convention on the Rights of the Child is every human being under the age of...?', 1, 1476, 'The Convention on the Rights of the Child is the most rapidly and widely ratified international human rights treaty in history.', 'http://www.unicef.org/crc/', '', b'1'),
(395, 6, 27, '2014-11-20 08:21:27', 'The children’s rights in the Convention on the Rights of the Child do not include:', 1, 1480, '', '', '', b'1'),
(396, 6, 27, '2014-09-17 06:37:14', 'According to the Convention on the Rights of the Child, every child has the right to participation. This means:', 1, 1485, '', '', '', b'1'),
(397, 9, 27, '2014-10-29 04:35:38', 'UNICEF''s NextGen believes in ZERO. What does ZERO mean?', 1, 1487, 'UNICEF Vietnam''s NextGen aims to help reduce the number of children in Vietnam dying of preventable deaths to ZERO.', 'http://www.unicefusa.org/supporters/donors/nextgen', '', b'1'),
(398, 6, 27, '2014-09-17 03:56:09', 'Child participation does not mean:', 1, 1490, '', '', '', b'1'),
(399, 1, 27, '2014-09-17 03:56:16', ' What is the mission of the UNICEF Next Generation Vietnam?', 1, 1497, '', '', '', b'1'),
(400, 6, 27, '2014-09-17 03:56:31', 'Which of the following is not a core principle of the Convention on the Rights of the\n\nChild?', 1, 1501, '', '', '', b'1'),
(401, 6, 27, '2014-11-20 08:20:58', 'Which are examples of violence against children?', 1, 1505, '', '', '', b'1'),
(403, 7, 27, '2014-12-05 06:00:32', 'UNICEF has partnered with the Child-to-Child trust to develop Getting Ready for School since 1997. What age group has the program targeted?', 1, 1511, '''Getting Ready for School: A child‐to‐child approach'' is an innovative and cost‐effective way of preparing preschool-aged children.', 'http://www.unicef.org/education/bege_61646.html', '', b'1'),
(404, 6, 27, '2014-09-17 06:26:14', 'How can we address violence against children?', 1, 1517, '', '', '', b'1'),
(405, 7, 27, '2014-12-05 05:59:21', 'Which region accounts for the largest proportion of all out-of-school children worldwide?', 1, 1521, 'There are currently an estimated 57 million primary school-age children who are not in school. Sub-Saharan Africa accounts for more than 1/2', 'http://www.unicef.org/education/bege_61657.html', '', b'1'),
(406, 6, 27, '2014-11-28 16:49:04', 'What is the number of children living in poverty in Vietnam in 2010 according to the Ministry of Labor, Invalids and Social Affaris (MOLISA)', 1, 1523, '', '', '', b'1'),
(407, 6, 27, '2014-09-17 04:02:38', 'Child maltreatment can cause:', 1, 1529, '', '', '', b'1'),
(408, 1, 27, '2014-12-05 06:30:33', 'UNICEF’s education programs are working to accelerate progress towards the achievement of two of the Millennium Development Goals. They are?', 1, 1533, 'At the international level, we are part of four core partnerships that work to accelerate progress towards Goal 2 and Goal 3. ', 'http://www.unicef.org/education/bege_61721.html', '', b'1'),
(409, 7, 27, '2014-12-05 06:26:07', 'Do Vietnamese children have to complete all the educational levels?\n', 1, 1535, 'Ethnic minorities, girls, children with disabilities, migrants and children affected by HIV have fewer opportunities to attend school.', 'http://www.unicef.org/vietnam/girls_education.html', '', b'1'),
(411, 7, 27, '2014-12-05 06:22:45', 'What factors can constrain a child''s educational performance?', 1, 1545, 'Vietnam Report: High Quality Education For All By 2020', 'http://www-wds.worldbank.org/external/default/WDSContentServer/WDSP/IB/2012/04/18/000333038_20120418014333/Rendered/PDF/680920v20WP0P10oduc0tap20Engl012012.pdf', '', b'1'),
(412, 7, 27, '2014-12-05 06:17:11', 'On average how long does a girl''s education last in VN?', 1, 1547, 'In Vietnam, girls, especially those who are part of a minority group, are less likely to complete their education than boys. ', 'http://www.savethechildren.org/site/c.8rKLIXMGIpI4E/b.6150551/k.C9F9/Vietnam.htm', '', b'1'),
(413, 7, 27, '2014-09-17 04:11:56', 'What percentage of Vietnamese children are enrolled in primary school?', 1, 1551, '', 'http://www.unicef.org/vietnam/girls_education.html', '', b'1'),
(414, 5, 27, '2014-10-27 05:16:07', 'What is usually the first sign of measles?', 1, 1554, '', '', '', b'1'),
(415, 5, 27, '2014-10-27 05:15:42', 'Who is at the highest risk of getting measles?', 1, 1560, '', '', '', b'1'),
(416, 5, 27, '2014-10-27 05:13:34', 'How much does a measles vaccine cost?', 1, 1562, '', '', '', b'1'),
(417, 5, 27, '2014-10-27 05:13:14', 'What kind of vitamin supplements has been shown to reduce the number of measles deaths by 50%', 1, 1566, '', '', '', b'1'),
(418, 5, 27, '2014-10-27 05:12:48', 'How is the measles virus transmitted?', 1, 1573, '', '', '', b'1'),
(419, 6, 30, '2014-09-17 06:14:23', 'Which of these is related to child maltreatment?', 1, 1577, '', '', '', b'1'),
(420, 6, 30, '2014-11-20 08:20:28', 'The consequences of violence against children can obstruct economic growth because of: ', 1, 1581, '', '', '', b'1'),
(421, 6, 30, '2014-09-17 04:35:35', 'What can be taught in schools to prevent and respond to child sexual abuse?', 1, 1585, '', '', '', b'1'),
(422, 6, 30, '2014-09-17 04:36:30', 'What are the possible consequences for children who were victims of violence?', 1, 1589, '', '', '', b'1'),
(423, 6, 30, '2014-09-17 04:37:06', 'Which of the things below are forms of child maltreatment?', 1, 1593, '', '', '', b'1'),
(424, 6, 30, '2014-09-17 04:37:35', 'What is the percentage of children 12-14 in Vietnam who experienced violent punishment by parents?', 1, 1595, '', '', '', b'1'),
(425, 6, 30, '2014-09-17 04:38:01', 'What does Corporal or Physical Punishment Include?', 1, 1601, '', '', '', b'1'),
(426, 5, 27, '2014-10-27 05:14:23', 'What is FALSE about measles?', 1, 1603, '', '', '', b'1'),
(427, 6, 30, '2014-09-17 04:39:17', 'What alternatives to corporal punishment will ensure good/positive discipline?', 1, 1609, '', '', '', b'1'),
(428, 5, 27, '2014-10-27 05:14:51', 'What is the MMR vaccine?', 1, 1612, '', 'http://www.who.int/mediacentre/factsheets/fs286/en/', '', b'1'),
(429, 6, 30, '2014-09-17 04:39:42', 'What is a possible sign of emotional abuse?', 1, 1616, '', '', '', b'1'),
(430, 6, 30, '2014-09-17 06:00:07', 'How much more likely are children with disabilities to suffer from violence or sexual abuse, compared with others?', 1, 1620, '', '', '', b'1'),
(431, 6, 30, '2014-09-17 04:40:51', 'How many children are exploited in the commercial sex trade in the world?', 1, 1624, '(Source: http://www.unicefusa.org/mission/protect/violence)', 'http://www.unicefusa.org/mission/protect/violence', '', b'1'),
(432, 6, 30, '2014-09-17 04:41:19', 'What is the percentage of women who have been sexually abused as children?', 1, 1628, '', '', '', b'1'),
(433, 5, 27, '2014-10-27 05:15:16', 'What vaccine does an infant receive within the first 24 ours after birth?', 1, 1630, '', 'http://www.wpro.who.int/vietnam/topics/food_safety/factsheet/en/', '', b'1'),
(434, 6, 30, '2014-11-20 08:19:38', 'If a child discloses that he or she has been abused by someone, what should you do?', 1, 1637, '', '', '', b'1'),
(435, 6, 30, '2014-09-17 04:42:43', 'If a child discloses that he or she has been abused by someone, what SHOULD you NOT\n\nDO?', 1, 1641, '', '', '', b'1'),
(436, 6, 30, '2014-09-17 04:42:58', 'How many children die every day as a result of abuse and neglect?', 1, 1643, '', '', '', b'1'),
(437, 6, 30, '2014-09-17 04:43:23', 'Approximately how many child abuse cases reported every year?', 1, 1648, '', '', '', b'1'),
(439, 7, 5, '2014-12-05 05:58:54', 'How many children under the age of 5 worldwide are not achieving their developmental potential?', 1, 1656, 'They do not reach their potential because of the lack of adequate nutrition, poor health and stimulating, nurturing, responsive environments', 'http://blogs.unicef.org/2014/05/14/how-childrens-brains-develop-new-insights/', '', b'1'),
(440, 1, 5, '2014-10-27 05:11:26', 'Nature or Nurture? Nurture? Nature? Which is the most important in child development?', 1, 1661, 'It is nature with nurture, the degree of interdependence is even greater than we ever imagined.', 'http://blogs.unicef.org/2014/05/14/how-childrens-brains-develop-new-insights/', '', b'1'),
(441, 5, 5, '2014-10-27 05:11:04', 'When does the human brain develop most rapidly?', 1, 1662, 'In young children, neurons form new connections at the astounding rate of 700 to 1,000 per second. ', 'http://blogs.unicef.org/2014/05/14/how-childrens-brains-develop-new-insights/', '', NULL),
(442, 5, 5, '2014-10-27 05:10:35', 'When is it hardest to fix brain development and set it back on track?', 1, 1669, 'The extent and severity of problems in later life linked with early deprivation can be remediated through early intervention.', 'http://blogs.unicef.org/2014/05/14/how-childrens-brains-develop-new-insights/', '', b'1'),
(443, 5, 5, '2014-10-27 05:05:11', 'What is the main experience the brain depends on for optimal development?', 1, 1673, 'The brain relies on multiple experiences to develop: Nutrition, Stimulation, Healthy Interactions, and Protection', 'http://blogs.unicef.org/2014/05/14/how-childrens-brains-develop-new-insights/', '', b'1'),
(444, 8, 5, '2014-10-27 05:04:11', 'In gestation and infancy how much of the total energy used by the body is used by the brain?', 1, 1676, 'It consumes between 50 and 75 per cent of all the energy absorbed by the body from food, including fats, proteins, vitamins and minerals.', 'http://blogs.unicef.org/2014/05/14/how-childrens-brains-develop-new-insights/', '', b'1'),
(445, 8, 5, '2014-10-15 08:41:46', 'What do high levels of stress do to a child''s body?', 1, 1681, 'Smarter interventions should therefore link nutrition with stress reduction, improving a child’s nutritional status and brain development.', 'http://blogs.unicef.org/2014/05/14/how-childrens-brains-develop-new-insights/', '', b'1'),
(446, 6, 5, '2014-10-15 08:47:45', 'What is toxic stress?', 1, 1683, 'Toxic stress produces high levels of cortisol, which damages health, learning and behavior.', 'http://blogs.unicef.org/2014/05/14/how-childrens-brains-develop-new-insights/', '', b'1'),
(447, 7, 5, '2014-12-05 05:59:46', 'What permanently strengthens a child''s ability to learn?', 1, 1689, 'Stimulating interaction between young children and their parents and caregivers positively and permanently strengthens the ability to learn.', 'http://blogs.unicef.org/2014/05/14/how-childrens-brains-develop-new-insights/', '', b'1'),
(448, 5, 5, '2014-10-27 05:02:09', 'When is the foundation of a brain''s network and pathways established?', 1, 1691, 'The “Heckman Curve” graph shows that the highest return on investments in education and training is pre-primary learning, from zero to three', 'http://blogs.unicef.org/2014/05/14/how-childrens-brains-develop-new-insights/', '', b'1'),
(449, 8, 5, '2014-10-27 05:01:40', 'What are some developmental benefits of breastfeeding?', 1, 1697, 'Better nutrition, stimulation, nurturing and a strengthened bond between mother and child support healthy brain development.', 'http://www.unicef.org/protection/57929_58022.html', '', b'1'),
(450, 5, 5, '2014-10-27 05:01:16', 'What fraction of children worldwide are not reaching their developmental potential?', 1, 1699, 'One third of all children3 are not achieving their development potential, with a profound effect on their lives and long-term consequences.', 'http://blogs.unicef.org/2014/05/14/how-childrens-brains-develop-new-insights/', '', b'1'),
(451, 5, 5, '2014-10-27 05:00:49', 'What is interesting about a child''s brain at age 3?', 1, 1704, 'At 3 years of age, a child’s brain is twice as active as an adult brain (Brotherson, 2009).', 'http://blogs.unicef.org/2014/05/14/how-childrens-brains-develop-new-insights/', '', b'1'),
(452, 8, 5, '2014-10-27 05:00:03', 'What percent of brain weight is acquired by 3 years of age?', 1, 1709, '87% of brain weight is acquired by 3 years of age (1,100 grams; Dekaban, 1978).', 'http://blogs.unicef.org/2014/05/14/how-childrens-brains-develop-new-insights/', '', b'1'),
(453, 5, 5, '2014-10-27 06:23:02', 'At what age do children most commonly become infected with Hand, Foot and Mouth Disease?', 1, 1713, '', 'Source: http://www.wpro.who.int/vietnam/topics/hand_foot_mouth/factsheet/en/', '', NULL),
(454, 5, 5, '2014-10-27 06:24:50', 'In developing countries, what percentage of mothers and newborns do not receive skilled care during and immediately after child birth?', 1, 1717, '', 'http://www.wpro.who.int/vietnam/mediacentre/events/world_immunization_week/en/', '', NULL),
(455, 0, 5, '2014-10-27 06:26:08', 'Who is the world''s largest purchaser of vaccines?', 1, 1718, '', 'http://www.unicefusa.org/mission/survival/immunization', '', NULL),
(456, 1, 5, '2014-10-27 06:28:20', 'On average, how many newborn babies die every year in Vietnam?', 1, 1723, '', 'http://www.wpro.who.int/vietnam/topics/newborn_health/factsheet/en/', '', NULL),
(457, 1, 5, '2014-10-27 06:30:24', 'Since 1988, UNICEF has eradicated polio in ____ countries.', 1, 1728, '', 'http://www.unicefusa.org/mission/survival/immunization', '', NULL),
(458, 1, 5, '2014-10-27 06:32:10', 'How many Vietnamese children do not have access to clean water?', 1, 1731, '', '', '', NULL),
(459, 1, 5, '2014-10-27 06:34:01', 'Where can a child/infant receive proper vaccines?', 1, 1737, '', '', '', NULL),
(460, 1, 5, '2014-10-27 06:37:46', 'When does World Immunization Week take place every year?', 1, 1740, 'World Immunization Week is an opportunity to remind families and communities how effective vaccines are in preventing dangerous diseases. ', 'http://www.who.int/campaigns/immunization-week/2014/overview/en/', '', NULL),
(461, 1, 5, '2014-10-27 06:40:25', 'What was the slogan for World Immunization Week 2014?', 1, 1742, 'Each World Immunization Week focuses on a theme. Previous themes have included the following:\n    2014: “Are you up-to-date?”', 'http://en.wikipedia.org/wiki/World_Immunization_Week', '', NULL),
(462, 0, 5, '2014-10-27 06:48:05', 'Who does not receive optimal care during labour, birth and immediate postnatal period?', 1, 1748, '', '', '', NULL),
(475, 0, 5, '2015-01-02 13:52:31', 'Children are likely to be physically and emotionally abused\nif they live in families:', 1, 1801, '', 'http://www.svri.org/InnocentiVACInstitutional.pdf', '', NULL),
(476, 0, 5, '2015-01-02 13:54:20', 'Children are likely to be physically and emotionally abused\nif they live in families:', 1, 1805, '', 'http://www.svri.org/InnocentiVACInstitutional.pdf', '', NULL),
(477, 6, 5, '2015-01-05 06:46:41', 'From 2006-2011 how many reported cases of sexual abuse against children were there?', 1, 1808, 'In Vietnam, from 2006-2011 5,600 cases of sexual abuse against children were reported to police. ', 'http://unicefvietnam.blogspot.com/2014/06/viet-nam-responds-to-unicefs-global.html', 'http://heroforzero.be/assets/uploads/835557feda3d1d33118e02c19ec54b73.jpg', b'1'),
(478, 6, 5, '2015-01-05 09:57:17', 'How many women in Vietnam with children under 15 witnessed violence against their children by their husbands? ', 1, 1810, 'A quarter of all married women in Vietnam with children under the age of 15 witnessed their husbands use violence against their children.', 'http://unicefvietnam.blogspot.com/2014/06/viet-nam-responds-to-unicefs-global.html', 'http://heroforzero.be/assets/uploads/b90563fb6fd7c3693f1ca7272dbf1639.jpg', b'1'),
(479, 0, 5, '2015-01-05 06:53:17', 'Which day is national Children''s Day in Vietnam?', 1, 1815, 'In Viet Nam, the first day of summer, 1st June, traditionally marks the national Children’s Day and the start of the national Month of Actio', 'http://unicefvietnam.blogspot.com/2014/06/viet-nam-responds-to-unicefs-global.html', '', NULL),
(480, 0, 5, '2015-01-05 07:18:47', 'What percentage of mothers in Vietnam think that physical punishment is necessary to raise/educate children?', 1, 1819, 'About 18% of mothers in Vietnam believe that physical punishment is necessary to educate and raise their children. ', 'http://files.unicef.org/publications/files/Hidden_in_plain_sight_statistical_analysis_EN_3_Sept_2014.pdf', '', NULL),
(481, 6, 5, '2015-01-05 07:31:48', 'What percentage of fathers in Viet Nam believe that physical punishment is necessary to raise and educate children?', 1, 1823, 'About 17% of fathers in Vietnam think that physical punishment is necessary to raise and educate children. ', 'http://files.unicef.org/publications/files/Hidden_in_plain_sight_statistical_analysis_EN_3_Sept_2014.pdf', '', NULL),
(482, 6, 5, '2015-01-05 07:38:00', 'Based on income distribution which group is more likely to believe that corporal punishment is necessary?', 1, 1826, 'In most countries, wealthier section of\nthe population is less likely to believe that\ncorporal punishment is necessary than the poorer', 'http://files.unicef.org/publications/files/Hidden_in_plain_sight_statistical_analysis_EN_3_Sept_2014.pdf', '', b'1'),
(483, 6, 5, '2015-01-05 07:43:07', 'Parents of which educational background are more likely to think that physical punishment is necessary?', 1, 1831, 'Overall, adults with little or no education are more likely than their more educated peers to think that physical punishment is necessary.', 'http://files.unicef.org/publications/files/Hidden_in_plain_sight_statistical_analysis_EN_3_Sept_2014.pdf', '', b'1'),
(484, 6, 5, '2015-01-05 09:56:14', 'What percentage of children in Vietnam between the ages of 2-14 have experienced physical punishment?', 1, 1837, 'Although only about 17% of parents think that physical punishment is necessary, 53% of children experienced physical punishment. ', 'http://files.unicef.org/publications/files/Hidden_in_plain_sight_statistical_analysis_EN_3_Sept_2014.pdf', '', b'1'),
(485, 6, 5, '2015-01-05 08:12:17', 'What percentage of women worldwide are child brides (married before the age of 18)?', 1, 1840, 'Women aged 20 to 24 worldwide, about one in three were child brides.  Many factors interact to place a girl at risk of marriage.', 'http://data.unicef.org/child-protection/child-marriage', '', b'1'),
(486, 1, 5, '2015-01-05 08:51:34', 'In what ways can child marriage (marriage under the age of 18) compromise a girl''s development?', 1, 1845, 'Child marriage often results in early pregnancy and social isolation, interrupted her schooling, limited career and vocational options', 'http://data.unicef.org/child-protection/child-marriage', '', b'1'),
(487, 6, 5, '2015-01-05 08:59:41', 'How many children worldwide are engaged in child labour?', 1, 1846, 'In the least developed countries, nearly one in four children (5-14) are engaged in labour that is considered detrimental to their health', 'http://data.unicef.org/child-protection/child-labour', '', b'1'),
(488, 0, 5, '2015-01-05 09:10:42', 'Why is it important that children be registered at birth?', 1, 1853, 'Registering children at birth is the first step in securing their recognition before the law, safeguarding their rights. ', 'http://data.unicef.org/child-protection/birth-registration', '', NULL),
(489, 1, 5, '2015-01-05 09:13:31', 'Why is it important that children be registered at birth?', 1, 1857, 'Registering children at birth is the first step in securing their recognition before the law and safeguarding their rights.', 'http://data.unicef.org/child-protection/birth-registration', '', b'1'),
(490, 1, 5, '2015-01-05 09:19:08', 'How many children worldwide under the age of five were not registered at birth?', 1, 1861, 'A name and nationality is every child’s right, enshrined in the Convention on the Rights of the Child and other international treaties. ', 'http://data.unicef.org/child-protection/birth-registration', '', b'1'),
(491, 6, 5, '2015-01-05 09:34:21', 'What percentage of adolescent girls in Southeast Asia believe that wife-beating can be justified in certain circumstances?', 1, 1865, 'Nearly half of adolescent girls worldwide say\nwife-beating can be justified under certain circumstances. ', 'http://files.unicef.org/publications/files/Hidden_in_plain_sight_statistical_analysis_EN_3_Sept_2014.pdf', '', b'1');

-- --------------------------------------------------------

--
-- Table structure for table `quizcategory`
--

CREATE TABLE IF NOT EXISTS `quizcategory` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=15 ;

--
-- Dumping data for table `quizcategory`
--

INSERT INTO `quizcategory` (`Id`, `CategoryName`) VALUES
(1, 'General'),
(5, 'Health'),
(6, 'Protection'),
(7, 'Education'),
(8, 'Nutrition'),
(9, 'Training'),
(10, 'Nutrition_Statistics'),
(11, 'Health_Diseases'),
(12, 'Health_SexEd'),
(13, 'Internet Protection'),
(14, 'Environment');

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
  `AvatarId` int(11) DEFAULT '1',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=397 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`Id`, `FullName`, `Email`, `RegisterDate`, `PhoneNumber`, `Address`, `AvatarId`) VALUES
(1, 'Vu Hoang Son', 'gun4boy@yahoo.com', '2014-04-25 00:00:00', '', NULL, 0),
(2, 'Chùa Kỳ Quang', 'hanoi.registry@unicef.org', '2014-11-01 00:00:00', NULL, NULL, 1),
(3, 'Unicef Vietnam', 'hanoi.registry@unicef.org', '2014-11-01 00:00:00', NULL, NULL, 1),
(4, 'Agapevn', 'hanoi.registry@unicef.org', '2014-11-01 00:00:00', NULL, NULL, 1),
(18, NULL, 'hanoi.registry@unicef.org', '2014-11-01 00:00:00', NULL, NULL, 1),
(21, NULL, 'imrhung@yahoo.com', '2014-05-07 02:21:25', '84912880656', NULL, 1),
(24, 'Ngọc Tân', '0', '2014-05-12 00:00:00', '', NULL, 1),
(25, 'Angel Mai Mai', '0', '2014-05-12 00:00:00', '', NULL, 0),
(26, NULL, 'hanoi.registry@unicef.org', '2014-11-01 00:00:00', NULL, NULL, 1),
(30, NULL, 'hanoi.registry@unicef.org', '2014-11-01 00:00:00', NULL, NULL, 1),
(32, 'Luan Jenkins', 'luan.jenkins@gmail.com', '2014-06-06 00:00:00', '', NULL, 2),
(33, 'Tuan Anh Do', '0', '2014-06-08 00:00:00', '', NULL, 1),
(35, 'Mariah Cannon', '0', '2014-06-24 00:00:00', '', NULL, 2),
(36, NULL, 'mariahhcannon@gmail.com', '2014-07-03 04:09:53', '012345678', NULL, 1),
(37, 'Nathan Heffington', '0', '2014-07-12 00:00:00', '', NULL, 1),
(38, NULL, 'Dana@LINvn.org', '2014-07-14 02:05:44', '848-3512-0092', NULL, 1),
(39, NULL, 'contact@thaodan.org.vn', '2014-07-16 04:03:31', '(08)38465410', NULL, 1),
(40, NULL, 'info@luanjenkins.com', '2014-07-21 03:48:39', '0902826031', NULL, 1),
(42, 'Mã Trung', '0', '2014-07-25 00:00:00', '', NULL, 2),
(43, 'Sky Nguyễn', '0', '2014-07-25 00:00:00', '', NULL, 2),
(44, 'Boynamanh Duc', '0', '2014-07-25 00:00:00', '', NULL, 1),
(45, 'Nam Bui', '0', '2014-07-25 00:00:00', '', NULL, 1),
(87, 'Mai Mai', NULL, '2014-08-22 00:00:00', NULL, NULL, 1),
(120, 'Ducnm', NULL, '2014-08-29 00:00:00', NULL, NULL, 1),
(168, 'sonka', NULL, '2014-08-31 00:00:00', NULL, NULL, 2),
(177, 'thương', NULL, '2014-09-05 00:00:00', NULL, NULL, 1),
(182, 'nhutminh', NULL, '2014-09-10 00:00:00', NULL, NULL, 1),
(183, 'hoài thương', NULL, '2014-09-12 00:00:00', NULL, NULL, 1),
(187, 'khánh', NULL, '2014-09-12 00:00:00', NULL, NULL, 1),
(191, 'Philip Mai', 'phituanma@yahoo.com', '2014-09-14 00:00:00', '', NULL, 0),
(192, 'nick', NULL, '2014-09-14 00:00:00', NULL, NULL, 1),
(194, 'Mars Jupiter', NULL, '2014-09-15 00:00:00', NULL, NULL, 2),
(199, 'Nate', NULL, '2014-09-16 00:00:00', NULL, NULL, 1),
(200, 'bobby', NULL, '2014-09-17 00:00:00', NULL, NULL, 1),
(201, 'vinh ', NULL, '2014-09-19 00:00:00', NULL, NULL, 1),
(205, 'Hoang anh', NULL, '2014-09-25 00:00:00', NULL, NULL, 1),
(206, 'Bubble', NULL, '2014-09-26 00:00:00', NULL, NULL, 1),
(208, 'Nghia', NULL, '2014-09-26 00:00:00', NULL, NULL, 1),
(209, 'Jindo', NULL, '2014-09-27 00:00:00', NULL, NULL, 1),
(211, 'Jupiter', NULL, '2014-09-29 00:00:00', NULL, NULL, 1),
(212, 'Yen Ngoc', NULL, '2014-09-29 00:00:00', NULL, NULL, 2),
(213, 'Alex', NULL, '2014-10-03 00:00:00', NULL, NULL, 1),
(215, 'Alex1', NULL, '2014-10-03 00:00:00', NULL, NULL, 1),
(220, 'heather', NULL, '2014-10-05 00:00:00', NULL, NULL, 1),
(221, 'linh', NULL, '2014-10-05 00:00:00', NULL, NULL, 1),
(224, 'Mr Hung', NULL, '2014-10-05 00:00:00', NULL, NULL, 1),
(271, '29/10', NULL, '2014-10-28 00:00:00', NULL, NULL, 1),
(272, 'vvvvvv', NULL, '2014-10-29 00:00:00', NULL, NULL, 1),
(273, NULL, 'communication@koto.com.au', '2014-10-29 05:55:02', '+84 4 3718 4573', NULL, 1),
(274, NULL, 'osv-info@operationsmile.org', '2014-10-29 06:09:37', '(84) 8 2222 1008', NULL, 1),
(275, NULL, 'office@sosvietnam.org', '2014-10-29 06:17:22', '+84.4.37644019/ 37641229/ 37641233', NULL, 1),
(276, NULL, 'mariahhcannon@gmail.com', '2014-10-29 06:24:53', '+84.3827.8787', NULL, 1),
(280, 'Dat', NULL, '2014-11-03 00:00:00', NULL, NULL, 1),
(285, 'An', NULL, '2014-11-04 00:00:00', NULL, NULL, 1),
(286, 'Anny', NULL, '2014-11-04 00:00:00', NULL, NULL, 1),
(288, 'Bin', NULL, '2014-11-07 00:00:00', NULL, NULL, 1),
(290, 'ufo', NULL, '2014-11-07 00:00:00', NULL, NULL, 1),
(295, 'opla', NULL, '2014-11-11 00:00:00', NULL, NULL, 1),
(297, '[Nhật Nam]', NULL, '2014-11-11 00:00:00', NULL, NULL, 1),
(298, 'minh', NULL, '2014-11-16 00:00:00', NULL, NULL, 1),
(300, 'unicef', NULL, '2014-11-20 00:00:00', NULL, NULL, 2),
(301, 'vhson13', NULL, '2014-11-23 00:00:00', NULL, NULL, 1),
(302, 'vhson14', NULL, '2014-11-24 00:00:00', NULL, NULL, 1),
(303, 'luanj', NULL, '2014-11-24 00:00:00', NULL, NULL, 2),
(304, 'lee nguyen', NULL, '2014-12-06 00:00:00', NULL, NULL, 2),
(305, 'hung', NULL, '2014-12-06 00:00:00', NULL, NULL, 2),
(306, 'Francis Smith', '0', '2014-12-08 00:00:00', '', NULL, 0),
(307, 'flyflyerson', NULL, '2014-12-08 00:00:00', NULL, NULL, 1),
(308, 'te', NULL, '2014-12-08 00:00:00', NULL, NULL, 1),
(309, '김진수', '0', '2014-12-09 00:00:00', '', NULL, 0),
(310, 'Паша', NULL, '2014-12-09 00:00:00', NULL, NULL, 1),
(311, 'Nell', NULL, '2014-12-09 00:00:00', NULL, NULL, 1),
(312, 'Вашид', NULL, '2014-12-09 00:00:00', NULL, NULL, 1),
(313, 'druggo', NULL, '2014-12-09 00:00:00', NULL, NULL, 1),
(314, 'Mel', NULL, '2014-12-09 00:00:00', NULL, NULL, 1),
(315, 'Tung Wanicha', '0', '2014-12-09 00:00:00', '', NULL, 0),
(316, 'Babs', NULL, '2014-12-09 00:00:00', NULL, NULL, 1),
(317, 'mic gukib', NULL, '2014-12-09 00:00:00', NULL, NULL, 1),
(318, 'Amy Breckenridge', '0', '2014-12-09 00:00:00', '', NULL, 0),
(319, 'Gamicka', NULL, '2014-12-09 00:00:00', NULL, NULL, 1),
(320, 'mike', NULL, '2014-12-09 00:00:00', NULL, NULL, 1),
(321, 'coachrat', NULL, '2014-12-09 00:00:00', NULL, NULL, 1),
(322, 'Cheyanne Lumpkin', '0', '2014-12-09 00:00:00', '', NULL, 0),
(323, 'Repanza', NULL, '2014-12-09 00:00:00', NULL, NULL, 1),
(324, 'emma', NULL, '2014-12-09 00:00:00', NULL, NULL, 2),
(325, 'aiza', NULL, '2014-12-09 00:00:00', NULL, NULL, 1),
(326, 'Dani', NULL, '2014-12-09 00:00:00', NULL, NULL, 1),
(327, 'Ngoc Nhan Tran Le', '0', '2014-12-09 00:00:00', '', NULL, 0),
(328, 'jose', NULL, '2014-12-10 00:00:00', NULL, NULL, 1),
(329, 'Asuka', NULL, '2014-12-10 00:00:00', NULL, NULL, 1),
(330, 'Brittany Blair', '0', '2014-12-10 00:00:00', '', NULL, 0),
(331, 'Naat', NULL, '2014-12-10 00:00:00', NULL, NULL, 1),
(332, 'Briana', NULL, '2014-12-10 00:00:00', NULL, NULL, 1),
(333, 'Tinkerkel', NULL, '2014-12-10 00:00:00', NULL, NULL, 1),
(334, 'Vintagezombieee ', NULL, '2014-12-10 00:00:00', NULL, NULL, 2),
(335, '馬玟欣', '0', '2014-12-10 00:00:00', '', NULL, 0),
(336, 'pimpdanny619', NULL, '2014-12-10 00:00:00', NULL, NULL, 1),
(337, 'rhyzis', NULL, '2014-12-10 00:00:00', NULL, NULL, 1),
(338, 'Oliver', NULL, '2014-12-10 00:00:00', NULL, NULL, 1),
(339, 'Tyra', NULL, '2014-12-10 00:00:00', NULL, NULL, 1),
(340, 'Kalynn ', NULL, '2014-12-10 00:00:00', NULL, NULL, 1),
(341, 'iMum', NULL, '2014-12-10 00:00:00', NULL, NULL, 1),
(342, 'beli', NULL, '2014-12-11 00:00:00', NULL, NULL, 1),
(343, 'iphone6', NULL, '2014-12-11 00:00:00', NULL, NULL, 1),
(344, 'Robin Karlsson', '0', '2014-12-11 00:00:00', '', NULL, 0),
(345, 'hhh', NULL, '2014-12-11 00:00:00', NULL, NULL, 1),
(346, 'Elizabeth', NULL, '2014-12-11 00:00:00', NULL, NULL, 2),
(347, 'Myy Nguyễn', '0', '2014-12-12 00:00:00', '', NULL, 0),
(348, 'Lord Christian the Mighty', NULL, '2014-12-12 00:00:00', NULL, NULL, 1),
(349, '하유라', '0', '2014-12-13 00:00:00', '', NULL, 0),
(350, 'pyrofalcon', NULL, '2014-12-14 00:00:00', NULL, NULL, 0),
(351, 'super Saylor ', NULL, '2014-12-14 00:00:00', NULL, NULL, 1),
(352, 'bejonce', NULL, '2014-12-15 00:00:00', NULL, NULL, 1),
(353, 'Yoyi ', NULL, '2014-12-15 00:00:00', NULL, NULL, 1),
(354, 'steph', NULL, '2014-12-15 00:00:00', NULL, NULL, 1),
(355, 'Sydney', NULL, '2014-12-15 00:00:00', NULL, NULL, 2),
(356, 'Diliah', NULL, '2014-12-15 00:00:00', NULL, NULL, 1),
(357, 'Bethany', NULL, '2014-12-16 00:00:00', NULL, NULL, 1),
(358, 'julie', NULL, '2014-12-16 00:00:00', NULL, NULL, 1),
(359, 'songndc', NULL, '2014-12-16 00:00:00', NULL, NULL, 1),
(360, 'Haley Faust', '0', '2014-12-17 00:00:00', '', NULL, 0),
(361, 'mermie', NULL, '2014-12-19 00:00:00', NULL, NULL, 2),
(362, 'Kath', NULL, '2014-12-21 00:00:00', NULL, NULL, 1),
(363, NULL, 'mollykelly@gmail.com', '2014-12-22 09:56:15', '0176455232', NULL, 1),
(364, 'Ryan ', NULL, '2014-12-23 00:00:00', NULL, NULL, 1),
(365, 'Yelena', NULL, '2014-12-24 00:00:00', NULL, NULL, 1),
(366, 'CDC ', NULL, '2014-12-25 00:00:00', NULL, NULL, 1),
(367, 'Huudan Phan', '0', '2014-12-29 00:00:00', '', NULL, 0),
(368, 'Toleen ', NULL, '2014-12-31 00:00:00', NULL, NULL, 2),
(369, 'I''m ', NULL, '2015-01-01 00:00:00', NULL, NULL, 1),
(370, 'mojon', NULL, '2015-01-04 00:00:00', NULL, NULL, 1),
(371, 'Lauren', NULL, '2015-01-05 00:00:00', NULL, NULL, 1),
(372, 'Nathan', NULL, '2015-01-06 00:00:00', NULL, NULL, 1),
(373, 'Chris', NULL, '2015-01-06 00:00:00', NULL, NULL, 1),
(374, 'ber', NULL, '2015-01-10 00:00:00', NULL, NULL, 1),
(375, 'Thi Nguyễn', '0', '2015-01-10 00:00:00', '', NULL, 0),
(376, NULL, 'bmtri@unicef.org', '2015-01-12 02:31:55', '0902501279', NULL, 1),
(377, 'Asuna', NULL, '2015-01-15 00:00:00', NULL, NULL, 1),
(378, 'Trang Thục Văn', '0', '2015-01-17 00:00:00', '', NULL, 0),
(379, 'Wayne Dong', '0', '2015-01-17 00:00:00', '', NULL, 0),
(380, 'Anelis Del Hall', '0', '2015-01-17 00:00:00', '', NULL, 0),
(381, 'Bethany Rose Berg', '0', '2015-01-19 00:00:00', '', NULL, 0),
(382, 'Bethany Rose', NULL, '2015-01-19 00:00:00', NULL, NULL, 1),
(383, 'Bob', NULL, '2015-01-23 00:00:00', NULL, NULL, 1),
(384, 'jim', NULL, '2015-01-23 00:00:00', NULL, NULL, 1),
(385, 'kate', NULL, '2015-01-30 00:00:00', NULL, NULL, 1),
(386, 'princess_kate', NULL, '2015-01-30 00:00:00', NULL, NULL, 1),
(387, 'Emerald Heart', '0', '2015-01-31 00:00:00', '', NULL, 0),
(388, 'JLamFamily', NULL, '2015-01-31 00:00:00', NULL, NULL, 1),
(389, 'Q Anh Ngoc Vu', '0', '2015-01-31 00:00:00', '', NULL, 0),
(390, 'iiii', NULL, '2015-02-01 00:00:00', NULL, NULL, 1),
(391, 'Hung Tada', NULL, '2015-02-01 00:00:00', NULL, NULL, 1),
(392, 'Tu le', NULL, '2015-02-01 00:00:00', NULL, NULL, 1),
(393, 'Tu le ngoc', NULL, '2015-02-01 00:00:00', NULL, NULL, 1),
(394, 'Katrina ', NULL, '2015-02-02 00:00:00', NULL, NULL, 1),
(395, 'JLam', NULL, '2015-02-02 00:00:00', NULL, NULL, 1),
(396, 'Areum Jung', '0', '2015-02-02 00:00:00', '', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `userapplication`
--

CREATE TABLE IF NOT EXISTS `userapplication` (
  `UserId` int(11) NOT NULL,
  `FacebookId` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Points` int(11) DEFAULT '0',
  `CurrentLevel` int(11) DEFAULT '0',
  `device_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `userapplication`
--

INSERT INTO `userapplication` (`UserId`, `FacebookId`, `Points`, `CurrentLevel`, `device_id`) VALUES
(1, '1498934909', 122, 0, NULL),
(24, '100002989569961', 436, 0, NULL),
(25, '548597684', 161, 0, NULL),
(32, '85500069', 273, 0, NULL),
(33, '1458138844428875', 4, 0, NULL),
(35, '10154275869240524', 648, 0, NULL),
(37, '10102113062587458', 10, 0, NULL),
(42, '869711813058521', 67, 0, NULL),
(43, '651970501560011', 174, 0, NULL),
(44, '763302353720189', 58, 0, NULL),
(45, '839219746090060', 193, 0, NULL),
(87, NULL, 8, 0, '0A6F0B05-AD08-473C-857B-25D33CD86DEC'),
(120, NULL, 10, 0, 'BFCAD374-C063-4E14-BEA6-B60E7671A94A'),
(168, NULL, 61, 0, '61EBB4B7-805D-4AB0-A96F-60E2B772474C'),
(177, NULL, 83, 0, '002BF535-192D-45FF-9DEB-6C8D0A90BCD2'),
(182, NULL, 4, 0, '002BF535-192D-45FF-9DEB-6C8D0A90BCD2'),
(183, NULL, 12, 0, '45CD7126-BDB6-4910-BBB9-8BE2C394B9F3'),
(187, NULL, 374, 0, '45CD7126-BDB6-4910-BBB9-8BE2C394B9F3'),
(191, '100000561357440', 293, 0, NULL),
(192, NULL, 25, 0, '45CD7126-BDB6-4910-BBB9-8BE2C394B9F3'),
(194, NULL, 52, 0, 'C36F44DD-23ED-43D2-94B3-28D6586741A3'),
(199, NULL, 7, 0, 'C36F44DD-23ED-43D2-94B3-28D6586741A3'),
(200, NULL, 52, 0, 'C36F44DD-23ED-43D2-94B3-28D6586741A3'),
(201, NULL, 7, 0, '18E0C976-1F24-44EE-A218-85D4CDB8F769'),
(205, NULL, 20, 0, '88362150-8E6C-4FCE-B6A2-F76D12738236'),
(206, NULL, 85, 0, '42F6EEDF-A31E-4CAA-BB90-A6F91692CF6B'),
(208, NULL, 5, 0, 'E0C220B6-633E-45B8-B6CB-659A7AEDA99F'),
(209, NULL, 25, 0, 'E0C220B6-633E-45B8-B6CB-659A7AEDA99F'),
(211, NULL, 25, 0, 'E11A0F4B-8B73-4699-9DEE-8AFA07697A2F'),
(212, NULL, 27, 0, '735D8104-6CD6-4669-AF0E-D79432C9AD0E'),
(213, NULL, 15, 0, 'B2F7512C-50C1-4FBB-8A9D-2FC1F84088B5'),
(215, NULL, 32, 0, 'E0AF1652-22FF-4CBB-BC7D-2D477FCD5481'),
(220, NULL, 8, 0, 'E6965FD1-BB5A-4F5D-B91E-618EF7D476F3'),
(221, NULL, 26, 0, 'E6965FD1-BB5A-4F5D-B91E-618EF7D476F3'),
(224, NULL, 27, 0, '12F35563-186C-4BEE-A0A5-2BEA702DE5FB'),
(271, NULL, 30, 0, 'CECF4758-5B05-4646-A22E-0F502B1F8E42'),
(272, NULL, 10, 0, 'CECF4758-5B05-4646-A22E-0F502B1F8E42'),
(280, NULL, 7, 0, 'C36F44DD-23ED-43D2-94B3-28D6586741A3'),
(285, NULL, 48, 0, 'E6965FD1-BB5A-4F5D-B91E-618EF7D476F3'),
(286, NULL, 16, 0, 'E6965FD1-BB5A-4F5D-B91E-618EF7D476F3'),
(288, NULL, 32, 0, 'B4B62961-97F8-4208-9F9D-EFFF5BBD3F38'),
(290, NULL, 23, 0, 'DE2BB2C9-3BB9-4979-B509-7E38B938298E'),
(295, NULL, 22, 0, '47DC3B98-2B31-4563-8509-034D4704C8F3'),
(297, NULL, 6, 0, '4C39C03F-D140-4DC2-8245-E512D6529063'),
(298, NULL, 8, 0, '002BF535-192D-45FF-9DEB-6C8D0A90BCD2'),
(300, NULL, 0, 0, 'DA7EEDAA-A8C5-49CA-BFF4-7D5A8EA839D6'),
(301, NULL, 36, 0, '45CD7126-BDB6-4910-BBB9-8BE2C394B9F3'),
(302, NULL, 32, 0, '45CD7126-BDB6-4910-BBB9-8BE2C394B9F3'),
(303, NULL, 1, 0, '47DC3B98-2B31-4563-8509-034D4704C8F3'),
(304, NULL, 10, 0, 'BB9D8A8E-405B-4B5F-B46F-B2E5758F56E3'),
(305, NULL, 1, 0, 'BB9D8A8E-405B-4B5F-B46F-B2E5758F56E3'),
(306, '485238781614942', 0, 0, NULL),
(307, NULL, 0, 0, '14DB7565-CB5C-442D-AB7E-33405A02E656'),
(308, NULL, 0, 0, 'E6965FD1-BB5A-4F5D-B91E-618EF7D476F3'),
(309, '845450358855795', 4, 0, NULL),
(310, NULL, 0, 0, '033175A1-B320-4E43-8FD1-510C2B86367B'),
(311, NULL, 11, 0, '6265946A-4681-42C3-A528-D89912EDD07E'),
(312, NULL, 13, 0, '6A0E36CF-D08A-4FD6-8A56-40F2488AA2FA'),
(313, NULL, 0, 0, 'B6F6DED8-8B59-4C95-8D2F-465DF54C5E84'),
(314, NULL, 0, 0, '5A9C3C40-3A5E-4223-8CA8-6454BD084E71'),
(315, '10203092419656187', 5, 0, NULL),
(316, NULL, 0, 0, '7FC2AED8-A5F9-49D6-8B0E-548B9C5F17CF'),
(317, NULL, 13, 0, 'F2E6BF77-548F-4615-A41D-86BA1C55F2F6'),
(318, '10152453497885636', 14, 0, NULL),
(319, NULL, 0, 0, 'D1DFE30A-C5C2-4658-AF3E-7E226E2D5662'),
(320, NULL, 10, 0, '0C1B8ECD-652F-4638-9AC8-1E421A4BB55F'),
(321, NULL, 5, 0, '1B07E0EF-7EF7-419C-B695-9281C37DC44D'),
(322, '842561739130129', 63, 0, NULL),
(323, NULL, 0, 0, '5ECD2DE8-8A34-4F02-B0C2-94793681E15A'),
(324, NULL, 13, 0, '205F5833-3B7E-4326-8923-3BB81DFDA921'),
(325, NULL, 0, 0, 'B308891D-B55D-45EF-9D1C-90E13B33A609'),
(326, NULL, 36, 0, '9101B8CA-7A14-4E5F-8805-2A958BD5DD76'),
(327, '771502402920092', 49, 0, NULL),
(328, NULL, 2, 0, 'C21FC986-B38B-43F3-AEA3-42795C13B0F8'),
(329, NULL, 4, 0, 'F933C50D-F177-47B6-AB3F-93FD8E0F8F6D'),
(330, '757642220990425', 73, 0, NULL),
(331, NULL, 9, 0, '5FC5E226-6A2E-4659-9251-464445BD0B6C'),
(332, NULL, 0, 0, '62ED4232-C993-4CED-A2C5-FEEC5F329414'),
(333, NULL, 0, 0, '8981C636-86C4-467B-BCFE-196D7B608F8F'),
(334, NULL, 14, 0, 'FB3EF517-46D2-476D-936F-9A1C2FCA2D5D'),
(335, '803979729659210', 0, 0, NULL),
(336, NULL, 9, 0, '14B362D4-6ACC-4E11-9496-00EBBB37BCE9'),
(337, NULL, 0, 0, '49534ED5-1314-4551-99A4-394815E222CB'),
(338, NULL, 52, 0, 'D2FBF765-1916-48D2-86F9-F3B6F4E9BE5D'),
(339, NULL, 0, 0, '9AD442CF-6922-42F1-B028-4E34D687AFA8'),
(340, NULL, 0, 0, 'A1EC1FD2-4969-43C7-BE34-B251F818718D'),
(341, NULL, 0, 0, '86CACD15-4CFA-4B8F-9B2C-E246AB2D9DA4'),
(342, NULL, 0, 0, '958FD7AD-D59A-484F-B33F-6533BBC9EA5D'),
(343, NULL, 10, 0, '868D0239-1F10-4336-9809-AB64243A4E0C'),
(344, '778485668867127', 10, 0, NULL),
(345, NULL, 4, 0, '2FD5AAD3-57CE-4DBD-BA42-8CCBADAD5AE3'),
(346, NULL, 60, 0, '909FDAC0-B57F-4F15-8707-ED3FC86F7B6D'),
(347, '1037120219637808', 0, 0, NULL),
(348, NULL, 22, 0, 'D8A60404-AB91-4DE9-BA27-EBD4A130464E'),
(349, '303426736533049', 0, 0, NULL),
(350, '801339606592429', 15, 0, 'EC638C51-A4C6-4B19-A62E-E2D64452A08C'),
(351, NULL, 53, 0, '619E56F1-1A03-44B0-B5AF-B09EC58A48A1'),
(352, NULL, 0, 0, '5AF8A6DA-6F5D-44EA-B65B-12D88F87D8C2'),
(353, NULL, 59, 0, '197DCA33-3938-4A39-8912-2563A2789E60'),
(354, NULL, 55, 0, 'ACB273BA-E9A3-4B71-9530-E4677EB38DEB'),
(355, NULL, 5, 0, '9D27B78D-E124-4590-84B5-82A562140B43'),
(356, NULL, 4, 0, 'E2A39D71-F89F-4844-BCB4-1089E553C5AB'),
(357, NULL, 0, 0, 'F8B98359-46BA-44D7-9276-E97CF35BB877'),
(358, NULL, 0, 0, 'BA98F2B7-A212-402E-8A85-B44F116F9B13'),
(359, NULL, 8, 0, '58E941E3-7D32-4AB0-AFD3-D36012D62AC4'),
(360, '1735566493335482', 0, 0, NULL),
(361, NULL, 65, 0, '29E9DA5D-9858-4C4A-A196-5CE0B49AAB2E'),
(362, NULL, 9, 0, 'BF5095C4-34ED-46B5-A45A-FCF2EE124F09'),
(364, NULL, 13, 0, '3C257695-568F-4DF8-B83C-8BB7CE84D39D'),
(365, NULL, 17, 0, 'A1E938DA-F330-4AD4-9602-E6A776E681F4'),
(366, NULL, 0, 0, '87909C54-772E-4315-9840-752A8F3648D3'),
(367, '831075353600533', 3, 0, NULL),
(368, NULL, 21, 0, 'C7331221-FBA9-4697-B8A2-3CC559ECEAA6'),
(369, NULL, 4, 0, '971E2AAF-C03F-49B0-864F-9C7387F8BDB4'),
(370, NULL, 48, 0, '1B105846-06A5-4A3B-BE64-456194ABE8E8'),
(371, NULL, 12, 0, '9650F962-B2C8-4425-B3B2-85CA0AAA6C92'),
(372, NULL, 10, 0, 'E0F3D790-99C5-4351-9118-AEA5A75970A2'),
(373, NULL, 3, 0, '33B2BC0E-737E-4A1E-A4A3-4063C973FAD7'),
(374, NULL, 2, 0, '217DC582-FB75-48E7-95FA-B84638B220C2'),
(375, '776210272447908', 16, 0, NULL),
(377, NULL, 38, 0, '6CA44C2F-D37C-4C70-9B2B-21D3623E4732'),
(378, '788827821197338', 29, 0, NULL),
(379, '10152528156125841', 0, 0, NULL),
(380, '10152989290552480', 10, 0, NULL),
(381, '838705202852460', 151, 0, NULL),
(382, NULL, 0, 0, 'B58F019E-DEDC-4170-B13D-EAFFCA73E112'),
(383, NULL, 7, 0, '5D48D639-CCC3-4007-859E-BD8C39D1104F'),
(384, NULL, 0, 0, '5D48D639-CCC3-4007-859E-BD8C39D1104F'),
(385, NULL, 0, 0, '6BB2422B-8A67-4B6A-A472-8521E1CB5035'),
(386, NULL, 8, 0, '6BB2422B-8A67-4B6A-A472-8521E1CB5035'),
(387, '10206054471988796', 57, 0, NULL),
(388, NULL, 72, 0, 'FD6FF1F2-1755-4B35-AADE-6DCE786729F0'),
(389, '450139335134879', 49, 0, NULL),
(390, NULL, 3, 0, '79F64DB7-06E1-4C82-9EAB-185CC098D483'),
(391, NULL, 0, 0, 'whatever'),
(392, NULL, 0, 0, 'F77F62CC-29E5-4F46-99C1-F08E989F3B3C'),
(393, NULL, 0, 0, 'F77F62CC-29E5-4F46-99C1-F08E989F3B3C'),
(394, NULL, 153, 0, 'BF932156-6FB4-407A-9236-A8964C6D7102'),
(395, NULL, 97, 0, '2410E208-0DBB-48B4-B52C-56FE6B293489'),
(396, '879643898753357', 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `usercondition`
--

CREATE TABLE IF NOT EXISTS `usercondition` (
  `UserId` int(11) NOT NULL,
  `ConditionId` int(11) NOT NULL,
  `AchievingPoints` int(11) DEFAULT '0',
  PRIMARY KEY (`UserId`,`ConditionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Keep track user - condition on each quest. If user have record here, means that user have completed this condition. :)';

--
-- Dumping data for table `usercondition`
--

INSERT INTO `usercondition` (`UserId`, `ConditionId`, `AchievingPoints`) VALUES
(0, 0, 0),
(1, 0, 122),
(24, 0, 436),
(25, 0, 161),
(32, 0, 273),
(35, 0, 333),
(35, 433, 87),
(35, 434, -200),
(35, 443, 207),
(35, 446, 211),
(35, 447, 12),
(35, 506, 49),
(35, 566, 20),
(35, 567, -100),
(35, 584, 29),
(37, 443, 10),
(42, 0, 1),
(42, 595, 12),
(42, 600, 54),
(43, 0, 10),
(43, 584, 31),
(43, 585, 10),
(43, 586, 22),
(43, 587, 10),
(43, 588, 10),
(43, 589, 10),
(43, 590, 10),
(43, 591, 10),
(43, 592, 20),
(43, 593, 10),
(43, 595, 18),
(43, 600, 10),
(43, 601, 10),
(43, 602, 3),
(43, 603, -20),
(44, 0, 0),
(44, 595, 11),
(44, 600, 25),
(44, 601, 10),
(44, 602, 12),
(45, 584, 23),
(45, 585, 20),
(45, 586, 31),
(45, 587, 10),
(45, 588, 10),
(45, 589, 10),
(45, 590, 10),
(45, 591, 10),
(45, 592, 10),
(45, 593, 10),
(45, 595, 15),
(45, 600, 10),
(45, 601, 10),
(45, 602, 24),
(45, 603, -10),
(87, 0, 8),
(120, 0, 10),
(168, 0, 61),
(177, 0, 83),
(182, 0, 4),
(183, 0, 12),
(187, 0, 374),
(191, 0, 293),
(192, 0, 25),
(194, 0, 52),
(199, 0, 7),
(200, 0, 52),
(201, 0, 7),
(205, 0, 20),
(206, 0, 85),
(208, 0, 5),
(209, 0, 25),
(211, 0, 25),
(212, 0, 27),
(213, 0, 15),
(215, 0, 32),
(220, 0, 8),
(221, 0, 26),
(224, 0, 27),
(271, 0, 30),
(272, 0, 10),
(280, 0, 7),
(285, 0, 48),
(286, 0, 16),
(288, 0, 32),
(290, 0, 23),
(295, 0, 22),
(297, 0, 6),
(298, 0, 8),
(301, 0, 36),
(302, 0, 32),
(303, 0, 1),
(304, 0, 10),
(305, 0, 1),
(306, 0, 0),
(308, 0, 0),
(309, 0, 4),
(310, 0, 0),
(311, 0, 11),
(312, 0, 13),
(313, 0, 0),
(315, 0, 5),
(317, 0, 13),
(318, 0, 14),
(319, 0, 0),
(320, 0, 10),
(321, 0, 5),
(322, 0, 63),
(323, 0, 0),
(324, 0, 13),
(326, 0, 36),
(327, 0, 49),
(328, 0, 2),
(329, 0, 4),
(330, 0, 73),
(331, 0, 9),
(334, 0, 14),
(335, 0, 0),
(336, 0, 9),
(337, 0, 0),
(338, 0, 52),
(341, 0, 0),
(343, 0, 10),
(344, 0, 10),
(345, 0, 4),
(346, 0, 60),
(347, 0, 0),
(348, 0, 22),
(349, 0, 0),
(350, 0, 15),
(351, 0, 53),
(352, 0, 0),
(353, 0, 59),
(354, 0, 55),
(355, 0, 5),
(356, 0, 4),
(359, 0, 8),
(361, 0, 65),
(362, 0, 9),
(364, 0, 13),
(365, 0, 17),
(367, 0, 3),
(368, 0, 21),
(369, 0, 4),
(370, 0, 48),
(371, 0, 12),
(372, 0, 10),
(373, 0, 3),
(374, 0, 2),
(375, 0, 16),
(377, 0, 38),
(378, 0, 29),
(379, 0, 0),
(380, 0, 10),
(381, 0, 151),
(383, 0, 7),
(386, 0, 8),
(387, 0, 57),
(388, 0, 72),
(389, 0, 49),
(390, 0, 3),
(392, 0, 0),
(394, 0, 153),
(395, 0, 97),
(396, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `usermedal`
--

CREATE TABLE IF NOT EXISTS `usermedal` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` int(11) DEFAULT NULL,
  `MedalId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=322 ;

--
-- Dumping data for table `usermedal`
--

INSERT INTO `usermedal` (`Id`, `UserId`, `MedalId`) VALUES
(16, 42, 4),
(17, 43, 4),
(19, 43, 5),
(21, 0, 0),
(23, 44, 4),
(24, 43, 17),
(25, 43, 17),
(28, 45, 4),
(34, 45, 5),
(35, 45, 17),
(36, 45, 6),
(37, 43, 7),
(39, 45, 7),
(40, 43, 8),
(42, 45, 8),
(50, 0, 0),
(58, 0, 3),
(59, 44, 5),
(111, 1, 4),
(117, 168, 4),
(130, 1, 5),
(138, 24, 4),
(140, 25, 19),
(141, 24, 5),
(142, 24, 6),
(143, 24, 31),
(144, 25, 18),
(145, 25, 4),
(146, 25, 5),
(147, 177, 4),
(151, 187, 4),
(153, 187, 5),
(156, 187, 6),
(159, 187, 31),
(160, 187, 7),
(163, 191, 4),
(164, 192, 4),
(165, 194, 4),
(166, 194, 5),
(167, 194, 6),
(168, 1, 6),
(170, 200, 4),
(171, 200, 5),
(172, 191, 5),
(173, 191, 6),
(174, 191, 31),
(175, 191, 7),
(176, 191, 8),
(177, 191, 10),
(178, 32, 4),
(179, 32, 5),
(180, 32, 6),
(181, 208, 0),
(185, 24, 12),
(193, 209, 19),
(194, 209, 18),
(195, 211, 19),
(196, 211, 18),
(197, 24, 19),
(198, 24, 18),
(199, 212, 19),
(200, 212, 18),
(202, 215, 19),
(203, 32, 31),
(204, 221, 4),
(206, 224, 4),
(207, 224, 5),
(209, 35, 31),
(211, 35, 19),
(212, 35, 18),
(213, 32, 19),
(218, 35, 7),
(219, 35, 8),
(220, 35, 10),
(225, 32, 7),
(226, 35, 11),
(227, 271, 4),
(228, 35, 12),
(229, 285, 4),
(230, 285, 5),
(231, 286, 4),
(233, 288, 4),
(234, 288, 5),
(235, 290, 4),
(237, 25, 6),
(238, 295, 4),
(239, 301, 4),
(240, 32, 8),
(241, 302, 4),
(242, 304, 4),
(243, 191, 11),
(244, 311, 4),
(245, 312, 4),
(246, 317, 4),
(247, 318, 4),
(248, 322, 4),
(249, 322, 5),
(250, 322, 6),
(251, 324, 4),
(252, 326, 4),
(253, 326, 5),
(254, 327, 4),
(255, 327, 5),
(256, 330, 4),
(257, 330, 5),
(258, 330, 6),
(259, 334, 4),
(260, 191, 12),
(261, 343, 4),
(262, 344, 4),
(263, 346, 4),
(264, 346, 5),
(265, 346, 6),
(266, 348, 4),
(267, 350, 4),
(268, 351, 4),
(269, 351, 5),
(270, 351, 6),
(271, 353, 4),
(272, 353, 5),
(273, 353, 6),
(274, 354, 4),
(275, 354, 5),
(276, 354, 6),
(277, 338, 4),
(278, 338, 5),
(279, 338, 6),
(280, 361, 4),
(281, 361, 5),
(282, 365, 4),
(283, 361, 6),
(284, 368, 4),
(285, 370, 4),
(286, 370, 5),
(287, 370, 6),
(288, 371, 4),
(289, 372, 4),
(290, 375, 4),
(291, 377, 4),
(292, 377, 5),
(293, 32, 0),
(294, 378, 4),
(295, 378, 5),
(296, 380, 4),
(297, 381, 4),
(298, 381, 5),
(299, 381, 6),
(300, 381, 31),
(301, 381, 7),
(302, 381, 8),
(303, 387, 4),
(304, 387, 5),
(305, 387, 6),
(306, 388, 4),
(307, 388, 5),
(308, 388, 6),
(309, 389, 4),
(310, 389, 5),
(311, 389, 6),
(312, 394, 4),
(313, 394, 5),
(314, 394, 6),
(315, 394, 31),
(316, 394, 7),
(317, 394, 8),
(318, 395, 4),
(319, 395, 5),
(320, 395, 6),
(321, 395, 31);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=377 ;

--
-- Dumping data for table `userpartner`
--

INSERT INTO `userpartner` (`UserId`, `PartnerId`, `UserName`, `Password`) VALUES
(2, 22, 'chuakyquang', '24632717443dda87183269c364d29fc2'),
(3, 5, 'unicef_vietnam', 'e10adc3949ba59abbe56e057f20f883e'),
(4, 6, 'agapevn', 'e10adc3949ba59abbe56e057f20f883e'),
(18, 23, 'vapcrcso', 'a710cfe81722c4b1854018fbb6e3257c'),
(21, 24, 'ocean4', 'e10adc3949ba59abbe56e057f20f883e'),
(26, 19, 'maiamq8', '563fe85511b161723cf4118632fa8942'),
(30, 25, 'hoahongnho', 'e10adc3949ba59abbe56e057f20f883e'),
(36, 27, 'UNICEF NextGen', 'e10adc3949ba59abbe56e057f20f883e'),
(38, 28, 'LINCenter', 'eb2557a15c8d0cf2e9b09fce77fe661f'),
(39, 29, 'Thaodan', 'f5bb0c8de146c67b44babbf4e6584cc0'),
(40, 30, 'heroforzero', 'd276d1806dc00afd3ba6d4f03dc36dc4'),
(273, 32, 'KOTO Vietnam', '77394c44c8eae65cafc5c6adee2745ba'),
(274, 33, 'Operation Smile', '867657ee73300de8835094bc1d479a3b'),
(275, 34, 'SOS Villages', '7745f1a3dcfd3c2e941b1e8c9a026c03'),
(276, 35, 'Heartbeat', '7ccb2d9bdf23c9a7b7f0c68be0fd65a1'),
(363, 36, 'mollykelly', 'fcea920f7412b5da7be0cf42b8c93759'),
(376, 37, 'Minh Tri', 'aedcb52ef93883d28b79f9098467d916');

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
(2, 4),
(3, 3),
(4, 4),
(5, 4),
(6, 4),
(7, 4),
(8, 4),
(9, 4),
(10, 4),
(11, 4),
(12, 4),
(13, 4),
(14, 4),
(15, 4),
(18, 4),
(21, 4),
(26, 4),
(29, 4),
(30, 4),
(36, 4),
(38, 4),
(39, 4),
(40, 4),
(273, 4),
(274, 4),
(275, 4),
(276, 4),
(363, 4),
(376, 4);

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
-- Table structure for table `uservirtualquest`
--

CREATE TABLE IF NOT EXISTS `uservirtualquest` (
  `UserId` int(11) NOT NULL,
  `QuestId` int(11) NOT NULL,
  `Status` int(11) NOT NULL COMMENT 'Status: 1 = lock, 1 = unlock, 2 = solve',
  PRIMARY KEY (`UserId`,`QuestId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `uservirtualquest`
--

INSERT INTO `uservirtualquest` (`UserId`, `QuestId`, `Status`) VALUES
(1, 1, 2),
(19, 1, 1),
(20, 1, 1),
(23, 1, 1),
(24, 1, 2),
(25, 1, 2),
(311, 2, 1),
(27, 1, 1),
(31, 1, 1),
(345, 1, 1),
(326, 3, 1),
(32, 1, 2),
(33, 1, 1),
(45, 1, 2),
(285, 1, 2),
(35, 1, 2),
(35, 2, 2),
(35, 3, 2),
(37, 1, 1),
(35, 4, 2),
(45, 2, 2),
(224, 2, 2),
(43, 4, 2),
(211, 1, 1),
(354, 1, 2),
(346, 1, 2),
(288, 1, 2),
(43, 2, 2),
(42, 1, 2),
(43, 1, 2),
(307, 1, 1),
(44, 1, 2),
(212, 1, 1),
(42, 2, 1),
(43, 3, 2),
(44, 2, 2),
(286, 2, 1),
(45, 3, 2),
(45, 4, 2),
(43, 5, 2),
(224, 1, 2),
(45, 5, 2),
(43, 6, 1),
(45, 6, 1),
(208, 1, 1),
(346, 2, 2),
(213, 1, 1),
(326, 2, 2),
(87, 1, 1),
(224, 3, 1),
(35, 10, 1),
(0, 1, 1),
(44, 3, 1),
(326, 1, 2),
(325, 1, 1),
(324, 2, 1),
(271, 2, 1),
(344, 2, 1),
(330, 1, 2),
(329, 1, 1),
(280, 1, 1),
(35, 5, 2),
(327, 2, 2),
(327, 1, 2),
(328, 1, 1),
(327, 3, 1),
(323, 1, 1),
(322, 2, 2),
(297, 1, 1),
(311, 1, 2),
(353, 4, 1),
(1, 2, 2),
(290, 2, 1),
(324, 1, 2),
(322, 4, 1),
(353, 3, 2),
(322, 3, 2),
(285, 3, 1),
(285, 2, 2),
(25, 4, 1),
(187, 2, 2),
(191, 9, 2),
(177, 2, 1),
(288, 2, 2),
(288, 3, 1),
(286, 1, 2),
(177, 1, 2),
(32, 7, 1),
(348, 1, 2),
(347, 1, 1),
(306, 1, 1),
(301, 2, 1),
(290, 1, 2),
(221, 2, 1),
(346, 4, 1),
(221, 1, 2),
(220, 1, 1),
(215, 1, 1),
(312, 2, 1),
(318, 2, 1),
(187, 3, 2),
(271, 1, 2),
(35, 9, 2),
(209, 1, 1),
(100, 1, 1),
(101, 1, 1),
(102, 1, 1),
(103, 1, 1),
(104, 1, 1),
(105, 1, 1),
(106, 1, 1),
(107, 1, 1),
(108, 1, 1),
(109, 1, 1),
(110, 1, 1),
(111, 1, 1),
(112, 1, 1),
(113, 1, 1),
(318, 1, 2),
(187, 1, 2),
(308, 1, 1),
(192, 2, 1),
(191, 2, 2),
(187, 5, 2),
(305, 1, 1),
(304, 2, 1),
(183, 1, 1),
(120, 1, 1),
(300, 1, 1),
(302, 2, 1),
(295, 1, 2),
(182, 1, 1),
(303, 1, 1),
(304, 1, 2),
(187, 6, 1),
(353, 2, 2),
(353, 1, 2),
(192, 1, 2),
(317, 2, 1),
(352, 1, 1),
(191, 3, 2),
(200, 3, 1),
(200, 2, 2),
(200, 1, 2),
(199, 1, 1),
(206, 1, 1),
(205, 1, 1),
(32, 4, 2),
(346, 3, 2),
(317, 1, 2),
(316, 1, 1),
(32, 3, 2),
(32, 2, 2),
(201, 1, 1),
(191, 8, 2),
(191, 7, 2),
(191, 6, 2),
(191, 5, 2),
(191, 4, 2),
(187, 4, 2),
(191, 1, 2),
(312, 1, 2),
(194, 2, 2),
(194, 3, 2),
(194, 4, 1),
(194, 1, 2),
(1, 4, 1),
(313, 1, 1),
(319, 1, 1),
(314, 1, 1),
(302, 1, 2),
(272, 1, 1),
(168, 1, 2),
(168, 2, 1),
(315, 1, 1),
(24, 5, 1),
(321, 1, 1),
(1, 3, 2),
(32, 5, 2),
(322, 1, 2),
(24, 4, 2),
(24, 3, 2),
(24, 2, 2),
(25, 2, 2),
(25, 3, 2),
(320, 1, 1),
(298, 1, 1),
(295, 2, 1),
(351, 4, 1),
(344, 1, 2),
(351, 3, 2),
(343, 2, 1),
(351, 2, 2),
(351, 1, 2),
(343, 1, 2),
(342, 1, 1),
(341, 1, 1),
(310, 1, 1),
(32, 6, 2),
(340, 1, 1),
(339, 1, 1),
(338, 1, 2),
(191, 10, 1),
(337, 1, 1),
(336, 1, 1),
(335, 1, 1),
(334, 2, 1),
(334, 1, 2),
(333, 1, 1),
(332, 1, 1),
(331, 1, 1),
(330, 4, 1),
(330, 3, 2),
(35, 6, 2),
(35, 7, 2),
(35, 8, 2),
(350, 2, 1),
(350, 1, 2),
(349, 1, 1),
(348, 2, 1),
(309, 1, 1),
(301, 1, 2),
(330, 2, 2),
(354, 2, 2),
(354, 3, 2),
(354, 4, 1),
(355, 1, 1),
(356, 1, 1),
(357, 1, 1),
(358, 1, 1),
(359, 1, 1),
(360, 1, 1),
(338, 2, 2),
(338, 3, 2),
(338, 4, 1),
(361, 1, 2),
(361, 2, 2),
(361, 3, 2),
(362, 1, 1),
(364, 1, 1),
(365, 1, 2),
(365, 2, 1),
(366, 1, 1),
(361, 4, 1),
(367, 1, 1),
(368, 1, 2),
(368, 2, 1),
(369, 1, 1),
(370, 1, 2),
(370, 2, 2),
(370, 3, 2),
(370, 4, 1),
(371, 1, 2),
(371, 2, 1),
(372, 1, 2),
(372, 2, 1),
(373, 1, 1),
(374, 1, 1),
(375, 1, 2),
(375, 2, 1),
(377, 1, 2),
(377, 2, 2),
(377, 3, 1),
(378, 1, 2),
(378, 2, 2),
(378, 3, 1),
(379, 1, 1),
(380, 1, 2),
(380, 2, 1),
(381, 1, 2),
(381, 2, 2),
(382, 1, 1),
(381, 3, 2),
(381, 4, 2),
(381, 5, 2),
(381, 6, 2),
(381, 7, 1),
(383, 1, 1),
(384, 1, 1),
(385, 1, 1),
(386, 1, 1),
(387, 1, 2),
(387, 2, 2),
(387, 3, 2),
(387, 4, 1),
(388, 1, 2),
(388, 2, 2),
(388, 3, 2),
(388, 4, 1),
(389, 1, 2),
(389, 2, 2),
(389, 3, 2),
(389, 4, 1),
(390, 1, 1),
(391, 1, 1),
(392, 1, 1),
(393, 1, 1),
(394, 1, 2),
(394, 2, 2),
(394, 3, 2),
(394, 4, 2),
(394, 5, 2),
(394, 6, 2),
(394, 7, 1),
(395, 1, 2),
(396, 1, 1),
(395, 2, 2),
(395, 3, 2),
(395, 4, 2),
(395, 5, 1);

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
-- Stand-in structure for view `view_userinfo`
--
CREATE TABLE IF NOT EXISTS `view_userinfo` (
`uUserId` int(11)
,`uFacebookId` varchar(45)
,`uPoints` int(11)
,`uCurrentLevel` int(11)
,`vId` int(11)
,`vQuestName` varchar(45)
,`vPacketId` int(11)
,`vPartnerId` int(11)
,`vAnimationId` int(11)
,`vUnlockPoint` int(11)
,`vCreateDate` datetime
,`qStatus` int(11)
,`cId` int(11)
,`cType` int(11)
,`cValue` int(11)
,`cVirtualQuestId` int(11)
,`cObjectId` int(11)
);
-- --------------------------------------------------------

--
-- Table structure for table `virtualquest`
--

CREATE TABLE IF NOT EXISTS `virtualquest` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `QuestName` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PacketId` int(11) DEFAULT NULL,
  `PartnerId` int(11) DEFAULT NULL,
  `AnimationId` int(11) DEFAULT '1',
  `UnlockPoint` int(11) DEFAULT NULL,
  `CreateDate` datetime DEFAULT NULL,
  `ImageURL` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MedalId` int(11) NOT NULL DEFAULT '0' COMMENT 'Id connect to Medal table.',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=16 ;

--
-- Dumping data for table `virtualquest`
--

INSERT INTO `virtualquest` (`Id`, `QuestName`, `PacketId`, `PartnerId`, `AnimationId`, `UnlockPoint`, `CreateDate`, `ImageURL`, `MedalId`) VALUES
(1, 'Earn a sword', 1, 5, 6, 0, NULL, 'http://heroforzero.be/assets/img/quest/training-sword.png', 4),
(2, 'Earn a shield', 1, 5, 5, 10, NULL, 'http://heroforzero.be/assets/img/quest/training-shield.png', 5),
(3, 'Earn a cape', 1, 5, 4, 15, NULL, 'http://heroforzero.be/assets/img/quest/training-cape.png', 6),
(4, 'Help Tu get treatment', 2, 5, 8, 20, NULL, 'http://heroforzero.be/assets/img/quest/nutrition-minority.png', 31),
(5, 'Save Nam from hunger', 2, 5, 2, 25, NULL, 'http://heroforzero.be/assets/img/quest/nutrition-buddist.png', 7),
(6, 'Help Ty find food', 2, 5, 2, 30, NULL, 'http://heroforzero.be/assets/img/quest/nutrition-streetkid.png', 8),
(7, 'Help Son get an education', 3, 5, 3, 30, NULL, 'http://heroforzero.be/assets/img/quest/education-streetworker.png', 10),
(8, 'Help Mai go to school', 3, 5, 3, 35, NULL, 'http://heroforzero.be/assets/img/quest/education-minority.png', 11),
(9, 'Give Linh scholarships', 3, 5, 3, 35, NULL, 'http://heroforzero.be/assets/img/quest/education-minority.png', 12),
(10, 'Save Mai from the wolf', 4, 5, 4, 40, '2014-05-05 07:31:44', 'http://heroforzero.be/assets/img/quest/training-sword.png', 13),
(11, 'Save Lac from abuse', 4, 5, 4, 40, '2014-08-25 04:33:28', 'http://heroforzero.be/assets/img/quest/protection-abused.png', 14),
(12, 'Help Ty away from school bullying', 4, 5, 2, 40, '2014-09-04 07:41:07', 'http://heroforzero.be/assets/img/quest/nutrition-streetkid.png', 36),
(13, 'General Health', 6, 5, 1, 40, '2014-07-16 02:47:30', 'http://heroforzero.be/assets/img/quest/training-sword.png', 32),
(14, 'Help Wie get treatment', 6, 5, 1, 40, '2014-07-16 02:45:38', 'http://heroforzero.be/assets/img/quest/health-sick.png', 15),
(15, 'Disease', 6, 5, 1, 50, '2014-07-16 02:46:52', 'http://heroforzero.be/assets/img/quest/training-sword.png', 16);

-- --------------------------------------------------------

--
-- Structure for view `leaderboard`
--
DROP TABLE IF EXISTS `leaderboard`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `leaderboard` AS select `a`.`UserId` AS `id`,`u`.`FullName` AS `name`,`u`.`AvatarId` AS `avatar`,`a`.`Points` AS `mark`,`a`.`FacebookId` AS `facebook_id`,`a`.`CurrentLevel` AS `current_level`,(1 + (select count(0) from `userapplication` `r` where ((`r`.`Points` > `a`.`Points`) or ((`r`.`Points` = `a`.`Points`) and (`r`.`UserId` < `a`.`UserId`))))) AS `rank` from (`userapplication` `a` join `user` `u`) where (`a`.`UserId` = `u`.`Id`) order by (1 + (select count(0) from `userapplication` `r` where ((`r`.`Points` > `a`.`Points`) or ((`r`.`Points` = `a`.`Points`) and (`r`.`UserId` < `a`.`UserId`)))));

-- --------------------------------------------------------

--
-- Structure for view `view_userinfo`
--
DROP TABLE IF EXISTS `view_userinfo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_userinfo` AS select `u`.`UserId` AS `uUserId`,`u`.`FacebookId` AS `uFacebookId`,`u`.`Points` AS `uPoints`,`u`.`CurrentLevel` AS `uCurrentLevel`,`v`.`Id` AS `vId`,`v`.`QuestName` AS `vQuestName`,`v`.`PacketId` AS `vPacketId`,`v`.`PartnerId` AS `vPartnerId`,`v`.`AnimationId` AS `vAnimationId`,`v`.`UnlockPoint` AS `vUnlockPoint`,`v`.`CreateDate` AS `vCreateDate`,`q`.`Status` AS `qStatus`,`c`.`Id` AS `cId`,`c`.`Type` AS `cType`,`c`.`Value` AS `cValue`,`c`.`VirtualQuestId` AS `cVirtualQuestId`,`c`.`ObjectId` AS `cObjectId` from (((`userapplication` `u` join `uservirtualquest` `q` on((`u`.`UserId` = `q`.`UserId`))) join `virtualquest` `v` on((`q`.`QuestId` = `v`.`Id`))) join `questcondition` `c` on((`c`.`VirtualQuestId` = `v`.`Id`)));

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
