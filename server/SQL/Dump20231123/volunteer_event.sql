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
  `title` varchar(255) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `target` int NOT NULL DEFAULT (0),
  `fanpage_id` int NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_event_fanpage` (`fanpage_id`),
  CONSTRAINT `FK_event_fanpage` FOREIGN KEY (`fanpage_id`) REFERENCES `fanpage` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,'Event Title 123','Event Content 123',100,2,1,NULL),(2,'Event Title','Event Content',100,2,1,NULL),(3,'Event Title','Event Content',100,2,1,NULL),(4,'Event Title','Event Content',100,2,1,NULL),(5,'Event Title','Event Content',100,2,1,NULL),(6,'Event Title','Event Content',100,2,1,NULL),(7,'Event Title','Event Content',100,2,1,NULL),(8,'Event Title','Event Content',100,2,1,NULL),(9,'Event Title','Event Content',100,2,1,NULL),(10,'Event Title 123','Event Content 123',100,2,1,NULL),(11,'Event Title','Event Content',100,2,1,NULL),(12,'Event Title','Event Content',100,2,1,NULL),(13,'Event Title','Event Content',100,2,1,NULL),(14,'Event Title','Event Content',100,2,1,NULL),(15,'Event Title','Event Content',100,2,1,NULL),(52,'Event Title','Event Content',100,2,1,'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.seiu1000.org%2Fpost%2Fimage-dimensions&psig=AOvVaw2XtPrBRcT6Z5EW7ds_T029&ust=1700796435219000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCIj0rsyW2YIDFQAAAAAdAAAAABAI');
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

-- Dump completed on 2023-11-23 10:40:36
