-- MySQL dump 10.13  Distrib 8.0.33, for Linux (x86_64)
--
-- Host: localhost    Database: tic_tac_toe
-- ------------------------------------------------------
-- Server version	8.0.33-0ubuntu0.22.04.2

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
-- Table structure for table `games`
--

DROP TABLE IF EXISTS `games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `games` (
  `id` int NOT NULL AUTO_INCREMENT,
  `player1` varchar(45) NOT NULL,
  `player2` varchar(45) NOT NULL,
  `active` bit(1) NOT NULL DEFAULT b'1',
  `cell1` int NOT NULL DEFAULT '0',
  `cell2` int NOT NULL DEFAULT '0',
  `cell3` int NOT NULL DEFAULT '0',
  `cell4` int NOT NULL DEFAULT '0',
  `cell5` int NOT NULL DEFAULT '0',
  `cell6` int NOT NULL DEFAULT '0',
  `cell7` int NOT NULL DEFAULT '0',
  `cell8` int NOT NULL DEFAULT '0',
  `cell9` int NOT NULL DEFAULT '0',
  `turn` int NOT NULL DEFAULT '1',
  `currentPlayer` varchar(45) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `games`
--

LOCK TABLES `games` WRITE;
/*!40000 ALTER TABLE `games` DISABLE KEYS */;
INSERT INTO `games` VALUES (1,'ori','shoval',_binary '\0',0,0,0,0,0,0,0,0,0,1,'1'),(2,'ori','shoval',_binary '\0',0,0,0,1,0,0,0,0,0,1,'1'),(3,'ori','shoval',_binary '\0',0,1,2,1,1,2,0,0,0,1,'1'),(4,'shoval','ori',_binary '\0',0,1,1,0,2,0,0,0,0,1,'1'),(5,'ori','shoval',_binary '\0',0,1,1,0,2,2,0,0,0,1,'1'),(6,'shoval','ori',_binary '\0',1,1,1,0,2,2,0,0,0,1,'1'),(7,'ori','shoval',_binary '\0',0,2,1,0,1,0,0,0,0,1,'1'),(8,'ori','shoval',_binary '\0',2,2,2,1,1,1,1,1,2,1,'1'),(9,'ori','shoval',_binary '\0',0,0,0,1,2,0,0,0,0,1,'1'),(10,'ori','shoval',_binary '\0',0,2,0,0,1,0,0,0,0,1,'1'),(11,'ori','shoval',_binary '\0',0,0,0,0,1,0,0,0,0,1,'1'),(12,'ori','shoval',_binary '\0',0,2,1,0,1,0,0,0,0,1,'1'),(13,'ori','shoval',_binary '\0',0,0,0,0,0,0,0,0,0,1,'1'),(14,'shoval','ori',_binary '\0',0,2,0,0,1,0,0,0,0,1,'1'),(15,'ori','shoval',_binary '\0',0,0,0,1,0,0,0,0,0,1,'1'),(16,'shoval','ori',_binary '\0',0,0,0,0,0,0,0,0,0,1,'1'),(17,'ori','shoval',_binary '\0',0,1,2,0,1,2,0,0,1,1,'1'),(18,'shoval','ori',_binary '\0',0,2,1,0,1,2,0,0,0,1,'1'),(19,'ori','shoval',_binary '\0',0,0,1,0,0,2,0,0,0,1,'1'),(20,'ori','shoval',_binary '\0',0,1,1,0,0,2,0,0,0,1,'1'),(21,'ori','shoval',_binary '\0',0,1,1,0,2,0,0,0,0,1,'1'),(22,'ori','shoval',_binary '\0',0,1,2,0,1,0,0,0,0,1,'1'),(23,'ori','shoval',_binary '\0',0,0,0,0,1,0,0,0,0,1,'1'),(24,'ori','shoval',_binary '\0',0,2,0,0,1,0,0,0,0,1,'1'),(25,'shoval','ori',_binary '\0',2,2,1,1,2,1,1,1,2,5,'ori'),(26,'shoval','ori',_binary '\0',0,1,2,0,1,2,0,1,0,5,'ori'),(27,'ori','shoval',_binary '\0',2,2,1,0,1,0,1,0,0,5,'shoval'),(28,'ori','shoval',_binary '\0',2,2,1,0,1,0,1,0,0,5,'shoval'),(29,'shoval','ori',_binary '\0',2,2,1,0,1,0,1,0,0,5,'ori'),(30,'ori','shoval',_binary '\0',1,2,1,0,2,1,0,2,0,6,'ori'),(31,'ori','shoval',_binary '\0',0,2,1,0,2,1,0,0,1,5,'shoval'),(32,'shoval','ori',_binary '\0',1,1,1,0,2,2,0,0,0,5,'ori'),(33,'ori','shoval',_binary '\0',0,2,1,0,2,1,0,0,1,5,'shoval'),(34,'shoval','ori',_binary '\0',1,2,1,2,2,1,1,2,1,9,'ori'),(35,'ori','shoval',_binary '\0',2,2,1,1,1,2,1,2,1,9,'shoval'),(36,'ori','shoval',_binary '\0',0,0,0,0,0,0,0,0,0,1,'1'),(37,'ori','shoval',_binary '\0',0,2,1,0,2,1,0,0,1,5,'shoval'),(38,'ori','shoval',_binary '\0',0,0,0,0,0,0,0,0,0,1,'1'),(39,'ori','shoval',_binary '\0',2,1,1,0,2,1,0,0,2,6,'ori'),(40,'ori','shoval',_binary '\0',2,1,2,0,1,0,0,1,0,5,'shoval'),(41,'ori','shoval',_binary '\0',1,2,2,0,1,0,0,0,1,5,'shoval'),(42,'shoval','ori',_binary '\0',2,1,2,1,2,2,1,1,1,9,'ori'),(43,'ori','shoval',_binary '\0',0,0,0,0,0,0,0,0,0,1,'1'),(44,'ori','shoval',_binary '\0',1,2,2,2,1,1,0,0,1,7,'shoval'),(45,'shoval','ori',_binary '\0',0,2,1,0,1,2,1,0,0,5,'ori'),(46,'ori','shoval',_binary '',1,2,2,0,1,2,1,0,1,7,'shoval'),(47,'ori','shoval',_binary '',0,0,0,0,0,0,0,0,0,1,'1'),(48,'shoval','ori',_binary '',0,0,0,0,0,0,0,0,0,1,'1'),(49,'ori','shoval',_binary '',0,0,0,0,0,0,0,0,0,1,'1'),(50,'shoval','ori',_binary '',0,0,0,0,0,0,0,0,0,1,'1'),(51,'ori','shoval',_binary '',0,0,0,0,0,0,0,0,0,1,'1'),(52,'ori','shoval',_binary '',0,0,0,0,0,0,0,0,0,1,'1');
/*!40000 ALTER TABLE `games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `lobby` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('ori','3344',-1),('shoval','2211',-1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-13 13:01:10
