CREATE DATABASE  IF NOT EXISTS `ourtrips` /*!40100 DEFAULT CHARACTER SET utf8 */;
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
  `on_vehicle` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `driver_vehicle_work_fk_idx` (`on_vehicle`),
  CONSTRAINT `driver_vehicle_work_fk` FOREIGN KEY (`on_vehicle`) REFERENCES `vehicle` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `invitations`
--

DROP TABLE IF EXISTS `invitations`;
/*!50001 DROP VIEW IF EXISTS `invitations`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `invitations` AS SELECT 
 1 AS `trip_id`,
 1 AS `owner_id`,
 1 AS `discount_id`,
 1 AS `payment_id`,
 1 AS `whole_trip_price`,
 1 AS `avg_price`,
 1 AS `route`,
 1 AS `road_length`,
 1 AS `inviting_vehicle`,
 1 AS `vehicle_id`,
 1 AS `brand`,
 1 AS `type`,
 1 AS `vehicle_name`,
 1 AS `engine_cap`,
 1 AS `color`,
 1 AS `gross_ton`,
 1 AS `total_weight`,
 1 AS `n_passengers`,
 1 AS `pic_l`,
 1 AS `pic_r`,
 1 AS `pic_f`,
 1 AS `pic_rr`,
 1 AS `approval_status`,
 1 AS `approval_due_date`,
 1 AS `trip_open_price`,
 1 AS `trip_price`,
 1 AS `wait_price`,
 1 AS `driver_id`,
 1 AS `employee_id`,
 1 AS `city`,
 1 AS `district`,
 1 AS `address_line1`,
 1 AS `address_line2`,
 1 AS `driver_name`,
 1 AS `gender`,
 1 AS `dob`,
 1 AS `email`,
 1 AS `address`,
 1 AS `tel`,
 1 AS `nationality`,
 1 AS `potrait_img_url`,
 1 AS `location`*/;
SET character_set_client = @saved_cs_client;

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
-- Table structure for table `on_trip`
--

DROP TABLE IF EXISTS `on_trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `on_trip` (
  `user_id` varchar(255) NOT NULL,
  `trip_id` int(11) NOT NULL,
  `geton_location` point DEFAULT NULL,
  `getoff_location` point DEFAULT NULL,
  PRIMARY KEY (`user_id`,`trip_id`)
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
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8;
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
  `route` linestring NOT NULL,
  `avg_price` int(12) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `shareroute_trip_fk` (`trip_id`),
  CONSTRAINT `shareroute_trip_fk` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
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
  `inviting_vehicle` int(11) DEFAULT NULL,
  `road_length` float(4,3) DEFAULT NULL,
  `share` tinyint(4) NOT NULL,
  `state` varchar(45) NOT NULL,
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
-- Temporary view structure for view `trip_driver`
--

DROP TABLE IF EXISTS `trip_driver`;
/*!50001 DROP VIEW IF EXISTS `trip_driver`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `trip_driver` AS SELECT 
 1 AS `driver_id`,
 1 AS `city`,
 1 AS `district`,
 1 AS `address_line1`,
 1 AS `address_line2`,
 1 AS `on_vehicle`,
 1 AS `username`,
 1 AS `name`,
 1 AS `gender`,
 1 AS `dob`,
 1 AS `email`,
 1 AS `address`,
 1 AS `tel`,
 1 AS `nationality`,
 1 AS `role`,
 1 AS `potrait_img_url`,
 1 AS `location`,
 1 AS `id`,
 1 AS `owner_id`,
 1 AS `discount_id`,
 1 AS `vehicle_id`,
 1 AS `payment_id`,
 1 AS `whole_trip_price`,
 1 AS `open_price`,
 1 AS `avg_price`,
 1 AS `route`,
 1 AS `inviting_vehicle`,
 1 AS `road_length`,
 1 AS `share`,
 1 AS `state`*/;
SET character_set_client = @saved_cs_client;

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
  `location` point DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `user_driver`
--

DROP TABLE IF EXISTS `user_driver`;
/*!50001 DROP VIEW IF EXISTS `user_driver`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `user_driver` AS SELECT 
 1 AS `id`,
 1 AS `city`,
 1 AS `district`,
 1 AS `address_line1`,
 1 AS `address_line2`,
 1 AS `on_vehicle`,
 1 AS `username`,
 1 AS `name`,
 1 AS `gender`,
 1 AS `dob`,
 1 AS `email`,
 1 AS `address`,
 1 AS `tel`,
 1 AS `nationality`,
 1 AS `role`,
 1 AS `potrait_img_url`,
 1 AS `location`*/;
SET character_set_client = @saved_cs_client;

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `working_driver`
--

DROP TABLE IF EXISTS `working_driver`;
/*!50001 DROP VIEW IF EXISTS `working_driver`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `working_driver` AS SELECT 
 1 AS `driver_id`,
 1 AS `city`,
 1 AS `district`,
 1 AS `address_line1`,
 1 AS `address_line2`,
 1 AS `on_vehicle`,
 1 AS `username`,
 1 AS `name`,
 1 AS `gender`,
 1 AS `dob`,
 1 AS `email`,
 1 AS `address`,
 1 AS `tel`,
 1 AS `nationality`,
 1 AS `role`,
 1 AS `potrait_img_url`,
 1 AS `location`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `world_points`
--

DROP TABLE IF EXISTS `world_points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `world_points` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `admin` varchar(255) DEFAULT NULL,
  `scalerank` int(11) DEFAULT NULL,
  `datarank` int(11) DEFAULT NULL,
  `coords` point NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'ourtrips'
--

--
-- Dumping routines for database 'ourtrips'
--

