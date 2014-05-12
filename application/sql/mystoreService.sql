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
		 SELECT '0' as `code`, 'User is Exist' as 'message', userapplication.* FROM userapplication WHERE FacebookId = iFacebookId;
	ELSE
		START TRANSACTION;
			
			INSERT INTO user(Fullname, Email, RegisterDate, PhoneNumber) VALUES(iFullName, iEmail, curdate(), iPhone);
		
			set @userId = (SELECT LAST_INSERT_ID());
			
			INSERT INTO userapplication(UserId, FacebookId, Points, CurrentLevel) VALUES(@userId, iFacebookId, 0, 0);
			
			INSERT INTO uservirtualquest(UserId, QuestId, Status) VALUES (@userId, (SELECT Id FROM virtualquest LIMIT 1), 1);
			
			SELECT '1' as `code`, 'Regist successful' as 'message', v.*
			FROM virtualquest v
			JOIN uservirtualquest u 
			ON v.Id = u.QuestId 
			WHERE u.UserId = @userId;

		COMMIT;
			
	END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getDonationByPartnerId`(IN partnerId INT)
BEGIN
	SELECT * FROM Donation WHERE PartnerId = partnerId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getActivitiesByPartnerId`(IN partnerId INT)
BEGIN
	SELECT * FROM Activity WHERE PartnerId = partnerId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertSpentPointDonation`(IN partnerId INT,IN donationId INT,)
BEGIN
	
	BEGIN
		-- ERROR
		ROLLBACK;
	END;

	BEGIN
		-- WARNING
		ROLLBACK;
	END;
	
	START TRANSACTION;
		INSERT INTO Donation() VALUES ();
		
		SET @donationId = (SELECT LAST_INSERT_ID());
		
		SELECT * FROM WHERE DonationId = @donationId;
	COMMIT;
	
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getNumberOfChildrenByUserId`(IN userId INT)
BEGIN
	SELECT 7000000 - COUNT(*) FROM uservirtualquest WHERE UserId = userId AND Status = 2;
	
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Get_ActivityList`(IN currentPage INTEGER, IN pageSize INTEGER)
BEGIN
	#DECLARE rowNumber INT;
	SET @_pageSize = pageSize;
	SET @_currentPage = currentPage;
	
	SET @rowNumber = (@_currentPage * @_pageSize);
	
	if (@_pageSize != 0) 
	then
		PREPARE STMT FROM
		"SELECT activity.Id, activity.Title, activity.ActionContent, partner.PartnerName, activity.BonusPoint,  activity.IsApproved, activity.CreateDate
		FROM 
				travel_hero.activity,
				travel_hero.partner
		WHERE 
				activity.PartnerId = partner.Id
		LIMIT ?,?";
		EXECUTE STMT USING @rowNumber, @_pageSize;
		DEALLOCATE PREPARE STMT;
	else  
		SELECT activity.Id, activity.Title, activity.ActionContent, partner.PartnerName, activity.BonusPoint,  activity.IsApproved, activity.CreateDate
		FROM 
				travel_hero.activity,
				travel_hero.partner
		WHERE 
				activity.PartnerId = partner.Id;
		end if;	
END$$







