-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: volunteer
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bank`
--

DROP TABLE IF EXISTS `bank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank` (
  `code` int NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank`
--

LOCK TABLES `bank` WRITE;
/*!40000 ALTER TABLE `bank` DISABLE KEYS */;
INSERT INTO `bank` VALUES (422589,'CIMB'),(458761,'HSBC'),(533948,'Citibank'),(546034,'CAKE'),(546035,'Ubank'),(668888,'KBank'),(796500,'DBSBank'),(801011,'Nonghyup'),(963388,'Timo'),(970400,'SaigonBank'),(970403,'Sacombank'),(970405,'Agribank'),(970406,'DongABank'),(970407,'Techcombank'),(970408,'GPBank'),(970409,'BacABank'),(970410,'StandardChartered'),(970412,'PVcomBank'),(970414,'Oceanbank'),(970415,'VietinBank'),(970416,'ACB'),(970418,'BIDV'),(970419,'NCB'),(970421,'VRB'),(970422,'MBBank'),(970423,'TPBank'),(970424,'ShinhanBank'),(970425,'ABBANK'),(970426,'MSB'),(970427,'VietABank'),(970428,'NamABank'),(970429,'SCB'),(970430,'PGBank'),(970431,'Eximbank'),(970432,'VPBank'),(970433,'VietBank'),(970434,'IndovinaBank'),(970436,'Vietcombank'),(970437,'HDBank'),(970438,'BaoVietBank'),(970439,'PublicBank'),(970440,'SeABank'),(970441,'VIB'),(970442,'HongLeong'),(970443,'SHB'),(970444,'CBBank'),(970446,'COOPBANK'),(970448,'OCB'),(970449,'LienVietPostBank'),(970452,'KienLongBank'),(970454,'VietCapitalBank'),(970455,'IBKHN'),(970456,'IBKHCM'),(970457,'Woori'),(970458,'UnitedOverseas'),(970462,'KookminHN'),(970463,'KookminHCM'),(970466,'KEBHanaHCM'),(970467,'KEBHANAHN'),(971005,'ViettelMoney'),(971011,'VNPTMoney'),(977777,'MAFC'),(999888,'VBSP');
/*!40000 ALTER TABLE `bank` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-29 19:28:03
