CREATE DATABASE  IF NOT EXISTS `cinePedia` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cinePedia`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: cinepedia
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `comentarios`
--

DROP TABLE IF EXISTS `comentarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comentarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_id` int NOT NULL,
  `pelicula_id` int NOT NULL,
  `contenido` text,
  PRIMARY KEY (`id`,`usuario_id`,`pelicula_id`),
  KEY `fk_usuarios_has_peliculas_peliculas1_idx` (`pelicula_id`),
  KEY `fk_usuarios_has_peliculas_usuarios_idx` (`usuario_id`),
  CONSTRAINT `fk_usuarios_has_peliculas_peliculas1` FOREIGN KEY (`pelicula_id`) REFERENCES `peliculas` (`id_pelicula`),
  CONSTRAINT `fk_usuarios_has_peliculas_usuarios` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comentarios`
--

LOCK TABLES `comentarios` WRITE;
/*!40000 ALTER TABLE `comentarios` DISABLE KEYS */;
INSERT INTO `comentarios` VALUES (5,'2024-12-12 00:56:43',1,8,'la mejor'),(7,'2024-12-12 20:13:48',3,8,'Excelente pelicula!'),(9,'2024-12-14 15:25:26',2,11,'Me encanto esta peli!'),(10,'2024-12-14 15:25:40',2,10,'Fue asombrosa'),(11,'2024-12-14 15:25:57',2,12,'woww'),(12,'2024-12-14 15:26:29',2,2,'mi preferida ');
/*!40000 ALTER TABLE `comentarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `peliculas`
--

DROP TABLE IF EXISTS `peliculas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `peliculas` (
  `id_pelicula` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `fecha_estreno` timestamp NULL DEFAULT NULL,
  `sinopsis` text,
  `director` varchar(45) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_organizador` int NOT NULL,
  PRIMARY KEY (`id_pelicula`),
  KEY `fk_peliculas_usuarios1_idx` (`id_organizador`),
  CONSTRAINT `fk_peliculas_usuarios1` FOREIGN KEY (`id_organizador`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peliculas`
--

LOCK TABLES `peliculas` WRITE;
/*!40000 ALTER TABLE `peliculas` DISABLE KEYS */;
INSERT INTO `peliculas` VALUES (2,'Titanic','1997-12-19 03:00:00','En 1912, el lujoso transatlántico Titanic navega hacia su fatídico destino en su viaje inaugural. A bordo, Rose (Kate Winslet), una joven de la alta sociedad, se enamora de Jack (Leonardo DiCaprio), un artista de clase baja. Su amor florece en medio de la tragedia mientras el barco se hunde tras chocar con un iceberg. La película combina una historia de amor épica con una recreación del desastre real.','James Cameron','2024-12-11 22:26:15','2024-12-14 15:22:48',1),(7,'Dune: Parte Dos','2024-03-15 03:00:00','Continúa la adaptación de la famosa novela de ciencia ficción de Frank Herbert. Paul Atreides (Timothée Chalamet) se une con los Fremen para vengar la traición a su familia y reclamar el control de Arrakis, el planeta desértico que produce la especia más valiosa del universo. En esta secuela, Paul debe enfrentar decisiones difíciles mientras se adentra en su destino como líder de una rebelión que podría cambiar el futuro del imperio.','Denis Villeneuve','2024-12-12 00:39:24','2024-12-14 15:25:00',2),(8,'Spider-Man: No Way Home','2021-12-17 03:00:00','Después de que Peter Parker (Tom Holland) es desenmascarado como Spider-Man, busca la ayuda del Doctor Strange (Benedict Cumberbatch) para borrar la memoria de todos y que nadie sepa su identidad secreta. Sin embargo, las cosas salen mal y, al abrir un portal hacia el multiverso, personajes de otras dimensiones, incluyendo versiones pasadas de Spider-Man, comienzan a aparecer. Peter debe enfrentarse a las consecuencias de su deseo y salvar el multiverso.','Jon Watts','2024-12-12 00:45:50','2024-12-14 15:23:44',2),(10,'El Origen','2010-07-16 04:00:00','Dom Cobb (Leonardo DiCaprio) es un ladrón especializado en el arte de la extracción: robar secretos valiosos de la mente de sus víctimas mientras sueñan. Acepta una tarea aparentemente imposible: en lugar de robar una idea, debe implantar una en la mente de un objetivo. Si tiene éxito, será capaz de borrar su historial criminal y regresar a su familia. Sin embargo, las barreras de la mente subconsciente, los peligros y su propio pasado amenazan con arruinar la misión.','Christopher Nolan','2024-12-14 15:19:48','2024-12-14 15:19:48',1),(11,'Interestelar','2014-11-07 03:00:00','En un futuro cercano, la Tierra está al borde de la destrucción debido a la escasez de alimentos. Un equipo de astronautas, liderado por Cooper (Matthew McConaughey), viaja a través de un agujero de gusano cercano en busca de un nuevo hogar para la humanidad. Mientras navegan por otros planetas, enfrentan dilemas emocionales, científicos y filosóficos sobre el espacio, el tiempo y el amor.','Christopher Nolan','2024-12-14 15:20:35','2024-12-14 15:20:35',1),(12,'La Naranja Mecánica','1971-12-13 03:00:00','Alex (Malcolm McDowell) es el líder de una banda de jóvenes delincuentes en una sociedad distópica. Después de cometer una serie de crímenes violentos, Alex es arrestado y sometido a un controvertido tratamiento de aversión para rehabilitarlo. La película explora temas de control social, violencia y la naturaleza humana a través de una crítica feroz a los sistemas de poder y la libertad individual.','Stanley Kubrick','2024-12-14 15:21:43','2024-12-14 15:21:43',1);
/*!40000 ALTER TABLE `peliculas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `apellido` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'emanuel','acosta','emanuelacostag17@gmail.com','$2b$12$d44TyDO6LgivnUYmQMx.6uKga06fYPtlNuT2P6G2H6.0IWOCXjcSG','2024-12-11 21:49:06','2024-12-11 21:49:06'),(2,'yessica','lopez ','yessicavirginia23@gmail.com','$2b$12$OGR2kis2Mjfbksa1BUR1VewsA789ekOATvQO8I7W16kv9Otj797ye','2024-12-12 00:38:03','2024-12-12 00:38:03'),(3,'admin','admin','admin@example.com','$2b$12$bl.PBy50llbqPLmuJu0k8uJ0vi3eVkWeslzJfp4dVibB49AJT53fy','2024-12-12 20:10:25','2024-12-12 20:10:25');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-16 14:16:10
