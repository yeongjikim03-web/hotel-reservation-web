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



-- 객실 타입(ROOM_TYPE)

INSERT INTO room_type (type_id, grade, bed_type, capacity)
VALUES
    (1, 'Standard', 'Single', 1)
  , (2, 'Standard', 'Double', 2)
  , (3, 'Deluxe', 'Double', 3)
  , (4, 'Deluxe', 'Twin', 4)
  , (5, 'Suite', 'Twin', 4)
  , (6, 'Suite', 'King', 2)
  , (7, 'Royal Suite', NULL, 6)
;


-- 고객(CUSTOMER)

INSERT INTO customer (customer_id, name, gender, phone_number, email)
VALUES
    (101, 'John Doe', 'M', '010-1111-2222', 'john@example.com')
  , (102, 'Alice Smith', 'F', '010-2222-3333', 'alice@test.com')
  , (103, 'Bob Johnson', 'M', '010-3333-4444', 'bob@company.net')
  , (104, 'Charlie Brown', 'M', '010-4444-5555', 'charlie@mail.com')
  , (105, 'Diana Prince', 'F', '010-5555-6666', NULL)
  , (106, 'Evan Wright', 'M', '010-6666-7777', 'evan@write.com')
  , (107, 'Fiona Green', 'F', '010-7777-8888', 'fiona@nature.org')
  , (108, 'George Hill', NULL, '010-8888-9999', NULL)
  , (109, 'Hannah Lee', 'F', '010-9999-0000', 'hannah@korea.com')
  , (110, 'Ian Clark', NULL, '010-0000-1111', 'ian@dev.io')
;

-- 객실정보(ROOM), (price에 적힌 금액은 박당 **만원 임)

INSERT INTO room (room_number, is_available, price, type_id)
VALUES
    (201, 1, 5.00, 1)
  , (202, 1, 5.00, 1)
  , (203, 1, 5.00, 1)
  , (204, 0, 5.00, 1)
  , (301, 0, 7.00, 2)
  , (302, 1, 7.00, 2)
  , (303, 0, 7.00, 2)
  , (304, 1, 7.00, 2)
  , (401, 1, 10.00, 3)
  , (402, 0, 10.00, 3)
  , (403, 1, 10.00, 3)
  , (404, 1, 10.00, 3)
  , (501, 0, 11.00, 4)
  , (502, 1, 11.00, 4)
  , (503, 0, 11.00, 4)
  , (504, 1, 11.00, 4)
  , (601, 1, 16.50, 5)
  , (602, 0, 16.50, 5)
  , (603, 1, 16.50, 5)
  , (604, 1, 16.50, 5)
  , (701, 1, 16.00, 6)
  , (702, 1, 16.00, 6)
  , (703, 1, 16.00, 6)
  , (704, 0, 16.00, 6)
  , (801, 1, 28.00, 7)
  , (802, 0, 28.00, 7)
;

-- 멤버십(MEMBERSHIP), (등급 승급 기준이 필요)

INSERT INTO membership (seq_number, membership_grade, point, customer_id)
VALUES
    (1, 'Silver', 100.20, 101)
  , (2, 'Gold', 2500.50, 102)
  , (3, 'Platinum', 50000.00, 103)
  , (4, 'Silver', 50.00, 104)
  , (5, 'Platinum', 56344.00, 105)
  , (6, 'Silver', 0.00, 106)
  , (7, 'Gold', 3400.00, 107)
  , (8, 'Silver', 210.00, 108)
  , (9, 'Platinum', 8900.00, 109)
  , (10, 'Silver', 150.00, 110)
;


INSERT INTO reservation (reservation_id, check_in, check_out, reservation_date, status, customer_id, room_number)
VALUES
    (1000, '2023-12-01', '2023-12-03', '2023-11-25 14:30:00', 'Completed', 101, 201)
  , (1001, '2023-12-10', '2023-12-12', '2023-12-01 09:00:00', 'Completed', 102, 603)
  , (1002, '2024-01-05', '2024-01-10', '2023-12-20 18:45:00', 'Completed', 103, 504)
  , (1003, '2024-02-14', '2024-02-15', '2024-01-10 10:10:00', 'Cancelled', 103, 302)
  , (1004, '2025-03-01', '2025-03-05', '2025-02-20 11:20:00', 'Completed', 105, 401)
  , (1005, '2025-05-05', '2025-05-07', '2025-04-01 15:00:00', 'NoShow', 106, 501)
  , (1006, '2025-11-22', '2025-12-29', '2025-04-02 15:30:00', 'CheckedIn', 105, 802)
  , (1007, '2025-12-20', '2025-12-21', '2025-08-11 16:30:00', 'Booked', 107, 503)
  , (1008, '2025-12-24', '2025-12-26', '2025-10-23 12:00:00', 'Booked', 110, 402)
  , (1009, '2025-12-23', '2025-12-30', '2025-11-01 08:50:00', 'Booked', 102, 204)
  , (1010, '2025-12-15', '2025-12-16', '2025-11-11 08:50:00', 'Cancelled', 102, 201)
  , (1011, '2026-01-10', '2026-01-12', '2025-11-23 13:10:00', 'Booked', 101, 704)
;
