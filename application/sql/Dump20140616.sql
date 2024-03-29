CREATE DATABASE  IF NOT EXISTS `zadmin_heroforzero` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `zadmin_heroforzero`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: 192.168.11.132    Database: zadmin_heroforzero
-- ------------------------------------------------------
-- Server version	5.6.14

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

--
-- Table structure for table `action`
--

DROP TABLE IF EXISTS `action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `action` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `action`
--

LOCK TABLES `action` WRITE;
/*!40000 ALTER TABLE `action` DISABLE KEYS */;
INSERT INTO `action` VALUES (1,'Share on their Facebook'),(2,'Sign up for Your news letter'),(3,'Like our facebook pages'),(4,'Add to User\'s calendar');
/*!40000 ALTER TABLE `action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity` (
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity`
--

LOCK TABLES `activity` WRITE;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
INSERT INTO `activity` VALUES (1,5,'Join NextGen on Facebook ','Join NextGen on Facebook to find other 18-35 year old leaders concerned about children!',4,100,'\0','2014-04-07 10:23:41','2014/06/02'),(3,5,'Change your profile to “Believe in ZERO”. ','Change your profile to “Believe in ZERO”. ',1,100,NULL,'2014-04-07 10:23:59','Change your profile to “Believe in ZERO”. '),(4,5,'Share this fact about children on your FB ','Share this fact about children on your FB – “100 children die every day in Vietnam of preventable causes.”',1,100,NULL,'2014-04-07 10:24:34','100 children die every day in Vietnam of preventable causes.'),(5,5,'Sign up for newsletter to keep updated with UNICEF activities in Vietnam','Sign up for newsletter to keep updated with UNICEF activities in Vietnam: partnershipvietnam@unicef.org',2,100,NULL,'2014-04-07 10:25:28','unicef.org/vietnam/vi/'),(6,5,'Share this fact about children on your FB ','Share this fact about children on your FB – “Every hour a child dies in Vietnam of an injury caused by traffic accidents or drowning.”',1,100,NULL,'2014-04-07 10:25:55','Every hour a child dies in Vietnam of an injury caused by traffic accidents or drowning.'),(7,5,'Volunteer to be a swimming coach and teach kids in the Mekong Delta how to swim!','Volunteer to be a swimming coach and teach kids in the Mekong Delta how to swim!',4,100,'\0','2014-04-07 10:26:15','2014/06/02'),(8,6,'Visit our children’s home in Vung Tau and teach English','Visit our children’s home in Vung Tau and teach English',1,100,NULL,'2014-04-07 10:33:17','Visit our children’s home in Vung Tau and teach English'),(9,6,'Sponsor a child on our website. Achvn.org/sponsor','Sponsor a child on our website. Achvn.org/sponsor',1,100,NULL,'2014-04-07 10:34:34','Sponsor a child on our website. Achvn.org/sponsor'),(10,6,'Like us on facebook and follow our feed.','Like us on facebook and follow our feed.',3,100,NULL,'2014-04-07 10:35:05','unicef.org/vietnam/vi/'),(11,6,'Share us on facebook','Just share make different',1,100,NULL,'2014-04-07 10:47:05','Hero for Zero'),(12,19,'Working as a volunteer to raise funds.','Working as a volunteer to raise funds ( writing a proposal, making an event, finding sponsors,…)',1,100,NULL,'2014-04-24 03:35:39','Working as a volunteer to raise funds ( writing a proposal, making an event, finding sponsors,…)'),(13,19,'Helping young children to revise or prepare lessons at home','Helping young children to revise or prepare lessons at home',1,100,NULL,'2014-04-24 03:35:52','Helping young children to revise or prepare lessons at home'),(14,19,'Teaching children some subjects','Teaching children some subjects such as drawing, dancing and making handmade products ',1,100,NULL,'2014-04-24 03:36:07','Teaching children some subjects such as drawing, dancing and making handmade products '),(15,19,'Helping staff in using IT / Internet','Helping staff in using IT / Internet',1,100,NULL,'2014-04-24 03:36:18','Helping staff in using IT / Internet'),(16,22,'Supporting to get all possible resources for the center. ','Supporting to get all possible resources for the center. ',1,100,NULL,'2014-04-28 16:00:45','Supporting to get all possible resources for the center. '),(17,22,'Participating in volunteer activities to look after and orient the children at the center. ','Participating in volunteer activities to look after and orient the children at the center. ',1,100,NULL,'2014-04-28 16:00:58','Participating in volunteer activities to look after and orient the children at the center. '),(18,23,'Doing volunteer work at the organization. ','Doing volunteer work at the organization. ',1,100,NULL,'2014-04-28 16:32:08','Doing volunteer work at the organization. '),(19,23,'Sharing information related to protection of children’s rights with other organizations.','Sharing information related to protection of children’s rights with other organizations.',1,100,NULL,'2014-04-28 16:32:27','Sharing information related to protection of children’s rights with other organizations.'),(20,23,'Introducing the organization to those who may concern.  ','Introducing the organization to those who may concern.  ',1,100,NULL,'2014-04-28 16:32:36','Introducing the organization to those who may concern.  '),(21,23,'Providing children with financial aid to support them. ','Providing children with financial aid to support them. ',1,100,NULL,'2014-04-28 16:32:44','Providing children with financial aid to support them. '),(22,24,'Sign up for email update from Ocean 4','We will send you email when there are some update for Heroforzero.',2,100,NULL,'2014-05-27 02:34:11','http://heroforzero.be/login'),(23,25,'Introducing Little Rose Story Warm Shelter','Introducing Little Rose Story Warm Shelter  to those who interest',1,100,NULL,'2014-05-29 03:30:00','Introducing Little Rose Story Warm Shelter'),(24,25,'Volunteering','Volunteering to raise fund for the Shelter ',1,100,NULL,'2014-05-29 03:30:22','Volunteering to raise fund for the Shelter ');
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `animation`
--

DROP TABLE IF EXISTS `animation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animation` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `time` float NOT NULL,
  `HeroAnimWalking` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `HeroAnimStandby` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `MonsterAnim` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `KidFrame` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `ColorR` int(11) NOT NULL,
  `ColorG` int(11) NOT NULL,
  `ColorB` int(11) NOT NULL,
  `ScreenShotURL` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animation`
--

LOCK TABLES `animation` WRITE;
/*!40000 ALTER TABLE `animation` DISABLE KEYS */;
INSERT INTO `animation` VALUES (1,60,'walking','standby','death_walking','sick-boy-1.png',242,156,51,NULL),(2,60,'cook_walking','cook_standby','death_walking','sick-boy-1.png',41,180,115,NULL),(3,60,'teacher_walking','teacher_standby','prisoner_walking','schoolgirl-1.png',17,152,195,NULL);
/*!40000 ALTER TABLE `animation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_sessions`
--

DROP TABLE IF EXISTS `app_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_sessions` (
  `session_id` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `ip_address` varchar(45) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `user_agent` varchar(120) CHARACTER SET utf8 NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `last_activity_idx` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_sessions`
--

