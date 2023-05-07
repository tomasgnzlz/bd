CREATE DATABASE  IF NOT EXISTS `bdmuseo2021` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `bdmuseo2021`;
-- MySQL dump 10.13  Distrib 5.5.49, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: bdmuseo2021
-- ------------------------------------------------------
-- Server version	5.5.49-0ubuntu0.14.04.1

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
-- Table structure for table `salas`
--

DROP TABLE IF EXISTS `salas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salas` (
  `codsala` int(11) NOT NULL,
  `nomsala` varchar(50) DEFAULT NULL,
  `ubicacion` char(3) DEFAULT NULL,
  PRIMARY KEY (`codsala`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salas`
--

LOCK TABLES `salas` WRITE;
/*!40000 ALTER TABLE `salas` DISABLE KEYS */;
INSERT INTO `salas` VALUES (1,'primera sala','101'),(2,'segunda sala','102'),(3,'tercera sala','103'),(4,'cuarta sala','201'),(5,'quinta sala','202'),(6,'almacén1','308'),(7,'almacén 2','309'),(8,'despacho restauración 1','308'),(9,'despacho restauración 2','307');
/*!40000 ALTER TABLE `salas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artistas`
--

DROP TABLE IF EXISTS `artistas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artistas` (
  `codartista` int(11) NOT NULL,
  `nomartista` varchar(50) NOT NULL,
  `fecnacim` date DEFAULT NULL,
  `fecfallec` date DEFAULT NULL,
  `biografia` mediumtext,
  PRIMARY KEY (`codartista`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artistas`
--

LOCK TABLES `artistas` WRITE;
/*!40000 ALTER TABLE `artistas` DISABLE KEYS */;
INSERT INTO `artistas` VALUES (1,'Vicent van Goh',NULL,NULL,''),(2,'Eva Gonzales',NULL,NULL,''),(3,'Rafael Mengs',NULL,NULL,''),(4,'Pablo Ruiz Picasso',NULL,NULL,''),(5,'Salvador Dalí',NULL,NULL,''),(6,'Joan Miró',NULL,NULL,'');
/*!40000 ALTER TABLE `artistas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empsegur`
--

DROP TABLE IF EXISTS `empsegur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empsegur` (
  `codsegur` int(11) NOT NULL,
  `nomsegur` varchar(50) NOT NULL,
  `ape1segur` varchar(50) NOT NULL,
  `ape2segur` varchar(50) DEFAULT NULL,
  `dnisegur` char(9) DEFAULT NULL,
  `codsala` int(11) DEFAULT NULL,
  PRIMARY KEY (`codsegur`),
  CONSTRAINT fk_empsegur_salas foreign key (codsala) references salas(codsala)
	on delete no action on update cascade
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empsegur`
--

LOCK TABLES `empsegur` WRITE;
/*!40000 ALTER TABLE `empsegur` DISABLE KEYS */;
INSERT INTO `empsegur` VALUES (1,'PEPA','PEREZ',NULL,NULL,1),(2,'JUAN','LOPEZ',NULL,NULL,1),(3,'ANA','GARCIA',NULL,NULL,2),(4,'JULIA','VARGAS',NULL,NULL,1),(5,'PEPA','CANALES	',NULL,NULL,3),(6,'JUANA','RODRIGUEZ','PEREZ',NULL,4),(7,'LUISA','GOMEZ',NULL,NULL,5),(8,'CESAR','PONS',NULL,NULL,6),(9,'MARIO','LASA',NULL,NULL,6),(10,'LUCIANO','TEROL',NULL,NULL,5),(11,'JULIO','PEREZ',NULL,NULL,6),(12,'AUREO','AGUIRRE	',NULL,NULL,7),(13,'MARCOS','PEREZ',NULL,NULL,5),(14,'JULIANA','VEIGA',NULL,NULL,8),(15,'PILAR','GALVEZ',NULL,NULL,9),(16,'LAVINIA','SANZ',NULL,NULL,2),(17,'ADRIANA','ALBA',NULL,NULL,2),(18,'ANTONIO','LOPEZ',NULL,NULL,4),(19,'OCTAVIO','GARCIA',NULL,NULL,5),(20,'DOROTEA','FLOR',NULL,NULL,7),(21,'OTILIA','POLO',NULL,NULL,7),(22,'GLORIA','GUIL',NULL,NULL,8),(23,'AUGUSTO','GARCIA',NULL,NULL,8),(24,'CORNELIO','SANZ',NULL,NULL,8),(25,'DORINDA','LARA',NULL,NULL,9),(26,'FABIOLA','RUIZ',NULL,NULL,9),(27,'MICAELA','MARTIN',NULL,NULL,7),(28,'CARMEN','MORAN',NULL,NULL,8),(29,'LUCRECIA','LARA',NULL,NULL,1),(30,'AZUCENA','MUÑOZ',NULL,NULL,2),(31,'CLAUDIA','FIERRO',NULL,NULL,3),(32,'VALERIANA','MORA',NULL,NULL,3),(33,'LIVIA','DURAN',NULL,NULL,4),(34,'DIANA','PINO',NULL,NULL,4),(35,'HONORIA','TORRES',NULL,NULL,5);
/*!40000 ALTER TABLE `empsegur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estilos`
--

DROP TABLE IF EXISTS `estilos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estilos` (
  `codestilo` int(11) NOT NULL,
  `desestilo` varchar(100) NOT NULL,
  `epoca` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codestilo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estilos`
--

LOCK TABLES `estilos` WRITE;
/*!40000 ALTER TABLE `estilos` DISABLE KEYS */;
INSERT INTO `estilos` VALUES (1,'ABSTRACTO',NULL),(2,'REALISMO',NULL),(3,'SURREALISMO',NULL),(4,'IMPRESIONISMO',NULL),(5,'BARROCO',NULL),(6,'POP',NULL),(7,'EXPRESIONISMO',NULL),(8,'DETALLISMO',NULL),(9,'NEOCLASICISMO',NULL);
/*!40000 ALTER TABLE `estilos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tiposobras`
--

DROP TABLE IF EXISTS `tiposobras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tiposobras` (
  `codtipo` int(11) NOT NULL,
  `destipo` varchar(50) NOT NULL,
  PRIMARY KEY (`codtipo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tiposobras`
--

LOCK TABLES `tiposobras` WRITE;
/*!40000 ALTER TABLE `tiposobras` DISABLE KEYS */;
INSERT INTO `tiposobras` VALUES (1,'PINTURA'),(2,'ESCULTURA');
/*!40000 ALTER TABLE `tiposobras` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `obras`
--

DROP TABLE IF EXISTS `obras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obras` (
  `codobra` int(11) NOT NULL,
  `nombreobra` varchar(100) NOT NULL,
  `codartista` int(11) DEFAULT NULL,
  `codtipo` int(11) DEFAULT NULL,
  `codestilo` int(11) DEFAULT NULL,
  `valoracion` decimal(19,2) DEFAULT NULL,
  `codsala` int(11) DEFAULT NULL,
  `nrestauraciones` tinyint(3) unsigned DEFAULT NULL,
  `estado` set('ok','def_1','def_2','def_3') DEFAULT NULL,
  `sigrevision` date DEFAULT '2016-06-16',
  `fecadquisicion` date DEFAULT '1990-02-01',
  PRIMARY KEY (`codobra`),
  CONSTRAINT fk_obras_estilos foreign key (codestilo) references estilos (codestilo)
	on delete no action on update cascade,
  CONSTRAINT fk_obras_artistas foreign key (codartista) references artistas (codartista)
	on delete no action on update cascade,
  CONSTRAINT fk_obras_tiposobras foreign key (codtipo) references tiposobras (codtipo)
	on delete no action on update cascade,
   CONSTRAINT fk_obras_salas foreign key (codsala) references salas(codsala)
	on delete no action on update cascade
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obras`
--

LOCK TABLES `obras` WRITE;
/*!40000 ALTER TABLE `obras` DISABLE KEYS */;
INSERT INTO `obras` VALUES (1,'LA MASÍA',6,1,8,700000.00,1,0,'ok','2016-06-16','1990-02-01'),(2,'CABEZA DE FUMADOR',6,1,3,400000.00,1,1,'ok','2016-06-16','1995-09-01'),(3,'LA PERSISTENCIA DE LA MEMORIA',5,1,3,NULL,2,0,'ok','2016-08-16','1992-02-21'),(4,'TRITÓN ALADO',5,2,3,NULL,3,1,'ok','2016-06-16','1991-05-05'),(5,'ANGEL SURREALISTA',5,2,3,NULL,3,3,'ok','2016-06-16','1990-02-01'),(6,'LA SOMBRERERA',2,1,4,NULL,2,2,'ok','2016-06-16','2012-03-08'),(7,'GRANJA EN REBAIS',2,1,4,NULL,1,0,'ok','2016-06-20','2000-05-15'),(8,'TE POR LA TARDE',2,1,4,NULL,5,0,'ok','2016-06-16','2015-01-30'),(9,'EL TRIUNFO DE LA AURORA',3,1,9,NULL,4,1,'ok','2016-06-16','2001-12-01');
/*!40000 ALTER TABLE `obras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obrasmasbuscadas`
--

DROP TABLE IF EXISTS `obrasmasbuscadas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obrasmasbuscadas` (
  `codobrabuscada` int(11) NOT NULL,
  `nomobrabuscada` varchar(100) DEFAULT NULL,
  `codtipo` int(11) DEFAULT NULL,
  `codestilo` int(11) DEFAULT NULL,
  `codartista` int(11) DEFAULT NULL,
  PRIMARY KEY (`codobrabuscada`),
   CONSTRAINT fk_obrasmasbuscadas_estilos foreign key (codestilo) references estilos (codestilo)
	on delete no action on update cascade,
  CONSTRAINT fk_obrasmasbuscadas_artistas foreign key (codartista) references artistas (codartista)
	on delete no action on update cascade,
  CONSTRAINT fk_obrasmasbuscadas_tiposobras foreign key (codtipo) references tiposobras (codtipo)
	on delete no action on update cascade
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obrasmasbuscadas`
--

LOCK TABLES `obrasmasbuscadas` WRITE;
/*!40000 ALTER TABLE `obrasmasbuscadas` DISABLE KEYS */;
/*!40000 ALTER TABLE `obrasmasbuscadas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restauraciones`
--

DROP TABLE IF EXISTS `restauraciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restauraciones` (
  `codobra` int(11) NOT NULL DEFAULT '0',
  `codrestaurador` int(11) NOT NULL DEFAULT '0',
  `fecinirest` date NOT NULL DEFAULT '0000-00-00',
  `fecprevrest` date DEFAULT NULL,
  `fecfinrest` date DEFAULT NULL,
  PRIMARY KEY (`codobra`,`codrestaurador`,`fecinirest`),
  KEY `fk_restauraciones_restarurador` (`codrestaurador`),
  CONSTRAINT `fk_restauraciones_obra` FOREIGN KEY (`codobra`) REFERENCES `obras` (`codobra`),
  CONSTRAINT `fk_restauraciones_restarurador` FOREIGN KEY (`codrestaurador`) REFERENCES `restaurador` (`codres`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restauraciones`
--

LOCK TABLES `restauraciones` WRITE;
/*!40000 ALTER TABLE `restauraciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `restauraciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurador`
--

DROP TABLE IF EXISTS `restaurador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurador` (
  `codres` int(11) NOT NULL,
  `nomres` varchar(100) DEFAULT NULL,
  `ape1res` varchar(100) DEFAULT NULL,
  `ape2res` varchar(100) DEFAULT NULL,
  `especialidad` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`codres`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurador`
--

LOCK TABLES `restaurador` WRITE;
/*!40000 ALTER TABLE `restaurador` DISABLE KEYS */;
INSERT INTO `restaurador` VALUES (1,'MARÍA','VALLE','DEL RÍO','Salvador Dalí'),(2,'JAVIER','LÓPEZ','CAMPOS','Expresionistas');
/*!40000 ALTER TABLE `restaurador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revisiones`
--

DROP TABLE IF EXISTS `revisiones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revisiones` (
  `codrevision` int(11) NOT NULL,
  `codobra` int(11) DEFAULT NULL,
  `codres` int(11) DEFAULT NULL,
  `fecharevision` date DEFAULT NULL,
  `observaciones` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`codrevision`),
  KEY `fk_revisiones_obras` (`codobra`),
  KEY `fk_revisiones_restauradores` (`codres`),
  CONSTRAINT `fk_revisiones_obras` FOREIGN KEY (`codobra`) REFERENCES `obras` (`codobra`),
  CONSTRAINT `fk_revisiones_restauradores` FOREIGN KEY (`codres`) REFERENCES `restaurador` (`codres`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revisiones`
--

LOCK TABLES `revisiones` WRITE;
/*!40000 ALTER TABLE `revisiones` DISABLE KEYS */;
/*!40000 ALTER TABLE `revisiones` ENABLE KEYS */;
UNLOCK TABLES;

