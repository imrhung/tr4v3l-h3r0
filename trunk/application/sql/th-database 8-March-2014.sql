
DELIMITER $$
CREATE DEFINER=`user_hau`@`localhost` 
PROCEDURE `sp_insertpartnerregisterinfo`(IN pName VARCHAR(500)
										,IN pPhone VARCHAR(15)
										,IN pAddress VARCHAR(1000)
										,IN pTypeId TINYINT
										,IN pDesction VARCHAR(1000)
										,IN pWebsite VARCHAR(100)
										,IN pLatitude FLOAT
										,IN pLongitude FLOAT
										
										,IN fullName VARCHAR(100)
										,IN email VARCHAR(100)
										,IN phone VARCHAR(15)
										,IN address VARCHAR(500)
										
										,IN username VARCHAR(100)
										,IN `password` VARCHAR(100))

BEGIN
INSERT INTO `travel_hero`.`partner`
(`pName`,
`pPhone`,
`pAddress`,
`pTypeId`,
`pDesction`,
`pWebsite`,
`pLatitude`,
`pLongitude`)
VALUES
(pName,
pPhone,
pAddress,
pTypeId,
pDesction,
pWebsite,
pLatitude,
pLongitude);


INSERT INTO `travel_hero`.`representative`
(`fullName`,
`email`,
`phone`,
`address`,
`registerDate`)
VALUES
(fullName,
email,
phone,
address,
NOW());


DECLARE partnerId INT
SELECT pId INTO partnerId FROM `travel_hero`.`partner` WHERE `partner`.`pWebsite` = pWebsite

INSERT INTO `travel_hero`.`user_partner`
(`partnerId`,
`username`,
`password`)
VALUES
(partnerId,
username,
password);


END$$
DELIMITER;







CREATE TABLE partner
(
	pId INT  PRIMARY KEY NOT NULL AUTO_INCREMENT
	,pName VARCHAR(500)
	,pPhone VARCHAR(15)
	,pAddress VARCHAR(1000)
	,pTypeId TINYINT
	,pDesction VARCHAR(1000)
	,pWebsite VARCHAR(100)
	,pLatitude FLOAT
	,pLongitude FLOAT
);



CREATE TABLE organization_type
(
	typeId TINYINT  PRIMARY KEY NOT NULL AUTO_INCREMENT
	,typeName VARCHAR(100)
);

CREATE TABLE user_partner
(
	partnerId INT
	,username VARCHAR(100)
	,`password` VARCHAR(100)
);

CREATE TABLE representative
(
	userId INT
	,fullName VARCHAR(100)
	,email VARCHAR(100)
	,phone VARCHAR(15)
	,address VARCHAR(500)
	,registerDate DATETIME
);

CREATE TABLE role
(
	id TINYINT PRIMARY KEY NOT NULL AUTO_INCREMENT
	,name VARCHAR(50)
);
CREATE TABLE functions
(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT
	,name INT
	,iconUrl VARCHAR(500)
	,funcUrl VARCHAR(500) 
);


CALL `travel_hero`.`sp_insertpartnerregisterinfo`('A','a','address',1,'dadfadsf','adwcec',2.000,1.00,'fulname1','adsf@gmail', '097123', 'aderes', 'user', '123');


--------------------

CREATE TABLE quiz
(
	qId INT PRIMARY KEY NOT NULL AUTO_INCREMENT
	,categoryId INT
	,partnerId INT
	,content VARCHAR(8000)
	,bonusPoint INT
	,connectChoiceId INT
	,createDate DATETIME
	,correctChoiceId INT
	,sharingInfo VARCHAR(100)
	,learnMoreUrl VARCHAR(500)
	,imageUrl VARCHAR(500)
	,isApproved BIT
);

CREATE TABLE choice
(
	cId INT PRIMARY KEY NOT NULL AUTO_INCREMENT
	,qId INT
	,content VARCHAR(8000)
);

CREATE TABLE quiz_category
(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT
);







