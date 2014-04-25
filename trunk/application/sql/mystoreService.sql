DELIMITER $$
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
			c.Id AS cId,
			c.Type AS cType,
			c.Value AS cValue,
			c.VirtualQuestId AS cVirtualQuestId,
			c.ObjectId AS cObjectId
		FROM packet p
		JOIN (SELECT Id FROM packet LIMIT ?,?) ids ON p.Id = ids.Id
		INNER JOIN virtualquest v 
		ON p.Id = v.PacketId
		INNER JOIN questcondition c
		ON c.VirtualQuestId = v.Id";
		EXECUTE STMT USING @rowNumber, @pageSize;
		DEALLOCATE PREPARE STMT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getQuizzBy`(IN iUserId INT)
BEGIN

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getUserProfileBy`(IN iUserId INT)
BEGIN

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getLeaderBoardBy`(IN iUserId INT)
BEGIN

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getUserAwardsBy`(IN iUserId INT)
BEGIN

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getActivitiesBy`(IN iUserId INT)
BEGIN

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getUserCurrentQuestBy`(IN iUserId INT)
BEGIN

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getNumberOfChildrenBy`(IN iUserId INT)
BEGIN

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertUserQuest`(IN iUserId INT)
BEGIN

END$$

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertUserFb`(IN iFullName VARCHAR(100),IN iEmail VARCHAR(100), IN iPhone VARCHAR(45), IN iFacebookId INT)
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
			c.Id AS cId,
			c.Type AS cType,
			c.Value AS cValue,
			c.VirtualQuestId AS cVirtualQuestId,
			c.ObjectId AS cObjectId

		FROM userapplication u
		JOIN uservirtualquest q ON u.UserId = q.UserId
		JOIN virtualquest v ON q.QuestId = v.Id
		JOIN questcondition c ON c.VirtualQuestId = v.Id
		WHERE FacebookId = iFacebookId;

	ELSE
		START TRANSACTION;
			
			INSERT INTO user(Fullname, Email, RegisterDate, PhoneNumber) VALUES(iFullName, iEmail, curdate(), iPhone);
		
			set @userId = (SELECT LAST_INSERT_ID());
			
			INSERT INTO userapplication(UserId, FacebookId, Points, CurrentLevel) VALUES(@userId, iFacebookId, 0, 0);
			
			INSERT INTO uservirtualquest(UserId, QuestId, Status) VALUES (@userId, (SELECT Id FROM virtualquest LIMIT 1), 1);
			
			SELECT '1' as `code`, 'Regist successful' as 'message', 
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
				c.Id AS cId,
				c.Type AS cType,
				c.Value AS cValue,
				c.VirtualQuestId AS cVirtualQuestId,
				c.ObjectId AS cObjectId

			FROM userapplication u
			JOIN uservirtualquest q ON u.UserId = q.UserId
			JOIN virtualquest v ON q.QuestId = v.Id
			JOIN questcondition c ON c.VirtualQuestId = v.Id
			WHERE u.UserId = @userId;

		COMMIT;
			
	END IF;
END$$
DELIMITER ;













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