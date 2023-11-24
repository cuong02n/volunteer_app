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
  `fanpage_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `leader_id` int NOT NULL DEFAULT (0),
  `status` int NOT NULL DEFAULT (0),
  `create_time` bigint NOT NULL DEFAULT (0),
  `subscriber` int NOT NULL DEFAULT '0',
  `cover_image` varchar(255) DEFAULT NULL,
  `avatar_image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fanpage_name` (`fanpage_name`) USING BTREE,
  KEY `FK_fanpage_user` (`leader_id`),
  CONSTRAINT `FK_fanpage_user` FOREIGN KEY (`leader_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanpage`
--

LOCK TABLES `fanpage` WRITE;
/*!40000 ALTER TABLE `fanpage` DISABLE KEYS */;
INSERT INTO `fanpage` VALUES (2,'new fanpage after put 2',12,0,1700551355,1002,NULL,NULL),(52,'fan page A',12,0,1700551355,1000,NULL,NULL),(53,'fan page B',12,0,1700551355,1000,NULL,NULL),(55,'fan page C',12,0,1700551355,1000,NULL,NULL),(252,'fan page F',12,0,1700551355,1000,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScgsJTy2dl-Tr4m1amid5OZyNTg-c2KlgbmnjO947w&s','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjIEnUkwQUdbyVfkutEwc9ZQDGz_f8IXu1R024nhc-&s');
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

-- Dump completed on 2023-11-23 10:40:36
