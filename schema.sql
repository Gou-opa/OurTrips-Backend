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


--
-- GTID state at the beginning of the backup 
--



--
-- Table structure for table `discount`
--

DROP TABLE IF EXISTS `discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discount` (
  `id` varchar(255) NOT NULL,
  `owner_id` varchar(255) NOT NULL,
  `policy_expression` json NOT NULL,
  PRIMARY KEY (`id`,`owner_id`),
  KEY `discount_owner_fk_idx` (`owner_id`),
  CONSTRAINT `discount_owner_fk` FOREIGN KEY (`owner_id`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `address_line2` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `emergency`
--

DROP TABLE IF EXISTS `emergency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emergency` (
  `id` int(13) NOT NULL,
  `type` varchar(255) NOT NULL,
  `employee_id` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `ewallet`
--

DROP TABLE IF EXISTS `ewallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ewallet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vendor` varchar(255) NOT NULL,
  `balance` int(11) unsigned NOT NULL,
  `accountNumber` varchar(34) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `ewallet_user_fk_idx` (`user_id`),
  CONSTRAINT `ewallet_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `licence_driver_fk_idx` (`driver_id`),
  KEY `licence_employee_fk_idx` (`employee_id`),
  CONSTRAINT `licence_driver_fk` FOREIGN KEY (`driver_id`) REFERENCES `driver` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `licence_employee_fk` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `trip_id` int(11) NOT NULL,
  `discount_id` varchar(255) DEFAULT NULL,
  `total_amount` int(12) NOT NULL,
  `amount` int(12) NOT NULL,
  `from_ewallet_id` int(11) NOT NULL,
  `to_ewallet_id` int(11) NOT NULL,
  `luquidation_type` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_from_ewallet_fk_idx` (`from_ewallet_id`),
  KEY `payment_to_ewallet_fk_idx` (`to_ewallet_id`),
  CONSTRAINT `payment_from_ewallet_fk` FOREIGN KEY (`from_ewallet_id`) REFERENCES `ewallet` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payment_to_ewallet_fk` FOREIGN KEY (`to_ewallet_id`) REFERENCES `ewallet` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report` (
  `id` int(13) NOT NULL,
  `type` varchar(255) NOT NULL,
  `subcategory` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `user_id` varchar(255) NOT NULL,
  `trip_id` int(11) NOT NULL,
  `review_id` int(13) NOT NULL,
  PRIMARY KEY (`user_id`,`trip_id`),
  KEY `review_report_fk_idx` (`review_id`),
  KEY `review_trip_fk` (`trip_id`),
  CONSTRAINT `review_emergency_fk` FOREIGN KEY (`review_id`) REFERENCES `emergency` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `review_report_fk` FOREIGN KEY (`review_id`) REFERENCES `report` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `review_trip_fk` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `review_tripreview_fk` FOREIGN KEY (`review_id`) REFERENCES `trip_review` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `session_user_fk_idx` (`username`),
  CONSTRAINT `session_user_fk` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `share_route_details`
--

DROP TABLE IF EXISTS `share_route_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `share_route_details` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `trip_id` int(11) NOT NULL,
  `route` json NOT NULL,
  `price` int(12) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `shareroute_trip_fk` (`trip_id`),
  CONSTRAINT `shareroute_trip_fk` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trip`
--

DROP TABLE IF EXISTS `trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trip` (
  `id` int(11) NOT NULL,
  `owner_id` varchar(255) NOT NULL,
  `discount_id` varchar(255) DEFAULT NULL,
  `vehicle_id` int(11) DEFAULT NULL,
  `payment_id` int(8) DEFAULT NULL,
  `whole_trip_price` int(12) DEFAULT NULL,
  `open_price` int(12) DEFAULT NULL,
  `avg_price` int(12) DEFAULT NULL,
  `route` json NOT NULL,
  PRIMARY KEY (`id`),
  KEY `trip_owner_fk_idx` (`owner_id`),
  KEY `trip_vehicle_fk_idx` (`vehicle_id`),
  KEY `trip_discount_fk` (`discount_id`,`owner_id`),
  CONSTRAINT `trip_discount_fk` FOREIGN KEY (`discount_id`, `owner_id`) REFERENCES `discount` (`id`, `owner_id`),
  CONSTRAINT `trip_owner_fk` FOREIGN KEY (`owner_id`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `trip_vehicle_fk` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trip_review`
--

DROP TABLE IF EXISTS `trip_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trip_review` (
  `id` int(13) NOT NULL,
  `rating` float(2,1) NOT NULL,
  `improve_category` varchar(255) DEFAULT NULL,
  `comment` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `potrait_img_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `vehicle_driver_fk_idx` (`driver_id`),
  KEY `vehicle_employee_fk_idx` (`employee_id`),
  CONSTRAINT `vehicle_driver_fk` FOREIGN KEY (`driver_id`) REFERENCES `driver` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `vehicle_employee_fk` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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

-- Dump completed on 2019-11-18  3:07:46
