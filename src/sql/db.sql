-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `user_id` INT NOT NULL,
  `user_name` VARCHAR(45) NOT NULL,
  `user_email` VARCHAR(45) NOT NULL,
  `user_psswd` VARCHAR(45) NOT NULL,
  `isAdmin` VARCHAR(45) NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `user_email_UNIQUE` (`user_email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`markdown_NER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`markdown_NER` (
  `markdown_id` INT NOT NULL,
  `partials_ready` VARCHAR(45) NULL,
  `partials_not_ready` VARCHAR(45) NULL,
  `markdown_status` INT NULL,
  PRIMARY KEY (`markdown_id`),
  UNIQUE INDEX `markdown_id_UNIQUE` (`markdown_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`markdown_SEMANTIC`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`markdown_SEMANTIC` (
  `markdown_id` INT NOT NULL,
  `partials_ready` VARCHAR(45) NULL,
  `partials_not_ready` VARCHAR(45) NULL,
  `markdown_status` INT NULL,
  PRIMARY KEY (`markdown_id`),
  UNIQUE INDEX `markdown_id_UNIQUE` (`markdown_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`markdown_INTENTION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`markdown_INTENTION` (
  `markdown_id` INT NOT NULL,
  `partials_ready` VARCHAR(45) NULL,
  `partials_not_ready` VARCHAR(45) NULL,
  `markdown_status` INT NULL,
  PRIMARY KEY (`markdown_id`),
  UNIQUE INDEX `markdown_id_UNIQUE` (`markdown_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`branch` (
  `branch_id` INT NOT NULL,
  `editor_id` INT NULL,
  `NER` INT NOT NULL,
  `SEMANTIC` INT NOT NULL,
  `INTENTION` INT NOT NULL,
  PRIMARY KEY (`branch_id`),
  INDEX `editor_idx` (`editor_id` ASC) VISIBLE,
  INDEX `NER_idx` (`NER` ASC) VISIBLE,
  INDEX `SEMANTIC_idx` (`SEMANTIC` ASC) VISIBLE,
  INDEX `INTENTION_idx` (`INTENTION` ASC) VISIBLE,
  CONSTRAINT `editor`
    FOREIGN KEY (`editor_id`)
    REFERENCES `mydb`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `NER`
    FOREIGN KEY (`NER`)
    REFERENCES `mydb`.`markdown_NER` (`markdown_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `SEMANTIC`
    FOREIGN KEY (`SEMANTIC`)
    REFERENCES `mydb`.`markdown_SEMANTIC` (`markdown_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `INTENTION`
    FOREIGN KEY (`INTENTION`)
    REFERENCES `mydb`.`markdown_INTENTION` (`markdown_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`files`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`files` (
  `file_id` INT NOT NULL,
  `file_name` VARCHAR(45) NOT NULL,
  `admin_id` INT NOT NULL,
  `branch1` INT NOT NULL,
  `branch2` INT NOT NULL,
  `original` VARCHAR(45) NOT NULL,
  `final_NER` VARCHAR(45) NULL,
  `final_SEMANTIC` VARCHAR(45) NULL,
  `final_INTENTION` VARCHAR(45) NULL,
  PRIMARY KEY (`file_id`),
  UNIQUE INDEX `file_id_UNIQUE` (`file_id` ASC) VISIBLE,
  INDEX `user_id_idx` (`admin_id` ASC) VISIBLE,
  INDEX `branch1_idx` (`branch1` ASC) VISIBLE,
  INDEX `branch2_idx` (`branch2` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`admin_id`)
    REFERENCES `mydb`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `branch1`
    FOREIGN KEY (`branch1`)
    REFERENCES `mydb`.`branch` (`branch_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `branch2`
    FOREIGN KEY (`branch2`)
    REFERENCES `mydb`.`branch` (`branch_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
