-- MySQL dump 10.13  Distrib 5.7.22, for Win64 (x86_64)
--
-- Host: localhost    Database: sched
-- ------------------------------------------------------
-- Server version	5.7.22-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `streetaddress` varchar(255) DEFAULT NULL,
  `postcode` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `address_id_uindex` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subeventId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `booking_id_uindex` (`id`),
  KEY `booking_user_id_fk` (`userId`),
  KEY `booking_subevent_id_fk` (`subeventId`),
  CONSTRAINT `booking_subevent_id_fk` FOREIGN KEY (`subeventId`) REFERENCES `subevent` (`id`),
  CONSTRAINT `booking_user_id_fk` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `event_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,'Konsertti1'),(2,'Konsertti2'),(3,'NotAvailable'),(4,'TestikonserttiMuutettu'),(6,'Lisäystestikonsertti'),(8,'Testikonsertti'),(9,'Testikonsertti'),(10,'Uusi testikonsertti'),(11,'Testikonsertti'),(12,'Testikonsertti'),(13,'Testikonsertti');
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventwork`
--

DROP TABLE IF EXISTS `eventwork`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventwork` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eventId` int(11) DEFAULT NULL,
  `workId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `eventwork_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventwork`
--

LOCK TABLES `eventwork` WRITE;
/*!40000 ALTER TABLE `eventwork` DISABLE KEYS */;
INSERT INTO `eventwork` VALUES (1,1,1),(2,1,2),(3,1,3);
/*!40000 ALTER TABLE `eventwork` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `place`
--

DROP TABLE IF EXISTS `place`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `place` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `addressId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `place_id_uindex` (`id`),
  KEY `place_address_id_fk` (`addressId`),
  CONSTRAINT `place_address_id_fk` FOREIGN KEY (`addressId`) REFERENCES `address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `place`
--

LOCK TABLES `place` WRITE;
/*!40000 ALTER TABLE `place` DISABLE KEYS */;
INSERT INTO `place` VALUES (1,'Konserttisali',NULL),(2,'Harjoitussali',NULL);
/*!40000 ALTER TABLE `place` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Viulisti',1),(2,'Sopraano',7),(3,'Alttoviulisti',1),(4,'Sellisti',1),(5,'Mezzosopraano',7),(6,'Pianisti',6),(7,'Konserttisihteeri',9),(8,'Järjestäjä',9),(9,'Autonkuljettaja',9),(10,'Kontrabasisti',1),(11,'Lyömäsoittaja',4),(12,'Klarinetisti',2),(13,'Sivunkääntäjä',9),(14,'Pianonvirittäjä',9);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rolecategory`
--

DROP TABLE IF EXISTS `rolecategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rolecategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rolecategory_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rolecategory`
--