LOCK TABLES `app_sessions` WRITE;
/*!40000 ALTER TABLE `app_sessions` DISABLE KEYS */;
INSERT INTO `app_sessions` VALUES ('dc1ad5986b367ba4d00b1a505ca67f24','192.168.11.114','Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.153 Safari/537.36',1402905116,'a:4:{s:9:\"user_data\";s:0:\"\";s:7:\"islogin\";b:1;s:4:\"role\";s:5:\"admin\";s:10:\"partner_id\";i:5;}');
/*!40000 ALTER TABLE `app_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `choice`
--

DROP TABLE IF EXISTS `choice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `choice` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `QuestionId` int(11) DEFAULT NULL,
  `Content` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=774 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `choice`
--

LOCK TABLES `choice` WRITE;
/*!40000 ALTER TABLE `choice` DISABLE KEYS */;
INSERT INTO `choice` VALUES (174,69,'Run and Hide'),(175,69,'Ignore it'),(176,69,'Call the 113 or 18001567 hotline to report'),(177,69,'Confront the aggressor'),(178,70,'Government'),(179,70,'Family'),(180,70,'Society'),(181,70,'All correct'),(182,71,'Children with disability'),(183,71,'Street children'),(184,71,'Poor children'),(185,71,'All correct'),(186,72,'1. Keep it for myself, otherwise other will tease me '),(187,72,'2. Report to parents or relatives '),(188,72,'3. Report to the local police, teachers or others'),(189,72,'2 & 3 correct'),(198,75,'110'),(199,75,'111'),(200,75,'112'),(201,75,'113'),(202,76,'2014-04-15 08:21:52'),(203,76,'115'),(204,76,''),(205,76,''),(210,78,'1'),(211,78,'2'),(212,78,'3'),(213,78,'4'),(214,79,'2'),(215,79,'2'),(216,79,'2'),(217,79,''),(222,81,'18'),(223,81,'Over 16'),(224,81,'Under/ = 16 years old'),(225,81,'14'),(226,82,'A police'),(227,82,'A teacher'),(228,82,'A doctor'),(229,82,'A person who is responsible for protection.'),(230,83,'Send a piece of sheet in the mail box '),(231,83,'Telephone to person you trust most'),(232,83,'Via email'),(233,83,'Face talk'),(234,84,'5'),(235,84,'3'),(236,84,'4'),(237,84,'6'),(238,85,'Abandoned or orphaned children. '),(239,85,'Disabled children.'),(240,85,'Immigrant children from other local areas. '),(241,85,'All of the above.'),(246,87,'All the children can learn to integrate with the comunity'),(247,87,'Only a few can learn to integrate with the community'),(248,87,'No children can learn to integrate with the community'),(249,87,'All  of the above are incorrect.'),(250,88,'Abandoned or orphaned children. '),(251,88,'Disabled children. '),(252,88,'Immigrant children from other local areas. '),(253,88,'All of the above.'),(254,89,'Street children, children doing heavy works'),(255,89,'Orphans, disabled children, sexually-abused.'),(256,89,'Chemicals-poisoned children, HIV-infected children'),(257,89,'All of the above.'),(258,90,'Injecting and preventing children from special situation'),(259,90,'Solving, helping and improving special situations '),(260,90,'Detecting, preventing and dealing'),(261,90,'All of the above.'),(262,91,'Around 52 years'),(263,91,'Around 72 years'),(264,91,'Around 92 years'),(265,91,'Around 42 years'),(266,92,'Eating healthy'),(267,92,'Physical activity'),(268,92,'Better hygiene'),(269,92,'Avoiding contact with animals'),(270,93,'2.000'),(271,93,'10.000'),(272,93,'18.000'),(273,93,'25.000'),(274,94,'World Health Organisation'),(275,94,'Unicef'),(276,94,'World Bank'),(277,94,'North Atlantic Treaty Organisation'),(278,95,'Heart Attacks and Diabetes'),(279,95,'Malnutrition and apendicitis'),(280,95,'Cogenital anormalities and pneunomia'),(281,95,'HIV and Malaria'),(282,96,'10'),(283,96,'20'),(284,96,'17'),(285,96,'2'),(286,97,'A. Loss of money to pay for the treatment.'),(287,97,'B. The next hospital is too far away.'),(288,97,'C. They do not feel sick “enough”.'),(289,97,'A and B are correct'),(290,98,'A. There is no statutory quality control.'),(291,98,'B. There is prescription for medications.'),(292,98,'C. They are all homeopathic.'),(293,98,'A and B are correct.'),(294,99,'The staff is nicer.'),(295,99,'The salary is higher.'),(296,99,'They get the chance to treat more people.'),(297,99,'No need to wear white coats.'),(298,100,'Around 5'),(299,100,'Around 10'),(300,100,'Around 20'),(301,100,'Around 50'),(302,101,'Solely public institutions.'),(303,101,'Solely private institutions.'),(304,101,'Public and private institutions.'),(305,101,' There is no health system in Vietnam.'),(306,102,'A. Big cities, like HCMC.'),(307,102,'B. Coastal cities, like Nha Trang.'),(308,102,'C. Central Highlands, like province Kon Tum'),(309,102,'A and B are correct'),(310,103,'A. Covering my skin with long clothes.'),(311,103,'B. Drinking carrot juice. The beta carotene.'),(312,103,'C. Using sun block.'),(313,103,'A and C are correct.'),(314,104,' Stop at red lights.'),(315,104,'Use blinkers.'),(316,104,'Respect speed limits. '),(317,104,'All correct.'),(318,105,'Hepatitis A'),(319,105,'Typhoid'),(320,105,'Yellow fever'),(321,105,'Routine vaccines, e.g. diphtheria-tetanus-pertussi'),(322,106,'Colds and flus'),(323,106,'Gastrointestinal effects'),(324,106,'Circulatory problems'),(325,106,'All correct'),(326,107,'Cover exposed skin'),(327,107,'Avoid sharing body fluids'),(328,107,'Select safe transportation '),(329,107,' All correct '),(330,108,'Solely eat raw food'),(331,108,'Do not wash your food before eating.'),(332,108,'Eat food that is cooked and served hot'),(333,108,'Drink as much tap water as possible'),(334,109,'Prescription medicines you usually take.'),(335,109,'Antibiotic prescribed for self-treatment'),(336,109,'Strong drugs like Morphine'),(337,109,'Bandages to treat small wounds'),(338,110,'cognitive development'),(339,110,'growth'),(340,110,'organ damage'),(341,110,'all correct'),(342,111,'29'),(343,111,'30'),(344,111,'40'),(345,111,'50'),(346,112,'1,85'),(347,112,'4,25'),(348,112,'0,20'),(349,112,'6,54'),(350,113,'10 %'),(351,113,'25 %'),(352,113,'0 %'),(353,113,'11 %'),(354,114,'0 %'),(355,114,'25 %'),(356,114,'52 %'),(357,114,'66 %'),(358,115,'Nhi Dong 2 hospital'),(359,115,'Hung Vuong hospital'),(360,115,'Cho Ray hospital'),(361,115,'An Sinh hospital'),(362,116,'It treats cancer in all its forms for children'),(363,116,'It serves as the main cancer center'),(364,116,' It is the largest public cancer hospital'),(365,116,'All are correct'),(366,117,'3 No Trang Long Street, Binh Thanh District'),(367,117,'201B Nguyen Chi Thanh Street, District 5'),(368,117,'106 Cong Quynh Street, District 1'),(369,117,'280 Dien Bien Phu Street, District 3'),(370,118,'The children are very ill and many are fighting'),(371,118,'The children can be receiving treatment on floor'),(372,118,'75% of the children are currently being treated'),(373,118,'All are correct'),(374,119,'a police'),(375,119,'a teacher'),(376,119,'a Doctor'),(377,119,'a person who is responsible to protect of children'),(378,120,'send a piece of sheet in the mail box'),(379,120,'telephone to person you trust most'),(380,120,'via email'),(381,120,'write into your diary'),(382,121,'1. Keep it for myself, otherwise other will tease me'),(383,121,'2. Report to parents or relatives'),(384,121,'3. Report to the local police, teachers or others'),(385,121,'2 & 3 correct'),(386,122,'effective child protection system'),(387,122,'professional social work'),(388,122,'building more youth centers'),(389,122,'all correct'),(390,123,'A. civil law system'),(391,123,'B. common law system'),(392,123,'C. sharia law system'),(393,123,' A and B are correct'),(394,124,'16 years'),(395,124,'18 years'),(396,124,'21 years'),(397,124,'There are no elections in VN.'),(398,125,'every 2nd year'),(399,125,'every 3rd year'),(400,125,'every 5th year'),(401,125,'twice a year'),(402,126,'petty crimes, such as pick pocketing'),(403,126,'armed robbery'),(404,126,'murder'),(405,126,'kidnapping'),(406,127,'Police of VN'),(407,127,'People\'s Public Security of Vietnam'),(408,127,'There is no police in VN'),(409,127,'People'),(410,128,'blue'),(411,128,'brown'),(412,128,'pink'),(413,128,'green'),(414,129,'5.000'),(415,129,'500'),(416,129,'120.000'),(417,129,'12.000'),(418,130,'A. China, Myanmar'),(419,130,'B. China, Malaysia'),(420,130,'C. China, Cambodia'),(421,130,'B&C are correct'),(422,131,'Marriage'),(423,131,' Labor exploitation'),(424,131,'Sex work and adoption'),(425,131,'All are correct'),(426,132,'50%'),(427,132,'60%'),(428,132,'70%'),(429,132,'80%'),(430,133,'They want to get a happier life'),(431,133,'They feel that they need to support financially'),(432,133,'They lack education'),(433,133,'All are correct'),(434,134,'A. Connecting to friends and families’ victims'),(435,134,'B. Connecting to the victims directly'),(436,134,'C. Connecting to local government'),(437,134,' A & B are correct'),(438,135,'Under age of 15'),(439,135,'Under age of 16'),(440,135,'Under age of 17'),(441,135,'Under age of 18'),(442,136,'A. Servants'),(443,136,'B. Restaurant assistants'),(444,136,'C. Lottery sellers'),(445,136,' A, B, C are correct'),(446,137,'35%'),(447,137,'40%'),(448,137,'45%'),(449,137,'50%'),(450,138,'A. Long hours of work'),(451,138,'B. Low wages'),(452,138,'C. Poor facilities'),(453,138,'A, B, C are correct'),(454,139,'About 22,000 children'),(455,139,'About 23,000 children'),(456,139,'About 24,000 children'),(457,139,' About 25,000 children'),(458,140,'Broken family'),(459,140,'Mindset problem'),(460,140,'Economic migration'),(461,140,'All are correct'),(462,141,'12'),(463,141,'13'),(464,141,'14'),(465,141,'15'),(466,142,'A. Providing loving home for children'),(467,142,'B. Providing schools for children that are illiterate'),(468,142,'C. Providing finances for children that are in need'),(469,142,'B&C are correct'),(470,143,'1967'),(471,143,'1977'),(472,143,'1987'),(473,143,'1997'),(474,144,'6-8'),(475,144,'8-10'),(476,144,'10-12'),(477,144,'One mother will take care only one child'),(478,145,'Ho Chi Minh'),(479,145,'Da Lat'),(480,145,'Ben Tre'),(481,145,'Ca Mau'),(482,146,'A. General knowledge'),(483,146,'B. Training quality human resources '),(484,146,'A and B'),(485,146,'C. Computer skills'),(486,147,'5 or 6'),(487,147,'9 or 10 '),(488,147,'3 or 4'),(489,147,'no answer is correct'),(490,148,'Physical Education'),(491,148,'Military and Security education'),(492,148,'Home Economics '),(493,148,'History'),(494,149,'American pedagogy, interaction and debate'),(495,149,'British pedagogy, interaction and debate '),(496,149,'Confucian pedagogy, passively attentive'),(497,149,'no answer is correct'),(498,150,'Australia, USA, China'),(499,150,'Germany, Japan, Singapore'),(500,150,'The Netherlands, Thailand, China'),(501,150,'France, USA, China'),(502,151,'A. Too little money e.g. for books, uniforms'),(503,151,'B. Necessity of earning money for the family'),(504,151,'C. School are too far away'),(505,151,'A and B'),(506,152,'French'),(507,152,'Japanese'),(508,152,'English'),(509,152,'Chinese'),(510,153,'6 per cent'),(511,153,'10 per cent'),(512,153,'25 per cent'),(513,153,'0 per cent'),(514,154,'A. democracy'),(515,154,'B. communism'),(516,154,'C. socialism'),(517,154,'B and C are correct'),(518,155,'Buddhist'),(519,155,'Catholic'),(520,155,'Muslim'),(521,155,'None'),(522,156,'around 22'),(523,156,'around 30'),(524,156,'around 18'),(525,156,'around 28'),(526,157,'20 % of GDP'),(527,157,'6,3 % of GDP'),(528,157,'0,5 % of GDP'),(529,157,'There\'re no governmental expenditures on education'),(530,158,'no children at all'),(531,158,'around 2 million'),(532,158,'around 10 million'),(533,158,'around 500.000'),(534,159,'University/College test VN'),(535,159,'National Graduation Examination'),(536,159,'SAT'),(537,159,'GMAT'),(538,160,'50:50'),(539,160,'10:90'),(540,160,'0:100'),(541,160,'100:0'),(542,161,'primary school'),(543,161,'Secondary school'),(544,161,'High school'),(545,161,'all correct'),(546,162,'Improves community feeling'),(547,162,'less peer pressure'),(548,162,'easier to clean'),(549,162,'no risk of teacher judging students due to clothes'),(550,163,'8 years'),(551,163,'10 years'),(552,163,'12 years'),(553,163,'13 years'),(554,164,'4'),(555,164,'5'),(556,164,'6'),(557,164,'7'),(558,165,'A. The lack of practical training'),(559,165,'B. Focusing on theory only'),(560,165,'C. Student-oriented'),(561,165,'A and B are correct'),(562,166,'A. Be studious and passively attentive'),(563,166,'B. Be interactive and active'),(564,166,'C. Be creative'),(565,166,'B&C are correct'),(566,167,'Around 60 to 100$ per month'),(567,167,'Around 80 to 120$ per month'),(568,167,'Around 100  to 140$ per month'),(569,167,'Around 120 to 160$ per month'),(570,168,'A. Running extra classes at their houses'),(571,168,'B. Getting another job'),(572,168,'C. Monthly salary is enough for their living'),(573,168,'A & B are correct'),(574,169,'3'),(575,169,'4'),(576,169,'5'),(577,169,'4 or 5'),(578,170,'Mathematics and Vietnamese literature  '),(579,170,'Mathematics and Physics'),(580,170,'Mathematics and English'),(581,170,'Vietnamese literature and English'),(582,171,'A. In late April or early May'),(583,171,'B. In late May or early June'),(584,171,'A are B are correct'),(585,171,'C. Any time'),(586,172,'20 Oct'),(587,172,'25 Oct'),(588,172,'20 Nov'),(589,172,'25 Nov'),(590,173,'A. Visiting their teachers’ house'),(591,173,'B. Giving gifts to their teachers'),(592,173,'C. Do not wear uniform at school'),(593,173,'A&B are correct'),(594,174,'65%'),(595,174,'70%'),(596,174,'75%'),(597,174,'80%'),(598,175,'In early June'),(599,175,'In late June'),(600,175,'In early July'),(601,175,'In late July'),(602,176,'A. unbalanced diet'),(603,176,'B. not enough food'),(604,176,'A and B correct'),(605,176,'C. genetic origin'),(606,177,'Group A'),(607,177,'Group B'),(608,177,'Group C'),(609,177,'Group D'),(610,178,'Mathematics, Physics, Chemistry'),(611,178,'Mathematics, Physics, Biology'),(612,178,'Mathematics, Biology, Chemistry'),(613,178,'Mathematics, Biology, Physics'),(614,179,'high infant mortality rate'),(615,179,'old/wrong hospital equipment'),(616,179,'child obesity'),(617,179,'all correct'),(618,180,'2007'),(619,180,'2008'),(620,180,'2009'),(621,180,'2010'),(622,181,'USD 2.000'),(623,181,'USD 10.000'),(624,181,'USD 950'),(625,181,'University is free of charge '),(626,182,'1,5 million'),(627,182,'5,3 million'),(628,182,'3,2 million'),(629,182,'nothing is correct'),(630,183,'A. Being able to read and write'),(631,183,'B. Minimum age of 15'),(632,183,'C. being enrolled to a school'),(633,183,'A and B are correct'),(634,184,'50:1'),(635,184,'15:1'),(636,184,' 25:1'),(637,184,' 25:1'),(638,185,'underweight'),(639,185,'stunted growth'),(640,185,'undeveloped bones'),(641,185,'all correct'),(642,186,'the central highlands'),(643,186,'big cities'),(644,186,'coastal areas'),(645,186,'no differences between areas'),(646,187,'A. generally, females are favoured over male'),(647,187,'B. limited economic opportunities'),(648,187,'C. Policy'),(649,187,'A and B correct'),(650,188,'eat various kinds of food'),(651,188,'avoid salty food'),(652,188,'breastfeed babies'),(653,188,'all correct'),(654,189,'A. Promoting of learning'),(655,189,'B. Respect for teachers'),(656,189,'C. Studying oversea'),(657,189,'A and B are correct'),(658,190,'wheat allergy'),(659,190,'lactose deficiency'),(660,190,'intolerance to gluten'),(661,190,'intolerance to pork'),(662,191,'Grammar and reading comprehension'),(663,191,'Listening and reading comprehension'),(664,191,'Speaking and listening'),(665,191,'Writing and speaking'),(666,192,'Asia'),(667,192,'Latin Caribbean'),(668,192,'Africa'),(669,192,'Middle East'),(670,193,'30-40%'),(671,193,'40-50%'),(672,193,'50-60%'),(673,193,'60-70%'),(674,194,'A. In summer'),(675,194,'B. In summer and winter'),(676,194,'C. In winter and spring'),(677,194,'B&C are correct'),(678,195,'50 %'),(679,195,'100 %'),(680,195,'85%'),(681,195,'31%'),(682,196,'at the registration office'),(683,196,'in the groom’s house'),(684,196,'in the bide’s backyard'),(685,196,'Local Department of Justice'),(686,197,'12'),(687,197,'16'),(688,197,'18'),(689,197,'20'),(690,198,'1,5 USD'),(691,198,'2 USD'),(692,198,'1,25 USD'),(693,198,'10 USD'),(694,199,'Reducing world hunger'),(695,199,'achieving primary education'),(696,199,'ensure environmental sustainability'),(697,199,'protection of species'),(698,200,'a country’s development by combining social and ec'),(699,200,'the GDP’s development over the last five years'),(700,200,'the development of a country’s population number'),(701,200,'the ratio between young and old people'),(702,201,'Hanoi'),(703,201,'HCMC'),(704,201,'Hanoi and HCMC'),(705,201,'Beijing'),(706,202,'black pepper'),(707,202,'rice'),(708,202,'cashew nuts'),(709,202,'all correct'),(710,203,'A. That is the Lunar New Year Celebration'),(711,203,'B. That is the independence day'),(712,203,'C. That is the national resting day'),(713,203,'B&C are correct'),(714,204,'A. Receiving lucky money'),(715,204,'B. Putting on new clothes'),(716,204,'C. Playing games'),(717,204,'A & B are correct'),(718,205,'Self-confidence and self-esteem'),(719,205,'Obedience and self-esteem'),(720,205,'Self-confidence and respect'),(721,205,'Obedience and respect'),(722,206,'They think they can change their life through educ'),(723,206,'Education has a high value in Vietnamese’s percept'),(724,206,'Education is a way for family advancement'),(725,206,'All are correct'),(726,207,'A. Discipline or punish physically'),(727,207,'B. Let children do anything they want'),(728,207,'C. Giving them some advices'),(729,207,'B&C are correct'),(730,208,'Giving their parents money to take care themselves'),(731,208,'Building a house for their parents'),(732,208,'Sending them to nursing homes'),(733,208,'Take care of their parents'),(734,209,'Hanoi'),(735,209,'HCMC'),(736,209,'Hanoi and HCMC'),(737,209,'Beijing'),(738,210,'USA'),(739,210,'Russia'),(740,210,'China'),(741,210,'Cambodia'),(742,211,'black pepper'),(743,211,'rice'),(744,211,'cashew nuts'),(745,211,'all correct'),(746,212,'A. That is the Lunar New Year Celebration'),(747,212,'B. That is the independence day'),(748,212,'C. That is the national resting day'),(749,212,'B&C are correct'),(750,213,'A. Receiving lucky money'),(751,213,'B. Putting on new clothes'),(752,213,'C. Playing games'),(753,213,'A & B are correct'),(754,214,'Self-confidence and self-esteem'),(755,214,'Obedience and self-esteem'),(756,214,'Self-confidence and respect'),(757,214,'Obedience and respect'),(758,215,'A. Discipline or punish physically'),(759,215,'B. Let children do anything they want'),(760,215,'C. Giving them some advices'),(761,215,'B&C are correct'),(762,216,'Giving their parents money to take care themselves'),(763,216,'Building a house for their parents'),(764,216,'Sending them to nursing homes'),(765,216,'Take care of their parents'),(766,217,'A. Taking care of children and grandchildren'),(767,217,'B. Performing all household tasks'),(768,217,'C. Having rights to make the final decisions'),(769,217,'D. A&B are correct'),(770,218,'A. Cat and mouse'),(771,218,'B. Cat and goat'),(772,218,'C. Cat and tiger'),(773,218,'D. A&C are correct');
/*!40000 ALTER TABLE `choice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donation`
--

DROP TABLE IF EXISTS `donation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `donation` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Description` varchar(8000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RequiredPoint` int(11) DEFAULT NULL,
  `MedalId` int(11) DEFAULT NULL,
  `PartnerId` int(11) DEFAULT NULL,
  `IsApproved` bit(1) DEFAULT NULL,
  `CreateDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donation`
--

LOCK TABLES `donation` WRITE;
/*!40000 ALTER TABLE `donation` DISABLE KEYS */;
INSERT INTO `donation` VALUES (11,'Heart Refills','Donate 65 cents – equivalent to the cost one measles vaccine that can save a child’ life',3245,0,5,'','2014-04-07 10:26:39'),(12,'Add more time','Donate 50 dollars – equivalent to the cost of Emergency support for children victims of abused, and exploitation. ',100,1,5,NULL,'2014-04-07 10:26:56'),(13,'Skip the question','Donate 65 cents – equivalent to the cost one measles vaccine that can save a child’ life',100,2,6,NULL,'2014-04-07 10:36:05'),(14,'Guardian Angel','Donate 50 dollars – equivalent to the cost of Emergency support for children victims of abused, and exploitation. ',100,3,6,NULL,'2014-04-07 10:36:24'),(15,'Donate $1','Just one dollar to save lives.',100,3,6,NULL,'2014-04-07 10:45:18'),(16,'Donate 2$','Just 2 dollars save many lives.',100,3,6,NULL,'2014-04-07 10:46:15'),(17,'We need 3 new bicycles','We need 3 new bicycles (US 50 each) for older boys to go to school/ vocational training outside',100,3,19,NULL,'2014-04-24 03:36:42'),(18,'A roof of the house for boys here need replacing','A roof of the house for boys here need replacing as soon as possible (US1,0  00)',100,3,19,NULL,'2014-04-24 03:37:04'),(19,'Nutritional care','Nutritional care: 30,000 VND/child/day.',100,3,22,NULL,'2014-04-28 16:01:51'),(20,'Health care','Health care: 200,000 VND/child/month.',100,3,22,NULL,'2014-04-28 16:02:09'),(21,'Educational expense','Educational expense: 500,000 VND/child/month.',100,3,22,NULL,'2014-04-28 16:02:27'),(22,'The regular expense of a child','The regular expense of a child:\n-	Nutritional care: 30,000 VND/child/day.\n-	Health care: 200,000 VND/child/month.\n-	Educational expense: 500',100,3,22,NULL,'2014-04-28 16:02:53'),(23,'$250 for the operational expense of a KNS course for children.  ','$250 for the operational expense of a KNS course for children.  ',100,3,23,NULL,'2014-04-28 16:32:54'),(24,'$50 for the financial aid of vocational training for children.','$50 for the financial aid of vocational training for children.',100,3,23,NULL,'2014-04-28 16:33:00'),(25,'$50 for the financial aid of a child’s study. ','$50 for the financial aid of a child’s study. ',100,3,23,NULL,'2014-04-28 16:33:05'),(26,'Join hand build a home','Just join your hand',100,3,24,NULL,'2014-05-07 02:33:53'),(27,'Breakfasts ','10USD for breakfasts for 20 kids/day (20 * 10.000vnd)',100,NULL,25,NULL,'2014-05-29 03:31:00'),(28,'School uniforms','800USD for school uniforms for 20 kids (20 kids * 2uniforms/each * 400.000vnd/each)',100,NULL,25,NULL,'2014-05-29 03:31:23');
/*!40000 ALTER TABLE `donation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `function`
--

DROP TABLE IF EXISTS `function`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `function` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IconURL` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FuncURL` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `function`
--

LOCK TABLES `function` WRITE;
/*!40000 ALTER TABLE `function` DISABLE KEYS */;
/*!40000 ALTER TABLE `function` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 NOT NULL,
  `description` varchar(100) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,'admin','Administrator'),(2,'members','General User');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_attempts`
--

DROP TABLE IF EXISTS `login_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_attempts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varbinary(16) NOT NULL,
  `login` varchar(100) CHARACTER SET utf8 NOT NULL,
  `time` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_attempts`
--

LOCK TABLES `login_attempts` WRITE;
/*!40000 ALTER TABLE `login_attempts` DISABLE KEYS */;
/*!40000 ALTER TABLE `login_attempts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medal`
--

DROP TABLE IF EXISTS `medal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medal` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ImageURL` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medal`
--

LOCK TABLES `medal` WRITE;
/*!40000 ALTER TABLE `medal` DISABLE KEYS */;
INSERT INTO `medal` VALUES (0,'Heart Refills','http://heroforzero.be/assets/img/profile/05_Donations/buy-heart-icon@2x.png'),(1,'Add more time','http://heroforzero.be/assets/img/profile/05_Donations/buy-skip-icon@2x.png'),(2,'Skip the question','http://heroforzero.be/assets/img/profile/05_Donations/buy-time-icon@2x.png'),(3,'Guardian Angel','http://heroforzero.be/assets/img/profile/05_Donations/donate-guaridan-icon@2x.png'),(4,'Save a sick girl','http://heroforzero.be/assets/img/quest/1.png'),(5,'Help a boy get back into school','http://heroforzero.be/assets/img/quest/2.png'),(6,'Help a girl get back into school','http://heroforzero.be/assets/img/quest/3.png'),(7,'Save a sick boy','http://heroforzero.be/assets/img/quest/4.png');
/*!40000 ALTER TABLE `medal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizationtype`
--

DROP TABLE IF EXISTS `organizationtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organizationtype` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `TypeName` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizationtype`
--

LOCK TABLES `organizationtype` WRITE;
/*!40000 ALTER TABLE `organizationtype` DISABLE KEYS */;
INSERT INTO `organizationtype` VALUES (1,'Local Non-profit organization'),(2,'International Non-profit organization'),(3,'Child Care Center or Shelter'),(4,'Mass Organization'),(5,'Religious Organization');
/*!40000 ALTER TABLE `organizationtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packet`
--

DROP TABLE IF EXISTS `packet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `packet` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(140) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ImageURL` varchar(140) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PartnerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packet`
--

LOCK TABLES `packet` WRITE;
/*!40000 ALTER TABLE `packet` DISABLE KEYS */;
INSERT INTO `packet` VALUES (1,'Basic Health Services','http://mytempbucket.s3.amazonaws.com/1400216231.jpg',5),(2,'Nutrition','http://mytempbucket.s3.amazonaws.com/1400226009.jpg',5),(3,'Education','http://mytempbucket.s3.amazonaws.com/1400226826.jpg',5),(4,'Protection from abuse and exploitation','http://mytempbucket.s3.amazonaws.com/1400225850.jpg',5),(6,'Clean Water','http://mytempbucket.s3.amazonaws.com/1400227503.jpg',5);
/*!40000 ALTER TABLE `packet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partner`
--

DROP TABLE IF EXISTS `partner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partner` (
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
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partner`
--

LOCK TABLES `partner` WRITE;
/*!40000 ALTER TABLE `partner` DISABLE KEYS */;
INSERT INTO `partner` VALUES (5,'UNICEF Viet Nam',2,'Sun Wah Tower, Suite 504, 115 Nguyen Hue, District 1, HCMC','+84 3821-9413','http://www.unicef.org/vietnam',NULL,NULL,'UNICEFs mission in Vietnam is to fulfill the rights of every child in Vietnam, particularly those most disadvantaged or vulnerable.','','http://www.unicef.org/vietnam/unicef-logo.gif','https://dl.dropboxusercontent.com/u/64958885/HeroForZero/Image/activity/avatar-unicef-big%402x.png'),(6,'Agape Childrens Home',3,'4232 Vermon Ave. S Minneapolis, MN 45234','01217799140','achvn.org',NULL,NULL,'Agape Childrens Home (ACH) mission is to give hope to the abandoned and impoverished children of Vietnam by providing them with a safe and l','','','https://dl.dropboxusercontent.com/u/64958885/HeroForZero/Image/activity/avatar-agape%402x.png'),(17,'qwe',1,'12 qweqwe','123123123','',NULL,NULL,'qweqwe','\0','0','https://dl.dropboxusercontent.com/u/64958885/HeroForZero/Image/activity/avatar-agape%402x.png'),(18,'qwe',2,'12 qw','1234221','http://www.rws.dss',NULL,NULL,'qwegffff','\0','http://mytempbucket.s3.amazonaws.com/1398069422.jpg','https://dl.dropboxusercontent.com/u/64958885/HeroForZero/Image/activity/avatar-agape%402x.png'),(19,'CHILDREN’S HOUSE DISTRICT 8',3,'73/10 Duong Ba Trac street, Ward 1, District 8, HCMC','+84  08-38502088','',NULL,NULL,'Contributing to improve the life of children/ adolescents who are in a street situation through social and professional integration.','','0','https://dl.dropboxusercontent.com/u/64958885/HeroForZero/Image/activity/avatar-agape%402x.png'),(20,'Kate2Aid',2,'k.mengede@me.com','+49 176 32841001','',NULL,NULL,'Helping!','','0','https://dl.dropboxusercontent.com/u/64958885/HeroForZero/Image/activity/avatar-agape%402x.png'),(21,'Agape Children\'s Home',3,'56 Dung Ba Trac Phuong 2 Quan 11','1234567890','achvn.org',NULL,NULL,'We like to help kids.','','0','https://dl.dropboxusercontent.com/u/64958885/HeroForZero/Image/activity/avatar-agape%402x.png'),(22,'Buddhist Social Charity Center of Ky Quang Pa',5,'154/4A Lê Hoàng Phái, P.17, Q. Gò Vấp, Tp. HCM','+84.38951014 – 0938.456.215 – 0903.005.442','',NULL,NULL,'Buddhist Social Charity Center of Ky Quang Pagoda II is a center whose aims are to raise, educate and orient orphaned, disabled children and','','0','https://dl.dropboxusercontent.com/u/64958885/HeroForZero/Image/activity/avatar-agape%402x.png'),(23,'Vietnam Association for Protection of Childre',1,'181 Nguyễn Cư Trinh, Quận 1, TP HCM','(+84) 838 388 872 – (+84) 913 639 386','www.treemviet.com.vn',NULL,NULL,'-	Ủng hộ và thúc đẩy quyền trẻ em.\n-	Thực hiện giám sát và báo cáo về những hành vi xâm phạm quyền trẻ em về cơ quan nhà nước.\n-	Bồi dưỡng n','','0','https://dl.dropboxusercontent.com/u/64958885/HeroForZero/Image/activity/avatar-agape%402x.png'),(24,'Ocean 4',1,'My Vien, Q7','84912880656','',NULL,NULL,'We build things to help people.','','0','https://dl.dropboxusercontent.com/u/64958885/HeroForZero/Image/activity/avatar-agape%402x.png'),(25,'Little Rose Story Warm Shelter',3,'30/31 Lâm Văn Bền- Phường Tân Kiểng- Quận 7- TPHCM','(+84) 38. 720. 308','',NULL,NULL,'Little Rose Story Warm Shelter were established in 1992, under the HCMC Child Welfare Association to provide care and support girls who are victims or at risk of being sexual abused, exploited. Moreover, the shelter also conduct educational and awareness raising activities on “prevention of child sexual abuse” to improve community knowledge and awareness about girls as victims.','','0','0');
/*!40000 ALTER TABLE `partner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partnerdonation`
--

DROP TABLE IF EXISTS `partnerdonation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partnerdonation` (
  `DonationId` int(11) NOT NULL AUTO_INCREMENT,
  `PartnerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`DonationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partnerdonation`
--

LOCK TABLES `partnerdonation` WRITE;
/*!40000 ALTER TABLE `partnerdonation` DISABLE KEYS */;
/*!40000 ALTER TABLE `partnerdonation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quest`
--

DROP TABLE IF EXISTS `quest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quest` (
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quest`
--

LOCK TABLES `quest` WRITE;
/*!40000 ALTER TABLE `quest` DISABLE KEYS */;
INSERT INTO `quest` VALUES (1,'Big Quest 0','',10.7172,106.73,'',NULL,0,NULL,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/1fdac2ef-62c7-4d5e-b7c7-7ddadaa37840.jpg',200,'1SB1-1 Mỹ ViA',1,NULL,1),(2,'Unicef Fight For Zero','UNICEF strives for Zero. That means, zero exploited children, zero abused children, and zero trafficked children.',10.7739,106.703,'https://dl.dropboxusercontent.com/u/3243296/videos/UNICEF.mp4','https://s3-us-west-2.amazonaws.com/travelhero/qrcode/497c717d-cc6d-4dfc-b615-90f628d0cb4d.png',0,1,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/b0d330a1-9697-4e90-8294-0a521a0a8e49.jpg',1000,'115 Nguyen Hue, District 1, Ho Chi Minh City, Vietnam',NULL,'https://unicef.org.vn/donate/',1),(3,'Koto | Know One Teach One','Is a vocational training organisation for street and disadvantaged youth in Vietnam. Accepts youth whose backgrounds are primarily orphans, street kids and the poor in both the city and rural communities.',10.7772,106.704,'https://dl.dropboxusercontent.com/u/3243296/videos/KOTO.mp4','https://s3-us-west-2.amazonaws.com/travelhero/qrcode/76def669-8511-427f-abf0-e05656f357bb.png',0,1,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/5a39b469-601a-4344-be67-0eca9dad7f42.jpg',1000,'89 Hai BA  Trưng, Bến NghA',NULL,NULL,0),(4,'Kristina Nobel Foundation','Christina Noble Children\'s Foundation is an International Partnership of people dedicated to serving underprivileged children in Vietnam and Mongolia with the hope of helping each child maximize their life potential.',10.7799,106.686,'https://dl.dropboxusercontent.com/u/3243296/videos/CNCF.mp4','https://s3-us-west-2.amazonaws.com/travelhero/qrcode/d5c4c7ea-7249-4b89-861a-627057d4861e.png',0,1,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/dbdd9ed2-9482-426c-9191-0605279b7b79.jpg',1000,'38 Tu Xuong Street \nDistrict 3 \nHO CHI MINH CITY \nVietnam',NULL,NULL,0),(5,'Big Quest 1','',10.7172,106.73,NULL,NULL,0,NULL,'',500,'1SB1-1 Mỹ ViA',1,NULL,0),(6,'American Red Cross in Vietnam','the American Red Cross has been working with the Vietnam Red Cross and other partners since early 2008 to improve access to and utilization of HIV information, treatment, care and support services.',21.0222,105.843,'https://dl.dropboxusercontent.com/u/3243296/videos/American%20Red%20Cross_VN.mp4','https://s3-us-west-2.amazonaws.com/travelhero/qrcode/5cc4d388-e8a0-4187-9178-f857cebcb0fd.png',0,5,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/b7a95302-5f27-4534-8f98-918c2901ffaa.png',800,'15 Thiền Quang, HA  Nội, Vietnam',NULL,'https://www.redcross.org/quickdonate/index.jsp',1),(7,'Blue Dragon Children’s Home','Blue Dragon Children\'s Foundation is an Australian grassroots charity that reaches out to kids in crisis throughout Vietnam.',21.0259,105.847,'https://dl.dropboxusercontent.com/u/3243296/videos/blueDragonChildrensHome.mp4','https://s3-us-west-2.amazonaws.com/travelhero/qrcode/a75d1db9-b5b0-4369-85fd-b85cdbaf819a.png',0,5,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/a09eeafc-5c08-447b-bc36-b763a016ff40.png',500,'66 Nghĩa Dũng, PhA',NULL,NULL,1),(8,'Care International in Vietnam','CARE has worked in Vietnam since 1989. As Vietnam becomes a middle-income country, we are concentrating our work on supporting rights and sustainable development among the most vulnerable groups in Vietnam, for example remote ethnic minorities, poor women and girls, and people vulnerable to climate change.',21.0681,105.823,'https://dl.dropboxusercontent.com/u/3243296/videos/care_international.mp4','https://s3-us-west-2.amazonaws.com/travelhero/qrcode/939389c7-3e0f-4071-aa30-9caa2742444d.png',0,5,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/d7c7942e-41fe-4d2d-ab7e-b8583e06c3ca.png',500,'92 TA',NULL,NULL,1),(9,'UNICEF Next Generation','a group of young entrepreneurs that advocate for UNICEF in the United-States, visited UNICEF projects in Ho Chi Minh City and Dong Thap. UNICEF Next Generation United States members are influential and passionate young adults (age 18-35) who are committed to supporting UNICEF\'s mission to fulfill the rights of all children through the deliverance of educational and fundraising programmes',10.7739,106.703,'https://dl.dropboxusercontent.com/u/3243296/videos/UNICEF%20next_genmp4.mp4','https://s3-us-west-2.amazonaws.com/travelhero/qrcode/2a6b4946-2c8b-441f-93cd-2c61490d1f32.png',1,5,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/49aa2afa-4068-42d8-9401-6113e4fa8065.jpg',2000,'115 Nguyen Hue, District 1, Ho Chi Minh City, Vietnam',NULL,'https://unicef.org.vn/donate/',0),(10,'Big Quest 0','',10.7172,106.73,'',NULL,0,NULL,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/1fdac2ef-62c7-4d5e-b7c7-7ddadaa37840.jpg',200,'1SB1-1 Mỹ ViA',1,NULL,1),(11,'Unicef Fight For Zero','UNICEF strives for Zero. That means, zero exploited children, zero abused children, and zero trafficked children.',10.7739,106.703,'https://dl.dropboxusercontent.com/u/3243296/videos/UNICEF.mp4','https://s3-us-west-2.amazonaws.com/travelhero/qrcode/497c717d-cc6d-4dfc-b615-90f628d0cb4d.png',0,1,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/b0d330a1-9697-4e90-8294-0a521a0a8e49.jpg',1000,'115 Nguyen Hue, District 1, Ho Chi Minh City, Vietnam',NULL,'https://unicef.org.vn/donate/',1),(12,'Koto | Know One Teach One','Is a vocational training organisation for street and disadvantaged youth in Vietnam. Accepts youth whose backgrounds are primarily orphans, street kids and the poor in both the city and rural communities.',10.7772,106.704,'https://dl.dropboxusercontent.com/u/3243296/videos/KOTO.mp4','https://s3-us-west-2.amazonaws.com/travelhero/qrcode/76def669-8511-427f-abf0-e05656f357bb.png',0,1,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/5a39b469-601a-4344-be67-0eca9dad7f42.jpg',1000,'89 Hai BA  Trưng, Bến NghA',NULL,NULL,0),(13,'Kristina Nobel Foundation','Christina Noble Children\'s Foundation is an International Partnership of people dedicated to serving underprivileged children in Vietnam and Mongolia with the hope of helping each child maximize their life potential.',10.7799,106.686,'https://dl.dropboxusercontent.com/u/3243296/videos/CNCF.mp4','https://s3-us-west-2.amazonaws.com/travelhero/qrcode/d5c4c7ea-7249-4b89-861a-627057d4861e.png',0,1,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/dbdd9ed2-9482-426c-9191-0605279b7b79.jpg',1000,'38 Tu Xuong Street \nDistrict 3 \nHO CHI MINH CITY \nVietnam',NULL,NULL,0),(14,'Big Quest 1','',10.7172,106.73,NULL,NULL,0,NULL,'',500,'1SB1-1 Mỹ ViA',1,NULL,0),(15,'American Red Cross in Vietnam','the American Red Cross has been working with the Vietnam Red Cross and other partners since early 2008 to improve access to and utilization of HIV information, treatment, care and support services.',21.0222,105.843,'https://dl.dropboxusercontent.com/u/3243296/videos/American%20Red%20Cross_VN.mp4','https://s3-us-west-2.amazonaws.com/travelhero/qrcode/5cc4d388-e8a0-4187-9178-f857cebcb0fd.png',0,5,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/b7a95302-5f27-4534-8f98-918c2901ffaa.png',800,'15 Thiền Quang, HA  Nội, Vietnam',NULL,'https://www.redcross.org/quickdonate/index.jsp',0),(16,'Blue Dragon Children’s Home','Blue Dragon Children\'s Foundation is an Australian grassroots charity that reaches out to kids in crisis throughout Vietnam.',21.0259,105.847,'https://dl.dropboxusercontent.com/u/3243296/videos/blueDragonChildrensHome.mp4','https://s3-us-west-2.amazonaws.com/travelhero/qrcode/a75d1db9-b5b0-4369-85fd-b85cdbaf819a.png',0,5,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/a09eeafc-5c08-447b-bc36-b763a016ff40.png',500,'66 Nghĩa Dũng, PhA',NULL,NULL,0),(17,'Care International in Vietnam','CARE has worked in Vietnam since 1989. As Vietnam becomes a middle-income country, we are concentrating our work on supporting rights and sustainable development among the most vulnerable groups in Vietnam, for example remote ethnic minorities, poor women and girls, and people vulnerable to climate change.',21.0681,105.823,'https://dl.dropboxusercontent.com/u/3243296/videos/care_international.mp4','https://s3-us-west-2.amazonaws.com/travelhero/qrcode/939389c7-3e0f-4071-aa30-9caa2742444d.png',0,5,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/d7c7942e-41fe-4d2d-ab7e-b8583e06c3ca.png',500,'92 TA',NULL,NULL,0),(18,'UNICEF Next Generation','a group of young entrepreneurs that advocate for UNICEF in the United-States, visited UNICEF projects in Ho Chi Minh City and Dong Thap. UNICEF Next Generation United States members are influential and passionate young adults (age 18-35) who are committed to supporting UNICEF\'s mission to fulfill the rights of all children through the deliverance of educational and fundraising programmes',10.7739,106.703,'https://dl.dropboxusercontent.com/u/3243296/videos/UNICEF%20next_genmp4.mp4','https://s3-us-west-2.amazonaws.com/travelhero/qrcode/2a6b4946-2c8b-441f-93cd-2c61490d1f32.png',1,5,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/49aa2afa-4068-42d8-9401-6113e4fa8065.jpg',2000,'115 Nguyen Hue, District 1, Ho Chi Minh City, Vietnam',NULL,'https://unicef.org.vn/donate/',0),(19,'Big Quest 0','',10.7172,106.73,'',NULL,0,NULL,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/1fdac2ef-62c7-4d5e-b7c7-7ddadaa37840.jpg',200,'1SB1-1 Mỹ ViA',1,NULL,1),(20,'Unicef Fight For Zero','UNICEF strives for Zero. That means, zero exploited children, zero abused children, and zero trafficked children.',10.7739,106.703,'https://dl.dropboxusercontent.com/u/3243296/videos/UNICEF.mp4','https://s3-us-west-2.amazonaws.com/travelhero/qrcode/497c717d-cc6d-4dfc-b615-90f628d0cb4d.png',0,1,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/b0d330a1-9697-4e90-8294-0a521a0a8e49.jpg',1000,'115 Nguyen Hue, District 1, Ho Chi Minh City, Vietnam',NULL,'https://unicef.org.vn/donate/',0),(21,'Koto | Know One Teach One','Is a vocational training organisation for street and disadvantaged youth in Vietnam. Accepts youth whose backgrounds are primarily orphans, street kids and the poor in both the city and rural communities.',10.7772,106.704,'https://dl.dropboxusercontent.com/u/3243296/videos/KOTO.mp4','https://s3-us-west-2.amazonaws.com/travelhero/qrcode/76def669-8511-427f-abf0-e05656f357bb.png',0,1,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/5a39b469-601a-4344-be67-0eca9dad7f42.jpg',1000,'89 Hai BA  Trưng, Bến NghA',NULL,NULL,0),(22,'Kristina Nobel Foundation','Christina Noble Children\'s Foundation is an International Partnership of people dedicated to serving underprivileged children in Vietnam and Mongolia with the hope of helping each child maximize their life potential.',10.7799,106.686,'https://dl.dropboxusercontent.com/u/3243296/videos/CNCF.mp4','https://s3-us-west-2.amazonaws.com/travelhero/qrcode/d5c4c7ea-7249-4b89-861a-627057d4861e.png',0,1,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/dbdd9ed2-9482-426c-9191-0605279b7b79.jpg',1000,'38 Tu Xuong Street \nDistrict 3 \nHO CHI MINH CITY \nVietnam',NULL,NULL,0),(23,'Big Quest 1','',10.7172,106.73,NULL,NULL,0,NULL,'',500,'1SB1-1 Mỹ ViA',1,NULL,0),(24,'American Red Cross in Vietnam','the American Red Cross has been working with the Vietnam Red Cross and other partners since early 2008 to improve access to and utilization of HIV information, treatment, care and support services.',21.0222,105.843,'https://dl.dropboxusercontent.com/u/3243296/videos/American%20Red%20Cross_VN.mp4','https://s3-us-west-2.amazonaws.com/travelhero/qrcode/5cc4d388-e8a0-4187-9178-f857cebcb0fd.png',0,5,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/b7a95302-5f27-4534-8f98-918c2901ffaa.png',800,'15 Thiền Quang, HA  Nội, Vietnam',NULL,'https://www.redcross.org/quickdonate/index.jsp',0),(25,'Blue Dragon Children’s Home','Blue Dragon Children\'s Foundation is an Australian grassroots charity that reaches out to kids in crisis throughout Vietnam.',21.0259,105.847,'https://dl.dropboxusercontent.com/u/3243296/videos/blueDragonChildrensHome.mp4','https://s3-us-west-2.amazonaws.com/travelhero/qrcode/a75d1db9-b5b0-4369-85fd-b85cdbaf819a.png',0,5,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/a09eeafc-5c08-447b-bc36-b763a016ff40.png',500,'66 Nghĩa Dũng, PhA',NULL,NULL,0),(26,'Care International in Vietnam','CARE has worked in Vietnam since 1989. As Vietnam becomes a middle-income country, we are concentrating our work on supporting rights and sustainable development among the most vulnerable groups in Vietnam, for example remote ethnic minorities, poor women and girls, and people vulnerable to climate change.',21.0681,105.823,'https://dl.dropboxusercontent.com/u/3243296/videos/care_international.mp4','https://s3-us-west-2.amazonaws.com/travelhero/qrcode/939389c7-3e0f-4071-aa30-9caa2742444d.png',0,5,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/d7c7942e-41fe-4d2d-ab7e-b8583e06c3ca.png',500,'92 TA',NULL,NULL,1),(27,'UNICEF Next Generation','a group of young entrepreneurs that advocate for UNICEF in the United-States, visited UNICEF projects in Ho Chi Minh City and Dong Thap. UNICEF Next Generation United States members are influential and passionate young adults (age 18-35) who are committed to supporting UNICEF\'s mission to fulfill the rights of all children through the deliverance of educational and fundraising programmes',10.7739,106.703,'https://dl.dropboxusercontent.com/u/3243296/videos/UNICEF%20next_genmp4.mp4','https://s3-us-west-2.amazonaws.com/travelhero/qrcode/2a6b4946-2c8b-441f-93cd-2c61490d1f32.png',1,5,'https://s3-ap-southeast-1.amazonaws.com/singtravelhero/images/questphoto/49aa2afa-4068-42d8-9401-6113e4fa8065.jpg',2000,'115 Nguyen Hue, District 1, Ho Chi Minh City, Vietnam',NULL,'https://unicef.org.vn/donate/',0);
/*!40000 ALTER TABLE `quest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quest_temp`
--

DROP TABLE IF EXISTS `quest_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quest_temp` (
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quest_temp`
--

LOCK TABLES `quest_temp` WRITE;
/*!40000 ALTER TABLE `quest_temp` DISABLE KEYS */;
INSERT INTO `quest_temp` VALUES (1,'Test','notest',10.7767,106.684,NULL,NULL,0,5,NULL,100,'256 Dien Bien Phu, Quan 3, HCM',NULL,'http://www.php.net/manual/en/reserved.variables.request.php',0),(2,'Test','test',10.7767,106.684,NULL,NULL,0,1,NULL,100,'256 Dien Bien Phu, Quan 3, HCM',NULL,'http://www.php.net/manual/en/reserved.variables.request.php',0),(3,'Test','test3',10.7767,106.684,NULL,NULL,0,1,NULL,50,'256 Dien Bien Phu, Quan 3, HCM',NULL,'http://www.php.net/manual/en/reserved.variables.request.php',0),(4,'Test Quest Form','The test begin',10.7861,106.678,NULL,NULL,0,NULL,NULL,50,'47 tran quang dieu',NULL,'',0),(5,'Test','test',10.7767,106.684,NULL,NULL,0,1,'http://mytempbucket.s3.amazonaws.com/1392013900.jpg',100,'256 Dien Bien Phu, Quan 3, HCM',NULL,'http://www.php.net/manual/en/reserved.variables.request.php',0),(6,'Take me inside','Give a hand to help a child.',21.0433,105.896,NULL,NULL,0,5,'http://mytempbucket.s3.amazonaws.com/1392013900.jpg',50,'123 Nguyen Van Linh',NULL,'http://www.php.net/manual/en/reserved.variables.request.php',0),(7,'Take me inside','Give a hand to help a child.',21.0433,105.896,NULL,NULL,0,5,'http://mytempbucket.s3.amazonaws.com/1392013900.jpg',50,'123 Nguyen Van Linh',NULL,'http://www.php.net/manual/en/reserved.variables.request.php',0);
/*!40000 ALTER TABLE `quest_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questcondition`
--

DROP TABLE IF EXISTS `questcondition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questcondition` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Type` int(11) DEFAULT NULL,
  `Value` int(11) DEFAULT '0',
  `VirtualQuestId` int(11) DEFAULT NULL,
  `ObjectId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=413 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questcondition`
--

LOCK TABLES `questcondition` WRITE;
/*!40000 ALTER TABLE `questcondition` DISABLE KEYS */;
INSERT INTO `questcondition` VALUES (10,1,1,4,1),(11,1,1,4,1),(12,1,1,4,1),(13,1,1,5,1),(14,1,1,5,1),(15,1,1,5,1),(16,1,1,6,1),(17,1,1,6,1),(18,1,1,6,1),(46,0,1,10,5),(47,1,1,10,11),(48,1,1,10,18),(49,1,1,10,17),(50,2,1,10,12),(51,2,1,10,22),(63,0,0,8,5),(64,1,0,8,10),(65,1,0,8,13),(66,1,0,8,7),(67,2,0,8,23),(68,0,0,9,5),(69,1,0,9,21),(70,1,0,9,18),(71,1,0,9,14),(72,2,0,9,17),(73,2,0,9,21),(74,2,0,9,19),(79,1,0,7,1),(80,1,0,7,3),(81,1,0,7,9),(82,2,0,7,26),(275,0,1400,3,5),(276,1,0,3,1),(277,1,0,3,9),(278,1,0,3,1),(279,2,0,3,17),(280,2,0,3,18),(281,2,0,3,21),(379,0,200,2,1),(380,1,0,2,1),(381,1,0,2,13),(382,1,0,2,1),(383,2,0,2,16),(384,2,0,2,26),(385,2,0,2,23),(406,0,100,1,5),(407,1,0,1,7),(408,1,0,1,4),(409,1,0,1,8),(410,2,0,1,11),(411,2,0,1,17),(412,2,0,1,23);
/*!40000 ALTER TABLE `questcondition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz`
--

DROP TABLE IF EXISTS `quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quiz` (
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
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz`
--

LOCK TABLES `quiz` WRITE;
/*!40000 ALTER TABLE `quiz` DISABLE KEYS */;
INSERT INTO `quiz` VALUES (69,5,5,'2014-04-07 10:15:36','What should you do in Vietnam if you see a child in situation where he/she looks like he/she needs help from an aggressor?',1,176,'','',NULL,''),(70,6,5,'2014-04-07 10:16:13','Who is responsible for of the protection of children?',1,181,'','',NULL,NULL),(71,6,5,'2014-04-07 10:17:11','Which group of children do you think is vulnerable to abuse?',1,185,'','',NULL,NULL),(72,6,5,'2014-04-07 10:17:58','If being abused, what should children do?',1,189,'','',NULL,NULL),(81,7,19,'2014-04-24 03:31:55','According to the Vietnamese Law of protection, education and care for children ,what ages are children at?',1,224,'','','',NULL),(82,6,19,'2014-04-24 03:33:12','When you see something wrong happening in the shelter, who /where can you know and trust to come to report  it?',1,229,'','','',NULL),(83,7,19,'2014-04-24 03:34:39','If you are so shy in a public to speak out what you though, which ways do you often use to express your feeling in the shelter?',1,231,'','','',NULL),(84,7,20,'2014-04-24 11:21:12','How many differet types of schools does the Vietnamese school system have? ',1,236,'The Vietnamese school system consists of four different types of school: Preschool, Primary School, Secondary School, High School. ','','',NULL),(85,0,22,'2014-04-28 15:58:47','What type are the children at the pagoda categorized as? ',1,241,'','','',NULL),(87,7,22,'2014-04-28 16:00:20','Can the children integrate with the community? ',1,246,'','','',NULL),(88,6,22,'2014-04-28 16:05:38','What type are the children at the pagoda categorized as?  ',1,253,'','','',NULL),(89,0,23,'2014-04-28 16:29:51','What children is considered to be difficulty children?',1,257,'','','',NULL),(90,0,23,'2014-04-28 16:31:53','How law protect children?',1,261,'','','',NULL),(91,5,24,'2014-05-07 02:22:33','What’s the life expectancy for Vietnamese people?',1,263,'','','',NULL),(92,5,24,'2014-05-07 02:23:18','In Vietnam, Malaria is still a serious problem. What helps to prevent this disease?\n',1,268,'','','',NULL),(93,5,24,'2014-05-07 02:23:58','How many people in VN die from HIV and Aids per year? \n',1,271,'','','',NULL),(94,5,24,'2014-05-07 02:24:36','Which of these Institution does NOT deal with health care?\n',1,277,'','','',NULL),(95,5,24,'2014-05-07 02:25:10','Which are the main death causes of Vietnamese children under 5 years?\n',1,280,'','','',NULL),(96,5,24,'2014-05-07 02:25:45','How high is the annual birth rate per 1.000 people in Vietnam?\n',1,284,'','','',NULL),(97,5,24,'2014-05-07 02:26:26','Which are the reasons why Vietnamese people do not go to a hospital?\n',1,289,'','','',NULL),(98,5,24,'2014-05-07 02:27:08','Which are the main problems of Vietnamese medications?\n',1,293,'','','',NULL),(99,5,24,'2014-05-07 02:28:03','Why do some doctors prefer to work in private hospitals instead of working in public hospitals?',1,295,'','','',NULL),(100,5,24,'2014-05-07 02:28:46','How many public hospitals are located in Vietnam’s capital Hanoi?\n',1,300,'','','',NULL),(101,5,24,'2014-05-07 02:29:20','How does the Vietnamese health system look like?\n',1,304,'','','',NULL),(102,5,24,'2014-05-07 02:30:00','Which of these areas in Vietnam are supposed to be Malaria free?\n',1,309,'','','',NULL),(103,6,24,'2014-05-07 02:50:37','How to protect your skin from intense sun?',1,313,'','','',NULL),(104,6,24,'2014-05-07 02:52:10','What to do to avoid traffic accidents?',1,317,'','','',NULL),(105,5,24,'2014-05-07 02:52:54','Which of these vaccines is not obligatory traveling to Vietnam?',1,320,'','','',NULL),(106,5,24,'2014-05-07 02:53:51','Which are the health problems most Vietnam travellers have to deal with?',1,325,'','','',NULL),(107,5,24,'2014-05-07 02:54:19','How to prevent bug bites?',1,326,'','','',NULL),(108,5,24,'2014-05-07 02:55:35','How to avoid gastrointestinal effects while traveling?',1,332,'','','',NULL),(109,6,24,'2014-05-07 02:56:47','What does a good travel health kit NOT include?',1,336,'','','',NULL),(110,8,24,'2014-05-07 02:57:21','What is affected by malnutrition?',1,341,'','','',NULL),(111,7,24,'2014-05-07 02:57:53','What is the median age of Vietnamese?',1,342,'','','',NULL),(112,5,24,'2014-05-07 02:58:41','What is the fertility rate per woman in VN?\n',1,346,'','','',NULL),(113,5,24,'2014-05-07 03:00:11','How high is the percentage of Vietnamese having NO access to drinking water?',1,350,'','','',NULL),(114,5,24,'2014-05-07 03:00:58','How high is the percentage of Vietnamese NOT having improved access to sanitation facilities?',1,357,'','','',NULL),(115,5,24,'2014-05-07 03:01:31','Which hospital is one of two public hospital in HCMC for children?\n',1,358,'','','',NULL),(116,5,24,'2014-05-07 03:02:41','Which information below are about Ho Chi Minh Ung Buou Cancer Hospital?',1,364,'','','',NULL),(117,5,24,'2014-05-07 03:04:16','Where is Ho Chi Minh Ung Buou Cancer Hospital?',1,366,'','','',NULL),(118,5,24,'2014-05-07 03:11:00','How are the children that are being treated in Ho Chi Minh Ung Buou Cancer Hospital?',1,373,'','','',NULL),(119,6,24,'2014-05-07 04:24:10','When you see something wrong happening in the shelter, who /where can you know and trust to come to report it?',1,377,'','','',NULL),(120,6,24,'2014-05-07 04:24:47','If you are so shy in a public to speak out what you though, which ways do you often use to\nexpress your feeling in the shelter?',1,379,'','','',NULL),(121,6,24,'2014-05-07 04:25:56','If being abused, what should children do?\n',1,385,'','','',NULL),(122,6,24,'2014-05-07 04:26:40','What can reduce the youth crime rate?',1,389,'','','',NULL),(123,6,24,'2014-05-07 04:27:05','Which legal system prevails in VN?\n',1,390,'','','',NULL),(124,6,24,'2014-05-07 04:27:38','From which age on are VN entitled to vote?',1,395,'','','',NULL),(125,6,24,'2014-05-07 04:28:04','In which pace of time are elections in Vietnam being held?\n',1,400,'','','',NULL),(126,6,24,'2014-05-07 04:28:29',' Which are the most common crimes tourists have to deal with while traveling around VN?\n',1,402,'','','',NULL),(127,6,24,'2014-05-07 04:30:47','What is the name of the main police and security force in VN?\n',1,407,'','','',NULL),(128,6,24,'2014-05-07 04:32:33',' Which color do VN police uniforms have?\n',1,413,'','','',NULL),(129,6,24,'2014-05-07 04:32:58','How many traffic related deaths does VN count per year?',1,417,'','','',NULL),(130,6,24,'2014-05-07 04:33:33','Where are the main destination of human trafficking in Vietnam?',1,420,'','','',NULL),(131,6,24,'2014-05-07 04:33:59','What are Vietnamese women, children and newborn babies trafficked for?\n',1,425,'','','',NULL),(132,6,24,'2014-05-07 04:47:37','How many percent of all Vietnamese victims of trafficking were children? (according to UK’s National Referral Mechanism record)',1,428,'','','',NULL),(133,6,24,'2014-05-07 04:48:29','Why are the trafficking girls recruited easily?',1,433,'','','',NULL),(134,6,24,'2014-05-07 04:49:00','How do the traffickers recruit the victims?',1,437,'','','',NULL),(135,6,24,'2014-05-07 04:49:29','Which age does Vietnamese law prohibit the employment of children?\n',1,438,'','','',NULL),(136,6,24,'2014-05-07 04:49:57','What kind of jobs could children do to earn money?\n',1,445,'','','',NULL),(137,6,24,'2014-05-07 04:50:38','How many percent of child laborers in manufacturing factories are under age of 15?\n',1,449,'','','',NULL),(138,6,24,'2014-05-07 04:51:19','How is working environment in manufacturing factories?\n',1,453,'','','',NULL),(139,6,24,'2014-05-07 04:53:01','According to a report from Human Rights Watch in 2006, how many street children were living throughout Vietnam?',1,455,'','','',NULL),(140,6,24,'2014-05-07 04:53:51','What causes street children?',1,461,'','','',NULL),(141,6,24,'2014-05-07 04:54:15','How many SOS children’s villages are there  in Vietnam?\n',1,464,'','','',NULL),(142,6,24,'2014-05-07 04:56:02','What is SOS children’s villages Vietnam’s function?\n',1,466,'','','',NULL),(143,6,24,'2014-05-07 04:56:26','When was SOS children’s villages Vietnam established?\n',1,472,'','','',NULL),(144,6,24,'2014-05-07 04:57:17','How many children does “a mother” take care of in SOS village?\n',1,475,'','','',NULL),(145,6,24,'2014-05-07 04:57:45','Where was the second SOS village opened?',1,479,'','','',NULL),(146,7,24,'2014-05-07 04:58:23','What are the main education goals in Vietnam?\n',1,484,'','','',NULL),(147,7,24,'2014-05-07 04:58:51','How old are Vietnamese children usually when they start going to school?',1,486,'','','',NULL),(148,7,24,'2014-05-07 04:59:17','Which one is NOT a school subject in Vietnam?\n',1,492,'','','',NULL),(149,7,24,'2014-05-07 05:00:08','Which teaching method is being practiced in VN universities?\n',1,496,'','','',NULL),(150,7,24,'2014-05-07 05:00:36','Which are the three most popular foreign countries for Vietnamese to study at?\n',1,498,'','','',NULL),(151,7,24,'2014-05-07 05:01:05','Which are the main reasons for Vietnamese students to drop out of school?\n',1,505,'','','',NULL),(152,7,24,'2014-05-07 05:01:26','Which is the most popular language to learn for Vietnamese students?\n',1,508,'','','',NULL),(153,7,24,'2014-05-07 05:01:56','How high is the illiteracy percentage amongst over 15 years old Vietnamese?',1,510,'','','',NULL),(154,7,24,'2014-05-07 05:02:37','Which form of state prevails in VN?\n',1,517,'','','',NULL),(155,7,24,'2014-05-07 05:03:23','What is the predominant religion in Vietnam?\n',1,521,'','','',NULL),(156,7,24,'2014-05-07 05:04:21','What’s the mean age at first birth of Vietnamese women?\n',1,522,'','','',NULL),(157,7,24,'2014-05-07 05:06:07','In Vietnam, how high are government’s education expenditures?\n',1,527,'','','',NULL),(158,7,24,'2014-05-07 05:06:40','How many Vietnamese children (5-14 years) are working?\n',1,531,'','','',NULL),(159,7,24,'2014-05-07 05:07:14','What is the name of the test, which enables Vietnamese students to attend Colleges or Universities?\n',1,535,'','','',NULL),(160,7,24,'2014-05-07 05:07:41','What is the estimated ratio between governmental and private kindergartens?',1,538,'','','',NULL),(161,7,24,'2014-05-07 05:08:14','Which types of school are compulsory in VN?\n',1,542,'','','',NULL),(162,7,24,'2014-05-07 05:08:41','What is NOT a benefit of school uniforms?\n',1,548,'','','',NULL),(163,7,24,'2014-05-07 05:09:07','How many years does the formal education consist of?\n',1,552,'','','',NULL),(164,7,24,'2014-05-07 05:09:23','How many subjects are there in the national High Graduation Examination?',1,556,'','','',NULL),(165,7,24,'2014-05-07 05:11:40','What are teaching quality issues?\n',1,561,'','','',NULL),(166,7,24,'2014-05-07 05:12:17','What are students expected in the class?',1,562,'','','',NULL),(167,7,24,'2014-05-07 05:12:51','What is the average monthly salary of local Vietnamese public teachers?\n',1,566,'','','',NULL),(168,7,24,'2014-05-07 05:13:18','What can teacher do to earn more money to make their living besides monthly salary?\n',1,573,'','','',NULL),(169,7,24,'2014-05-07 05:13:41','How many basic groups can the students choose to do their exams to go to university?',1,575,'','','',NULL),(170,7,24,'2014-05-07 05:14:06','Which fixed subjects are included in national High Graduation Examination?\n',1,578,'','','',NULL),(171,7,24,'2014-05-07 05:14:37','When is the national High Graduation Examination held?\n',1,583,'','','',NULL),(172,7,24,'2014-05-07 05:15:08','When is Teacher’s day?\n',1,588,'','','',NULL),(173,7,24,'2014-05-07 06:58:49','What do students usually do on Teacher’s day?\n',1,593,'','','',NULL),(174,7,24,'2014-05-07 06:59:15','According to the World Bank, in 2010 what was the gross enrolment rate at upper-secondary schools in Vietnam?',1,594,'','','',NULL),(175,7,24,'2014-05-07 06:59:45','When is University entrance examination held?\n',1,600,'','','',NULL),(176,8,24,'2014-05-07 07:03:49','What causes a loss of nutrition?',1,604,'','','',NULL),(177,7,24,'2014-05-07 07:04:40','If going to University of Technology in HCM, which group of subjects will students have to do exams?',1,606,'','','',NULL),(178,7,24,'2014-05-07 07:05:07','Which subjects does group A consist of?',1,610,'','','',NULL),(179,8,24,'2014-05-07 07:06:48','Which are the main health problems Vietnamese children have to deal with today?',1,617,'','','',NULL),(180,7,24,'2014-05-07 07:07:06','When did Vietnam’s Ministry of Education and Training start to use multiple choice exam format for several subjects during the entrance',1,618,'','','',NULL),(181,7,24,'2014-05-07 07:07:41','How high are the average annual university fees in VN?\n',1,624,'','','',NULL),(182,8,24,'2014-05-07 07:07:52','How many children under the age of 5 suffer from malnutrition?',1,628,'','','',NULL),(183,7,24,'2014-05-07 07:08:11','What is the definition of literacy?',1,633,'','','',NULL),(184,7,24,'2014-05-07 07:08:47','What Vietnam’s average pupil-teacher ratio?\n',1,636,'','','',NULL),(185,8,24,'2014-05-07 07:08:48','Which are possible symptoms of chronic malnutrition?',1,641,'','','',NULL),(186,8,24,'2014-05-07 07:09:33','Which areas of VN are hit hardest by malnutrition?',1,642,'','','',NULL),(187,0,24,'2014-05-07 07:09:52','Which are the main educational barriers for VN children?',1,649,'','','',NULL),(188,8,24,'2014-05-07 07:10:14','How to prevent malnutrition?',1,653,'','','',NULL),(189,7,24,'2014-05-07 07:10:33','What are one of traditional values of Vietnamese people?',1,657,'','','',NULL),(190,8,24,'2014-05-07 07:11:01','Which food intolerance do most Asians and Africans suffer from?',1,659,'','','',NULL),(191,7,24,'2014-05-07 07:11:02','Which English skills do Vietnamese schools focus on?\n',1,662,'','','',NULL),(192,8,24,'2014-05-07 07:11:40','Which parts of the world have the highest malnutrition rates?',1,668,'','','',NULL),(193,7,24,'2014-05-07 07:11:55','How many percent of children in rural areas do not continue in education after they reach age of 14?',1,671,'','','',NULL),(194,7,24,'2014-05-07 07:12:34','When is students’ vacation?',1,674,'','','',NULL),(195,0,24,'2014-05-07 07:13:09','Which percentage of VN people lives in urban areas?',1,681,'','','',NULL),(196,0,24,'2014-05-07 07:14:21','Where do Vietnamese civil weddings take place?',1,685,'','','',NULL),(197,0,24,'2014-05-07 07:16:20','What’s the minimum age for Vietnamese men to get married?',1,688,'','','',NULL),(198,0,24,'2014-05-07 07:17:54','How high is the NEW international poverty line referring to the World Bank?',1,692,'','','',NULL),(199,0,24,'2014-05-07 07:18:47','Which one is NOT a UN Millennium Development Goal?',1,697,'','','',NULL),(200,0,24,'2014-05-07 07:19:40','What does the Human Development Index measure?',1,698,'','','',NULL),(201,0,24,'2014-05-07 07:20:19','Which is VN’s biggest city?',1,703,'','','',NULL),(202,0,24,'2014-05-07 07:22:21','Which are VN’s main export goods?',1,709,'','','',NULL),(203,0,24,'2014-05-07 07:23:11','What is the Tet holiday?',1,710,'','','',NULL),(204,0,24,'2014-05-07 07:23:56','What do children usually do on the Tet holiday?',1,717,'','','',NULL),(205,0,24,'2014-05-07 07:25:21','What are traditional virtues the children are taught in their families?',1,721,'','','',NULL),(206,0,24,'2014-05-07 07:26:16','Why do Vietnamese parents encourage their children study and excel in their education?',1,725,'','','',NULL),(207,0,24,'2014-05-07 07:28:44','What are parents allowed to do when children are disobedient?',1,726,'','','',NULL),(208,0,24,'2014-05-07 07:29:19','What are children expected to do when their parents grow old?',1,733,'','','',NULL),(209,0,24,'2014-05-07 07:34:40','Which is VN’s biggest city?',1,735,'','','',NULL),(210,0,24,'2014-05-07 07:37:13','Which countries count more than 1 million citizens? ',1,740,'','','',NULL),(211,0,24,'2014-05-07 07:38:50','Which are VN’s main export goods?',1,745,'','','',NULL),(212,0,24,'2014-05-07 07:39:34','What is the Tet holiday?',1,746,'','','',NULL),(213,0,24,'2014-05-07 07:40:10','What do children usually do on the Tet holiday?',1,753,'','','',NULL),(214,0,24,'2014-05-07 07:40:44','What are traditional virtues the children are taught in their families?',1,757,'','','',NULL),(215,0,24,'2014-05-07 07:41:48','What are parents allowed to do when children are disobedient?',1,758,'','','',NULL),(216,0,24,'2014-05-07 07:50:44','What are children expected to do when their parents grow old?',1,765,'','','',NULL),(217,0,24,'2014-05-07 07:53:27',' What is the role of the wife in the family?',1,769,'','','',NULL),(218,0,24,'2014-05-07 07:54:18','Which one below is traditional game?',1,770,'','','',NULL);
/*!40000 ALTER TABLE `quiz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quizcategory`
--

DROP TABLE IF EXISTS `quizcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quizcategory` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quizcategory`
--

LOCK TABLES `quizcategory` WRITE;
/*!40000 ALTER TABLE `quizcategory` DISABLE KEYS */;
INSERT INTO `quizcategory` VALUES (0,'No Category'),(1,'General'),(5,'Health services'),(6,'Protection'),(7,'Education'),(8,'Nutritions');
/*!40000 ALTER TABLE `quizcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reward`
--

DROP TABLE IF EXISTS `reward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reward` (
  `id` int(11) NOT NULL,
  `reward_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_url` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reward`
--

LOCK TABLES `reward` WRITE;
/*!40000 ALTER TABLE `reward` DISABLE KEYS */;
INSERT INTO `reward` VALUES (1,'Medal of HONOR','http://ec2-54-200-123-156.us-west-2.compute.amazonaws.com/travelhero/images/medals/d6cd052f-273b-4192-9af2-5769db01ed04.png'),(2,'Trophy of HONOR','http://ec2-54-200-123-156.us-west-2.compute.amazonaws.com/travelhero/images/medals/e266579b-df4c-49a4-9146-eba7a8a11961.png');
/*!40000 ALTER TABLE `reward` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'hyper-admin'),(2,'super-admin'),(3,'admin'),(4,'ngo'),(5,'user');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rolefunction`
--

DROP TABLE IF EXISTS `rolefunction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rolefunction` (
  `RoleId` int(11) NOT NULL AUTO_INCREMENT,
  `FunctionId` int(11) DEFAULT NULL,
  PRIMARY KEY (`RoleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rolefunction`
--

LOCK TABLES `rolefunction` WRITE;
/*!40000 ALTER TABLE `rolefunction` DISABLE KEYS */;
/*!40000 ALTER TABLE `rolefunction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `id` int(11) NOT NULL DEFAULT '0',
  `fullname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES (1,'a'),(2,'b'),(3,'c'),(4,'d'),(5,'e'),(6,'f'),(7,'g'),(8,'h'),(9,'i'),(10,'j'),(11,'k'),(12,'l'),(13,'m'),(14,'n'),(15,'o'),(16,'p'),(17,'q'),(71,'a'),(92,'b'),(103,'c'),(114,'d'),(125,'e'),(136,'f'),(147,'g'),(158,'h');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `FullName` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RegisterDate` datetime DEFAULT NULL,
  `PhoneNumber` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Address` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Vu Hoang Son','gun4boy@yahoo.com','2014-04-25 00:00:00','',NULL),(2,NULL,'hoiquangvn@gmail.com','2014-04-28 15:57:11','+84.38951014 – 0938.456.215 – 0903.005.442',NULL),(3,NULL,'cuccuvn2005@yahoo.com','2014-04-28 16:10:54','(+84) 838 388 872 – (+84) 913 639 386',NULL),(4,NULL,'cuccuvn2005@yahoo.com','2014-04-28 16:11:16','(+84) 838 388 872 – (+84) 913 639 386',NULL),(5,NULL,'cuccuvn2005@yahoo.com','2014-04-28 16:11:34','(+84) 838 388 872 – (+84) 913 639 386',NULL),(6,NULL,'cuccuvn2005@yahoo.com','2014-04-28 16:11:41','(+84) 838 388 872 – (+84) 913 639 386',NULL),(7,NULL,'cuccuvn2005@yahoo.com','2014-04-28 16:11:47','(+84) 838 388 872 – (+84) 913 639 386',NULL),(8,NULL,'cuccuvn2005@yahoo.com','2014-04-28 16:12:01','(+84) 838 388 872 – (+84) 913 639 386',NULL),(9,NULL,'cuccuvn2005@yahoo.com','2014-04-28 16:12:09','(+84) 838 388 872 – (+84) 913 639 386',NULL),(10,NULL,'cuccuvn2005@yahoo.com','2014-04-28 16:12:15','(+84) 838 388 872 – (+84) 913 639 386',NULL),(11,NULL,'cuccuvn2005@yahoo.com','2014-04-28 16:12:20','(+84) 838 388 872 – (+84) 913 639 386',NULL),(12,NULL,'cuccuvn2005@yahoo.com','2014-04-28 16:12:26','(+84) 838 388 872 – (+84) 913 639 386',NULL),(13,NULL,'cuccuvn2005@yahoo.com','2014-04-28 16:12:31','(+84) 838 388 872 – (+84) 913 639 386',NULL),(14,NULL,'cuccuvn2005@yahoo.com','2014-04-28 16:12:38','(+84) 838 388 872 – (+84) 913 639 386',NULL),(15,NULL,'cuccuvn2005@yahoo.com','2014-04-28 16:12:44','(+84) 838 388 872 – (+84) 913 639 386',NULL),(16,NULL,'cuccuvn2005@yahoo.com','2014-04-28 16:12:49','(+84) 838 388 872 – (+84) 913 639 386',NULL),(17,NULL,'cuccuvn2005@yahoo.com','2014-04-28 16:12:54','(+84) 838 388 872 – (+84) 913 639 386',NULL),(18,NULL,'cuccuvn2005@yahoo.com','2014-04-28 16:26:32','(+84) 838 388 872 – (+84) 913 639 386',NULL),(19,'test','test','2014-05-05 00:00:00','123',NULL),(20,'Test','test@gmail.com','2014-05-07 00:00:00','09013523',NULL),(21,NULL,'imrhung@yahoo.com','2014-05-07 02:21:25','84912880656',NULL),(23,'test','','2014-05-12 00:00:00','123123',NULL),(24,'Ngọc Tân','0','2014-05-12 00:00:00','',NULL),(25,'Angel Mai Mai','0','2014-05-12 00:00:00','',NULL),(26,'Saltilano Chan','green.peak93@gmail.com','2014-05-19 00:00:00','',NULL),(27,'hung','asdf','2014-05-28 00:00:00','sdfsf',NULL),(28,NULL,'littlerosestory@gmail.com','2014-05-29 03:25:41','(+84) 38. 720. 308',NULL),(29,NULL,'littlerosestory@gmail.com','2014-05-29 03:27:08','(+84) 38. 720. 308',NULL),(30,NULL,'littlerosestory@gmail.com','2014-05-29 03:28:34','(+84) 38. 720. 308',NULL),(31,'0','0','2014-06-02 00:00:00','0',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_quest`
--

DROP TABLE IF EXISTS `user_quest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_quest` (
  `user_id` int(11) DEFAULT NULL,
  `quest_id` int(11) DEFAULT NULL,
  `parent_quest_id` int(11) DEFAULT NULL,
  `status_quest` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_quest`
--

LOCK TABLES `user_quest` WRITE;
/*!40000 ALTER TABLE `user_quest` DISABLE KEYS */;
INSERT INTO `user_quest` VALUES (1,2,1,0),(27,8,5,0),(1,3,1,0),(27,6,5,0),(27,9,5,0),(27,2,1,0),(6,2,1,0),(1,7,5,0),(1,4,1,0);
/*!40000 ALTER TABLE `user_quest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userapplication`
--

DROP TABLE IF EXISTS `userapplication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userapplication` (
  `UserId` int(11) NOT NULL,
  `FacebookId` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Points` int(11) DEFAULT '0',
  `CurrentLevel` int(11) DEFAULT '0',
  PRIMARY KEY (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userapplication`
--

LOCK TABLES `userapplication` WRITE;
/*!40000 ALTER TABLE `userapplication` DISABLE KEYS */;
INSERT INTO `userapplication` VALUES (1,'1498934909',990633,0),(19,'34563',80,0),(20,'86756578',0,0),(23,'23123',0,0),(24,'100002989569961',994052,0),(25,'548597684',17,0),(26,'100002646112287',0,0),(27,'asdfsdf',0,0),(31,'0',0,0);
/*!40000 ALTER TABLE `userapplication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usercondition`
--

DROP TABLE IF EXISTS `usercondition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usercondition` (
  `UserId` int(11) NOT NULL,
  `ConditionId` int(11) NOT NULL,
  `AchievingPoints` int(11) DEFAULT '0',
  PRIMARY KEY (`UserId`,`ConditionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Keep track user - condition on each quest. If user have record here, means that user have completed this condition. :)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usercondition`
--

LOCK TABLES `usercondition` WRITE;
/*!40000 ALTER TABLE `usercondition` DISABLE KEYS */;
INSERT INTO `usercondition` VALUES (1,1,NULL),(1,2,91),(1,3,10),(1,4,10),(1,6,70),(1,12,10),(1,261,9),(1,282,13),(1,283,400),(1,303,501),(1,304,100),(1,305,100),(1,306,100),(1,307,-3245),(1,308,-100),(1,309,-100),(1,330,1),(1,343,100),(1,344,100),(1,345,100),(1,346,-3245),(1,347,-100),(1,348,-100),(1,379,200),(1,380,100),(1,381,100),(1,382,100),(1,383,-100),(1,384,-100),(1,385,-100),(1,406,200),(1,407,100),(1,408,100),(1,409,100),(1,410,-3245),(1,411,-100),(1,412,-100),(24,0,-1445),(24,1,15),(24,2,2),(24,3,1),(24,4,1),(24,5,1),(24,8,1),(24,9,7),(24,303,513),(24,304,100),(24,305,100),(24,306,100),(24,307,-3245),(24,308,-100),(24,309,-100),(24,406,7),(24,407,100),(24,408,100),(24,409,100),(24,410,-3245),(24,411,-100),(24,412,-100);
/*!40000 ALTER TABLE `usercondition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usermedal`
--

DROP TABLE IF EXISTS `usermedal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usermedal` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` int(11) DEFAULT NULL,
  `MedalId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usermedal`
--

LOCK TABLES `usermedal` WRITE;
/*!40000 ALTER TABLE `usermedal` DISABLE KEYS */;
INSERT INTO `usermedal` VALUES (1,1,3),(2,1,4),(3,1,5),(4,1,6),(5,1,7),(6,24,1),(7,24,2),(8,24,3),(10,24,3),(11,24,0);
/*!40000 ALTER TABLE `usermedal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpartner`
--

DROP TABLE IF EXISTS `userpartner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpartner` (
  `UserId` int(11) NOT NULL AUTO_INCREMENT,
  `PartnerId` int(11) DEFAULT NULL,
  `UserName` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Password` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpartner`
--

LOCK TABLES `userpartner` WRITE;
/*!40000 ALTER TABLE `userpartner` DISABLE KEYS */;
INSERT INTO `userpartner` VALUES (2,22,'chuakyquang','24632717443dda87183269c364d29fc2'),(3,5,'unicef_vietnam','e10adc3949ba59abbe56e057f20f883e'),(4,6,'agapevn','e10adc3949ba59abbe56e057f20f883e'),(16,17,'qweqwe','efe6398127928f1b2e9ef3207fb82663'),(17,18,'qweqwe12','e10adc3949ba59abbe56e057f20f883e'),(18,23,'vapcrcso','a710cfe81722c4b1854018fbb6e3257c'),(21,24,'ocean4','e10adc3949ba59abbe56e057f20f883e'),(26,19,'maiamq8','563fe85511b161723cf4118632fa8942'),(27,20,'Kate M.','e61b7c148c24d2bdc50d2ad9a61e4e17'),(28,21,'jenkins','f57e705fda6ce4fbdcc71b68909c1767'),(30,25,'hoahongnho','e10adc3949ba59abbe56e057f20f883e');
/*!40000 ALTER TABLE `userpartner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userrole`
--

DROP TABLE IF EXISTS `userrole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userrole` (
  `UserId` int(11) NOT NULL,
  `RoleId` int(11) DEFAULT NULL,
  PRIMARY KEY (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userrole`
--

LOCK TABLES `userrole` WRITE;
/*!40000 ALTER TABLE `userrole` DISABLE KEYS */;
INSERT INTO `userrole` VALUES (2,4),(3,3),(4,4),(5,4),(6,4),(7,4),(8,4),(9,4),(10,4),(11,4),(12,4),(13,4),(14,4),(15,4),(16,4),(17,4),(18,4),(21,4),(26,4),(27,4),(29,4),(30,4);
/*!40000 ALTER TABLE `userrole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'\0\0','administrator','59beecdf7fc966e2f17fd8f65a4a9aeb09d4a3d4','9462e8eee0','admin@admin.com','',NULL,NULL,'9d029802e28cd9c768e8e62277c0df49ec65c48c',1268889823,1393398559,1,'Admin','istrator','ADMIN','0',0,'','','0000-00-00','','','','','','',0,0,'','0000-00-00'),(5,'\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0','nguyen hung','972df4edf86993b212e52272d58baac2240e3af3',NULL,'imrhung3@yahoo.com',NULL,NULL,NULL,'53d06108ae0d58e982780f8633648efbbfb00563',1393147053,1393164677,1,'Nguyen','Hung','SEED Inc.','84912880656',0,'','','0000-00-00','','','','','','',0,0,'','0000-00-00'),(8,'\0\0','imr.hung','025ed971853ccd493bd1a8615f273b16bb786800',NULL,'50901113@stu.hcmut.edu.vn',NULL,NULL,NULL,'de143548ca32dc28afd51d88d84fe51119a18e62',1393470989,1393485901,1,'Imr','Hung',NULL,NULL,1,'https://www.facebook.com/imr.hung','I like to smile every time !','1991-07-14','Ho Chi Minh City, Vietnam','','','','','',0,0,'','0000-00-00');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_users_groups` (`user_id`,`group_id`),
  KEY `fk_users_groups_users1_idx` (`user_id`),
  KEY `fk_users_groups_groups1_idx` (`group_id`),
  CONSTRAINT `fk_users_groups_groups1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_groups_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_groups`
--

LOCK TABLES `users_groups` WRITE;
/*!40000 ALTER TABLE `users_groups` DISABLE KEYS */;
INSERT INTO `users_groups` VALUES (1,1,1),(2,1,2),(6,5,2),(13,8,2);
/*!40000 ALTER TABLE `users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uservirtualquest`
--

DROP TABLE IF EXISTS `uservirtualquest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uservirtualquest` (
  `UserId` int(11) NOT NULL,
  `QuestId` int(11) NOT NULL,
  `Status` int(11) NOT NULL COMMENT 'Status: 1 = lock, 1 = unlock, 2 = solve',
  PRIMARY KEY (`UserId`,`QuestId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uservirtualquest`
--

LOCK TABLES `uservirtualquest` WRITE;
/*!40000 ALTER TABLE `uservirtualquest` DISABLE KEYS */;
INSERT INTO `uservirtualquest` VALUES (1,1,2),(19,1,1),(20,1,1),(23,1,1),(24,1,1),(25,1,1),(26,1,1),(27,1,1),(31,1,1),(1,3,1),(1,2,2);
/*!40000 ALTER TABLE `uservirtualquest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `view_userinfo`
--

DROP TABLE IF EXISTS `view_userinfo`;
/*!50001 DROP VIEW IF EXISTS `view_userinfo`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_userinfo` (
  `uUserId` tinyint NOT NULL,
  `uFacebookId` tinyint NOT NULL,
  `uPoints` tinyint NOT NULL,
  `uCurrentLevel` tinyint NOT NULL,
  `vId` tinyint NOT NULL,
  `vQuestName` tinyint NOT NULL,
  `vPacketId` tinyint NOT NULL,
  `vPartnerId` tinyint NOT NULL,
  `vAnimationId` tinyint NOT NULL,
  `vUnlockPoint` tinyint NOT NULL,
  `vCreateDate` tinyint NOT NULL,
  `qStatus` tinyint NOT NULL,
  `cId` tinyint NOT NULL,
  `cType` tinyint NOT NULL,
  `cValue` tinyint NOT NULL,
  `cVirtualQuestId` tinyint NOT NULL,
  `cObjectId` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `virtualquest`
--

DROP TABLE IF EXISTS `virtualquest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `virtualquest` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `QuestName` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PacketId` int(11) DEFAULT NULL,
  `PartnerId` int(11) DEFAULT NULL,
  `AnimationId` int(11) DEFAULT '1',
  `UnlockPoint` int(11) DEFAULT NULL,
  `CreateDate` datetime DEFAULT NULL,
  `ImageURL` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `virtualquest`
--

LOCK TABLES `virtualquest` WRITE;
/*!40000 ALTER TABLE `virtualquest` DISABLE KEYS */;
INSERT INTO `virtualquest` VALUES (1,'Save Nam, a sick boy',1,5,1,0,NULL,'http://192.168.11.132/~vuhoangson/assets/img/quest/2.png'),(2,'Help Han Get Clean Water',1,5,2,100,NULL,'http://192.168.11.132/~vuhoangson/assets/img/quest/1.png'),(3,'quest 3',1,5,3,200,NULL,'http://192.168.11.132/~vuhoangson/assets/img/quest/2.png'),(4,'Test D',2,5,1,1000,NULL,'http://192.168.11.132/~vuhoangson/assets/img/quest/3.png'),(5,'Test E',2,5,1,1000,NULL,'http://192.168.11.132/~vuhoangson/assets/img/quest/3.png'),(6,'Test F',2,5,1,1000,NULL,'http://192.168.11.132/~vuhoangson/assets/img/quest/2.png'),(7,'Da Nang Quest',3,5,1,500,NULL,'http://192.168.11.132/~vuhoangson/assets/img/quest/2.png'),(8,'Da Nang Hero',3,5,1,100,NULL,'http://192.168.11.132/~vuhoangson/assets/img/quest/1.png'),(9,'Middle Hero',3,5,1,5,NULL,'http://192.168.11.132/~vuhoangson/assets/img/quest/4.png'),(10,'Heal the world',4,5,1,500,'2014-05-05 07:31:44','http://192.168.11.132/~vuhoangson/assets/img/quest/3.png');
/*!40000 ALTER TABLE `virtualquest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'zadmin_heroforzero'
--
/*!50003 DROP FUNCTION IF EXISTS `fnc_checkSignUpInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fnc_checkSignUpInfo`(iFullName VARCHAR(100),
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fnc_checkSignUpWithFacebookInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fnc_checkSignUpWithFacebookInfo`(iFacebookId VARCHAR(100),
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_allquestofuseraccept` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_allquestofuseraccept`(IN iUserId INT)
BEGIN
	SELECT * FROM quest
	INNER JOIN user_quest
	ON quest.id = user_quest.quest_id
	WHERE user_quest.user_id = iUserId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_checksignupwithemailinfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_checksignupwithemailinfo`(iFullName VARCHAR(100),
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_checksignupwithfacebookinfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_checksignupwithfacebookinfo`(IN iFacebookId VARCHAR(100),
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_completeQuestProcess` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_completeQuestProcess`(IN inUserId INT, IN inQuestId INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Delete_Activity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Delete_Activity`(Id INT)
BEGIN
		DELETE FROM zadmin_heroforzero.activity
			WHERE activity.Id = Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Delete_Donation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Delete_Donation`(Id INT)
BEGIN
		DELETE FROM zadmin_heroforzero.donation
			WHERE donation.Id = Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Delete_Partner` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Delete_Partner`(Id INT)
BEGIN
	SET @Id = Id;

	-- Delete in 4 table:
	DELETE userrole, user, userpartner, partner FROM userrole inner join userpartner inner join user inner join partner
			WHERE userrole.UserId = userpartner.UserId
			AND userpartner.UserId = user.Id
			AND partner.Id = @Id
			and userpartner.PartnerId = @Id ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Delete_QuestCondition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Delete_QuestCondition`(Id INT)
BEGIN
	DELETE FROM zadmin_heroforzero.questcondition WHERE VirtualQuestId = Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Delete_Quiz` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Delete_Quiz`(Id INT)
BEGIN
	DELETE FROM zadmin_heroforzero.quiz
		WHERE quiz.Id = Id;
				
	DELETE FROM zadmin_heroforzero.choice
		WHERE choice.QuestionId = Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Delete_VirtualQuest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Delete_VirtualQuest`(Id INT)
BEGIN
	DELETE FROM zadmin_heroforzero.virtualquest
			WHERE virtualquest.Id = Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getActivitiesByPartnerId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_getActivitiesByPartnerId`(IN partnerId INT)
BEGIN
	SELECT * FROM Activity WHERE PartnerId = partnerId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getDonationBy` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_getDonationBy`(IN currentPage INT, IN pageSize INT)
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getNumberOfChildrenByUserId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_getNumberOfChildrenByUserId`()
BEGIN
	SELECT (7000000 - COUNT(QuestId)) AS `numOfChildren` FROM uservirtualquest WHERE Status = 2;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetOrganizationList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_GetOrganizationList`(
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
		"SELECT partner.*, organizationtype.TypeName
		FROM 
				zadmin_heroforzero.organizationtype,
				zadmin_heroforzero.partner
		WHERE 
				organizationtype.Id = partner.OrganizationTypeId
		ORDER BY partner.Id
		LIMIT ?,?";
		EXECUTE STMT USING @rowNumber, @_pageSize;
		DEALLOCATE PREPARE STMT;
	else  
		SELECT partner.*, organizationtype.TypeName
		FROM 
				zadmin_heroforzero.organizationtype,
				zadmin_heroforzero.partner
		WHERE 
				organizationtype.Id = partner.OrganizationTypeId
		ORDER BY partner.Id;
		end if;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getPacketsBy` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_getPacketsBy`(IN currentPage INT, IN iPageSize INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getparentquest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_getparentquest`(IN iQuestId INT)
BEGIN
	SELECT * FROM quest WHERE id = (SELECT parent_quest_id FROM quest WHERE id = iQuestId);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getquestrefer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_getquestrefer`(IN iQuestId INT)
BEGIN
	SELECT * FROM quest WHERE parent_quest_id = (SELECT parent_quest_id FROM quest WHERE id = iQuestId) ORDER BY id ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getuserdatawithemail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_getuserdatawithemail`(IN userName VARCHAR(100), IN pass VARCHAR(100))
BEGIN
	DECLARE userId INT;
	SELECT id INTO userId FROM user WHERE email = userName AND `password` = pass;
	SELECT *,(SELECT COUNT(*) FROM user_quest WHERE user_quest.user_id = userId) AS quest_count FROM user WHERE id = userId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getuserdatawithfacebook` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_getuserdatawithfacebook`(IN facebookId VARCHAR(100))
BEGIN
	DECLARE userId INT;
	SELECT id INTO userId FROM user WHERE facebook_id = facebookId;
	SELECT *,(SELECT COUNT(*) FROM user_quest WHERE user_quest.user_id = userId) AS quest_count FROM user WHERE id = userId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getVirtualQuestForMobile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_getVirtualQuestForMobile`(IN inId INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_Activity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_Activity`(id INT)
BEGIN
	SELECT activity.*, partner.PartnerName FROM zadmin_heroforzero.activity, zadmin_heroforzero.action, zadmin_heroforzero.partner
		
			
		WHERE
				activity.PartnerId = partner.Id
			AND
				activity.Id = id;
				
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_ActivityList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_ActivityList`(IN currentPage INTEGER, IN pageSize INTEGER)
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
				zadmin_heroforzero.activity,
				zadmin_heroforzero.partner
		WHERE 
				activity.PartnerId = partner.Id
		ORDER BY activity.CreateDate DESC
		LIMIT ?,?";
		EXECUTE STMT USING @rowNumber, @_pageSize;
		DEALLOCATE PREPARE STMT;
	else  
		SELECT activity.Id, activity.Title, activity.ActionContent, partner.PartnerName, activity.BonusPoint,  activity.IsApproved, activity.CreateDate, partner.IconURL, activity.Description, activity.ActionId, partner.WebsiteUrl
		FROM 
				zadmin_heroforzero.activity,
				zadmin_heroforzero.partner
		WHERE 
				activity.PartnerId = partner.Id
		ORDER BY activity.CreateDate DESC;
		end if;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_Animation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_Animation`(id INT)
BEGIN
	SELECT * FROM zadmin_heroforzero.animation			
		WHERE
				animation.Id = id;
				
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_Donation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_Donation`(Id INT)
BEGIN
	SELECT donation.Id, donation.Title, donation.Description, donation.PartnerId, partner.PartnerName, donation.RequiredPoint,  donation.IsApproved, donation.CreateDate
		FROM 
				zadmin_heroforzero.donation,
				zadmin_heroforzero.partner
		WHERE 
				donation.PartnerId = partner.Id
		AND 	donation.Id = Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_DonationList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_DonationList`(IN currentPage INT, IN pageSize INT)
BEGIN
	DECLARE rowNumber INT;
	SET @currentPage = currentPage;
	SET @rowNumber = currentPage * pageSize;
	
	if (pageSize != 0) 
	then
		PREPARE STMT FROM
		"SELECT donation.Id, donation.Title, partner.PartnerName, donation.RequiredPoint,  donation.IsApproved, donation.CreateDate, medal.ImageURL, donation.Description, donation.MedalId
		FROM 
				zadmin_heroforzero.donation,
				zadmin_heroforzero.partner,
				zadmin_heroforzero.medal
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
				zadmin_heroforzero.donation,
				zadmin_heroforzero.partner,
				zadmin_heroforzero.medal
		WHERE 
				donation.PartnerId = partner.Id
				AND medal.Id = donation.MedalId
		ORDER BY donation.CreateDate DESC;
		END if;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_Leaderboard` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_Leaderboard`(IN currentPage INT, IN pageSize INT, IN friends NVARCHAR(5000))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_PacketAvailableList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_PacketAvailableList`(IN currentPage INT, IN pageSize INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_PacketList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_PacketList`(IN currentPage INT, IN pageSize INT)
BEGIN
	DECLARE rowNumber INT;
	
	SET @currentPage = currentPage;
	SET @rowNumber = currentPage * pageSize;
	
	if (pageSize != 0) 
	then	
		PREPARE STMT FROM
		"SELECT * FROM zadmin_heroforzero.packet
		LIMIT ?,?";
		EXECUTE STMT USING @rowNumber, @pageSize;
		DEALLOCATE PREPARE STMT;
	else
		SELECT * FROM zadmin_heroforzero.packet;
	END if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_Partner` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_Partner`(IN Id INT)
BEGIN
	SELECT partner.Id, partner.PartnerName, partner.OrganizationTypeId, partner.Address,  partner.PhoneNumber, partner.WebsiteURL, partner.Latitude, partner.Longtitude, partner.Description, userpartner.UserName, partner.IsApproved, user.Email
		FROM 
				zadmin_heroforzero.user,
				zadmin_heroforzero.userpartner,
				zadmin_heroforzero.partner
		WHERE 
				partner.Id = Id
		AND		partner.Id = userpartner.PartnerId
		AND 	userpartner.UserId = user.Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_PartnerList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_PartnerList`(IN currentPage INT, IN pageSize INT)
BEGIN
	DECLARE rowNumber INT;
	SET @currentPage = currentPage;
	SET @rowNumber = currentPage * pageSize;
	
	if (pageSize != 0) 
	then
		PREPARE STMT FROM
		"SELECT partner.Id, partner.PartnerName, partner.OrganizationTypeId, partner.Address,  partner.PhoneNumber, partner.WebsiteURL, partner.Latitude, partner.Longtitude, partner.Description, partner.IsApproved
		FROM 
				zadmin_heroforzero.partner
		order by partner.Id DESC
		LIMIT  ?,?";
		EXECUTE STMT USING @rowNumber, @_pageSize;
		DEALLOCATE PREPARE STMT;
	
	else  
		SELECT partner.Id, partner.PartnerName, partner.OrganizationTypeId, partner.Address,  partner.PhoneNumber, partner.WebsiteURL, partner.Latitude, partner.Longtitude, partner.Description, partner.IsApproved
		FROM 
				zadmin_heroforzero.partner
		order by partner.Id DESC;
	END if;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_QuestCondition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_QuestCondition`(Id INT)
BEGIN
	
		SELECT 
			Id, 
			Type, 
			ObjectId,
			Value
		FROM zadmin_heroforzero.questcondition
		WHERE questcondition.VirtualQuestId = Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_QuestCondition_before` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_QuestCondition_before`(Id INT)
BEGIN
	DECLARE typeCondition INT;
	SET typeCondition = (SELECT Type FROM zadmin_heroforzero.questcondition 
								WHERE questcondition.VirtualQuestId = Id);
	
	if(typeCondition = 0) then
		SELECT 
			Id, 
			Type, 
			ObjectId, 
			
			Value
		FROM zadmin_heroforzero.virtualquest, questcondition
		WHERE questcondition.VirtualQuestId = Id;

	elseif(typeCondition = 1) then
		SELECT 
			Id, 
			Type, 
			ObjectId, 
			activity.Title as ObjectName,
			Value
		FROM zadmin_heroforzero.virtualquest, questcondition, activity
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
		FROM zadmin_heroforzero.virtualquest, questcondition, donation
		WHERE 
				questcondition.VirtualQuestId = Id
			AND
				donation.Id = questcondition.ObjectId;
	END if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_Quiz` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_Quiz`(Id Int)
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
	
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_QuizCategoryList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_QuizCategoryList`(IN currentPage INT, IN pageSize INT)
BEGIN
	DECLARE rowNumber INT;
	SET @currentPage = currentPage;
	SET @rowNumber = currentPage * pageSize;

	if (pageSize != 0) 
	then
		PREPARE STMT FROM
		"SELECT Id, CategoryName FROM zadmin_heroforzero.quizcategory
		LIMIT ?,?";
		EXECUTE STMT USING @rowNumber, @pageSize;
		DEALLOCATE PREPARE STMT;
	else
		SELECT Id, CategoryName FROM zadmin_heroforzero.quizcategory;
	END if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_QuizChoiceList_Random` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_QuizChoiceList_Random`(IN pageSize INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_QuizChoiceList_Random_Cate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_QuizChoiceList_Random_Cate`(IN pageSize INT, IN category INT)
BEGIN
	
	SET @pageSize = pageSize;
	SET @category = category;
	
	if (pageSize != 0) 
	then	
		PREPARE STMT FROM
		"SELECT q.*, c.Id as cId, c.Content as answer
		FROM choice c 
		JOIN (SELECT *  FROM  quiz WHERE quiz.CategoryId = ? order by RAND() 	LIMIT ?) as q ON q.Id = c.QuestionId";
		EXECUTE STMT USING @category, @pageSize;
		DEALLOCATE PREPARE STMT;
	 else
		SELECT q.*, c.Id as cId, c.Content as answer
		FROM choice c 
		JOIN (SELECT *  FROM  quiz WHERE quiz.CategoryId = @category order by RAND()) as q ON q.Id = c.QuestionId;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_QuizList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_QuizList`(IN currentPage INT, IN pageSize INT)
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
		ORDER BY quiz.CreatedDate DESC
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
			 quiz.CategoryId = quizcategory.Id
		ORDER BY quiz.CreatedDate DESC;
	end if;
	

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_QuizList_ByCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_QuizList_ByCategory`(IN currentPage INT, IN pageSize INT, IN category INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_QuizList_Random` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_QuizList_Random`(IN pageSize INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_QuizList_Random_Cate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_QuizList_Random_Cate`(IN pageSize INT, IN category INT)
BEGIN
	
	SET @pageSize = pageSize;
	SET @category = category;
	
	if (pageSize != 0) 
	then	
		PREPARE STMT FROM
		"SELECT *   
		FROM 
			 zadmin_heroforzero.quiz
		WHERE quiz.CategoryId = ?
		order by rand()
		LIMIT ?";
		EXECUTE STMT USING @category, @pageSize;
		DEALLOCATE PREPARE STMT;
	 else
		SELECT *   
		FROM 
			 zadmin_heroforzero.quiz
		WHERE quiz.CategoryId = @category
		order by RAND();
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_UserMedal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_UserMedal`(IN currentPage INT, IN pageSize INT, IN userId INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_VirtualQuest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_VirtualQuest`(Id INT)
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
		zadmin_heroforzero.virtualquest,
		partner, packet, questcondition
	WHERE 
				virtualquest.Id = Id
		AND		virtualquest.PartnerId = partner.Id
		AND		virtualquest.PacketId = packet.Id
		AND     questcondition.VirtualQuestId = Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Get_VirtualQuestList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Get_VirtualQuestList`(IN currentPage INT, IN pageSize INT)
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
				
		FROM zadmin_heroforzero.virtualquest, packet
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
				
		FROM zadmin_heroforzero.virtualquest, packet
		WHERE virtualquest.PacketId = packet.Id;
	END if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_InsertMedal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_InsertMedal`(
	userId INT, 
	medalId INT
)
BEGIN
	INSERT INTO zadmin_heroforzero.usermedal(
												UserId,
												MedalId
											)
									VALUES(
												userId,
												medalId
											);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insertUserFb` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_insertUserFb`(IN iFullName VARCHAR(100),IN iEmail VARCHAR(100), IN iPhone VARCHAR(45), IN iFacebookId VARCHAR(45))
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
		FROM (SELECT *, 
				IF((cType = 0), IF((SELECT `Value`
									FROM questcondition
									WHERE Id = cId) <= ( SELECT AchievingPoints
														FROM usercondition
														WHERE UserId = uUserId
															AND ConditionId = cId),1,0),1) AS is_completed
			FROM view_userinfo 
			WHERE uUserId = @var_userId AND cId IN (SELECT ConditionId 
													FROM usercondition u 
													WHERE u.userId = @var_userId)

			UNION
			
			SELECT *, 0 AS is_completed 
			FROM view_userinfo 
			WHERE uUserId = @var_userId AND cId NOT IN (SELECT ConditionId 
														FROM usercondition u 
														WHERE u.userId = @var_userId)
		) AS tt
		ORDER BY cId;
	ELSE
		START TRANSACTION;
			
			INSERT INTO user(Fullname, Email, RegisterDate, PhoneNumber) VALUES(iFullName, iEmail, curdate(), iPhone);
		
			SET @var_userId = (SELECT LAST_INSERT_ID());
			
			INSERT INTO userapplication(UserId, FacebookId, Points, CurrentLevel) VALUES(@var_userId, iFacebookId, 0, 0);
			
			INSERT INTO uservirtualquest(UserId, QuestId, Status) VALUES (@var_userId, (SELECT Id FROM virtualquest LIMIT 1), 1);
			
			SELECT *
			FROM (SELECT *, 
					IF((cType = 0), IF((SELECT `Value`
										FROM questcondition
										WHERE Id = cId) <= ( SELECT AchievingPoints
															FROM usercondition
															WHERE UserId = uUserId
																AND ConditionId = cId),1,0),1) AS is_completed
				FROM view_userinfo 
				WHERE uUserId = @var_userId AND cId IN (SELECT ConditionId 
														FROM usercondition u 
														WHERE u.userId = @var_userId)

				UNION
				
				SELECT *, 0 AS is_completed 
				FROM view_userinfo 
				WHERE uUserId = @var_userId AND cId NOT IN (SELECT ConditionId 
															FROM usercondition u 
															WHERE u.userId = @var_userId)
			) AS tt
			ORDER BY cId;

		COMMIT;
		
	END IF;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Insert_Activity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Insert_Activity`(	
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Insert_Choice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Insert_Choice`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Insert_ConditionQuest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Insert_ConditionQuest`(
	type INT,
	objectId INT,
	Id INT
)
BEGIN
	INSERT INTO zadmin_heroforzero.questcondition
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Insert_Donation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Insert_Donation`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Insert_Packet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Insert_Packet`(
	title 		nvarchar(140),
	imageUrl	nvarchar(140),
	partnerId 	int
)
BEGIN
	INSERT INTO zadmin_heroforzero.packet
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
			
					
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Insert_Quiz` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Insert_Quiz`(
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
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Insert_QuizCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Insert_QuizCategory`(category nvarchar(140))
BEGIN
	INSERT INTO zadmin_heroforzero.quizcategory
				(
					quizcategory.CategoryName
				)
			VALUES
				(
					category
				);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Insert_Quiz_Choice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Insert_Quiz_Choice`(
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
	
	UPDATE zadmin_heroforzero.quiz
			SET quiz.correctChoiceId = choiceId
			WHERE Id = QuestionId;	
	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Insert_VirtualQuest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Insert_VirtualQuest`(
	partner_id Int,
	packet_id Int,
	name nvarchar(40),
	point INT,
	create_date datetime,
	animation int,
	image_url nvarchar(200)
	
)
BEGIN
	INSERT INTO zadmin_heroforzero.virtualquest
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_paginationhotelagodabydistance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_paginationhotelagodabydistance`(IN currentPage INT
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_paginationquest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_paginationquest`(IN currentPage INT, IN pageSize INT)
BEGIN
	DECLARE rowNumber INT;
	SET @currentPage = currentPage;
	SET @rowNumber = currentPage * pageSize;
	PREPARE STMT FROM
	"SELECT A.* FROM quest A WHERE !isnull(A.parent_quest_id)
	ORDER BY A.id LIMIT ?,?";
	EXECUTE STMT USING @rowNumber, @pageSize;
	DEALLOCATE PREPARE STMT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_saveGame` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_saveGame`(IN inUserId INT, IN score INT, IN inConditionId INT)
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Update_Activity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Update_Activity`(
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
	UPDATE zadmin_heroforzero.activity
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
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Update_ActivityApprove` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Update_ActivityApprove`(Id int, IsApproved bit)
BEGIN
		UPDATE zadmin_heroforzero.activity
		   SET 
				activity.IsApproved = IsApproved
		   WHERE
				activity.Id = Id;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Update_BonusPoint_Activity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Update_BonusPoint_Activity`(Id int, point float)
BEGIN
	UPDATE activity
	SET
		activity.BonusPoint = point
	WHERE 
		activity.Id = Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Update_BonusPoint_Quiz` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Update_BonusPoint_Quiz`(
	Id INT,
	BonusPoint float
)
BEGIN
	UPDATE  zadmin_heroforzero.quiz
			SET
				BonusPoint = BonusPoint
			WHERE
				quiz.Id = Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Update_Choice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Update_Choice`(
	Id 		int,
	Content nvarchar(50)
)
BEGIN
	UPDATE choice 
		SET
			choice.Content = Content
		WHERE
			choice.Id = Id;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Update_ConditionQuest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Update_ConditionQuest`(
	objectId INT,
	Id INT
)
BEGIN
	UPDATE zadmin_heroforzero.questcondition
				SET
					ObjectId = objectId 
				WHERE	Id = Id;
				
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Update_Donation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Update_Donation`(
	id INT,
	partner_id INT,
	title nvarchar(140),
	description nvarchar(140),
	bonus_point INT,
	approve BIT
)
BEGIN
	UPDATE zadmin_heroforzero.donation
			SET 
				donation.PartnerId = partner_id,
				donation.Title = title,
				donation.description = description,
				donation.RequiredPoint = bonus_point,
				donation.IsApproved = approve
			WHERE
				donation.Id = id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Update_DonationApprove` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Update_DonationApprove`(Id int, IsApproved bit)
BEGIN
	UPDATE zadmin_heroforzero.donation
		   SET 
				donation.IsApproved = IsApproved
		   WHERE
				donation.Id = Id;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Update_Partner_IsApproved` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Update_Partner_IsApproved`(Id int, IsApproved bit)
BEGIN
			
	UPDATE zadmin_heroforzero.partner
		   SET 
				partner.IsApproved = IsApproved
		   WHERE
				partner.Id = Id;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Update_Quiz` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Update_Quiz`(
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
	UPDATE zadmin_heroforzero.quiz
		   SET
						quiz.CategoryId = questCategory,
						quiz.CreatedDate = createdDate,
						quiz.Content = questQuestion,
						quiz.CorrectChoiceId = CorrectChoiceId,
						quiz.SharingInfo = sharingInfo,
						quiz.LearnMoreURL = linkURL
			WHERE	
				quiz.Id = Id;
				
				
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Update_QuizApprove` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Update_QuizApprove`(Id int, IsApproved bit)
BEGIN
			
	UPDATE zadmin_heroforzero.quiz
		   SET 
				quiz.IsApproved = IsApproved
		   WHERE
				quiz.Id = Id;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Update_RequiredPoint_Donation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Update_RequiredPoint_Donation`(Id int, point float)
BEGIN
	UPDATE zadmin_heroforzero.donation
	SET
		donation.RequiredPoint = point
	WHERE 
		donation.Id = Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Update_VirtualQuest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Update_VirtualQuest`(IN `id` INT, IN `partner_id` INT, IN `packet_id` INT, IN `name` nvarchar(140), point INT, animation INT, imageURL nvarchar(100))
BEGIN
	UPDATE zadmin_heroforzero.virtualquest
				SET
					virtualquest.PacketId = packet_id,
					virtualquest.QuestName = name,
					virtualquest.UnlockPoint = point,
					virtualquest.AnimationId = animation,
					virtualquest.ImageURL = imageURL
				WHERE  virtualquest.Id = id;
					
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_useracceptquest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_useracceptquest`(IN iUserId INT, IN iQuestId INT, IN iParentQuestId INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_usercompletequest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_usercompletequest`(IN iUserId INT, IN iQuestId INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `test` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `test`()
BEGIN 
	DECLARE a INT;
	SELECT id INTO a FROM quest WHERE id = 1;
	SELECT a;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `test_proc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `test_proc`(IN con int)
BEGIN
  SELECT * FROM userapplication
  WHERE UserId = con;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `view_userinfo`
--

/*!50001 DROP TABLE IF EXISTS `view_userinfo`*/;
/*!50001 DROP VIEW IF EXISTS `view_userinfo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_userinfo` AS select `u`.`UserId` AS `uUserId`,`u`.`FacebookId` AS `uFacebookId`,`u`.`Points` AS `uPoints`,`u`.`CurrentLevel` AS `uCurrentLevel`,`v`.`Id` AS `vId`,`v`.`QuestName` AS `vQuestName`,`v`.`PacketId` AS `vPacketId`,`v`.`PartnerId` AS `vPartnerId`,`v`.`AnimationId` AS `vAnimationId`,`v`.`UnlockPoint` AS `vUnlockPoint`,`v`.`CreateDate` AS `vCreateDate`,`q`.`Status` AS `qStatus`,`c`.`Id` AS `cId`,`c`.`Type` AS `cType`,`c`.`Value` AS `cValue`,`c`.`VirtualQuestId` AS `cVirtualQuestId`,`c`.`ObjectId` AS `cObjectId` from (((`userapplication` `u` join `uservirtualquest` `q` on((`u`.`UserId` = `q`.`UserId`))) join `virtualquest` `v` on((`q`.`QuestId` = `v`.`Id`))) join `questcondition` `c` on((`c`.`VirtualQuestId` = `v`.`Id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-06-16 14:54:46
