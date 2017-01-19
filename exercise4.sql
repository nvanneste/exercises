-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medical` (
  `Doctor_ID` INT NOT NULL COMMENT '	',
  `Overtime_rate` INT NULL,
  PRIMARY KEY (`Doctor_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Specialist` (
  `Doctor_ID` INT NOT NULL,
  `Field_area` VARCHAR(45) NULL,
  PRIMARY KEY (`Doctor_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Doctor` (
  `ID` INT NOT NULL,
  `Doctor_ID` INT NULL COMMENT '		',
  `Name` VARCHAR(45) NULL,
  `Date_of_birth` DATE NULL,
  `Address` VARCHAR(45) NULL,
  `Phone_number` INT NULL,
  `Salary` INT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Docter_ID_idx` (`Doctor_ID` ASC),
  CONSTRAINT `fk_Medical`
    FOREIGN KEY (`Doctor_ID`)
    REFERENCES `mydb`.`Medical` (`Doctor_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Specialist`
    FOREIGN KEY (`Doctor_ID`)
    REFERENCES `mydb`.`Specialist` (`Doctor_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Appointment` (
  `Patient_ID` INT NULL,
  `Date` DATE NULL,
  `Time` TIME NULL,
  `Doctor_ID` INT NOT NULL,
  PRIMARY KEY (`Doctor_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill` (
  `Bill_ID` INT NOT NULL,
  `Total` INT NULL,
  PRIMARY KEY (`Bill_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `Payment_ID` INT NOT NULL,
  `Details` VARCHAR(45) NULL,
  `Method` VARCHAR(45) NULL,
  PRIMARY KEY (`Payment_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Xref`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Xref` (
  `ID` INT NOT NULL,
  `Patient_ID` INT NULL,
  `Bill_ID` INT NULL,
  `Payment_ID` INT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Bill_ID_idx` (`Bill_ID` ASC),
  INDEX `fk_Payment_ID_idx` (`Payment_ID` ASC),
  CONSTRAINT `fk_Bill_ID`
    FOREIGN KEY (`Bill_ID`)
    REFERENCES `mydb`.`Bill` (`Bill_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_ID`
    FOREIGN KEY (`Payment_ID`)
    REFERENCES `mydb`.`Payment` (`Payment_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `Patient_ID` INT NOT NULL,
  `Doctor_ID` INT NULL,
  `Name` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `Phone_number` INT NULL,
  `Date_of_birth` DATE NULL,
  `Payment_and_bill` INT NULL,
  PRIMARY KEY (`Patient_ID`),
  INDEX `fk_Doctor_idx` (`Doctor_ID` ASC),
  INDEX `fk_Xref_idx` (`Payment_and_bill` ASC),
  CONSTRAINT `fk_Doctor`
    FOREIGN KEY (`Doctor_ID`)
    REFERENCES `mydb`.`Doctor` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment`
    FOREIGN KEY (`Doctor_ID`)
    REFERENCES `mydb`.`Appointment` (`Doctor_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_and_bill`
    FOREIGN KEY (`Payment_and_bill`)
    REFERENCES `mydb`.`Xref` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
