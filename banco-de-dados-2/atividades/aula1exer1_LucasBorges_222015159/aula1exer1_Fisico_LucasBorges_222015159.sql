-- ------------------------------------------------------
-- Projeto de Banco de Dados - Banco MySQL
-- Base de Dados = aula1exer1
--   01 = Base de Dados
--   02 = Tabelas
--
-- Aluno: Lucas Borges
-- Matricula: 22/2015159
--
-- SGBD: MySQL 8.4
-- Criado: 17/08/2026 - criacao da base e das tabelas
-- ------------------------------------------------------
---

-- Cria Base de Dados AULA1EXER1
--
CREATE DATABASE
  IF NOT EXISTS aula1exer1
  DEFAULT CHARACTER SET utf8mb4;
USE aula1exer1;

-- Cria Tabela PESSOA
--
CREATE TABLE `pessoa` (
  `cpf` char(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  PRIMARY KEY (`cpf`),
  CONSTRAINT `ck_pessoa_cpf` CHECK (`cpf` REGEXP '^[0-9]{11}$')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Cria Tabela EMPREGADO
--
CREATE TABLE `empregado` (
  `cpf` char(11) NOT NULL,
  `matricula` varchar(20) NOT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE KEY `un_empregado_matricula` (`matricula`),
  CONSTRAINT `fk_empregado_pessoa` FOREIGN KEY (`cpf`)
    REFERENCES `pessoa` (`cpf`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Cria Tabela GERENTE
--
CREATE TABLE `gerente` (
  `cpf` char(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `formacaoEscolar` enum('Primario','Medio','Superior','Pos-Graduacao') NOT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE KEY `un_gerente_email` (`email`),
  CONSTRAINT `fk_gerente_pessoa` FOREIGN KEY (`cpf`)
    REFERENCES `pessoa` (`cpf`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Cria Tabela TELEFONE
--
CREATE TABLE `telefone` (
  `cpf` char(11) NOT NULL,
  `telefone` varchar(15) NOT NULL,
  PRIMARY KEY (`cpf`,`telefone`),
  CONSTRAINT `fk_telefone_empregado` FOREIGN KEY (`cpf`)
    REFERENCES `empregado` (`cpf`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Cria Tabela ENDERECO
--
CREATE TABLE `endereco` (
  `idEndereco` int(11) NOT NULL AUTO_INCREMENT,
  `cpf` char(11) NOT NULL,
  `cep` char(8) NOT NULL,
  `rua` varchar(100) NOT NULL,
  `numero` varchar(10) NOT NULL,
  `bairro` varchar(50) NOT NULL,
  `cidade` varchar(50) NOT NULL,
  `estado` char(2) NOT NULL,
  PRIMARY KEY (`idEndereco`),
  UNIQUE KEY `un_endereco_empregado` (`cpf`),
  CONSTRAINT `ck_endereco_cep` CHECK (`cep` REGEXP '^[0-9]{8}$'),
  CONSTRAINT `fk_endereco_empregado` FOREIGN KEY (`cpf`)
    REFERENCES `empregado` (`cpf`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Cria Tabela SUPERVISIONA
--
CREATE TABLE `supervisiona` (
  `cpfGerente` char(11) NOT NULL,
  `cpfEmpregado` char(11) NOT NULL,
  `area` varchar(50) NOT NULL,
  PRIMARY KEY (`cpfGerente`,`cpfEmpregado`,`area`),
  CONSTRAINT `fk_supervisiona_gerente` FOREIGN KEY (`cpfGerente`)
    REFERENCES `gerente` (`cpf`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_supervisiona_empregado` FOREIGN KEY (`cpfEmpregado`)
    REFERENCES `empregado` (`cpf`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Cria Tabela PRODUTO
--
CREATE TABLE `produto` (
  `idProduto` int(11) NOT NULL AUTO_INCREMENT,
  `nomeProduto` varchar(100) NOT NULL,
  PRIMARY KEY (`idProduto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Cria Tabela NOTAFISCAL
--
CREATE TABLE `notafiscal` (
  `idNotaFiscal` int(11) NOT NULL AUTO_INCREMENT,
  `dataVenda` date NOT NULL,
  `cpfEmpregado` char(11) NOT NULL,
  PRIMARY KEY (`idNotaFiscal`),
  CONSTRAINT `fk_notafiscal_empregado` FOREIGN KEY (`cpfEmpregado`)
    REFERENCES `empregado` (`cpf`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Cria Tabela POSSUI
--
CREATE TABLE `possui` (
  `idNotaFiscal` int(11) NOT NULL,
  `idProduto` int(11) NOT NULL,
  `quantidade` decimal(5,0) NOT NULL,
  `precoUnitario` decimal(8,2) NOT NULL,
  `precoTotalItem` decimal(13,2) GENERATED ALWAYS AS
    (`quantidade` * `precoUnitario`) STORED,
  PRIMARY KEY (`idNotaFiscal`,`idProduto`),
  CONSTRAINT `ck_possui_quantidade` CHECK (`quantidade` > 0),
  CONSTRAINT `ck_possui_preco` CHECK (`precoUnitario` >= 0),
  CONSTRAINT `fk_possui_notafiscal` FOREIGN KEY (`idNotaFiscal`)
    REFERENCES `notafiscal` (`idNotaFiscal`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_possui_produto` FOREIGN KEY (`idProduto`)
    REFERENCES `produto` (`idProduto`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
