-- MySQL Script generated by MySQL Workbench
-- Sat Jan 23 18:04:43 2021
-- Model: Sakila Full    Version: 2.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema backoffice
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema backoffice
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `backoffice` ;
USE `backoffice` ;

-- -----------------------------------------------------
-- Table `backoffice`.`TipoNotaFiscal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `backoffice`.`TipoNotaFiscal` (
  `IDTipoNotaFiscal` INT NOT NULL AUTO_INCREMENT,
  `TipoNotaFiscal` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDTipoNotaFiscal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `backoffice`.`NotaFiscal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `backoffice`.`NotaFiscal` (
  `IDNotaFiscal` INT NOT NULL AUTO_INCREMENT,
  `NumeroNotaFiscal` VARCHAR(8) NOT NULL,
  `Valor` DECIMAL(7,2) NOT NULL,
  `IDTipoNotaFiscal` INT NOT NULL,
  PRIMARY KEY (`IDNotaFiscal`, `IDTipoNotaFiscal`),
  INDEX `fk_NotaFiscal_TipoNotaFiscal1_idx` (`IDTipoNotaFiscal` ASC),
  CONSTRAINT `fk_NotaFiscal_TipoNotaFiscal1`
    FOREIGN KEY (`IDTipoNotaFiscal`)
    REFERENCES `backoffice`.`TipoNotaFiscal` (`IDTipoNotaFiscal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `backoffice`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `backoffice`.`Produto` (
  `IDProduto` INT NOT NULL AUTO_INCREMENT,
  `Produto` VARCHAR(60) NOT NULL,
  `Descricao` VARCHAR(500) NULL,
  `Foto` VARCHAR(100) NULL,
  `Valor` DECIMAL(7,2) NULL,
  PRIMARY KEY (`IDProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `backoffice`.`StatusVenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `backoffice`.`StatusVenda` (
  `IDStatusVenda` INT NOT NULL AUTO_INCREMENT,
  `StatusVenda` VARCHAR(45) NULL,
  PRIMARY KEY (`IDStatusVenda`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `backoffice`.`CanalVenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `backoffice`.`CanalVenda` (
  `IDCanalVenda` INT NOT NULL AUTO_INCREMENT,
  `CanalVenda` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`IDCanalVenda`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `backoffice`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `backoffice`.`Fornecedor` (
  `IDFornecedor` INT NOT NULL AUTO_INCREMENT,
  `CNPJ` VARCHAR(50) NOT NULL,
  `RazaoSocial` VARCHAR(150) NOT NULL,
  `NomeFantasia` VARCHAR(100) NULL,
  `Contato` VARCHAR(100) NULL,
  `Anotacoes` VARCHAR(100) NULL,
  PRIMARY KEY (`IDFornecedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `backoffice`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `backoffice`.`Categoria` (
  `IDCategoria` INT NOT NULL AUTO_INCREMENT,
  `Categoria` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`IDCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `backoffice`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `backoffice`.`Cliente` (
  `IDCliente` INT NOT NULL AUTO_INCREMENT,
  `Cliente` VARCHAR(50) NOT NULL,
  `Email` VARCHAR(50) NULL,
  `IDCanalVenda` INT NOT NULL,
  PRIMARY KEY (`IDCliente`, `IDCanalVenda`),
  INDEX `fk_Cliente_CanalVenda1_idx` (`IDCanalVenda` ASC),
  CONSTRAINT `fk_Cliente_CanalVenda1`
    FOREIGN KEY (`IDCanalVenda`)
    REFERENCES `backoffice`.`CanalVenda` (`IDCanalVenda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `backoffice`.`Venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `backoffice`.`Venda` (
  `IDVenda` INT NOT NULL AUTO_INCREMENT,
  `Data` DATETIME NOT NULL,
  `Quantidade` BIGINT NOT NULL,
  `Valor` DECIMAL(7,2) NOT NULL,
  `Frete` DECIMAL(7,2) NULL,
  `ValorComissao` DECIMAL(7,2) NULL,
  `IDProduto` INT NOT NULL,
  `IDCliente` INT NOT NULL,
  `IDCanalVenda` INT NOT NULL,
  `IDNotaFiscal` INT NOT NULL,
  `IDStatusVenda` INT NOT NULL,
  PRIMARY KEY (`IDVenda`, `IDProduto`, `IDCliente`, `IDCanalVenda`, `IDNotaFiscal`, `IDStatusVenda`),
  INDEX `fk_Venda_Produto1_idx` (`IDProduto` ASC),
  INDEX `fk_Venda_Cliente1_idx` (`IDCliente` ASC),
  INDEX `fk_Venda_CanalVenda1_idx` (`IDCanalVenda` ASC),
  INDEX `fk_Venda_NotaFiscal2_idx` (`IDNotaFiscal` ASC),
  INDEX `fk_Venda_Situacao1_idx` (`IDStatusVenda` ASC),
  CONSTRAINT `fk_Venda_Produto1`
    FOREIGN KEY (`IDProduto`)
    REFERENCES `backoffice`.`Produto` (`IDProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_Cliente1`
    FOREIGN KEY (`IDCliente`)
    REFERENCES `backoffice`.`Cliente` (`IDCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_CanalVenda1`
    FOREIGN KEY (`IDCanalVenda`)
    REFERENCES `backoffice`.`CanalVenda` (`IDCanalVenda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_NotaFiscal2`
    FOREIGN KEY (`IDNotaFiscal`)
    REFERENCES `backoffice`.`NotaFiscal` (`IDNotaFiscal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_Situacao1`
    FOREIGN KEY (`IDStatusVenda`)
    REFERENCES `backoffice`.`StatusVenda` (`IDStatusVenda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `backoffice`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `backoffice`.`Estoque` (
  `IDEstoque` INT NOT NULL AUTO_INCREMENT,
  `Quantidade` BIGINT NOT NULL,
  `IDProduto` INT NOT NULL,
  `IDCategoria` INT NOT NULL,
  `IDFornecedor` INT NOT NULL,
  PRIMARY KEY (`IDEstoque`, `IDProduto`, `IDCategoria`, `IDFornecedor`),
  INDEX `fk_Estoque_Produto1_idx` (`IDProduto` ASC),
  INDEX `fk_Estoque_Categoria1_idx` (`IDCategoria` ASC),
  INDEX `fk_Estoque_Fornecedor1_idx` (`IDFornecedor` ASC),
  CONSTRAINT `fk_Estoque_Produto1`
    FOREIGN KEY (`IDProduto`)
    REFERENCES `backoffice`.`Produto` (`IDProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Estoque_Categoria1`
    FOREIGN KEY (`IDCategoria`)
    REFERENCES `backoffice`.`Categoria` (`IDCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Estoque_Fornecedor1`
    FOREIGN KEY (`IDFornecedor`)
    REFERENCES `backoffice`.`Fornecedor` (`IDFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `backoffice`.`Compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `backoffice`.`Compra` (
  `IDCompra` INT NOT NULL AUTO_INCREMENT,
  `Data` DATETIME NOT NULL,
  `Quantidade` BIGINT NULL,
  `Valor` DECIMAL(9,2) NULL,
  `IDProduto` INT NOT NULL,
  `IDNotaFiscal` INT NOT NULL,
  `IDCategoria` INT NOT NULL,
  `IDFornecedor` INT NOT NULL,
  PRIMARY KEY (`IDCompra`, `IDProduto`, `IDNotaFiscal`, `IDCategoria`, `IDFornecedor`),
  INDEX `fk_Compra_Produto1_idx` (`IDProduto` ASC),
  INDEX `fk_Compra_NotaFiscal1_idx` (`IDNotaFiscal` ASC),
  INDEX `fk_Compra_Categoria1_idx` (`IDCategoria` ASC),
  INDEX `fk_Compra_Fornecedor1_idx` (`IDFornecedor` ASC),
  CONSTRAINT `fk_Compra_Produto1`
    FOREIGN KEY (`IDProduto`)
    REFERENCES `backoffice`.`Produto` (`IDProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compra_NotaFiscal1`
    FOREIGN KEY (`IDNotaFiscal`)
    REFERENCES `backoffice`.`NotaFiscal` (`IDNotaFiscal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compra_Categoria1`
    FOREIGN KEY (`IDCategoria`)
    REFERENCES `backoffice`.`Categoria` (`IDCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compra_Fornecedor1`
    FOREIGN KEY (`IDFornecedor`)
    REFERENCES `backoffice`.`Fornecedor` (`IDFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `backoffice`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `backoffice`.`Usuario` (
  `IDUsuario` INT NOT NULL AUTO_INCREMENT,
  `Usuario` VARCHAR(45) NULL,
  `Senha` VARCHAR(45) NULL,
  PRIMARY KEY (`IDUsuario`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
