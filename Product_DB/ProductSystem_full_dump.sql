-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: localhost    Database: ProductSystem
-- ------------------------------------------------------
-- Server version	8.0.42-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `ProductSystem`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ProductSystem` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `ProductSystem`;

--
-- Table structure for table `LikeList`
--

DROP TABLE IF EXISTS `LikeList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LikeList` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `SN` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `UserID` bigint NOT NULL,
  `PurchaseProductID` bigint NOT NULL,
  `PurchaseQuantity` int NOT NULL,
  `Account` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `TotalFee` decimal(15,2) NOT NULL,
  `TotalAmount` decimal(15,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `SN` (`SN`),
  UNIQUE KEY `uk_user_product` (`UserID`,`PurchaseProductID`),
  KEY `fk_likelist_product` (`PurchaseProductID`),
  CONSTRAINT `fk_likelist_product` FOREIGN KEY (`PurchaseProductID`) REFERENCES `Product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_likelist_user` FOREIGN KEY (`UserID`) REFERENCES `User` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chk_quantity_positive` CHECK ((`PurchaseQuantity` > 0)),
  CONSTRAINT `chk_totalamount_positive` CHECK ((`TotalAmount` >= 0)),
  CONSTRAINT `chk_totalfee_positive` CHECK ((`TotalFee` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LikeList`
--

LOCK TABLES `LikeList` WRITE;
/*!40000 ALTER TABLE `LikeList` DISABLE KEYS */;
INSERT INTO `LikeList` VALUES (50,'142026030515212216',14,1,6,'8071112223333',90.00,6000.00),(51,'1420260305152127117',14,11,7,'8071112223333',1.93,3850.00),(52,'1420260305152337145',14,14,5,'8071112223333',8.00,16000.00),(53,'132026030515241165',13,6,5,'70011122223334444',1.50,750.00),(54,'1320260305152414146',13,14,6,'70011122223334444',9.60,19200.00),(55,'13202603051524191010',13,10,10,'70011122223334444',3.60,1800.00),(56,'1320260305152425177',13,17,7,'70011122223334444',210.00,14000.00);
/*!40000 ALTER TABLE `LikeList` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Product`
--

DROP TABLE IF EXISTS `Product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `No` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ProductName` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Price` decimal(15,2) NOT NULL,
  `FeeRate` decimal(5,4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `No` (`No`),
  CONSTRAINT `chk_feerate_range` CHECK (((`FeeRate` >= 0) and (`FeeRate` <= 1))),
  CONSTRAINT `chk_price_positive` CHECK ((`Price` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Product`
--

LOCK TABLES `Product` WRITE;
/*!40000 ALTER TABLE `Product` DISABLE KEYS */;
INSERT INTO `Product` VALUES (1,'1000001','富邦台灣成長基金',1000.00,0.0150),(2,'1000002','元大穩健收益基金',1200.00,0.0120),(3,'1000003','群益高股息基金',900.00,0.0180),(4,'1000004','國泰中小型基金',1100.00,0.0165),(5,'1000005','兆豐科技基金',950.00,0.0140),(6,'2000001','元大台灣50 ETF',150.00,0.0020),(7,'2000002','富邦科技 ETF',220.00,0.0025),(8,'2000003','國泰高股息 ETF',130.00,0.0018),(9,'2000004','群益金融 ETF',105.00,0.0022),(10,'2000005','兆豐能源 ETF',180.00,0.0020),(11,'3000001','台積電',550.00,0.0005),(12,'3000002','聯發科',900.00,0.0005),(13,'3000003','鴻海',110.00,0.0005),(14,'3000004','大立光',3200.00,0.0005),(15,'3000005','中華電',110.00,0.0005),(16,'7000001','國泰人壽終身壽險',5000.00,0.0200),(17,'7000002','富邦意外險',2000.00,0.0150),(18,'7000003','新光健康險',2500.00,0.0180),(19,'7000004','台灣人壽旅平險',1500.00,0.0120),(20,'7000005','兆豐定期壽險',3000.00,0.0170);
/*!40000 ALTER TABLE `Product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `NationID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `UserName` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Account` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `NationID` (`NationID`),
  UNIQUE KEY `Email` (`Email`),
  CONSTRAINT `chk_password_length` CHECK ((char_length(`Password`) >= 8))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (13,'A111111111','小明','Aa1@aaaa.a','$2a$10$d0/yz0n/jTfZWJVij7OsrexDD5aNiL3m69vGBbLVsDbGdzxnuBIea','70011122223334444'),(14,'A222222222','阿偉','Aa2@aaaa.a','$2a$10$UR5qt5BQeXiuWHuOUwmliOFOZxyxoZEBT66AXPrjQwAh8tXoC5zrC','8071112223333');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ProductSystem'
--

--
-- Dumping routines for database 'ProductSystem'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddLikeList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_AddLikeList`(IN p_UserID bigint, IN p_ProductID bigint, IN p_Quantity int)
BEGIN

    DECLARE v_Price DECIMAL(15,2);
    DECLARE v_FeeRate DECIMAL(5,4);
    DECLARE v_TotalAmount DECIMAL(15,2);
    DECLARE v_TotalFee DECIMAL(15,2);
    DECLARE v_Account VARCHAR(50);
    DECLARE v_SN VARCHAR(50);

    START TRANSACTION;

    -- 防止重複加入清單
    IF EXISTS (
        SELECT 1
        FROM LikeList
        WHERE UserID = p_UserID
          AND PurchaseProductID = p_ProductID
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '該商品已加入清單';
    END IF;

    -- 自動生成 SN
    SET v_SN = CONCAT(
            p_UserID,
            DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'),
            p_ProductID,
            p_Quantity
               );

    -- 取得商品價格與手續費率
    SELECT Price, FeeRate
    INTO v_Price, v_FeeRate
    FROM Product
    WHERE id = p_ProductID;

    -- 取得使用者帳號
    SELECT Account
    INTO v_Account
    FROM User
    WHERE id = p_UserID;

    -- 商品不存在
    IF v_Price IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '找不到該商品';
    END IF;

    -- 計算金額
    SET v_TotalAmount = v_Price * p_Quantity;
    SET v_TotalFee = v_TotalAmount * v_FeeRate;

    -- 新增資料
    INSERT INTO LikeList (
        SN,
        UserID,
        PurchaseProductID,
        PurchaseQuantity,
        Account,
        TotalFee,
        TotalAmount
    )
    VALUES (
               v_SN,
               p_UserID,
               p_ProductID,
               p_Quantity,
               v_Account,
               v_TotalFee,
               v_TotalAmount
           );

    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_CreateProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_CreateProduct`(IN p_No varchar(50), IN p_ProductName varchar(200),
                                                 IN p_Price decimal(15, 2), IN p_FeeRate decimal(5, 4))
BEGIN
    DECLARE v_count INT;

    START TRANSACTION;

    -- 檢查流水號是否存在
    SELECT COUNT(*) INTO v_count
    FROM Product
    WHERE No = p_No;

    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '商品已存在';
    END IF;

    -- 價格檢查
    IF p_Price < 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '價格需為非負整數';
    END IF;

    -- 費率檢查
    IF p_FeeRate < 0 OR p_FeeRate > 1 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '手續費率需在0~1之間';
    END IF;

    INSERT INTO Product (
        No,
        ProductName,
        Price,
        FeeRate
    )
    VALUES (
               p_No,
               p_ProductName,
               p_Price,
               p_FeeRate
           );

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_CreateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_CreateUser`(IN p_NationID varchar(20), IN p_UserName varchar(100),
                                              IN p_Email varchar(255), IN p_Password varchar(255),
                                              IN p_Account varchar(50))
BEGIN
    DECLARE v_count INT;

    START TRANSACTION;

    -- 檢查 NationID 是否存在
    SELECT COUNT(*) INTO v_count
    FROM User
    WHERE NationID = p_NationID;

    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '身分證字號已使用';
    END IF;

    -- 檢查 Email 是否存在
    SELECT COUNT(*) INTO v_count
    FROM User
    WHERE Email = p_Email;

    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Email已使用';
    END IF;

    -- 新增資料
    INSERT INTO User (
        NationID,
        UserName,
        Email,
        Password,
        Account
    )
    VALUES (
               p_NationID,
               p_UserName,
               p_Email,
               p_Password,
               p_Account
           );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_DeleteLikeList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_DeleteLikeList`(IN p_UserID bigint, IN p_LikeListID bigint)
BEGIN
    DECLARE v_count INT;

    START TRANSACTION;

    -- 驗證該筆是否屬於該使用者
    SELECT COUNT(*) INTO v_count
    FROM LikeList
    WHERE id = p_LikeListID
      AND UserID = p_UserID;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '找不到該清單或存取失敗';
    END IF;

    DELETE FROM LikeList
    WHERE id = p_LikeListID
      AND UserID = p_UserID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetAllProducts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_GetAllProducts`()
BEGIN

    START TRANSACTION;

    SELECT
        id,
        No,
        ProductName,
        Price,
        FeeRate
    FROM Product
    ORDER BY No ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetProductById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_GetProductById`(IN p_ProductID bigint)
BEGIN

    START TRANSACTION;

    SELECT
        id,
        No,
        ProductName,
        Price,
        FeeRate
    FROM Product
    WHERE id = p_ProductID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetUserByEmailAndNationId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_GetUserByEmailAndNationId`(IN p_email varchar(255), IN p_nationId varchar(20))
BEGIN

    START TRANSACTION;

    SELECT
        id,         -- 使用者自動遞增ID
        nationId,   -- 身分證
        userName,   -- 姓名
        email,      -- 信箱
        account,    -- 帳號
        password    -- 加密密碼
    FROM User
    WHERE email = p_email
      AND nationId = p_nationId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetUserById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_GetUserById`(IN p_UserID bigint)
BEGIN

    START TRANSACTION;

    SELECT
        id,
        NationID,
        UserName,
        Email,
        Account
    FROM User
    WHERE id = p_UserID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetUserLikeList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_GetUserLikeList`(IN p_UserID bigint)
BEGIN

    START TRANSACTION;

    SELECT
        l.id,
        l.SN,
        u.Email,
        p.ProductName,
        l.PurchaseQuantity,
        l.TotalAmount,
        l.TotalFee,
        l.Account
    FROM LikeList l
             INNER JOIN User u
                        ON l.UserID = u.id
             INNER JOIN Product p
                        ON l.PurchaseProductID = p.id
    WHERE l.UserID = p_UserID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetUserLikeListById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_GetUserLikeListById`(IN p_UserID bigint, IN p_LikeListID bigint)
BEGIN
    DECLARE v_count INT;

    START TRANSACTION;

    -- 確認該筆資料是否屬於該使用者
    SELECT COUNT(*) INTO v_count
    FROM LikeList
    WHERE id = p_LikeListID
      AND UserID = p_UserID;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'LikeList not found or access denied';
    END IF;

    -- 查詢資料
    SELECT
        l.id,
        l.SN,
        u.Email,
        p.ProductName,
        l.PurchaseQuantity,
        l.TotalAmount,
        l.TotalFee,
        l.Account
    FROM LikeList l
             INNER JOIN User u
                        ON l.UserID = u.id
             INNER JOIN Product p
                        ON l.PurchaseProductID = p.id
    WHERE l.id = p_LikeListID
      AND l.UserID = p_UserID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UpdateLikeList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_UpdateLikeList`(IN p_LikeListId bigint, IN p_UserId bigint, IN p_ProductId bigint,
                                                  IN p_PurchaseQuantity int, IN p_Account varchar(20))
BEGIN
    DECLARE v_Count INT DEFAULT 0;
    DECLARE v_Price DECIMAL(18,4);
    DECLARE v_FeeRate DECIMAL(10,4);
    DECLARE v_TotalFee DECIMAL(18,4);
    DECLARE v_TotalAmount DECIMAL(18,4);
    DECLARE v_SN VARCHAR(50);

    -- 驗證喜愛清單是否存在
    IF NOT EXISTS (
        SELECT 1 FROM LikeList
        WHERE id = p_LikeListId AND UserID = p_UserId
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'LikeList 不存在';
    END IF;

    -- 驗證商品是否存在
    IF NOT EXISTS (
        SELECT 1 FROM Product
        WHERE id = p_ProductId
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '商品不存在';
    END IF;

    -- 驗證該商品是否已在清單內 (排除當前項)
    SELECT COUNT(*) INTO v_Count
    FROM LikeList
    WHERE UserID = p_UserId
      AND PurchaseProductID = p_ProductId
      AND id <> p_LikeListId;

    IF v_Count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '該商品已在喜愛清單內';
    END IF;

    -- 驗證購買數量
    IF p_PurchaseQuantity <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '購買數量必須大於 0';
    END IF;

    -- 取得商品單價與手續費率
    SELECT Price, FeeRate INTO v_Price, v_FeeRate
    FROM Product
    WHERE id = p_ProductId;

    -- 計算手續費與總金額
    SET v_TotalFee = v_Price * p_PurchaseQuantity * v_FeeRate;
    SET v_TotalAmount = v_Price * p_PurchaseQuantity + v_TotalFee;

    -- 自動生成新的 SN (UserID + yyyyMMddHHmmss + ProductID + Quantity)
    SET v_SN = CONCAT(
            p_UserId,
            DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'),
            p_ProductId,
            p_PurchaseQuantity
               );

    -- 更新清單
    UPDATE LikeList
    SET
        PurchaseProductID = p_ProductId,
        PurchaseQuantity = p_PurchaseQuantity,
        Account = p_Account,
        TotalFee = v_TotalFee,
        TotalAmount = v_TotalAmount,
        SN = v_SN
    WHERE id = p_LikeListId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UpdateProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_UpdateProduct`(IN p_ProductID bigint, IN p_No varchar(50),
                                                 IN p_ProductName varchar(200), IN p_Price decimal(15, 2),
                                                 IN p_FeeRate decimal(5, 4))
BEGIN
    DECLARE v_count INT;

    START TRANSACTION;

    -- 檢查是否存在
    SELECT COUNT(*) INTO v_count
    FROM Product
    WHERE id = p_ProductID;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Product not found';
    END IF;

    -- 如果修改 No，檢查唯一性
    IF p_No IS NOT NULL THEN
        SELECT COUNT(*) INTO v_count
        FROM Product
        WHERE No = p_No
          AND id <> p_ProductID;

        IF v_count > 0 THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Product No already exists';
        END IF;
    END IF;

    -- 價格檢查
    IF p_Price IS NOT NULL AND p_Price < 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Price must be >= 0';
    END IF;

    -- 費率檢查
    IF p_FeeRate IS NOT NULL AND (p_FeeRate < 0 OR p_FeeRate > 1) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'FeeRate must be between 0 and 1';
    END IF;

    UPDATE Product
    SET
        No = COALESCE(p_No, No),
        ProductName = COALESCE(p_ProductName, ProductName),
        Price = COALESCE(p_Price, Price),
        FeeRate = COALESCE(p_FeeRate, FeeRate)
    WHERE id = p_ProductID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UpdateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_UpdateUser`(IN p_UserID bigint, IN p_UserName varchar(100), IN p_Email varchar(255),
                                              IN p_Password varchar(255), IN p_Account varchar(50))
BEGIN
    DECLARE v_count INT;

    START TRANSACTION;

    -- 確認使用者存在
    SELECT COUNT(*) INTO v_count
    FROM User
    WHERE id = p_UserID;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'User not found';
    END IF;

    -- 如果 Email 有變更才檢查唯一性
    IF p_Email IS NOT NULL THEN
        SELECT COUNT(*) INTO v_count
        FROM User
        WHERE Email = p_Email
          AND id <> p_UserID;

        IF v_count > 0 THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Email already exists';
        END IF;
    END IF;

    -- 更新
    UPDATE User
    SET
        UserName = COALESCE(p_UserName, UserName),
        Email = COALESCE(p_Email, Email),
        Password = COALESCE(p_Password, Password),
        Account = COALESCE(p_Account, Account)
    WHERE id = p_UserID;

    -- 回傳新增 ID 用戶
    SELECT id, NationID, UserName, Email, Account
    FROM User
    WHERE id = p_UserID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `ProductSystem`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ProductSystem` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `ProductSystem`;

--
-- Table structure for table `LikeList`
--

DROP TABLE IF EXISTS `LikeList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LikeList` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `SN` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `UserID` bigint NOT NULL,
  `PurchaseProductID` bigint NOT NULL,
  `PurchaseQuantity` int NOT NULL,
  `Account` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `TotalFee` decimal(15,2) NOT NULL,
  `TotalAmount` decimal(15,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `SN` (`SN`),
  UNIQUE KEY `uk_user_product` (`UserID`,`PurchaseProductID`),
  KEY `fk_likelist_product` (`PurchaseProductID`),
  CONSTRAINT `fk_likelist_product` FOREIGN KEY (`PurchaseProductID`) REFERENCES `Product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_likelist_user` FOREIGN KEY (`UserID`) REFERENCES `User` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chk_quantity_positive` CHECK ((`PurchaseQuantity` > 0)),
  CONSTRAINT `chk_totalamount_positive` CHECK ((`TotalAmount` >= 0)),
  CONSTRAINT `chk_totalfee_positive` CHECK ((`TotalFee` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LikeList`
--

LOCK TABLES `LikeList` WRITE;
/*!40000 ALTER TABLE `LikeList` DISABLE KEYS */;
INSERT INTO `LikeList` VALUES (50,'142026030515212216',14,1,6,'8071112223333',90.00,6000.00),(51,'1420260305152127117',14,11,7,'8071112223333',1.93,3850.00),(52,'1420260305152337145',14,14,5,'8071112223333',8.00,16000.00),(53,'132026030515241165',13,6,5,'70011122223334444',1.50,750.00),(54,'1320260305152414146',13,14,6,'70011122223334444',9.60,19200.00),(55,'13202603051524191010',13,10,10,'70011122223334444',3.60,1800.00),(56,'1320260305152425177',13,17,7,'70011122223334444',210.00,14000.00);
/*!40000 ALTER TABLE `LikeList` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Product`
--

DROP TABLE IF EXISTS `Product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `No` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ProductName` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Price` decimal(15,2) NOT NULL,
  `FeeRate` decimal(5,4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `No` (`No`),
  CONSTRAINT `chk_feerate_range` CHECK (((`FeeRate` >= 0) and (`FeeRate` <= 1))),
  CONSTRAINT `chk_price_positive` CHECK ((`Price` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Product`
--

LOCK TABLES `Product` WRITE;
/*!40000 ALTER TABLE `Product` DISABLE KEYS */;
INSERT INTO `Product` VALUES (1,'1000001','富邦台灣成長基金',1000.00,0.0150),(2,'1000002','元大穩健收益基金',1200.00,0.0120),(3,'1000003','群益高股息基金',900.00,0.0180),(4,'1000004','國泰中小型基金',1100.00,0.0165),(5,'1000005','兆豐科技基金',950.00,0.0140),(6,'2000001','元大台灣50 ETF',150.00,0.0020),(7,'2000002','富邦科技 ETF',220.00,0.0025),(8,'2000003','國泰高股息 ETF',130.00,0.0018),(9,'2000004','群益金融 ETF',105.00,0.0022),(10,'2000005','兆豐能源 ETF',180.00,0.0020),(11,'3000001','台積電',550.00,0.0005),(12,'3000002','聯發科',900.00,0.0005),(13,'3000003','鴻海',110.00,0.0005),(14,'3000004','大立光',3200.00,0.0005),(15,'3000005','中華電',110.00,0.0005),(16,'7000001','國泰人壽終身壽險',5000.00,0.0200),(17,'7000002','富邦意外險',2000.00,0.0150),(18,'7000003','新光健康險',2500.00,0.0180),(19,'7000004','台灣人壽旅平險',1500.00,0.0120),(20,'7000005','兆豐定期壽險',3000.00,0.0170);
/*!40000 ALTER TABLE `Product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `NationID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `UserName` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Account` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `NationID` (`NationID`),
  UNIQUE KEY `Email` (`Email`),
  CONSTRAINT `chk_password_length` CHECK ((char_length(`Password`) >= 8))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (13,'A111111111','小明','Aa1@aaaa.a','$2a$10$d0/yz0n/jTfZWJVij7OsrexDD5aNiL3m69vGBbLVsDbGdzxnuBIea','70011122223334444'),(14,'A222222222','阿偉','Aa2@aaaa.a','$2a$10$UR5qt5BQeXiuWHuOUwmliOFOZxyxoZEBT66AXPrjQwAh8tXoC5zrC','8071112223333');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ProductSystem'
--

--
-- Dumping routines for database 'ProductSystem'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddLikeList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_AddLikeList`(IN p_UserID bigint, IN p_ProductID bigint, IN p_Quantity int)
BEGIN

    DECLARE v_Price DECIMAL(15,2);
    DECLARE v_FeeRate DECIMAL(5,4);
    DECLARE v_TotalAmount DECIMAL(15,2);
    DECLARE v_TotalFee DECIMAL(15,2);
    DECLARE v_Account VARCHAR(50);
    DECLARE v_SN VARCHAR(50);

    START TRANSACTION;

    -- 防止重複加入清單
    IF EXISTS (
        SELECT 1
        FROM LikeList
        WHERE UserID = p_UserID
          AND PurchaseProductID = p_ProductID
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '該商品已加入清單';
    END IF;

    -- 自動生成 SN
    SET v_SN = CONCAT(
            p_UserID,
            DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'),
            p_ProductID,
            p_Quantity
               );

    -- 取得商品價格與手續費率
    SELECT Price, FeeRate
    INTO v_Price, v_FeeRate
    FROM Product
    WHERE id = p_ProductID;

    -- 取得使用者帳號
    SELECT Account
    INTO v_Account
    FROM User
    WHERE id = p_UserID;

    -- 商品不存在
    IF v_Price IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '找不到該商品';
    END IF;

    -- 計算金額
    SET v_TotalAmount = v_Price * p_Quantity;
    SET v_TotalFee = v_TotalAmount * v_FeeRate;

    -- 新增資料
    INSERT INTO LikeList (
        SN,
        UserID,
        PurchaseProductID,
        PurchaseQuantity,
        Account,
        TotalFee,
        TotalAmount
    )
    VALUES (
               v_SN,
               p_UserID,
               p_ProductID,
               p_Quantity,
               v_Account,
               v_TotalFee,
               v_TotalAmount
           );

    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_CreateProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_CreateProduct`(IN p_No varchar(50), IN p_ProductName varchar(200),
                                                 IN p_Price decimal(15, 2), IN p_FeeRate decimal(5, 4))
BEGIN
    DECLARE v_count INT;

    START TRANSACTION;

    -- 檢查流水號是否存在
    SELECT COUNT(*) INTO v_count
    FROM Product
    WHERE No = p_No;

    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '商品已存在';
    END IF;

    -- 價格檢查
    IF p_Price < 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '價格需為非負整數';
    END IF;

    -- 費率檢查
    IF p_FeeRate < 0 OR p_FeeRate > 1 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '手續費率需在0~1之間';
    END IF;

    INSERT INTO Product (
        No,
        ProductName,
        Price,
        FeeRate
    )
    VALUES (
               p_No,
               p_ProductName,
               p_Price,
               p_FeeRate
           );

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_CreateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_CreateUser`(IN p_NationID varchar(20), IN p_UserName varchar(100),
                                              IN p_Email varchar(255), IN p_Password varchar(255),
                                              IN p_Account varchar(50))
BEGIN
    DECLARE v_count INT;

    START TRANSACTION;

    -- 檢查 NationID 是否存在
    SELECT COUNT(*) INTO v_count
    FROM User
    WHERE NationID = p_NationID;

    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '身分證字號已使用';
    END IF;

    -- 檢查 Email 是否存在
    SELECT COUNT(*) INTO v_count
    FROM User
    WHERE Email = p_Email;

    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Email已使用';
    END IF;

    -- 新增資料
    INSERT INTO User (
        NationID,
        UserName,
        Email,
        Password,
        Account
    )
    VALUES (
               p_NationID,
               p_UserName,
               p_Email,
               p_Password,
               p_Account
           );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_DeleteLikeList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_DeleteLikeList`(IN p_UserID bigint, IN p_LikeListID bigint)
BEGIN
    DECLARE v_count INT;

    START TRANSACTION;

    -- 驗證該筆是否屬於該使用者
    SELECT COUNT(*) INTO v_count
    FROM LikeList
    WHERE id = p_LikeListID
      AND UserID = p_UserID;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '找不到該清單或存取失敗';
    END IF;

    DELETE FROM LikeList
    WHERE id = p_LikeListID
      AND UserID = p_UserID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetAllProducts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_GetAllProducts`()
BEGIN

    START TRANSACTION;

    SELECT
        id,
        No,
        ProductName,
        Price,
        FeeRate
    FROM Product
    ORDER BY No ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetProductById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_GetProductById`(IN p_ProductID bigint)
BEGIN

    START TRANSACTION;

    SELECT
        id,
        No,
        ProductName,
        Price,
        FeeRate
    FROM Product
    WHERE id = p_ProductID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetUserByEmailAndNationId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_GetUserByEmailAndNationId`(IN p_email varchar(255), IN p_nationId varchar(20))
BEGIN

    START TRANSACTION;

    SELECT
        id,         -- 使用者自動遞增ID
        nationId,   -- 身分證
        userName,   -- 姓名
        email,      -- 信箱
        account,    -- 帳號
        password    -- 加密密碼
    FROM User
    WHERE email = p_email
      AND nationId = p_nationId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetUserById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_GetUserById`(IN p_UserID bigint)
BEGIN

    START TRANSACTION;

    SELECT
        id,
        NationID,
        UserName,
        Email,
        Account
    FROM User
    WHERE id = p_UserID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetUserLikeList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_GetUserLikeList`(IN p_UserID bigint)
BEGIN

    START TRANSACTION;

    SELECT
        l.id,
        l.SN,
        u.Email,
        p.ProductName,
        l.PurchaseQuantity,
        l.TotalAmount,
        l.TotalFee,
        l.Account
    FROM LikeList l
             INNER JOIN User u
                        ON l.UserID = u.id
             INNER JOIN Product p
                        ON l.PurchaseProductID = p.id
    WHERE l.UserID = p_UserID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetUserLikeListById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_GetUserLikeListById`(IN p_UserID bigint, IN p_LikeListID bigint)
BEGIN
    DECLARE v_count INT;

    START TRANSACTION;

    -- 確認該筆資料是否屬於該使用者
    SELECT COUNT(*) INTO v_count
    FROM LikeList
    WHERE id = p_LikeListID
      AND UserID = p_UserID;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'LikeList not found or access denied';
    END IF;

    -- 查詢資料
    SELECT
        l.id,
        l.SN,
        u.Email,
        p.ProductName,
        l.PurchaseQuantity,
        l.TotalAmount,
        l.TotalFee,
        l.Account
    FROM LikeList l
             INNER JOIN User u
                        ON l.UserID = u.id
             INNER JOIN Product p
                        ON l.PurchaseProductID = p.id
    WHERE l.id = p_LikeListID
      AND l.UserID = p_UserID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UpdateLikeList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_UpdateLikeList`(IN p_LikeListId bigint, IN p_UserId bigint, IN p_ProductId bigint,
                                                  IN p_PurchaseQuantity int, IN p_Account varchar(20))
BEGIN
    DECLARE v_Count INT DEFAULT 0;
    DECLARE v_Price DECIMAL(18,4);
    DECLARE v_FeeRate DECIMAL(10,4);
    DECLARE v_TotalFee DECIMAL(18,4);
    DECLARE v_TotalAmount DECIMAL(18,4);
    DECLARE v_SN VARCHAR(50);

    -- 驗證喜愛清單是否存在
    IF NOT EXISTS (
        SELECT 1 FROM LikeList
        WHERE id = p_LikeListId AND UserID = p_UserId
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'LikeList 不存在';
    END IF;

    -- 驗證商品是否存在
    IF NOT EXISTS (
        SELECT 1 FROM Product
        WHERE id = p_ProductId
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '商品不存在';
    END IF;

    -- 驗證該商品是否已在清單內 (排除當前項)
    SELECT COUNT(*) INTO v_Count
    FROM LikeList
    WHERE UserID = p_UserId
      AND PurchaseProductID = p_ProductId
      AND id <> p_LikeListId;

    IF v_Count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '該商品已在喜愛清單內';
    END IF;

    -- 驗證購買數量
    IF p_PurchaseQuantity <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '購買數量必須大於 0';
    END IF;

    -- 取得商品單價與手續費率
    SELECT Price, FeeRate INTO v_Price, v_FeeRate
    FROM Product
    WHERE id = p_ProductId;

    -- 計算手續費與總金額
    SET v_TotalFee = v_Price * p_PurchaseQuantity * v_FeeRate;
    SET v_TotalAmount = v_Price * p_PurchaseQuantity + v_TotalFee;

    -- 自動生成新的 SN (UserID + yyyyMMddHHmmss + ProductID + Quantity)
    SET v_SN = CONCAT(
            p_UserId,
            DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'),
            p_ProductId,
            p_PurchaseQuantity
               );

    -- 更新清單
    UPDATE LikeList
    SET
        PurchaseProductID = p_ProductId,
        PurchaseQuantity = p_PurchaseQuantity,
        Account = p_Account,
        TotalFee = v_TotalFee,
        TotalAmount = v_TotalAmount,
        SN = v_SN
    WHERE id = p_LikeListId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UpdateProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_UpdateProduct`(IN p_ProductID bigint, IN p_No varchar(50),
                                                 IN p_ProductName varchar(200), IN p_Price decimal(15, 2),
                                                 IN p_FeeRate decimal(5, 4))
BEGIN
    DECLARE v_count INT;

    START TRANSACTION;

    -- 檢查是否存在
    SELECT COUNT(*) INTO v_count
    FROM Product
    WHERE id = p_ProductID;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Product not found';
    END IF;

    -- 如果修改 No，檢查唯一性
    IF p_No IS NOT NULL THEN
        SELECT COUNT(*) INTO v_count
        FROM Product
        WHERE No = p_No
          AND id <> p_ProductID;

        IF v_count > 0 THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Product No already exists';
        END IF;
    END IF;

    -- 價格檢查
    IF p_Price IS NOT NULL AND p_Price < 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Price must be >= 0';
    END IF;

    -- 費率檢查
    IF p_FeeRate IS NOT NULL AND (p_FeeRate < 0 OR p_FeeRate > 1) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'FeeRate must be between 0 and 1';
    END IF;

    UPDATE Product
    SET
        No = COALESCE(p_No, No),
        ProductName = COALESCE(p_ProductName, ProductName),
        Price = COALESCE(p_Price, Price),
        FeeRate = COALESCE(p_FeeRate, FeeRate)
    WHERE id = p_ProductID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UpdateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`psm`@`%` PROCEDURE `sp_UpdateUser`(IN p_UserID bigint, IN p_UserName varchar(100), IN p_Email varchar(255),
                                              IN p_Password varchar(255), IN p_Account varchar(50))
BEGIN
    DECLARE v_count INT;

    START TRANSACTION;

    -- 確認使用者存在
    SELECT COUNT(*) INTO v_count
    FROM User
    WHERE id = p_UserID;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'User not found';
    END IF;

    -- 如果 Email 有變更才檢查唯一性
    IF p_Email IS NOT NULL THEN
        SELECT COUNT(*) INTO v_count
        FROM User
        WHERE Email = p_Email
          AND id <> p_UserID;

        IF v_count > 0 THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Email already exists';
        END IF;
    END IF;

    -- 更新
    UPDATE User
    SET
        UserName = COALESCE(p_UserName, UserName),
        Email = COALESCE(p_Email, Email),
        Password = COALESCE(p_Password, Password),
        Account = COALESCE(p_Account, Account)
    WHERE id = p_UserID;

    -- 回傳新增 ID 用戶
    SELECT id, NationID, UserName, Email, Account
    FROM User
    WHERE id = p_UserID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-05 15:45:12
