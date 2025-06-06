-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: eco
-- ------------------------------------------------------
-- Server version	9.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `atendimento`
--

DROP TABLE IF EXISTS `atendimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `atendimento` (
  `protocolo` bigint NOT NULL AUTO_INCREMENT,
  `data_atendimento` date NOT NULL,
  `status` enum('aberto','em atendimento','atendida') NOT NULL DEFAULT 'aberto',
  `funcionario_codigo` varchar(6) NOT NULL,
  `denuncia_id` bigint NOT NULL,
  PRIMARY KEY (`protocolo`),
  KEY `fk_atendimento_admin1_idx` (`funcionario_codigo`),
  KEY `fk_atendimento_denuncia1_idx` (`denuncia_id`),
  CONSTRAINT `fk_atendimento_admin1` FOREIGN KEY (`funcionario_codigo`) REFERENCES `funcionario` (`codigo`),
  CONSTRAINT `fk_atendimento_denuncia1` FOREIGN KEY (`denuncia_id`) REFERENCES `denuncia` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `avaliacoes`
--

DROP TABLE IF EXISTS `avaliacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avaliacoes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `usuario_cpf` varchar(11) NOT NULL,
  `jogos_id` bigint NOT NULL,
  `avaliacao` varchar(255) NOT NULL,
  `comentario` text,
  `data_criacao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_avaliacoes_usuario1_idx` (`usuario_cpf`),
  KEY `fk_avaliacoes_jogos1_idx` (`jogos_id`),
  CONSTRAINT `fk_avaliacoes_jogos1` FOREIGN KEY (`jogos_id`) REFERENCES `jogos` (`id`),
  CONSTRAINT `fk_avaliacoes_usuario1` FOREIGN KEY (`usuario_cpf`) REFERENCES `usuario` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `denuncia`
--

DROP TABLE IF EXISTS `denuncia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `denuncia` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `titulo` varchar(45) NOT NULL,
  `descricao` text NOT NULL,
  `data_criacao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `data_atualizacao` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_cpf` varchar(11) NOT NULL,
  `endereco_cep` varchar(8) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_denuncia_usuario_idx` (`usuario_cpf`),
  KEY `fk_denuncia_endereco1_idx` (`endereco_cep`),
  CONSTRAINT `fk_denuncia_endereco1` FOREIGN KEY (`endereco_cep`) REFERENCES `endereco` (`cep`),
  CONSTRAINT `fk_denuncia_usuario` FOREIGN KEY (`usuario_cpf`) REFERENCES `usuario` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `endereco`
--

DROP TABLE IF EXISTS `endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `endereco` (
  `cep` varchar(8) NOT NULL,
  `estado` varchar(45) NOT NULL,
  `cidade` varchar(45) NOT NULL,
  `bairro` varchar(45) NOT NULL,
  `logradouro` varchar(100) NOT NULL,
  PRIMARY KEY (`cep`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionario` (
  `codigo` varchar(6) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` varchar(45) NOT NULL,
  `senha` varchar(100) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `telefone_UNIQUE` (`telefone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `horarios_coleta`
--

DROP TABLE IF EXISTS `horarios_coleta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `horarios_coleta` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dia_semana` enum('segunda','terça','quarta','quinta','sexta','sabado','domingo') DEFAULT NULL,
  `turno` enum('matutino','vespertino','noturno') DEFAULT NULL,
  `endereco_cep` varchar(8) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `endereco_cep` (`endereco_cep`),
  CONSTRAINT `horarios_coleta_ibfk_1` FOREIGN KEY (`endereco_cep`) REFERENCES `endereco` (`cep`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jogos`
--

DROP TABLE IF EXISTS `jogos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jogos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `genero` varchar(45) NOT NULL,
  `descricao` text,
  `data_lancamento` date DEFAULT NULL,
  `desenvolvedor` varchar(100) DEFAULT NULL,
  `link_jogo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=1745 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resposta`
--

DROP TABLE IF EXISTS `resposta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resposta` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `mensagem` text NOT NULL,
  `atendimento_protocolo` bigint NOT NULL,
  `data_resposta` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_resposta_atendimento1_idx` (`atendimento_protocolo`),
  CONSTRAINT `fk_resposta_atendimento1` FOREIGN KEY (`atendimento_protocolo`) REFERENCES `atendimento` (`protocolo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `cpf` varchar(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `nickname` varchar(65) NOT NULL,
  `email` varchar(45) NOT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `senha` varchar(100) NOT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE KEY `usuariocol_UNIQUE` (`nickname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-06  1:10:31
