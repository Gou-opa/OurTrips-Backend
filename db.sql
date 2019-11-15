CREATE DATABASE  IF NOT EXISTS `ourtrips` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `ourtrips`;
-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: freetier.ckulrgi4xq9m.ap-southeast-1.rds.amazonaws.com    Database: ourtrips
-- ------------------------------------------------------
-- Server version	5.7.26-log

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

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
-- Table structure for table `ewallet`
--

DROP TABLE IF EXISTS `ewallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ewallet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vendor` varchar(255) NOT NULL,
  `balance` int(11) NOT NULL,
  `accountNumber` varchar(34) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ewallet`
--

LOCK TABLES `ewallet` WRITE;
/*!40000 ALTER TABLE `ewallet` DISABLE KEYS */;
INSERT INTO `ewallet` VALUES (6,'OurTrips',0,'0000000000000000000000000000000006','c860cf66-6e5e-4c1e-86c0-deed6568bc24'),(7,'BIDV',0,'VN3239013930317410','c860cf66-6e5e-4c1e-86c0-deed6568bc24'),(8,'BIDV',800000,'VN32390139303117410','c860cf66-6e5e-4c1e-86c0-deed6568bc24'),(9,'OurTrips',0,'0000000000000000000000000000000009','c860cf66-6e5e-4c1e-86c0-deed6568bc24');
/*!40000 ALTER TABLE `ewallet` ENABLE KEYS */;
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
INSERT INTO `licence` VALUES ('1361101119701703000','2036-03-29 00:00:00','A2','TP. Hà Nội','c860cf66-6e5e-4c1e-86c0-deed6568bc24','APPROVED','2022-08-11 18:56:44','kembong'),('1361103701703717','2031-03-29 00:00:00','A1','TP. Hà Nội','5ea3f3c2-4e42-47f8-bfa3-60946f768157','WAITING',NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
INSERT INTO `session` VALUES (14,'','2019-10-21 17:09:14','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InN1YiI6ImM4NjBjZjY2LTZlNWUtNGMxZS04NmMwLWRlZWQ2NTY4YmMyNCIsImFkZHJlc3MiOiJ2bnUiLCJiaXJ0aGRhdGUiOiIxOTk4LTAxLTEzIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiZ2VuZGVyIjoibWFsZSIsIm5hbWUiOiJOTiBUaeG6v24iLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJmYWxzZSIsInBob25lX251bWJlciI6Iis4NDk3NDc5MzQwNiIsImN1c3RvbTpyb2xlIjoidXNlciIsImVtYWlsIjoiY2h1aXRiaUBnbWFpbC5jb20ifSwiaWF0IjoxNTcxNjUyNTU0LCJleHAiOjE1NzE3Mzg5NTR9.1BTbNgL-zRE2NeWqaYA9BEjWxS7WSoPuL3cEFYMZyoM',0,'device info put in here later'),(15,'gouopa','2019-10-21 21:40:52','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoiZ291b3BhIiwiaW5mbyI6eyJzdWIiOiJjODYwY2Y2Ni02ZTVlLTRjMWUtODZjMC1kZWVkNjU2OGJjMjQiLCJhZGRyZXNzIjoidm51IiwiYmlydGhkYXRlIjoiMTk5OC0wMS0xMyIsImVtYWlsX3ZlcmlmaWVkIjoidHJ1ZSIsImdlbmRlciI6Im1hbGUiLCJuYW1lIjoiTk4gVGnhur9uIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiZmFsc2UiLCJwaG9uZV9udW1iZXIiOiIrODQ5NzQ3OTM0MDYiLCJjdXN0b206cm9sZSI6InVzZXIiLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzE2Njg4NTEsImV4cCI6MTU3MTc1NTI1MX0.-fkqmZGJSuiCz3BSFnr9xlhgyEW2P2HQnVqNxs-TUco',0,'device info put in here later'),(16,'gouopa','2019-10-21 22:19:25','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoiZ291b3BhIiwiaW5mbyI6eyJzdWIiOiJjODYwY2Y2Ni02ZTVlLTRjMWUtODZjMC1kZWVkNjU2OGJjMjQiLCJhZGRyZXNzIjoidm51IiwiYmlydGhkYXRlIjoiMTk5OC0wMS0xMyIsImVtYWlsX3ZlcmlmaWVkIjoidHJ1ZSIsImdlbmRlciI6Im1hbGUiLCJuYW1lIjoiTk4gVGnhur9uIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiZmFsc2UiLCJwaG9uZV9udW1iZXIiOiIrODQ5NzQ3OTM0MDYiLCJjdXN0b206cm9sZSI6InVzZXIiLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzE2NzExNjUsImV4cCI6MTU3MTc1NzU2NX0.oPzckzmSpGkTmoBpbVoSk-Vzwhoy58-sQZgqu7M7qjw',0,'device info put in here later'),(17,'gouopa','2019-10-21 22:19:39','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoiZ291b3BhIiwiaW5mbyI6eyJzdWIiOiJjODYwY2Y2Ni02ZTVlLTRjMWUtODZjMC1kZWVkNjU2OGJjMjQiLCJhZGRyZXNzIjoidm51IiwiYmlydGhkYXRlIjoiMTk5OC0wMS0xMyIsImVtYWlsX3ZlcmlmaWVkIjoidHJ1ZSIsImdlbmRlciI6Im1hbGUiLCJuYW1lIjoiTk4gVGnhur9uIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiZmFsc2UiLCJwaG9uZV9udW1iZXIiOiIrODQ5NzQ3OTM0MDYiLCJjdXN0b206cm9sZSI6InVzZXIiLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzE2NzExNzgsImV4cCI6MTU3MTc1NzU3OH0.3aKSKxFfF8YPuKEPVZdB0zEInhayX58VxYInFinhxnY',1,'device info put in here later'),(18,'gouopa','2019-10-21 22:21:45','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoiZ291b3BhIiwiaW5mbyI6eyJzdWIiOiJjODYwY2Y2Ni02ZTVlLTRjMWUtODZjMC1kZWVkNjU2OGJjMjQiLCJhZGRyZXNzIjoidm51IiwiYmlydGhkYXRlIjoiMTk5OC0wMS0xMyIsImVtYWlsX3ZlcmlmaWVkIjoidHJ1ZSIsImdlbmRlciI6Im1hbGUiLCJuYW1lIjoiTk4gVGnhur9uIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiZmFsc2UiLCJwaG9uZV9udW1iZXIiOiIrODQ5NzQ3OTM0MDYiLCJjdXN0b206cm9sZSI6InVzZXIiLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzE2NzEzMDUsImV4cCI6MTU3MTc1NzcwNX0.PacglOHZCEdYpUVTSo9qybLx2MwXqA5GTYMGU_-5I5w',1,'device info put in here later'),(19,'gouopa','2019-10-27 16:42:04','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoiZ291b3BhIiwiaW5mbyI6eyJzdWIiOiJjODYwY2Y2Ni02ZTVlLTRjMWUtODZjMC1kZWVkNjU2OGJjMjQiLCJhZGRyZXNzIjoidm51IiwiYmlydGhkYXRlIjoiMTk5OC0wMS0xMyIsImVtYWlsX3ZlcmlmaWVkIjoidHJ1ZSIsImdlbmRlciI6Im1hbGUiLCJuYW1lIjoiTk4gVGnhur9uIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiZmFsc2UiLCJwaG9uZV9udW1iZXIiOiIrODQ5NzQ3OTM0MDYiLCJjdXN0b206cm9sZSI6InVzZXIiLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzIxNjkzMjMsImV4cCI6MTU3MjI1NTcyM30.DMERXKqX6sM2yodSMCNMxh4gMQ9c584LRUSIvN6VdIw',0,'device info put in here later'),(20,'gouopa','2019-11-03 22:57:31','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoiZ291b3BhIiwiaW5mbyI6eyJzdWIiOiJjODYwY2Y2Ni02ZTVlLTRjMWUtODZjMC1kZWVkNjU2OGJjMjQiLCJhZGRyZXNzIjoidm51IiwiYmlydGhkYXRlIjoiMTk5OC0wMS0xMyIsImVtYWlsX3ZlcmlmaWVkIjoidHJ1ZSIsImdlbmRlciI6Im1hbGUiLCJuYW1lIjoiTk4gVGnhur9uIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiZmFsc2UiLCJwaG9uZV9udW1iZXIiOiIrODQ5NzQ3OTM0MDYiLCJjdXN0b206cm9sZSI6InVzZXIiLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzI3OTY2NTAsImV4cCI6MTU3Mjg4MzA1MH0.OYTaWIbrb9Q2MGirNDLmbmfWJZQ9TVpR75ZLf8l2uYM',1,'device info put in here later'),(21,'gouopa','2019-11-03 23:33:21','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoiZ291b3BhIiwiaW5mbyI6eyJzdWIiOiJjODYwY2Y2Ni02ZTVlLTRjMWUtODZjMC1kZWVkNjU2OGJjMjQiLCJhZGRyZXNzIjoidm51IiwiYmlydGhkYXRlIjoiMTk5OC0wMS0xMyIsImVtYWlsX3ZlcmlmaWVkIjoidHJ1ZSIsImdlbmRlciI6Im1hbGUiLCJuYW1lIjoiTk4gVGnhur9uIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiZmFsc2UiLCJwaG9uZV9udW1iZXIiOiIrODQ5NzQ3OTM0MDYiLCJjdXN0b206cm9sZSI6InVzZXIiLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzI3OTg4MDEsImV4cCI6MTU3Mjg4NTIwMX0.mMle7wPjfD6X-xQ2yfgHZ_YJ2cH5sidqLV9BRYV3Gzc',1,'device info put in here later'),(22,'gouopa','2019-11-03 23:37:09','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoiZ291b3BhIiwiaW5mbyI6eyJzdWIiOiJjODYwY2Y2Ni02ZTVlLTRjMWUtODZjMC1kZWVkNjU2OGJjMjQiLCJhZGRyZXNzIjoidm51IiwiYmlydGhkYXRlIjoiMTk5OC0wMS0xMyIsImVtYWlsX3ZlcmlmaWVkIjoidHJ1ZSIsImdlbmRlciI6Im1hbGUiLCJuYW1lIjoiTk4gVGnhur9uIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiZmFsc2UiLCJwaG9uZV9udW1iZXIiOiIrODQ5NzQ3OTM0MDYiLCJjdXN0b206cm9sZSI6InVzZXIiLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzI3OTkwMjksImV4cCI6MTU3Mjg4NTQyOX0.UaDeuw-5v4xiFYII7BfeS9H7siCVv36D50yXp1943t8',0,'device info put in here later'),(23,'peape','2019-11-03 23:55:17','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoicGVhcGUiLCJpbmZvIjp7InN1YiI6IjVlYTNmM2MyLTRlNDItNDdmOC1iZmEzLTYwOTQ2Zjc2ODE1NyIsImFkZHJlc3MiOiJ2bnUiLCJiaXJ0aGRhdGUiOiIxOTk4LTAxLTEzIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiZ2VuZGVyIjoibWFsZSIsIm5hbWUiOiJOTiBUaeG6v24iLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJmYWxzZSIsInBob25lX251bWJlciI6Iis4NDk3NDc5MzQwNiIsImN1c3RvbTpyb2xlIjoidXNlciIsImVtYWlsIjoiY2h1aXRiaUBnbWFpbC5jb20ifX0sImlhdCI6MTU3MjgwMDExNiwiZXhwIjoxNTcyODg2NTE2fQ.2DkuRBjgLfa87RhtruQ3khm462wb20rc_BbJT-zFSP4',0,'device info put in here later'),(24,'peape','2019-11-04 00:29:43','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoicGVhcGUiLCJpbmZvIjp7InN1YiI6IjVlYTNmM2MyLTRlNDItNDdmOC1iZmEzLTYwOTQ2Zjc2ODE1NyIsImFkZHJlc3MiOiJ2bnUiLCJiaXJ0aGRhdGUiOiIxOTk4LTAxLTEzIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiZ2VuZGVyIjoibWFsZSIsIm5hbWUiOiJOTiBUaeG6v24iLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJmYWxzZSIsInBob25lX251bWJlciI6Iis4NDk3NDc5MzQwNiIsImN1c3RvbTpyb2xlIjoidXNlciIsImVtYWlsIjoiY2h1aXRiaUBnbWFpbC5jb20ifX0sImlhdCI6MTU3MjgwMjE4MywiZXhwIjoxNTcyODg4NTgzfQ.dcXZ8cGvVYYYnwUrK5i15rhWjVkdI-QY0WzPpFYAMEI',0,'device info put in here later'),(25,'peape','2019-11-04 02:32:25','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoicGVhcGUiLCJpbmZvIjp7InN1YiI6IjVlYTNmM2MyLTRlNDItNDdmOC1iZmEzLTYwOTQ2Zjc2ODE1NyIsImFkZHJlc3MiOiJ2bnUiLCJiaXJ0aGRhdGUiOiIxOTk4LTAxLTEzIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiZ2VuZGVyIjoibWFsZSIsIm5hbWUiOiJOTiBUaeG6v24iLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJmYWxzZSIsInBob25lX251bWJlciI6Iis4NDk3NDc5MzQwNiIsImN1c3RvbTpyb2xlIjoidXNlciIsImVtYWlsIjoiY2h1aXRiaUBnbWFpbC5jb20ifX0sImlhdCI6MTU3MjgwOTU0NCwiZXhwIjoxNTcyODk1OTQ0fQ.NuBZB_N9tCMwQ4GS6-lsscIVwZyJMjvtHErVprFBXUw',0,'device info put in here later'),(26,'peape','2019-11-04 02:32:49','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoicGVhcGUiLCJpbmZvIjp7InN1YiI6IjVlYTNmM2MyLTRlNDItNDdmOC1iZmEzLTYwOTQ2Zjc2ODE1NyIsImFkZHJlc3MiOiJ2bnUiLCJiaXJ0aGRhdGUiOiIxOTk4LTAxLTEzIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiZ2VuZGVyIjoibWFsZSIsIm5hbWUiOiJOTiBUaeG6v24iLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJmYWxzZSIsInBob25lX251bWJlciI6Iis4NDk3NDc5MzQwNiIsImN1c3RvbTpyb2xlIjoidXNlciIsImVtYWlsIjoiY2h1aXRiaUBnbWFpbC5jb20ifX0sImlhdCI6MTU3MjgwOTU2OCwiZXhwIjoxNTcyODk1OTY4fQ.a64RV9tdQ31qSvyAgBq3UJmapgfiPq06NzsuAg-Uf5o',0,'device info put in here later'),(27,'peape','2019-11-04 02:35:34','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoicGVhcGUiLCJpbmZvIjp7InN1YiI6IjVlYTNmM2MyLTRlNDItNDdmOC1iZmEzLTYwOTQ2Zjc2ODE1NyIsImFkZHJlc3MiOiJ2bnUiLCJiaXJ0aGRhdGUiOiIxOTk4LTAxLTEzIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiZ2VuZGVyIjoibWFsZSIsIm5hbWUiOiJOTiBUaeG6v24iLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJmYWxzZSIsInBob25lX251bWJlciI6Iis4NDk3NDc5MzQwNiIsImN1c3RvbTpyb2xlIjoiYWRtaW4iLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzI4MDk3MzQsImV4cCI6MTU3Mjg5NjEzNH0.237PjLm-Ob1qnRv5RWOwmOPRu1lq_3YwozOrbTYEVus',0,'device info put in here later'),(28,'peape','2019-11-04 02:44:18','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoicGVhcGUiLCJpbmZvIjp7InN1YiI6IjVlYTNmM2MyLTRlNDItNDdmOC1iZmEzLTYwOTQ2Zjc2ODE1NyIsImFkZHJlc3MiOiJ2bnUiLCJiaXJ0aGRhdGUiOiIxOTk4LTAxLTEzIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiZ2VuZGVyIjoibWFsZSIsIm5hbWUiOiJOTiBUaeG6v24iLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJmYWxzZSIsInBob25lX251bWJlciI6Iis4NDk3NDc5MzQwNiIsImN1c3RvbTpyb2xlIjoidXNlciIsImVtYWlsIjoiY2h1aXRiaUBnbWFpbC5jb20ifX0sImlhdCI6MTU3MjgxMDI1NywiZXhwIjoxNTcyODk2NjU3fQ.rr62PXGVUDqGDkBv2P4rxGXQT8FVHy4YydQddxQHdSw',0,'device info put in here later'),(29,'peape','2019-11-04 02:45:06','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoicGVhcGUiLCJpbmZvIjp7InN1YiI6IjVlYTNmM2MyLTRlNDItNDdmOC1iZmEzLTYwOTQ2Zjc2ODE1NyIsImFkZHJlc3MiOiJ2bnUiLCJiaXJ0aGRhdGUiOiIxOTk4LTAxLTEzIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiZ2VuZGVyIjoibWFsZSIsIm5hbWUiOiJOTiBUaeG6v24iLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJmYWxzZSIsInBob25lX251bWJlciI6Iis4NDk3NDc5MzQwNiIsImN1c3RvbTpyb2xlIjoiYWRtaW4iLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzI4MTAzMDYsImV4cCI6MTU3Mjg5NjcwNn0.Xv-3XaDTMHcjhbHlvJYagnXYRfbAWukVkLfdyzEQmZM',0,'device info put in here later'),(30,'peape','2019-11-04 02:58:19','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoicGVhcGUiLCJpbmZvIjp7InN1YiI6IjVlYTNmM2MyLTRlNDItNDdmOC1iZmEzLTYwOTQ2Zjc2ODE1NyIsImFkZHJlc3MiOiJ2bnUiLCJiaXJ0aGRhdGUiOiIxOTk4LTAxLTEzIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiZ2VuZGVyIjoibWFsZSIsIm5hbWUiOiJOTiBUaeG6v24iLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJmYWxzZSIsInBob25lX251bWJlciI6Iis4NDk3NDc5MzQwNiIsImN1c3RvbTpyb2xlIjoiZW1wbG95ZWUiLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzI4MTEwOTksImV4cCI6MTU3Mjg5NzQ5OX0.NmxLlzm-ADv_GzFFHtoL0blgkx4IAzXmdz19cF6OO68',0,'device info put in here later'),(31,'peape','2019-11-04 21:53:24','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoicGVhcGUiLCJpbmZvIjp7InN1YiI6IjVlYTNmM2MyLTRlNDItNDdmOC1iZmEzLTYwOTQ2Zjc2ODE1NyIsImFkZHJlc3MiOiJ2bnUiLCJiaXJ0aGRhdGUiOiIxOTk4LTAxLTEzIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiZ2VuZGVyIjoibWFsZSIsIm5hbWUiOiJOTiBUaeG6v24iLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJmYWxzZSIsInBob25lX251bWJlciI6Iis4NDk3NDc5MzQwNiIsImN1c3RvbTpyb2xlIjoiYWRtaW4iLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzI4NzkyMDMsImV4cCI6MTU3Mjk2NTYwM30.vyIBLu6NYo3nk8pPuNJ7NYmd1yJHR4UnKw0g2U15AFY',0,'device info put in here later'),(32,'peape','2019-11-04 23:29:22','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoicGVhcGUiLCJpbmZvIjp7InN1YiI6IjVlYTNmM2MyLTRlNDItNDdmOC1iZmEzLTYwOTQ2Zjc2ODE1NyIsImFkZHJlc3MiOiJ2bnUiLCJiaXJ0aGRhdGUiOiIxOTk4LTAxLTEzIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiZ2VuZGVyIjoibWFsZSIsIm5hbWUiOiJOTiBUaeG6v24iLCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOiJmYWxzZSIsInBob25lX251bWJlciI6Iis4NDk3NDc5MzQwNiIsImN1c3RvbTpyb2xlIjoiZW1wbG95ZWUiLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIn19LCJpYXQiOjE1NzI4ODQ5NjEsImV4cCI6MTU3Mjk3MTM2MX0.iNstLXtRgQp2iXpO2XIDdgCpW7rcgKvZiICz8AdJCKw',0,'device info put in here later'),(33,'gouopa','2019-11-05 22:24:44','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoiZ291b3BhIiwiaW5mbyI6eyJzdWIiOiJjODYwY2Y2Ni02ZTVlLTRjMWUtODZjMC1kZWVkNjU2OGJjMjQiLCJhZGRyZXNzIjoidm51IiwiYmlydGhkYXRlIjoiMTk5OC0wMS0xMyIsImVtYWlsX3ZlcmlmaWVkIjoiZmFsc2UiLCJnZW5kZXIiOiJtYWxlIiwibmFtZSI6Ik5OIFRp4bq_biIsInBob25lX251bWJlcl92ZXJpZmllZCI6ImZhbHNlIiwicGhvbmVfbnVtYmVyIjoiKzg0OTc0NzkzNDA2IiwiY3VzdG9tOnJvbGUiOiJ1c2VyIiwiZW1haWwiOiJjaHVpdGJpQGdtYWlsLmNvbSJ9fSwiaWF0IjoxNTcyOTY3NDg0LCJleHAiOjE1NzQyNjM0ODR9.DCwg0GErl9b5O099Bde2tPhTR0fiul0paNTcIOxggpA',0,'device info put in here later'),(34,'kembong','2019-11-15 18:33:43','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoia2VtYm9uZyIsImluZm8iOlt7InVzZXJuYW1lIjoia2VtYm9uZyIsIm5hbWUiOiJOTiBUaT9uIiwiZ2VuZGVyIjoxLCJkb2IiOiIxOTk4LTAxLTEzVDAwOjAwOjAwLjAwMFoiLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIiwiYWRkcmVzcyI6InZudSIsInRlbCI6Iis4NDk3NDc5MzQwNiIsIm5hdGlvbmFsaXR5IjoidmlldG5hbWVzZSIsInJvbGUiOiJ1c2VyIn1dfSwiaWF0IjoxNTczODE3NjIzLCJleHAiOjE1NzUxMTM2MjN9.c9sDvY3XqnHXnYJn_l3WWCJojuYlJ6_dCMd8Pxbe9VA',0,'device info put in here later'),(35,'admin','2019-11-15 18:41:51','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoiYWRtaW4iLCJpbmZvIjpbeyJ1c2VybmFtZSI6ImFkbWluIiwibmFtZSI6Ik5OIFRpP24iLCJnZW5kZXIiOjEsImRvYiI6IjE5OTgtMDEtMTNUMDA6MDA6MDAuMDAwWiIsImVtYWlsIjoiY2h1aXRiaUBnbWFpbC5jb20iLCJhZGRyZXNzIjoidm51IiwidGVsIjoiKzg0OTc0NzkzNDA2IiwibmF0aW9uYWxpdHkiOiJ2aWV0bmFtZXNlIiwicm9sZSI6ImFkbWluIn1dfSwiaWF0IjoxNTczODE4MTEwLCJleHAiOjE1NzUxMTQxMTB9.Y-ozNcLyfSXj_uGtnH3PjFH_HmZm5P8xS6t1PhzSVvg',0,'device info put in here later'),(36,'admin','2019-11-15 18:42:19','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoiYWRtaW4iLCJpbmZvIjpbeyJ1c2VybmFtZSI6ImFkbWluIiwibmFtZSI6Ik5OIFRpP24iLCJnZW5kZXIiOjEsImRvYiI6IjE5OTgtMDEtMTNUMDA6MDA6MDAuMDAwWiIsImVtYWlsIjoiY2h1aXRiaUBnbWFpbC5jb20iLCJhZGRyZXNzIjoidm51IiwidGVsIjoiKzg0OTc0NzkzNDA2IiwibmF0aW9uYWxpdHkiOiJ2aWV0bmFtZXNlIiwicm9sZSI6ImFkbWluIn1dfSwiaWF0IjoxNTczODE4MTM4LCJleHAiOjE1NzUxMTQxMzh9.dXQ5gHcGMi1ErR4qy29IMFTPFFicKSDIl_q6JXSZlRI',0,'device info put in here later'),(37,'kembong','2019-11-15 18:47:29','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoia2VtYm9uZyIsImluZm8iOlt7InVzZXJuYW1lIjoia2VtYm9uZyIsIm5hbWUiOiJOTiBUaT9uIiwiZ2VuZGVyIjoxLCJkb2IiOiIxOTk4LTAxLTEzVDAwOjAwOjAwLjAwMFoiLCJlbWFpbCI6ImNodWl0YmlAZ21haWwuY29tIiwiYWRkcmVzcyI6InZudSIsInRlbCI6Iis4NDk3NDc5MzQwNiIsIm5hdGlvbmFsaXR5IjoidmlldG5hbWVzZSIsInJvbGUiOiJlbXBsb3llZSJ9XX0sImlhdCI6MTU3MzgxODQ0OCwiZXhwIjoxNTc1MTE0NDQ4fQ.oE2J0AyCQT8FG605DpImuQALoEeJWR_iSCiFxyGiGzk',0,'device info put in here later'),(38,'kembong','2019-11-15 18:52:28','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJuYW1lIjoia2VtYm9uZyIsImluZm8iOnsidXNlcm5hbWUiOiJrZW1ib25nIiwibmFtZSI6Ik5OIFRpP24iLCJnZW5kZXIiOjEsImRvYiI6IjE5OTgtMDEtMTNUMDA6MDA6MDAuMDAwWiIsImVtYWlsIjoiY2h1aXRiaUBnbWFpbC5jb20iLCJhZGRyZXNzIjoidm51IiwidGVsIjoiKzg0OTc0NzkzNDA2IiwibmF0aW9uYWxpdHkiOiJ2aWV0bmFtZXNlIiwicm9sZSI6ImVtcGxveWVlIn19LCJpYXQiOjE1NzM4MTg3NDgsImV4cCI6MTU3NTExNDc0OH0.q3mHRGvJ_k9hlev3jD2gFiomByH2cW2_LgMHrNm4Ybc',0,'device info put in here later');
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trip`
--

