DELIMITER $$
CREATE PROCEDURE `sp_insertUserFb2`(IN iFullName VARCHAR(100),IN iEmail VARCHAR(100), IN iPhone VARCHAR(45), IN iFacebookId VARCHAR(45))
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