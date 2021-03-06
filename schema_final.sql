-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema diss1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema diss1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `diss1` DEFAULT CHARACTER SET latin1 ;
USE `diss1` ;

-- -----------------------------------------------------
-- Table `diss1`.`agency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diss1`.`agency` (
  `agency_id` INT(11) NOT NULL AUTO_INCREMENT,
  `agency_name` VARCHAR(100) NOT NULL,
  `location` ENUM('FI', 'FRA', 'SPA') NOT NULL,
  `balance` DOUBLE NOT NULL DEFAULT '0',
  `psw` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`agency_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `diss1`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diss1`.`city` (
  `city_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `country` ENUM('FI', 'FRA', 'SPA') NOT NULL,
  PRIMARY KEY (`city_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `diss1`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diss1`.`orders` (
  `order_id` INT(11) NOT NULL AUTO_INCREMENT,
  `duration` DOUBLE NOT NULL,
  `number_of_repeat` INT(11) NOT NULL,
  `city_id` INT(11) NOT NULL,
  `screen_type` ENUM('billboard', 'standing', 'small') NOT NULL,
  `amount` DOUBLE NOT NULL,
  `agency_id` INT(11) NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `agency_idx` (`agency_id` ASC),
  CONSTRAINT `agency`
    FOREIGN KEY (`agency_id`)
    REFERENCES `diss1`.`agency` (`agency_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `diss1`.`screen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diss1`.`screen` (
  `screen_id` INT(11) NOT NULL AUTO_INCREMENT,
  `type` ENUM('billboard', 'standing', 'small') NOT NULL,
  `city_id` INT(11) NOT NULL,
  `price` DOUBLE NOT NULL,
  PRIMARY KEY (`screen_id`),
  INDEX `city_id_idx` (`city_id` ASC),
  CONSTRAINT `city_id`
    FOREIGN KEY (`city_id`)
    REFERENCES `diss1`.`city` (`city_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `diss1`.`screenorder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diss1`.`screenorder` (
  `screen_id` INT(11) NOT NULL,
  `order_id` INT(11) NOT NULL,
  PRIMARY KEY (`screen_id`, `order_id`),
  INDEX `order_idx` (`order_id` ASC),
  CONSTRAINT `order`
    FOREIGN KEY (`order_id`)
    REFERENCES `diss1`.`orders` (`order_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `screen`
    FOREIGN KEY (`screen_id`)
    REFERENCES `diss1`.`screen` (`screen_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