DROP TABLE IF EXISTS `trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trip` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `owner_id` varchar(255) NOT NULL,
  `discount_id` int(8) DEFAULT NULL,
  `vehicle_id` int(11) DEFAULT NULL,
  `payment_id` int(8) DEFAULT NULL,
  `whole_trip_price` int(12) DEFAULT NULL,
  `open_price` int(12) DEFAULT NULL,
  `avg_price` int(12) DEFAULT NULL,
  `route` json NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip`
--

LOCK TABLES `trip` WRITE;
/*!40000 ALTER TABLE `trip` DISABLE KEYS */;
INSERT INTO `trip` VALUES (1,'c860cf66-6e5e-4c1e-86c0-deed6568bc24',NULL,NULL,NULL,NULL,NULL,NULL,'{\"type\": \"FeatureCollection\", \"features\": [{\"type\": \"Feature\", \"title\": \"End\", \"geometry\": {\"type\": \"Point\", \"coordinates\": [105.822114944458, 21.01651291743697]}, \"properties\": {}}, {\"type\": \"Feature\", \"title\": \"Route\", \"geometry\": {\"type\": \"LineString\", \"coordinates\": [[105.81456184387208, 21.035840851524423], [105.81318855285645, 21.031414675457153], [105.811665058136, 21.02590680672356], [105.80690145492554, 21.017915028040143], [105.8070945739746, 21.017694697246966], [105.80829620361328, 21.019797841540587], [105.81477642059326, 21.016713219758817], [105.8186388015747, 21.013908962771954], [105.81891775131226, 21.013778763845288], [105.82098841667175, 21.016012160455343], [105.82125663757324, 21.016222478592425], [105.8214819431305, 21.01631261484609], [105.82325220108032, 21.016362690519024], [105.82327365875244, 21.01656299304265], [105.82212567329408, 21.016542962802394]]}, \"properties\": {}}, {\"type\": \"Feature\", \"title\": \"Start\", \"geometry\": {\"type\": \"Point\", \"coordinates\": [105.81454038619994, 21.035820823874563]}, \"properties\": {}}, {\"type\": \"Feature\", \"title\": \"Stop_1\", \"geometry\": {\"type\": \"Point\", \"coordinates\": [105.81020593643188, 21.018891490136955]}, \"properties\": {}}, {\"type\": \"Feature\", \"title\": \"Stop_2\", \"geometry\": {\"type\": \"Point\", \"coordinates\": [105.81984043121338, 21.01475024540435]}, \"properties\": {}}]}'),(2,'c860cf66-6e5e-4c1e-86c0-deed6568bc24',NULL,NULL,NULL,NULL,NULL,NULL,'{\"type\": \"FeatureCollection\", \"features\": [{\"type\": \"Feature\", \"title\": \"End\", \"geometry\": {\"type\": \"Point\", \"coordinates\": [105.822114944458, 21.01651291743697]}, \"properties\": {}}, {\"type\": \"Feature\", \"title\": \"Route\", \"geometry\": {\"type\": \"LineString\", \"coordinates\": [[105.81456184387208, 21.035840851524423], [105.81318855285645, 21.031414675457153], [105.811665058136, 21.02590680672356], [105.80690145492554, 21.017915028040143], [105.8070945739746, 21.017694697246966], [105.80829620361328, 21.019797841540587], [105.81477642059326, 21.016713219758817], [105.8186388015747, 21.013908962771954], [105.81891775131226, 21.013778763845288], [105.82098841667175, 21.016012160455343], [105.82125663757324, 21.016222478592425], [105.8214819431305, 21.01631261484609], [105.82325220108032, 21.016362690519024], [105.82327365875244, 21.01656299304265], [105.82212567329408, 21.016542962802394]]}, \"properties\": {}}, {\"type\": \"Feature\", \"title\": \"Start\", \"geometry\": {\"type\": \"Point\", \"coordinates\": [105.81454038619994, 21.035820823874563]}, \"properties\": {}}, {\"type\": \"Feature\", \"title\": \"Stop_1\", \"geometry\": {\"type\": \"Point\", \"coordinates\": [105.81020593643188, 21.018891490136955]}, \"properties\": {}}, {\"type\": \"Feature\", \"title\": \"Stop_2\", \"geometry\": {\"type\": \"Point\", \"coordinates\": [105.81984043121338, 21.01475024540435]}, \"properties\": {}}]}');
/*!40000 ALTER TABLE `trip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `username` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `gender` tinyint(4) NOT NULL,
  `dob` datetime NOT NULL,
  `email` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `tel` varchar(12) NOT NULL,
  `nationality` varchar(255) NOT NULL,
  `role` varchar(45) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('admin','NN Ti?n',1,'1998-01-13 07:00:00','chuitbi@gmail.com','vnu','+84974793406','vietnamese','admin'),('kem','NN Ti?n',1,'1998-01-13 07:00:00','chuitbi@gmail.com','vnu','+84974793406','vietnamese','user'),('kembong','NN Ti?n',1,'1998-01-13 07:00:00','chuitbi@gmail.com','vnu','+84974793406','vietnamese','employee');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
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
INSERT INTO `vehicle` VALUES (2,'Honda',2,'Future125',125,'grey',138,180,2,NULL,NULL,NULL,NULL,'APPROVED','2020-05-03 12:11:23',10000,8000,1000,'c860cf66-6e5e-4c1e-86c0-deed6568bc24','5ea3f3c2-4e42-47f8-bfa3-60946f768157'),(3,'Honda',2,'AirBlade125',125,'grey',138,180,2,NULL,NULL,NULL,NULL,'APPROVED','2020-05-03 21:53:05',NULL,NULL,NULL,'c860cf66-6e5e-4c1e-86c0-deed6568bc24','5ea3f3c2-4e42-47f8-bfa3-60946f768157'),(4,'Honda',2,'SH125',125,'grey',138,180,2,NULL,NULL,NULL,NULL,'WAITING',NULL,NULL,NULL,NULL,'c860cf66-6e5e-4c1e-86c0-deed6568bc24',NULL),(5,'Honda',2,'Lead125',125,'grey',138,180,2,NULL,NULL,NULL,NULL,'WAITING',NULL,NULL,NULL,NULL,'c860cf66-6e5e-4c1e-86c0-deed6568bc24',NULL);
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ourtrips'
--

--
-- Dumping routines for database 'ourtrips'
--
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-15 18:58:16
