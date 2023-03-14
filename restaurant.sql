DROP DATABASE IF EXISTS `restaurant`;
CREATE DATABASE `restaurant`;
USE `restaurant`;
SHOW TABLES;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


CREATE SCHEMA IF NOT EXISTS `restaurant` DEFAULT CHARACTER SET utf8 ;
USE `restaurant` ;


CREATE TABLE IF NOT EXISTS `restaurant`.`orders` (
  `№ code` INT NOT NULL,
  `order date` DATE NULL,
  `table number` INT NULL,
  `waiter` VARCHAR(45) NULL,
  `total amount` INT NULL,
  PRIMARY KEY (`№ code`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `restaurant`.`waiters` (
  `№ waiters` INT NOT NULL,
  `full name` VARCHAR(45) NULL,
  `orders_№ code` INT NOT NULL,
  PRIMARY KEY (`№ waiters`, `orders_№ code`),
  INDEX `fk_waiters_orders_idx` (`orders_№ code` ASC),
  CONSTRAINT `fk_waiters_orders`
    FOREIGN KEY (`orders_№ code`)
    REFERENCES `mydb`.`orders` (`№ code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `restaurant`.`drinks` (
  `№ drinks` INT NOT NULL,
  `names` VARCHAR(45) NULL,
  `№ group` INT NULL,
  `cost price` INT NULL,
  `price` INT NULL,
  `extra charge` INT NULL,
  PRIMARY KEY (`№ drinks`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `restaurant`.`order from the menu` (
  `order code` INT NOT NULL,
  `dish code` INT NULL,
  `drink code` INT NULL,
  `quanity` INT NULL,
  `the amount` INT NULL,
  `drinks_№ drinks` INT NOT NULL,
  PRIMARY KEY (`order code`, `drinks_№ drinks`),
  INDEX `fk_order from the menu_drinks1_idx` (`drinks_№ drinks` ASC),
  CONSTRAINT `fk_order from the menu_drinks1`
    FOREIGN KEY (`drinks_№ drinks`)
    REFERENCES `restaurant`.`drinks` (`№ drinks`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `restaurant`.`ingredients` (
  `№ ingredients` INT NOT NULL,
  `names` VARCHAR(45) NULL,
  `cost price` INT NULL,
  `unit of mesurement` INT NULL,
  PRIMARY KEY (`№ ingredients`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `restaurant`.`the composition of the dish` (
  `dish code` INT NOT NULL,
  `ingredient code` INT NULL,
  `quanity` INT NULL,
  `cost price` INT NULL,
  `ingredients_№ ingredients` INT NOT NULL,
  PRIMARY KEY (`dish code`, `ingredients_№ ingredients`),
  INDEX `fk_the composition of the dish_ingredients1_idx` (`ingredients_№ ingredients` ASC),
  CONSTRAINT `fk_the composition of the dish_ingredients1`
    FOREIGN KEY (`ingredients_№ ingredients`)
    REFERENCES `restaurant`.`ingredients` (`№ ingredients`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `restaurant`.`group` (
  `№ group` INT NOT NULL,
  `group names` VARCHAR(45) NULL,
  `drinks_№ drinks` INT NOT NULL,
  PRIMARY KEY (`№ group`, `drinks_№ drinks`),
  INDEX `fk_group_drinks1_idx` (`drinks_№ drinks` ASC),
  CONSTRAINT `fk_group_drinks1`
    FOREIGN KEY (`drinks_№ drinks`)
    REFERENCES `restaurant`.`drinks` (`№ drinks`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `restaurant`.`dishes` (
  `№ dishes` INT NOT NULL,
  `names` VARCHAR(45) NULL,
  `№ group` INT NULL,
  `interview` VARCHAR(45) NULL,
  `price` INT NULL,
  `extra charge` INT NULL,
  `order from the menu_order code` INT NOT NULL,
  `the composition of the dish_dish code` INT NOT NULL,
  `group_№ group` INT NOT NULL,
  PRIMARY KEY (`№ dishes`, `order from the menu_order code`, `the composition of the dish_dish code`, `group_№ group`),
  INDEX `fk_dishes_order from the menu1_idx` (`order from the menu_order code` ASC),
  INDEX `fk_dishes_the composition of the dish1_idx` (`the composition of the dish_dish code` ASC),
  INDEX `fk_dishes_group1_idx` (`group_№ group` ASC),
  CONSTRAINT `fk_dishes_order from the menu1`
    FOREIGN KEY (`order from the menu_order code`)
    REFERENCES `restaurant`.`order from the menu` (`order code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dishes_the composition of the dish1`
    FOREIGN KEY (`the composition of the dish_dish code`)
    REFERENCES `restaurant`.`the composition of the dish` (`dish code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dishes_group1`
    FOREIGN KEY (`group_№ group`)
    REFERENCES `restaurant`.`group` (`№ group`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
