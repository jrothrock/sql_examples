-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema jaro6612projecttest
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `jaro6612projecttest` ;

-- -----------------------------------------------------
-- Schema jaro6612projecttest
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `jaro6612projecttest` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema jaro6612mydbtest
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `jaro6612mydbtest` ;

-- -----------------------------------------------------
-- Schema jaro6612mydbtest
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `jaro6612mydbtest` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema jaro6612bank
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `jaro6612bank` ;

-- -----------------------------------------------------
-- Schema jaro6612bank
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `jaro6612bank` DEFAULT CHARACTER SET utf8 ;
USE `jaro6612projecttest` ;

-- -----------------------------------------------------
-- Table `Vendor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Vendor` ;

CREATE TABLE IF NOT EXISTS `Vendor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `street` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `postal_code` VARCHAR(45) NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Customer` ;

CREATE TABLE IF NOT EXISTS `Customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `age` INT NULL,
  `street` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `postal_code` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `User` ;

CREATE TABLE IF NOT EXISTS `User` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `First` VARCHAR(45) NULL,
  `Last` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  `Vendor_id` INT NULL,
  `Customer_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_User_Vendor_idx` (`Vendor_id` ASC) VISIBLE,
  INDEX `fk_User_Customer1_idx` (`Customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_User_Vendor`
    FOREIGN KEY (`Vendor_id`)
    REFERENCES `Vendor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_Customer1`
    FOREIGN KEY (`Customer_id`)
    REFERENCES `Customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Beer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Beer` ;

CREATE TABLE IF NOT EXISTS `Beer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `type` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `price` DECIMAL(10,2) NULL,
  `size` VARCHAR(45) NULL,
  `active` TINYINT NULL,
  `Vendor_id` INT NOT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Beer_Vendor1_idx` (`Vendor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Beer_Vendor1`
    FOREIGN KEY (`Vendor_id`)
    REFERENCES `Vendor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Image` ;

CREATE TABLE IF NOT EXISTS `Image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(120) NULL,
  `Beer_id` INT NOT NULL,
  `User_id` INT NOT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Image_Beer1_idx` (`Beer_id` ASC) VISIBLE,
  INDEX `fk_Image_User1_idx` (`User_id` ASC) VISIBLE,
  CONSTRAINT `fk_Image_Beer1`
    FOREIGN KEY (`Beer_id`)
    REFERENCES `Beer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Image_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Customer_Order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Customer_Order` ;

CREATE TABLE IF NOT EXISTS `Customer_Order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Customer_id` INT NOT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Customer Order_Customer1_idx` (`Customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Customer Order_Customer1`
    FOREIGN KEY (`Customer_id`)
    REFERENCES `Customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Inventory_Purchase_Order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Inventory_Purchase_Order` ;

CREATE TABLE IF NOT EXISTS `Inventory_Purchase_Order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Vendor_id` INT NOT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Inventory Purchase Order_Vendor1_idx` (`Vendor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Inventory Purchase Order_Vendor1`
    FOREIGN KEY (`Vendor_id`)
    REFERENCES `Vendor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Customer_Order_Details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Customer_Order_Details` ;

CREATE TABLE IF NOT EXISTS `Customer_Order_Details` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantity` INT NULL,
  `Customer_Order_id` INT NOT NULL,
  `Beer_id` INT NOT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Customer Order Details_Customer Order1_idx` (`Customer_Order_id` ASC) VISIBLE,
  INDEX `fk_Customer Order Details_Beer1_idx` (`Beer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Customer Order Details_Customer Order1`
    FOREIGN KEY (`Customer_Order_id`)
    REFERENCES `Customer_Order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer Order Details_Beer1`
    FOREIGN KEY (`Beer_id`)
    REFERENCES `Beer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Inventory_Purchase_Order_Details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Inventory_Purchase_Order_Details` ;

CREATE TABLE IF NOT EXISTS `Inventory_Purchase_Order_Details` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantity` INT NULL,
  `Inventory_Purchase_Order_id` INT NOT NULL,
  `Beer_id` INT NOT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Inventory Purchase Order Details_Inventory Purchase Orde_idx` (`Inventory_Purchase_Order_id` ASC) VISIBLE,
  INDEX `fk_Inventory Purchase Order Details_Beer1_idx` (`Beer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Inventory Purchase Order Details_Inventory Purchase Order1`
    FOREIGN KEY (`Inventory_Purchase_Order_id`)
    REFERENCES `Inventory_Purchase_Order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventory Purchase Order Details_Beer1`
    FOREIGN KEY (`Beer_id`)
    REFERENCES `Beer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `jaro6612mydbtest` ;

-- -----------------------------------------------------
-- Table `branch`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `branch` ;

CREATE TABLE IF NOT EXISTS `branch` (
  `idBranch` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idBranch`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `staff` ;

CREATE TABLE IF NOT EXISTS `staff` (
  `idStaff` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `position` VARCHAR(45) NULL DEFAULT NULL,
  `salary` DECIMAL(10,2) NULL DEFAULT NULL,
  `Branch_idBranch` INT(11) NOT NULL,
  PRIMARY KEY (`idStaff`),
  INDEX `fk_Staff_Branch_idx` (`Branch_idBranch` ASC) VISIBLE,
  CONSTRAINT `fk_Staff_Branch`
    FOREIGN KEY (`Branch_idBranch`)
    REFERENCES `branch` (`idBranch`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `phone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `phone` ;

CREATE TABLE IF NOT EXISTS `phone` (
  `idPhone` INT(11) NOT NULL,
  `number` VARCHAR(45) NULL DEFAULT NULL,
  `staff_id` VARCHAR(45) NULL DEFAULT NULL,
  `primary` TINYINT(4) NULL DEFAULT NULL,
  `Staff_idStaff` INT(11) NOT NULL,
  PRIMARY KEY (`idPhone`),
  INDEX `fk_Phone_Staff1_idx` (`Staff_idStaff` ASC) VISIBLE,
  CONSTRAINT `fk_Phone_Staff1`
    FOREIGN KEY (`Staff_idStaff`)
    REFERENCES `staff` (`idStaff`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `jaro6612bank` ;

-- -----------------------------------------------------
-- Table `branch`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `branch` ;

CREATE TABLE IF NOT EXISTS `branch` (
  `branchNo` INT(11) NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `postCode` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`branchNo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `phone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `phone` ;

CREATE TABLE IF NOT EXISTS `phone` (
  `branchNo` INT(11) NOT NULL,
  `phone` BIGINT(20) NOT NULL,
  INDEX `fk_Phone_Branch1_idx` (`branchNo` ASC) VISIBLE,
  CONSTRAINT `fk_Phone_Branch1`
    FOREIGN KEY (`branchNo`)
    REFERENCES `branch` (`branchNo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `staff` ;

CREATE TABLE IF NOT EXISTS `staff` (
  `staffNo` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `position` VARCHAR(45) NOT NULL,
  `salary` DECIMAL(10,2) NULL DEFAULT NULL,
  `branchNo` INT(11) NOT NULL,
  PRIMARY KEY (`staffNo`),
  INDEX `fk_staff_Branch_idx` (`branchNo` ASC) VISIBLE,
  CONSTRAINT `fk_staff_Branch`
    FOREIGN KEY (`branchNo`)
    REFERENCES `branch` (`branchNo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
