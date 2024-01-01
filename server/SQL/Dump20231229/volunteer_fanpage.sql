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
-- Table structure for table `fanpage`
--

DROP TABLE IF EXISTS `fanpage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fanpage` (
  `id` int NOT NULL AUTO_INCREMENT,
  `avatar_image` varchar(255) DEFAULT NULL,
  `cover_image` varchar(255) DEFAULT NULL,
  `create_time` bigint DEFAULT NULL,
  `fanpage_name` varchar(100) DEFAULT NULL,
  `leader_id` int DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `subscriber` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_t9ouhctegj3otfg8wlv3q4kdi` (`fanpage_name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanpage`
--

LOCK TABLES `fanpage` WRITE;
/*!40000 ALTER TABLE `fanpage` DISABLE KEYS */;
INSERT INTO `fanpage` VALUES (1,NULL,NULL,1702999964102,'fan page A',1,'VERIFIED',NULL),(2,NULL,NULL,1703319290094,'string',2,'VERIFIED',NULL),(6,NULL,NULL,1703852397670,'fan page cua namker thu xxxxxx',1,'NOT_VERIFY',NULL),(7,NULL,NULL,1703852404396,'fan page cua cuong thu xxxxxx',1,'NOT_VERIFY',NULL);
/*!40000 ALTER TABLE `fanpage` ENABLE KEYS */;
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