LOCK TABLES `rolecategory` WRITE;
/*!40000 ALTER TABLE `rolecategory` DISABLE KEYS */;
INSERT INTO `rolecategory` VALUES (1,'Jousisoittimet'),(2,'Puupuhaltimet'),(3,'Vaskipuhaltimet'),(4,'Lyömäsoittimet'),(5,'Kielisoittimet'),(6,'Kosketinsoittimet'),(7,'Laulu'),(8,'Muut'),(9,'Tukihenkilöstö');
/*!40000 ALTER TABLE `rolecategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subevent`
--

DROP TABLE IF EXISTS `subevent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subevent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `begin` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `placeId` int(11) DEFAULT NULL,
  `eventId` int(11) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subevent_id_uindex` (`id`),
  KEY `subevent_event_id_fk` (`eventId`),
  CONSTRAINT `subevent_event_id_fk` FOREIGN KEY (`eventId`) REFERENCES `event` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subevent`
--

LOCK TABLES `subevent` WRITE;
/*!40000 ALTER TABLE `subevent` DISABLE KEYS */;
INSERT INTO `subevent` VALUES (1,'saliharjoitus','2019-07-06 15:00:00','2019-07-06 18:00:00',1,1,'harjoitus'),(2,'konsertti 1','2019-07-06 19:00:00','2019-07-06 21:00:00',1,1,'konsertti'),(3,'harjoitus','2019-07-05 11:00:00','2019-07-05 15:00:00',2,1,'harjoitus'),(4,'poissa','2019-07-06 00:00:00','2019-07-06 15:00:00',NULL,3,'poissaolo');
/*!40000 ALTER TABLE `subevent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subeventcast`
--

DROP TABLE IF EXISTS `subeventcast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subeventcast` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subeventId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL,
  `workId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `eventcast_id_uindex` (`id`),
  KEY `eventcast_role_id_fk` (`roleId`),
  KEY `eventcast_user_id_fk` (`userId`),
  KEY `subeventcast_subevent_id_fk` (`subeventId`),
  KEY `subeventcast_work_id_fk` (`workId`),
  CONSTRAINT `eventcast_role_id_fk` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`),
  CONSTRAINT `eventcast_user_id_fk` FOREIGN KEY (`userId`) REFERENCES `user` (`id`),
  CONSTRAINT `subeventcast_subevent_id_fk` FOREIGN KEY (`subeventId`) REFERENCES `subevent` (`id`),
  CONSTRAINT `subeventcast_work_id_fk` FOREIGN KEY (`workId`) REFERENCES `work` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subeventcast`
--

LOCK TABLES `subeventcast` WRITE;
/*!40000 ALTER TABLE `subeventcast` DISABLE KEYS */;
INSERT INTO `subeventcast` VALUES (1,3,NULL,1,NULL),(2,3,NULL,1,NULL),(3,3,NULL,3,NULL),(4,3,NULL,4,NULL),(5,1,NULL,1,NULL),(6,1,NULL,1,NULL),(7,1,NULL,3,NULL),(8,1,NULL,4,NULL),(9,1,NULL,5,NULL),(10,1,NULL,6,NULL),(11,2,NULL,1,NULL),(12,2,NULL,1,NULL),(13,2,NULL,3,NULL),(14,2,NULL,4,NULL),(15,2,NULL,5,NULL),(16,2,NULL,6,NULL),(17,2,NULL,7,NULL),(18,2,NULL,8,NULL),(19,4,3,NULL,NULL),(20,4,4,NULL,NULL);
/*!40000 ALTER TABLE `subeventcast` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `userLevel` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Muusikko1',3),(2,'Muusikko2',3),(3,'Muusikko3',3),(4,'Muusikko4',3),(5,'Muusikko5',3),(6,'Muusikko6',3),(7,'Muusikko7',3),(8,'Muusikko8',3),(9,'SuperAdmin',1),(10,'Admin',2),(11,'Järjestäjä',3),(12,'Konserttisihteeri',2);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userrole`
--

DROP TABLE IF EXISTS `userrole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userrole` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userrole_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userrole`
--

LOCK TABLES `userrole` WRITE;
/*!40000 ALTER TABLE `userrole` DISABLE KEYS */;
INSERT INTO `userrole` VALUES (1,1,1),(2,1,2),(3,3,3),(4,4,4),(5,5,5),(6,6,6),(7,7,12),(8,8,11),(9,10,7),(10,11,8),(11,2,4);
/*!40000 ALTER TABLE `userrole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work`
--

DROP TABLE IF EXISTS `work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `work` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `work` varchar(255) DEFAULT NULL,
  `composer` varchar(255) DEFAULT NULL,
  `instrumentation` varchar(255) DEFAULT NULL,
  `musicians` int(11) DEFAULT NULL,
  `durationInMinutes` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `work_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work`
--

LOCK TABLES `work` WRITE;
/*!40000 ALTER TABLE `work` DISABLE KEYS */;
INSERT INTO `work` VALUES (1,'Jousikvartetto','Schumann','2vl, 1vla, 1vcl',4,32),(2,'Gretchen am Spinnrade','Schubert','1s, 1pf',2,5),(3,'Tilausteos','Nuori säveltäjä','1s, 2vl, 1vla, 1vcl, 1pf',6,35);
/*!40000 ALTER TABLE `work` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-08-27 13:54:38
