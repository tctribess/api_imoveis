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
-- Table `mydb`.`tipoImovel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipoImovel` (
  `id_tipoImovel` INT NOT NULL AUTO_INCREMENT,
  `descricao_tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipoImovel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`imovel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`imovel` (
  `id_imovel` INT NOT NULL AUTO_INCREMENT,
  `tipo_imovel` INT NOT NULL,
  `descricao_imovel` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_imovel`),
  INDEX `tipo_imovel_idx` (`tipo_imovel` ASC) VISIBLE,
  CONSTRAINT `tipo_imovel`
    FOREIGN KEY (`tipo_imovel`)
    REFERENCES `mydb`.`tipoImovel` (`id_tipoImovel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`venda` (
  `id_venda` INT NOT NULL AUTO_INCREMENT,
  `imovel_id` INT NOT NULL,
  PRIMARY KEY (`id_venda`),
  INDEX `imovel_id_idx` (`imovel_id` ASC) VISIBLE,
  CONSTRAINT `imovel_id`
    FOREIGN KEY (`imovel_id`)
    REFERENCES `mydb`.`imovel` (`id_imovel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pagamento` (
  `id_pagamento` INT NOT NULL AUTO_INCREMENT,
  `data_pagamento` DATE NOT NULL,
  `valor_pagamento` FLOAT NOT NULL,
  `venda_id` INT NOT NULL,
  PRIMARY KEY (`id_pagamento`),
  INDEX `venda_id_idx` (`venda_id` ASC) VISIBLE,
  CONSTRAINT `venda_id`
    FOREIGN KEY (`venda_id`)
    REFERENCES `mydb`.`venda` (`id_venda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
