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
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event` (
  `id` int NOT NULL,
  `content` text NOT NULL,
  `end_time` bigint DEFAULT NULL,
  `fanpage_id` int NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `progress` int DEFAULT NULL,
  `start_time` bigint DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `target` int NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL,
  `bank` varchar(45) DEFAULT NULL,
  `bank_account` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (2,'Event Content',NULL,1,NULL,NULL,NULL,'NOT_VERIFY',100,'Event Title',NULL,NULL),(52,'Event Content',NULL,1,NULL,100,NULL,'NOT_VERIFY',100,'Event Title',NULL,NULL),(102,'Event Content',NULL,2,NULL,NULL,NULL,'NOT_VERIFY',1000,'Event Title put',NULL,NULL),(103,'Event Content',NULL,2,NULL,NULL,NULL,'NOT_VERIFY',100,'Event Title',NULL,NULL),(104,'Event Content',NULL,2,NULL,NULL,NULL,'NOT_VERIFY',100,'Event Title',NULL,NULL),(152,'Event Content',NULL,2,NULL,NULL,NULL,'NOT_VERIFY',100,'Event Title',NULL,NULL),(202,'string',0,6,NULL,0,0,'NOT_VERIFY',0,'string',NULL,NULL),(252,'string',0,6,NULL,0,0,'NOT_VERIFY',0,'string','string','string'),(253,'string',0,6,NULL,0,0,'NOT_VERIFY',0,'string','string','string'),(254,'string',0,6,NULL,0,0,'NOT_VERIFY',0,'string','string','string'),(302,'string',0,6,NULL,0,0,'NOT_VERIFY',0,'string','string','string');
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
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
