-- MySQL Script generated by MySQL Workbench
-- mar 11 may 2021 21:26:45
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tp1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tp1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tp1` ;
USE `tp1` ;

-- -----------------------------------------------------
-- Table `tp1`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp1`.`provincia` (
  `idProvincia` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idProvincia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp1`.`departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp1`.`departamento` (
  `idDepartamento` INT NOT NULL AUTO_INCREMENT,
  `idProvincia` INT NOT NULL,
  PRIMARY KEY (`idDepartamento`, `idProvincia`),
  INDEX `fk_provincia_departamento_idx` (`idProvincia` ASC) VISIBLE,
  CONSTRAINT `fk_provincia_departamento`
    FOREIGN KEY (`idProvincia`)
    REFERENCES `tp1`.`provincia` (`idProvincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp1`.`localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp1`.`localidad` (
  `idLocalidad` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `idDepartamento` INT NOT NULL,
  `idProvincia` INT NOT NULL,
  PRIMARY KEY (`idLocalidad`, `idDepartamento`, `idProvincia`),
  INDEX `fk_departamento_localidad_idx` (`idDepartamento` ASC) VISIBLE,
  INDEX `fk_provincia_localidad_idx` (`idProvincia` ASC) VISIBLE,
  CONSTRAINT `fk_departamento_localidad`
    FOREIGN KEY (`idDepartamento`)
    REFERENCES `tp1`.`departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_provincia_localidad`
    FOREIGN KEY (`idProvincia`)
    REFERENCES `tp1`.`provincia` (`idProvincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp1`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp1`.`persona` (
  `dni` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `idLocalidad` INT NULL,
  `idDepartamento` INT NULL,
  `idProvincia` INT NULL,
  PRIMARY KEY (`dni`),
  UNIQUE INDEX `dni_UNIQUE` (`dni` ASC) VISIBLE,
  INDEX `fk_localidad_persona_idx` (`idLocalidad` ASC) VISIBLE,
  INDEX `fk_departamento_persona_idx` (`idDepartamento` ASC) VISIBLE,
  INDEX `fk_provincia_persona_idx` (`idProvincia` ASC) VISIBLE,
  CONSTRAINT `fk_localidad_persona`
    FOREIGN KEY (`idLocalidad`)
    REFERENCES `tp1`.`localidad` (`idLocalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_departamento_persona`
    FOREIGN KEY (`idDepartamento`)
    REFERENCES `tp1`.`departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_provincia_persona`
    FOREIGN KEY (`idProvincia`)
    REFERENCES `tp1`.`provincia` (`idProvincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp1`.`tarea`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp1`.`tarea` (
  `idTarea` INT NOT NULL AUTO_INCREMENT,
  `dniResponsable` INT NULL,
  `fecha-hora` DATETIME NULL,
  `textoTarea` VARCHAR(90) NULL,
  `realizada` TINYINT NULL,
  PRIMARY KEY (`idTarea`),
  INDEX `fk_persona_tarea_idx` (`dniResponsable` ASC) VISIBLE,
  CONSTRAINT `fk_persona_tarea`
    FOREIGN KEY (`dniResponsable`)
    REFERENCES `tp1`.`persona` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
