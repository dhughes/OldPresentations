-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.51a


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema ReactorExamples
--

CREATE DATABASE IF NOT EXISTS ReactorExamples;
USE ReactorExamples;

--
-- Definition of table `ReactorExamples`.`Address`
--

DROP TABLE IF EXISTS `ReactorExamples`.`Address`;
CREATE TABLE  `ReactorExamples`.`Address` (
  `addressId` int(10) NOT NULL auto_increment,
  `street` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `postalCode` varchar(20) NOT NULL,
  `country` varchar(50) NOT NULL,
  PRIMARY KEY  (`addressId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ReactorExamples`.`Address`
--

/*!40000 ALTER TABLE `Address` DISABLE KEYS */;
LOCK TABLES `Address` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `Address` ENABLE KEYS */;


--
-- Definition of table `ReactorExamples`.`Customer`
--

DROP TABLE IF EXISTS `ReactorExamples`.`Customer`;
CREATE TABLE  `ReactorExamples`.`Customer` (
  `customerId` int(10) NOT NULL auto_increment,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `addressId` int(10) default NULL,
  PRIMARY KEY  (`customerId`),
  KEY `FK_Customer_Address` (`addressId`),
  CONSTRAINT `FK_Customer_Address` FOREIGN KEY (`addressId`) REFERENCES `address` (`addressId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ReactorExamples`.`Customer`
--

/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
LOCK TABLES `Customer` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;


--
-- Definition of table `ReactorExamples`.`Invoice`
--

DROP TABLE IF EXISTS `ReactorExamples`.`Invoice`;
CREATE TABLE  `ReactorExamples`.`Invoice` (
  `invoiceId` int(10) NOT NULL auto_increment,
  `customerId` int(10) NOT NULL,
  `total` decimal(19,4) NOT NULL,
  `invoiceDate` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`invoiceId`),
  KEY `FK_Invoice_Customer` (`customerId`),
  CONSTRAINT `FK_Invoice_Customer` FOREIGN KEY (`customerId`) REFERENCES `customer` (`customerId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ReactorExamples`.`Invoice`
--

/*!40000 ALTER TABLE `Invoice` DISABLE KEYS */;
LOCK TABLES `Invoice` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `Invoice` ENABLE KEYS */;


--
-- Definition of table `ReactorExamples`.`InvoiceProduct`
--

DROP TABLE IF EXISTS `ReactorExamples`.`InvoiceProduct`;
CREATE TABLE  `ReactorExamples`.`InvoiceProduct` (
  `invoiceProductId` int(10) NOT NULL auto_increment,
  `invoiceId` int(10) NOT NULL,
  `productId` int(10) NOT NULL,
  PRIMARY KEY  (`invoiceProductId`),
  KEY `FK_InvoiceProduct_Invoice` (`invoiceId`),
  KEY `FK_InvoiceProduct_Product` (`productId`),
  CONSTRAINT `FK_InvoiceProduct_Invoice` FOREIGN KEY (`invoiceId`) REFERENCES `invoice` (`invoiceId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_InvoiceProduct_Product` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ReactorExamples`.`InvoiceProduct`
--

/*!40000 ALTER TABLE `InvoiceProduct` DISABLE KEYS */;
LOCK TABLES `InvoiceProduct` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `InvoiceProduct` ENABLE KEYS */;


--
-- Definition of table `ReactorExamples`.`Product`
--

DROP TABLE IF EXISTS `ReactorExamples`.`Product`;
CREATE TABLE  `ReactorExamples`.`Product` (
  `productId` int(10) NOT NULL auto_increment,
  `name` varchar(50) character set utf8 NOT NULL,
  `description` longtext NOT NULL,
  `price` decimal(19,4) NOT NULL,
  PRIMARY KEY  (`productId`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ReactorExamples`.`Product`
--

/*!40000 ALTER TABLE `Product` DISABLE KEYS */;
LOCK TABLES `Product` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `Product` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
