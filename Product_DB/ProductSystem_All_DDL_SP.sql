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
  `SN` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `UserID` bigint NOT NULL,
  `PurchaseProductID` bigint NOT NULL,
  `PurchaseQuantity` int NOT NULL,
  `Account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
-- Table structure for table `Product`
--

DROP TABLE IF EXISTS `Product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `No` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ProductName` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Price` decimal(15,2) NOT NULL,
  `FeeRate` decimal(5,4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `No` (`No`),
  CONSTRAINT `chk_feerate_range` CHECK (((`FeeRate` >= 0) and (`FeeRate` <= 1))),
  CONSTRAINT `chk_price_positive` CHECK ((`Price` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `NationID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `UserName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `NationID` (`NationID`),
  UNIQUE KEY `Email` (`Email`),
  CONSTRAINT `chk_password_length` CHECK ((char_length(`Password`) >= 8))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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

    
    IF EXISTS (
        SELECT 1
        FROM LikeList
        WHERE UserID = p_UserID
          AND PurchaseProductID = p_ProductID
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '該商品已加入清單';
    END IF;

    
    SET v_SN = CONCAT(
            p_UserID,
            DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'),
            p_ProductID,
            p_Quantity
               );

    
    SELECT Price, FeeRate
    INTO v_Price, v_FeeRate
    FROM Product
    WHERE id = p_ProductID;

    
    SELECT Account
    INTO v_Account
    FROM User
    WHERE id = p_UserID;

    
    IF v_Price IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '找不到該商品';
    END IF;

    
    SET v_TotalAmount = v_Price * p_Quantity;
    SET v_TotalFee = v_TotalAmount * v_FeeRate;

    
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

    
    SELECT COUNT(*) INTO v_count
    FROM Product
    WHERE No = p_No;

    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '商品已存在';
    END IF;

    
    IF p_Price < 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '價格需為非負整數';
    END IF;

    
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

    
    SELECT COUNT(*) INTO v_count
    FROM User
    WHERE NationID = p_NationID;

    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '身分證字號已使用';
    END IF;

    
    SELECT COUNT(*) INTO v_count
    FROM User
    WHERE Email = p_Email;

    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Email已使用';
    END IF;

    
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
        id,         
        nationId,   
        userName,   
        email,      
        account,    
        password    
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

    
    SELECT COUNT(*) INTO v_count
    FROM LikeList
    WHERE id = p_LikeListID
      AND UserID = p_UserID;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '查無喜愛清單或無權存取';
    END IF;

    
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

    
    IF NOT EXISTS (
        SELECT 1 FROM LikeList
        WHERE id = p_LikeListId AND UserID = p_UserId
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '喜愛清單不存在';
    END IF;

    
    IF NOT EXISTS (
        SELECT 1 FROM Product
        WHERE id = p_ProductId
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '商品不存在';
    END IF;

    
    SELECT COUNT(*) INTO v_Count
    FROM LikeList
    WHERE UserID = p_UserId
      AND PurchaseProductID = p_ProductId
      AND id <> p_LikeListId;

    IF v_Count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '該商品已在喜愛清單內';
    END IF;

    
    IF p_PurchaseQuantity <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '購買數量必須大於 0';
    END IF;

    
    SELECT Price, FeeRate INTO v_Price, v_FeeRate
    FROM Product
    WHERE id = p_ProductId;

    
    SET v_TotalFee = v_Price * p_PurchaseQuantity * v_FeeRate;
    SET v_TotalAmount = v_Price * p_PurchaseQuantity + v_TotalFee;

    
    SET v_SN = CONCAT(
            p_UserId,
            DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'),
            p_ProductId,
            p_PurchaseQuantity
               );

    
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

    
    SELECT COUNT(*) INTO v_count
    FROM Product
    WHERE id = p_ProductID;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Product not found';
    END IF;

    
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

    
    IF p_Price IS NOT NULL AND p_Price < 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Price must be >= 0';
    END IF;

    
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

    
    SELECT COUNT(*) INTO v_count
    FROM User
    WHERE id = p_UserID;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '使用者不存在';
    END IF;

    
    IF p_Email IS NOT NULL THEN
        SELECT COUNT(*) INTO v_count
        FROM User
        WHERE Email = p_Email
          AND id <> p_UserID;

        IF v_count > 0 THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Email已使用';
        END IF;
    END IF;

    
    UPDATE User
    SET
        UserName = COALESCE(p_UserName, UserName),
        Email = COALESCE(p_Email, Email),
        Password = COALESCE(p_Password, Password),
        Account = COALESCE(p_Account, Account)
    WHERE id = p_UserID;

    
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

-- Dump completed on 2026-03-05 16:01:06
