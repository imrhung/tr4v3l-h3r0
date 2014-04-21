DELIMITER //
CREATE DEFINER=`user_hau`@`localhost` PROCEDURE `sp_getPacketsBy`(IN currentPage INT, IN iPageSize INT)
BEGIN

	DECLARE rowNumber INT;
	SET currentPage = currentPage;
	SET rowNumber = currentPage * iPageSize;

		SELECT  
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
			c.Id AS cId,
			c.Type AS cType,
			c.Value AS cValue,
			c.VirtualQuestId AS cVirtualQuestId,
			c.ObjectId AS cObjectId
		FROM packet p
		JOIN (SELECT Id FROM packet LIMIT rowNumber, iPageSize) ids ON p.Id = ids.Id
		INNER JOIN virtualquest v 
		ON p.Id = v.PacketId
		INNER JOIN questcondition c
		ON c.VirtualQuestId = v.Id;
		
END//
DELIMITER;

CREATE DEFINER=`user_hau`@`localhost` PROCEDURE `sp_getQuizzBy`(IN iUserId INT)
BEGIN

END$$

CREATE DEFINER=`user_hau`@`localhost` PROCEDURE `sp_getUserProfileBy`(IN iUserId INT)
BEGIN

END$$

CREATE DEFINER=`user_hau`@`localhost` PROCEDURE `sp_getLeaderBoardBy`(IN iUserId INT)
BEGIN

END$$

CREATE DEFINER=`user_hau`@`localhost` PROCEDURE `sp_getUserAwardsBy`(IN iUserId INT)
BEGIN

END$$

CREATE DEFINER=`user_hau`@`localhost` PROCEDURE `sp_getActivitiesBy`(IN iUserId INT)
BEGIN

END$$

CREATE DEFINER=`user_hau`@`localhost` PROCEDURE `sp_getUserCurrentQuestBy`(IN iUserId INT)
BEGIN

END$$

CREATE DEFINER=`user_hau`@`localhost` PROCEDURE `sp_getNumberOfChildrenBy`(IN iUserId INT)
BEGIN

END$$

CREATE DEFINER=`user_hau`@`localhost` PROCEDURE `sp_insertUserQuest`(IN iUserId INT)
BEGIN

END$$

DELIMITER //
CREATE DEFINER=`user_hau`@`localhost` PROCEDURE `sp_insertUserFb`(IN iFullName VARCHAR(100),IN iEmail VARCHAR(100), IN iPhone VARCHAR(15), IN iFacebookId INT)
BEGIN

	# Parameter for main Store Proceduce
	declare userId int;
	
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
		
		INSERT INTO user(Fullname, Email, RegisterDate, PhoneNumber, Address) VALUES(iFullName, iEmail, curdate(), iPhone, iFacebookId);
	
		set userId = (SELECT LAST_INSERT_ID());
		
		INSERT INTO userapplication(UserId, FacebookId, Points, CurrentLevel) VALUES(userId, iFacebookId, 0, 0);
		
	COMMIT;
	
END//
DELIMITER ;