--
-- Final view structure for view `invitations`
--

/*!50001 DROP VIEW IF EXISTS `invitations`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ourtrips_be`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `invitations` AS select `t`.`id` AS `trip_id`,`t`.`owner_id` AS `owner_id`,`t`.`discount_id` AS `discount_id`,`t`.`payment_id` AS `payment_id`,`t`.`whole_trip_price` AS `whole_trip_price`,`t`.`avg_price` AS `avg_price`,`t`.`route` AS `route`,`t`.`road_length` AS `road_length`,`t`.`inviting_vehicle` AS `inviting_vehicle`,`v`.`id` AS `vehicle_id`,`v`.`brand` AS `brand`,`v`.`type` AS `type`,`v`.`name` AS `vehicle_name`,`v`.`engine_cap` AS `engine_cap`,`v`.`color` AS `color`,`v`.`gross_ton` AS `gross_ton`,`v`.`total_weight` AS `total_weight`,`v`.`n_passengers` AS `n_passengers`,`v`.`pic_l` AS `pic_l`,`v`.`pic_r` AS `pic_r`,`v`.`pic_f` AS `pic_f`,`v`.`pic_rr` AS `pic_rr`,`v`.`approval_status` AS `approval_status`,`v`.`approval_due_date` AS `approval_due_date`,`v`.`open_price` AS `trip_open_price`,`v`.`trip_price` AS `trip_price`,`v`.`wait_price` AS `wait_price`,`v`.`driver_id` AS `driver_id`,`v`.`employee_id` AS `employee_id`,`d`.`city` AS `city`,`d`.`district` AS `district`,`d`.`address_line1` AS `address_line1`,`d`.`address_line2` AS `address_line2`,'d.name' AS `driver_name`,'d.gender' AS `gender`,'d.dob' AS `dob`,'d.email' AS `email`,'d.address' AS `address`,'d.tel' AS `tel`,'d.nationality' AS `nationality`,'d.potrait_img_url' AS `potrait_img_url`,'d.location' AS `location` from ((`trip` `t` join `vehicle` `v` on((`t`.`inviting_vehicle` = `v`.`id`))) join `driver` `d` on((`d`.`id` = `v`.`driver_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `trip_driver`
--

/*!50001 DROP VIEW IF EXISTS `trip_driver`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ourtrips_be`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `trip_driver` AS select `w`.`driver_id` AS `driver_id`,`w`.`city` AS `city`,`w`.`district` AS `district`,`w`.`address_line1` AS `address_line1`,`w`.`address_line2` AS `address_line2`,`w`.`on_vehicle` AS `on_vehicle`,`w`.`username` AS `username`,`w`.`name` AS `name`,`w`.`gender` AS `gender`,`w`.`dob` AS `dob`,`w`.`email` AS `email`,`w`.`address` AS `address`,`w`.`tel` AS `tel`,`w`.`nationality` AS `nationality`,`w`.`role` AS `role`,`w`.`potrait_img_url` AS `potrait_img_url`,`w`.`location` AS `location`,`t`.`id` AS `id`,`t`.`owner_id` AS `owner_id`,`t`.`discount_id` AS `discount_id`,`t`.`vehicle_id` AS `vehicle_id`,`t`.`payment_id` AS `payment_id`,`t`.`whole_trip_price` AS `whole_trip_price`,`t`.`open_price` AS `open_price`,`t`.`avg_price` AS `avg_price`,`t`.`route` AS `route`,`t`.`inviting_vehicle` AS `inviting_vehicle`,`t`.`road_length` AS `road_length`,`t`.`share` AS `share`,`t`.`state` AS `state` from (`working_driver` `w` join `trip` `t` on((`w`.`on_vehicle` = `t`.`vehicle_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_driver`
--

/*!50001 DROP VIEW IF EXISTS `user_driver`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ourtrips_be`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `user_driver` AS select `d`.`id` AS `id`,`d`.`city` AS `city`,`d`.`district` AS `district`,`d`.`address_line1` AS `address_line1`,`d`.`address_line2` AS `address_line2`,`d`.`on_vehicle` AS `on_vehicle`,`u`.`username` AS `username`,`u`.`name` AS `name`,`u`.`gender` AS `gender`,`u`.`dob` AS `dob`,`u`.`email` AS `email`,`u`.`address` AS `address`,`u`.`tel` AS `tel`,`u`.`nationality` AS `nationality`,`u`.`role` AS `role`,`u`.`potrait_img_url` AS `potrait_img_url`,`u`.`location` AS `location` from (`driver` `d` join `user` `u` on((`d`.`id` = `u`.`username`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `working_driver`
--

/*!50001 DROP VIEW IF EXISTS `working_driver`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ourtrips_be`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `working_driver` AS select `user_driver`.`id` AS `driver_id`,`user_driver`.`city` AS `city`,`user_driver`.`district` AS `district`,`user_driver`.`address_line1` AS `address_line1`,`user_driver`.`address_line2` AS `address_line2`,`user_driver`.`on_vehicle` AS `on_vehicle`,`user_driver`.`username` AS `username`,`user_driver`.`name` AS `name`,`user_driver`.`gender` AS `gender`,`user_driver`.`dob` AS `dob`,`user_driver`.`email` AS `email`,`user_driver`.`address` AS `address`,`user_driver`.`tel` AS `tel`,`user_driver`.`nationality` AS `nationality`,`user_driver`.`role` AS `role`,`user_driver`.`potrait_img_url` AS `potrait_img_url`,`user_driver`.`location` AS `location` from `user_driver` where (`user_driver`.`on_vehicle` is not null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-24 22:03:41
