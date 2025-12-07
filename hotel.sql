-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hotel
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hotel
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hotel` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `hotel` ;

-- -----------------------------------------------------
-- Table `hotel`.`room_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotel`.`room_type` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hotel`.`room_type` (
  `type_id` INT NOT NULL,
  `grade` VARCHAR(20) NOT NULL,
  `bed_type` VARCHAR(20) NULL,
  `capacity` INT(10) NULL,
  PRIMARY KEY (`type_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `hotel`.`room`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotel`.`room` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hotel`.`room` (
  `room_number` INT NOT NULL,
  `is_available` TINYINT(1) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `type_id` INT NOT NULL,
  PRIMARY KEY (`room_number`),
  INDEX `fk_room_room_type_idx` (`type_id` ASC),
  CONSTRAINT `fk_room_room_type`
    FOREIGN KEY (`type_id`)
    REFERENCES `hotel`.`room_type` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `hotel`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotel`.`customer` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hotel`.`customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `gender` VARCHAR(10) NULL,
  `phone_number` VARCHAR(20) NOT NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `hotel`.`reservation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotel`.`reservation` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hotel`.`reservation` (
  `reservation_id` INT NOT NULL AUTO_INCREMENT,
  `check_in` DATE NOT NULL,
  `check_out` DATE NOT NULL,
  `reservation_date` DATETIME NOT NULL,
  `status` VARCHAR(20) NOT NULL,
  `customer_id` INT NOT NULL,
  `room_number` INT NOT NULL,
  PRIMARY KEY (`reservation_id`),
  INDEX `fk_reservation_customer1_idx` (`customer_id` ASC),
  INDEX `fk_reservation_room1_idx` (`room_number` ASC),
  CONSTRAINT `fk_reservation_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `hotel`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservation_room1`
    FOREIGN KEY (`room_number`)
    REFERENCES `hotel`.`room` (`room_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `hotel`.`membership`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotel`.`membership` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hotel`.`membership` (
  `seq_number` INT NOT NULL AUTO_INCREMENT,
  `membership_grade` VARCHAR(15) NOT NULL,
  `point` DECIMAL(10,2) NOT NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`seq_number`, `customer_id`),
  INDEX `fk_membership_customer1_idx` (`customer_id` ASC),
  CONSTRAINT `fk_membership_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `hotel`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
