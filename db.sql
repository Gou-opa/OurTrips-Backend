CREATE DATABASE  IF NOT EXISTS `ourtrips` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ourtrips`;
-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ourtrips
-- ------------------------------------------------------
-- Server version	8.0.17

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
-- Table structure for table `driver`
--

DROP TABLE IF EXISTS `driver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `driver` (
  `id` varchar(255) NOT NULL,
  `city` varchar(45) NOT NULL,
  `district` varchar(45) NOT NULL,
  `address_line1` text NOT NULL,
  `address_line2` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `driver`
--

LOCK TABLES `driver` WRITE;
/*!40000 ALTER TABLE `driver` DISABLE KEYS */;
INSERT INTO `driver` VALUES ('5ea3f3c2-4e42-47f8-bfa3-60946f768157','Ha Noi','Ba Dinh','129 Ngoc Ha','Tang 2');
/*!40000 ALTER TABLE `driver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `id` varchar(255) NOT NULL,
  `department` varchar(255) NOT NULL,
  `role` binary(3) NOT NULL,
  `username` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('5ea3f3c2-4e42-47f8-bfa3-60946f768157','IT',_binary '111','peape');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `licence`
--

DROP TABLE IF EXISTS `licence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `licence` (
  `id` varchar(20) NOT NULL,
  `due_date` datetime NOT NULL,
  `type` varchar(255) NOT NULL,
  `authority` varchar(255) NOT NULL,
  `driver_id` varchar(255) NOT NULL,
  `approval_status` varchar(45) NOT NULL,
  `approval_due_date` datetime DEFAULT NULL,
  `employee_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `licence`
--

LOCK TABLES `licence` WRITE;
/*!40000 ALTER TABLE `licence` DISABLE KEYS */;
INSERT INTO `licence` VALUES ('1361103701703717','2031-03-29 00:00:00','A1','TP. Hà Nội','5ea3f3c2-4e42-47f8-bfa3-60946f768157','WAITING',NULL,NULL);
/*!40000 ALTER TABLE `licence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `session` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `login_at` datetime NOT NULL,
  `token` longtext NOT NULL,
  `logged_out` tinyint(4) NOT NULL DEFAULT '0',
  `info` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
INSERT INTO `session` VALUES (14,'','2019-10-21 17:09:14','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InN1YiI6ImM4NjBjZjY2LTZlNWUtNGMxZS04NmMwLWRlZWQ2NTY4YmMyNCIsImFkZHJlc3MiOiJ2bnUiLCJiaXJ0aGRhdGUiOiIxOTk4LTAxLTEzIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiZ2VuZGVyIjoibWFsZSIsIm5hbWUiOiJOTiBUaeG6v24iLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJmYWxzZSIsInBob25lX251bWJlciI6Iis4NDk3NDc5MzQwNiIsImN1c3RvbTpyb2xlIjoidXNlciIsImVtYWlsIjoiY2h1aXRiaUBnbWFpbC5jb20ifSwiaWF0IjoxNTcxNjUyNTU0LCJleHAiOjE1NzE3Mzg5NTR9.1BTbNgL-zRE2NeWqaYA9BEjWxS7WSoPuL3cEFYMZyoM',0,'device info put in here later'),(15,'gouopa','2019-10-21 21:40:52','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoiZ291b3BhIiwiaW5mbyI6eyJzdWIiOiJjODYwY2Y2Ni02ZTVlLTRjMWUtODZjMC1kZWVkNjU2OGJjMjQiLCJhZGRyZXNzIjoidm51IiwiYmlydGhkYXRlIjoiMTk5OC0wMS0xMyIsImVtYWlsX3ZlcmlmaWVkIjoidHJ1ZSIsImdlbmRlciI6Im1hbGUiLCJuYW1lIjoiTk4gVGnhur9uIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiZmFsc2UiLCJwaG9uZV9udW1iZXIiOiIrODQ5NzQ3OTM0MDYiLCJjdXN0b206cm9sZSI6InVzZXIiLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzE2Njg4NTEsImV4cCI6MTU3MTc1NTI1MX0.-fkqmZGJSuiCz3BSFnr9xlhgyEW2P2HQnVqNxs-TUco',0,'device info put in here later'),(16,'gouopa','2019-10-21 22:19:25','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoiZ291b3BhIiwiaW5mbyI6eyJzdWIiOiJjODYwY2Y2Ni02ZTVlLTRjMWUtODZjMC1kZWVkNjU2OGJjMjQiLCJhZGRyZXNzIjoidm51IiwiYmlydGhkYXRlIjoiMTk5OC0wMS0xMyIsImVtYWlsX3ZlcmlmaWVkIjoidHJ1ZSIsImdlbmRlciI6Im1hbGUiLCJuYW1lIjoiTk4gVGnhur9uIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiZmFsc2UiLCJwaG9uZV9udW1iZXIiOiIrODQ5NzQ3OTM0MDYiLCJjdXN0b206cm9sZSI6InVzZXIiLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzE2NzExNjUsImV4cCI6MTU3MTc1NzU2NX0.oPzckzmSpGkTmoBpbVoSk-Vzwhoy58-sQZgqu7M7qjw',0,'device info put in here later'),(17,'gouopa','2019-10-21 22:19:39','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoiZ291b3BhIiwiaW5mbyI6eyJzdWIiOiJjODYwY2Y2Ni02ZTVlLTRjMWUtODZjMC1kZWVkNjU2OGJjMjQiLCJhZGRyZXNzIjoidm51IiwiYmlydGhkYXRlIjoiMTk5OC0wMS0xMyIsImVtYWlsX3ZlcmlmaWVkIjoidHJ1ZSIsImdlbmRlciI6Im1hbGUiLCJuYW1lIjoiTk4gVGnhur9uIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiZmFsc2UiLCJwaG9uZV9udW1iZXIiOiIrODQ5NzQ3OTM0MDYiLCJjdXN0b206cm9sZSI6InVzZXIiLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzE2NzExNzgsImV4cCI6MTU3MTc1NzU3OH0.3aKSKxFfF8YPuKEPVZdB0zEInhayX58VxYInFinhxnY',1,'device info put in here later'),(18,'gouopa','2019-10-21 22:21:45','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoiZ291b3BhIiwiaW5mbyI6eyJzdWIiOiJjODYwY2Y2Ni02ZTVlLTRjMWUtODZjMC1kZWVkNjU2OGJjMjQiLCJhZGRyZXNzIjoidm51IiwiYmlydGhkYXRlIjoiMTk5OC0wMS0xMyIsImVtYWlsX3ZlcmlmaWVkIjoidHJ1ZSIsImdlbmRlciI6Im1hbGUiLCJuYW1lIjoiTk4gVGnhur9uIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiZmFsc2UiLCJwaG9uZV9udW1iZXIiOiIrODQ5NzQ3OTM0MDYiLCJjdXN0b206cm9sZSI6InVzZXIiLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzE2NzEzMDUsImV4cCI6MTU3MTc1NzcwNX0.PacglOHZCEdYpUVTSo9qybLx2MwXqA5GTYMGU_-5I5w',1,'device info put in here later'),(19,'gouopa','2019-10-27 16:42:04','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoiZ291b3BhIiwiaW5mbyI6eyJzdWIiOiJjODYwY2Y2Ni02ZTVlLTRjMWUtODZjMC1kZWVkNjU2OGJjMjQiLCJhZGRyZXNzIjoidm51IiwiYmlydGhkYXRlIjoiMTk5OC0wMS0xMyIsImVtYWlsX3ZlcmlmaWVkIjoidHJ1ZSIsImdlbmRlciI6Im1hbGUiLCJuYW1lIjoiTk4gVGnhur9uIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiZmFsc2UiLCJwaG9uZV9udW1iZXIiOiIrODQ5NzQ3OTM0MDYiLCJjdXN0b206cm9sZSI6InVzZXIiLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzIxNjkzMjMsImV4cCI6MTU3MjI1NTcyM30.DMERXKqX6sM2yodSMCNMxh4gMQ9c584LRUSIvN6VdIw',0,'device info put in here later'),(20,'gouopa','2019-11-03 22:57:31','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoiZ291b3BhIiwiaW5mbyI6eyJzdWIiOiJjODYwY2Y2Ni02ZTVlLTRjMWUtODZjMC1kZWVkNjU2OGJjMjQiLCJhZGRyZXNzIjoidm51IiwiYmlydGhkYXRlIjoiMTk5OC0wMS0xMyIsImVtYWlsX3ZlcmlmaWVkIjoidHJ1ZSIsImdlbmRlciI6Im1hbGUiLCJuYW1lIjoiTk4gVGnhur9uIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiZmFsc2UiLCJwaG9uZV9udW1iZXIiOiIrODQ5NzQ3OTM0MDYiLCJjdXN0b206cm9sZSI6InVzZXIiLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzI3OTY2NTAsImV4cCI6MTU3Mjg4MzA1MH0.OYTaWIbrb9Q2MGirNDLmbmfWJZQ9TVpR75ZLf8l2uYM',1,'device info put in here later'),(21,'gouopa','2019-11-03 23:33:21','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoiZ291b3BhIiwiaW5mbyI6eyJzdWIiOiJjODYwY2Y2Ni02ZTVlLTRjMWUtODZjMC1kZWVkNjU2OGJjMjQiLCJhZGRyZXNzIjoidm51IiwiYmlydGhkYXRlIjoiMTk5OC0wMS0xMyIsImVtYWlsX3ZlcmlmaWVkIjoidHJ1ZSIsImdlbmRlciI6Im1hbGUiLCJuYW1lIjoiTk4gVGnhur9uIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiZmFsc2UiLCJwaG9uZV9udW1iZXIiOiIrODQ5NzQ3OTM0MDYiLCJjdXN0b206cm9sZSI6InVzZXIiLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzI3OTg4MDEsImV4cCI6MTU3Mjg4NTIwMX0.mMle7wPjfD6X-xQ2yfgHZ_YJ2cH5sidqLV9BRYV3Gzc',1,'device info put in here later'),(22,'gouopa','2019-11-03 23:37:09','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoiZ291b3BhIiwiaW5mbyI6eyJzdWIiOiJjODYwY2Y2Ni02ZTVlLTRjMWUtODZjMC1kZWVkNjU2OGJjMjQiLCJhZGRyZXNzIjoidm51IiwiYmlydGhkYXRlIjoiMTk5OC0wMS0xMyIsImVtYWlsX3ZlcmlmaWVkIjoidHJ1ZSIsImdlbmRlciI6Im1hbGUiLCJuYW1lIjoiTk4gVGnhur9uIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiZmFsc2UiLCJwaG9uZV9udW1iZXIiOiIrODQ5NzQ3OTM0MDYiLCJjdXN0b206cm9sZSI6InVzZXIiLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzI3OTkwMjksImV4cCI6MTU3Mjg4NTQyOX0.UaDeuw-5v4xiFYII7BfeS9H7siCVv36D50yXp1943t8',0,'device info put in here later'),(23,'peape','2019-11-03 23:55:17','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoicGVhcGUiLCJpbmZvIjp7InN1YiI6IjVlYTNmM2MyLTRlNDItNDdmOC1iZmEzLTYwOTQ2Zjc2ODE1NyIsImFkZHJlc3MiOiJ2bnUiLCJiaXJ0aGRhdGUiOiIxOTk4LTAxLTEzIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiZ2VuZGVyIjoibWFsZSIsIm5hbWUiOiJOTiBUaeG6v24iLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJmYWxzZSIsInBob25lX251bWJlciI6Iis4NDk3NDc5MzQwNiIsImN1c3RvbTpyb2xlIjoidXNlciIsImVtYWlsIjoiY2h1aXRiaUBnbWFpbC5jb20ifX0sImlhdCI6MTU3MjgwMDExNiwiZXhwIjoxNTcyODg2NTE2fQ.2DkuRBjgLfa87RhtruQ3khm462wb20rc_BbJT-zFSP4',0,'device info put in here later'),(24,'peape','2019-11-04 00:29:43','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoicGVhcGUiLCJpbmZvIjp7InN1YiI6IjVlYTNmM2MyLTRlNDItNDdmOC1iZmEzLTYwOTQ2Zjc2ODE1NyIsImFkZHJlc3MiOiJ2bnUiLCJiaXJ0aGRhdGUiOiIxOTk4LTAxLTEzIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiZ2VuZGVyIjoibWFsZSIsIm5hbWUiOiJOTiBUaeG6v24iLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJmYWxzZSIsInBob25lX251bWJlciI6Iis4NDk3NDc5MzQwNiIsImN1c3RvbTpyb2xlIjoidXNlciIsImVtYWlsIjoiY2h1aXRiaUBnbWFpbC5jb20ifX0sImlhdCI6MTU3MjgwMjE4MywiZXhwIjoxNTcyODg4NTgzfQ.dcXZ8cGvVYYYnwUrK5i15rhWjVkdI-QY0WzPpFYAMEI',0,'device info put in here later'),(25,'peape','2019-11-04 02:32:25','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoicGVhcGUiLCJpbmZvIjp7InN1YiI6IjVlYTNmM2MyLTRlNDItNDdmOC1iZmEzLTYwOTQ2Zjc2ODE1NyIsImFkZHJlc3MiOiJ2bnUiLCJiaXJ0aGRhdGUiOiIxOTk4LTAxLTEzIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiZ2VuZGVyIjoibWFsZSIsIm5hbWUiOiJOTiBUaeG6v24iLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJmYWxzZSIsInBob25lX251bWJlciI6Iis4NDk3NDc5MzQwNiIsImN1c3RvbTpyb2xlIjoidXNlciIsImVtYWlsIjoiY2h1aXRiaUBnbWFpbC5jb20ifX0sImlhdCI6MTU3MjgwOTU0NCwiZXhwIjoxNTcyODk1OTQ0fQ.NuBZB_N9tCMwQ4GS6-lsscIVwZyJMjvtHErVprFBXUw',0,'device info put in here later'),(26,'peape','2019-11-04 02:32:49','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoicGVhcGUiLCJpbmZvIjp7InN1YiI6IjVlYTNmM2MyLTRlNDItNDdmOC1iZmEzLTYwOTQ2Zjc2ODE1NyIsImFkZHJlc3MiOiJ2bnUiLCJiaXJ0aGRhdGUiOiIxOTk4LTAxLTEzIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiZ2VuZGVyIjoibWFsZSIsIm5hbWUiOiJOTiBUaeG6v24iLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJmYWxzZSIsInBob25lX251bWJlciI6Iis4NDk3NDc5MzQwNiIsImN1c3RvbTpyb2xlIjoidXNlciIsImVtYWlsIjoiY2h1aXRiaUBnbWFpbC5jb20ifX0sImlhdCI6MTU3MjgwOTU2OCwiZXhwIjoxNTcyODk1OTY4fQ.a64RV9tdQ31qSvyAgBq3UJmapgfiPq06NzsuAg-Uf5o',0,'device info put in here later'),(27,'peape','2019-11-04 02:35:34','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoicGVhcGUiLCJpbmZvIjp7InN1YiI6IjVlYTNmM2MyLTRlNDItNDdmOC1iZmEzLTYwOTQ2Zjc2ODE1NyIsImFkZHJlc3MiOiJ2bnUiLCJiaXJ0aGRhdGUiOiIxOTk4LTAxLTEzIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiZ2VuZGVyIjoibWFsZSIsIm5hbWUiOiJOTiBUaeG6v24iLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJmYWxzZSIsInBob25lX251bWJlciI6Iis4NDk3NDc5MzQwNiIsImN1c3RvbTpyb2xlIjoiYWRtaW4iLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzI4MDk3MzQsImV4cCI6MTU3Mjg5NjEzNH0.237PjLm-Ob1qnRv5RWOwmOPRu1lq_3YwozOrbTYEVus',0,'device info put in here later'),(28,'peape','2019-11-04 02:44:18','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoicGVhcGUiLCJpbmZvIjp7InN1YiI6IjVlYTNmM2MyLTRlNDItNDdmOC1iZmEzLTYwOTQ2Zjc2ODE1NyIsImFkZHJlc3MiOiJ2bnUiLCJiaXJ0aGRhdGUiOiIxOTk4LTAxLTEzIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiZ2VuZGVyIjoibWFsZSIsIm5hbWUiOiJOTiBUaeG6v24iLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJmYWxzZSIsInBob25lX251bWJlciI6Iis4NDk3NDc5MzQwNiIsImN1c3RvbTpyb2xlIjoidXNlciIsImVtYWlsIjoiY2h1aXRiaUBnbWFpbC5jb20ifX0sImlhdCI6MTU3MjgxMDI1NywiZXhwIjoxNTcyODk2NjU3fQ.rr62PXGVUDqGDkBv2P4rxGXQT8FVHy4YydQddxQHdSw',0,'device info put in here later'),(29,'peape','2019-11-04 02:45:06','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoicGVhcGUiLCJpbmZvIjp7InN1YiI6IjVlYTNmM2MyLTRlNDItNDdmOC1iZmEzLTYwOTQ2Zjc2ODE1NyIsImFkZHJlc3MiOiJ2bnUiLCJiaXJ0aGRhdGUiOiIxOTk4LTAxLTEzIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiZ2VuZGVyIjoibWFsZSIsIm5hbWUiOiJOTiBUaeG6v24iLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJmYWxzZSIsInBob25lX251bWJlciI6Iis4NDk3NDc5MzQwNiIsImN1c3RvbTpyb2xlIjoiYWRtaW4iLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzI4MTAzMDYsImV4cCI6MTU3Mjg5NjcwNn0.Xv-3XaDTMHcjhbHlvJYagnXYRfbAWukVkLfdyzEQmZM',0,'device info put in here later'),(30,'peape','2019-11-04 02:58:19','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoicGVhcGUiLCJpbmZvIjp7InN1YiI6IjVlYTNmM2MyLTRlNDItNDdmOC1iZmEzLTYwOTQ2Zjc2ODE1NyIsImFkZHJlc3MiOiJ2bnUiLCJiaXJ0aGRhdGUiOiIxOTk4LTAxLTEzIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiZ2VuZGVyIjoibWFsZSIsIm5hbWUiOiJOTiBUaeG6v24iLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJmYWxzZSIsInBob25lX251bWJlciI6Iis4NDk3NDc5MzQwNiIsImN1c3RvbTpyb2xlIjoiZW1wbG95ZWUiLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzI4MTEwOTksImV4cCI6MTU3Mjg5NzQ5OX0.NmxLlzm-ADv_GzFFHtoL0blgkx4IAzXmdz19cF6OO68',0,'device info put in here later'),(31,'peape','2019-11-04 21:53:24','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoicGVhcGUiLCJpbmZvIjp7InN1YiI6IjVlYTNmM2MyLTRlNDItNDdmOC1iZmEzLTYwOTQ2Zjc2ODE1NyIsImFkZHJlc3MiOiJ2bnUiLCJiaXJ0aGRhdGUiOiIxOTk4LTAxLTEzIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiZ2VuZGVyIjoibWFsZSIsIm5hbWUiOiJOTiBUaeG6v24iLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJmYWxzZSIsInBob25lX251bWJlciI6Iis4NDk3NDc5MzQwNiIsImN1c3RvbTpyb2xlIjoiYWRtaW4iLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzI4NzkyMDMsImV4cCI6MTU3Mjk2NTYwM30.vyIBLu6NYo3nk8pPuNJ7NYmd1yJHR4UnKw0g2U15AFY',0,'device info put in here later'),(32,'peape','2019-11-04 23:29:22','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoicGVhcGUiLCJpbmZvIjp7InN1YiI6IjVlYTNmM2MyLTRlNDItNDdmOC1iZmEzLTYwOTQ2Zjc2ODE1NyIsImFkZHJlc3MiOiJ2bnUiLCJiaXJ0aGRhdGUiOiIxOTk4LTAxLTEzIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiZ2VuZGVyIjoibWFsZSIsIm5hbWUiOiJOTiBUaeG6v24iLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJmYWxzZSIsInBob25lX251bWJlciI6Iis4NDk3NDc5MzQwNiIsImN1c3RvbTpyb2xlIjoiZW1wbG95ZWUiLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzI4ODQ5NjEsImV4cCI6MTU3Mjk3MTM2MX0.iNstLXtRgQp2iXpO2XIDdgCpW7rcgKvZiICz8AdJCKw',0,'device info put in here later');
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brand` varchar(255) NOT NULL,
  `type` int(2) NOT NULL,
  `name` varchar(255) NOT NULL,
  `engine_cap` int(6) NOT NULL,
  `color` varchar(255) NOT NULL,
  `gross_ton` int(6) NOT NULL,
  `total_weight` int(6) NOT NULL,
  `n_passengers` int(3) NOT NULL,
  `pic_l` blob,
  `pic_r` blob,
  `pic_f` blob,
  `pic_rr` blob,
  `approval_status` varchar(8) NOT NULL,
  `approval_due_date` datetime DEFAULT NULL,
  `open_price` int(12) DEFAULT NULL,
  `trip_price` int(12) DEFAULT NULL,
  `wait_price` int(12) DEFAULT NULL,
  `driver_id` varchar(255) NOT NULL,
  `employee_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES (1,'Honda',2,'',125,'grey',138,180,2,NULL,NULL,NULL,NULL,'APPROVED','2020-05-03 00:18:33',NULL,NULL,NULL,'c860cf66-6e5e-4c1e-86c0-deed6568bc24','5ea3f3c2-4e42-47f8-bfa3-60946f768157'),(2,'Honda',2,'Future125',125,'grey',138,180,2,NULL,NULL,NULL,NULL,'WAITING',NULL,NULL,NULL,NULL,'c860cf66-6e5e-4c1e-86c0-deed6568bc24',NULL),(3,'Honda',2,'AirBlade125',125,'grey',138,180,2,NULL,NULL,NULL,NULL,'WAITING',NULL,NULL,NULL,NULL,'c860cf66-6e5e-4c1e-86c0-deed6568bc24',NULL),(4,'Honda',2,'SH125',125,'grey',138,180,2,NULL,NULL,NULL,NULL,'WAITING',NULL,NULL,NULL,NULL,'c860cf66-6e5e-4c1e-86c0-deed6568bc24',NULL),(5,'Honda',2,'Lead125',125,'grey',138,180,2,NULL,NULL,NULL,NULL,'WAITING',NULL,NULL,NULL,NULL,'c860cf66-6e5e-4c1e-86c0-deed6568bc24',NULL);
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ourtrips'
--

--
-- Dumping routines for database 'ourtrips'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-05 11:55:58
