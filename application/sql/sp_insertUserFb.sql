CREATE VIEW view_userinfo AS
	SELECT u.UserId AS uUserId,
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
		c.ObjectId AS cObjectId
	FROM userapplication u
	JOIN uservirtualquest q ON u.UserId = q.UserId
	JOIN virtualquest v ON q.QuestId = v.Id
	JOIN questcondition c ON c.VirtualQuestId = v.Id

	
	
DELIMITER $$
CREATE PROCEDURE `sp_insertUserFb`(IN iFullName VARCHAR(100),IN iEmail VARCHAR(100), IN iPhone VARCHAR(45), IN iFacebookId VARCHAR(45))
BEGIN
	DECLARE var_userId INT;
	BEGIN
		-- ERROR
		ROLLBACK;
	END;

	BEGIN
		-- WARNING
		ROLLBACK;
	END;
	IF EXISTS(SELECT * FROM userapplication WHERE FacebookId = iFacebookId) 
	THEN
	
		SELECT UserId INTO @var_userId 
		FROM userapplication 
		WHERE FacebookId = iFacebookId;
		
		SELECT * 
		FROM (SELECT *, 1 AS is_completed 
				FROM view_userinfo 
				WHERE uUserId = @var_userId AND cId IN (
					SELECT ConditionId 
					FROM usercondition u 
					WHERE u.userId = @var_userId
				)
					
			UNION
			
			SELECT *, 0 AS is_completed 
			FROM view_userinfo 
			WHERE uUserId = @var_userId AND cId NOT IN (
				SELECT ConditionId 
				FROM usercondition u 
				WHERE u.userId = @var_userId
			)
		) AS tt
		ORDER BY cId;
	ELSE
		START TRANSACTION;
			
			INSERT INTO user(Fullname, Email, RegisterDate, PhoneNumber) VALUES(iFullName, iEmail, curdate(), iPhone);
		
			SET @var_userId = (SELECT LAST_INSERT_ID());
			
			INSERT INTO userapplication(UserId, FacebookId, Points, CurrentLevel) VALUES(@var_userId, iFacebookId, 0, 0);
			
			INSERT INTO uservirtualquest(UserId, QuestId, Status) VALUES (@var_userId, (SELECT Id FROM virtualquest LIMIT 1), 1);
			
			SELECT * 
			FROM (SELECT *, 1 AS is_completed 
					FROM view_userinfo 
					WHERE uUserId = @var_userId AND cId IN (
						SELECT ConditionId 
						FROM usercondition u 
						WHERE u.userId = @var_userId
					)
						
				UNION
				
				SELECT *, 0 AS is_completed 
				FROM view_userinfo 
				WHERE uUserId = @var_userId AND cId NOT IN (
					SELECT ConditionId 
					FROM usercondition u 
					WHERE u.userId = @var_userId
				)
			) AS tt
			ORDER BY cId;

		COMMIT;
		
	END IF;
	
END ;;
DELIMITER ;

100000334657072