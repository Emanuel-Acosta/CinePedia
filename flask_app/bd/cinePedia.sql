-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema cinepedia
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cinepedia
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cinepedia` DEFAULT CHARACTER SET utf8mb3 ;
USE `cinepedia` ;

-- -----------------------------------------------------
-- Table `cinepedia`.`usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinepedia`.`usuarios` ;

CREATE TABLE IF NOT EXISTS `cinepedia`.`usuarios` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `apellido` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `password` VARCHAR(255) NULL DEFAULT NULL,
  `fecha_creacion` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cinepedia`.`peliculas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinepedia`.`peliculas` ;

CREATE TABLE IF NOT EXISTS `cinepedia`.`peliculas` (
  `id_pelicula` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NULL DEFAULT NULL,
  `fecha_estreno` TIMESTAMP NULL DEFAULT NULL,
  `sinopsis` TEXT NULL DEFAULT NULL,
  `director` VARCHAR(45) NULL DEFAULT NULL,
  `fecha_creacion` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_organizador` INT NOT NULL,
  PRIMARY KEY (`id_pelicula`),
  INDEX `fk_peliculas_usuarios1_idx` (`id_organizador` ASC) VISIBLE,
  CONSTRAINT `fk_peliculas_usuarios1`
    FOREIGN KEY (`id_organizador`)
    REFERENCES `cinepedia`.`usuarios` (`id_usuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cinepedia`.`comentarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinepedia`.`comentarios` ;

CREATE TABLE IF NOT EXISTS `cinepedia`.`comentarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha_creacion` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_id` INT NOT NULL,
  `pelicula_id` INT NOT NULL,
  `contenido` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `usuario_id`, `pelicula_id`),
  INDEX `fk_usuarios_has_peliculas_peliculas1_idx` (`pelicula_id` ASC) VISIBLE,
  INDEX `fk_usuarios_has_peliculas_usuarios_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_has_peliculas_peliculas1`
    FOREIGN KEY (`pelicula_id`)
    REFERENCES `cinepedia`.`peliculas` (`id_pelicula`),
  CONSTRAINT `fk_usuarios_has_peliculas_usuarios`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `cinepedia`.`usuarios` (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
