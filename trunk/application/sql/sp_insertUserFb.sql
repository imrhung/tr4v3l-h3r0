-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`%` PROCEDURE `sp_insertUserFb`(IN iFullName VARCHAR(100),IN iEmail VARCHAR(100), IN iPhone VARCHAR(45), IN iFacebookId VARCHAR(45))
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
			WHERE u.UserId = @userId;

		COMMIT;
			
	END IF;
END