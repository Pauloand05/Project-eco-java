-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema eco
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema eco
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `eco` DEFAULT CHARACTER SET utf8mb3 ;
USE `eco` ;

-- -----------------------------------------------------
-- Table `eco`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eco`.`funcionario` (
  `codigo` VARCHAR(6) NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `telefone_UNIQUE` (`telefone` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `eco`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eco`.`endereco` (
  `cep` VARCHAR(8) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `logradouro` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`cep`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `eco`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eco`.`usuario` (
  `cpf` VARCHAR(11) NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `nickname` VARCHAR(65) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(15) NULL DEFAULT NULL,
  `senha` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE INDEX `usuariocol_UNIQUE` (`nickname` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `eco`.`denuncia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eco`.`denuncia` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `descricao` TEXT NOT NULL,
  `data_criacao` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `data_atualizacao` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_cpf` VARCHAR(11) NOT NULL,
  `endereco_cep` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_denuncia_usuario_idx` (`usuario_cpf` ASC) VISIBLE,
  INDEX `fk_denuncia_endereco1_idx` (`endereco_cep` ASC) VISIBLE,
  CONSTRAINT `fk_denuncia_endereco1`
    FOREIGN KEY (`endereco_cep`)
    REFERENCES `eco`.`endereco` (`cep`),
  CONSTRAINT `fk_denuncia_usuario`
    FOREIGN KEY (`usuario_cpf`)
    REFERENCES `eco`.`usuario` (`cpf`))
ENGINE = InnoDB
AUTO_INCREMENT = 101
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `eco`.`atendimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eco`.`atendimento` (
  `protocolo` BIGINT NOT NULL AUTO_INCREMENT,
  `data_atendimento` DATE NOT NULL,
  `status` ENUM('aberto', 'em atendimento', 'atendida') NOT NULL DEFAULT 'aberto',
  `funcionario_codigo` VARCHAR(6) NOT NULL,
  `denuncia_id` BIGINT NOT NULL,
  PRIMARY KEY (`protocolo`),
  INDEX `fk_atendimento_admin1_idx` (`funcionario_codigo` ASC) VISIBLE,
  INDEX `fk_atendimento_denuncia1_idx` (`denuncia_id` ASC) VISIBLE,
  CONSTRAINT `fk_atendimento_admin1`
    FOREIGN KEY (`funcionario_codigo`)
    REFERENCES `eco`.`funcionario` (`codigo`),
  CONSTRAINT `fk_atendimento_denuncia1`
    FOREIGN KEY (`denuncia_id`)
    REFERENCES `eco`.`denuncia` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `eco`.`jogos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eco`.`jogos` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `genero` VARCHAR(45) NOT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  `data_lancamento` DATE NULL DEFAULT NULL,
  `desenvolvedor` VARCHAR(100) NULL DEFAULT NULL,
  `link_jogo` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `unique_nome` (`nome` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1744
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `eco`.`avaliacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eco`.`avaliacoes` (
  `id` BIGINT NOT NULL,
  `usuario_cpf` VARCHAR(11) NOT NULL,
  `jogos_id` BIGINT NOT NULL,
  `avaliacao` ENUM('1', '2', '3', '4', '5') NOT NULL,
  `comentario` TEXT NULL DEFAULT NULL,
  `data_criacao` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_avaliacoes_usuario1_idx` (`usuario_cpf` ASC) VISIBLE,
  INDEX `fk_avaliacoes_jogos1_idx` (`jogos_id` ASC) VISIBLE,
  CONSTRAINT `fk_avaliacoes_jogos1`
    FOREIGN KEY (`jogos_id`)
    REFERENCES `eco`.`jogos` (`id`),
  CONSTRAINT `fk_avaliacoes_usuario1`
    FOREIGN KEY (`usuario_cpf`)
    REFERENCES `eco`.`usuario` (`cpf`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `eco`.`horarios_coleta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eco`.`horarios_coleta` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `dia_semana` ENUM('segunda', 'terça', 'quarta', 'quinta', 'sexta', 'sabado', 'domingo') NULL DEFAULT NULL,
  `turno` ENUM('matutino', 'vespertino', 'noturno') NULL DEFAULT NULL,
  `endereco_cep` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `endereco_cep` (`endereco_cep` ASC) VISIBLE,
  CONSTRAINT `horarios_coleta_ibfk_1`
    FOREIGN KEY (`endereco_cep`)
    REFERENCES `eco`.`endereco` (`cep`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `eco`.`resposta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eco`.`resposta` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `mensagem` TEXT NOT NULL,
  `atendimento_protocolo` BIGINT NOT NULL,
  `data_resposta` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_resposta_atendimento1_idx` (`atendimento_protocolo` ASC) VISIBLE,
  CONSTRAINT `fk_resposta_atendimento1`
    FOREIGN KEY (`atendimento_protocolo`)
    REFERENCES `eco`.`atendimento` (`protocolo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
