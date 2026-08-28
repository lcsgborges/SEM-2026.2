-- === <<aula1exer1_Evolucao2>> ===
--
--   SCRIPT DE CRIACAO (DDL)
--
-- Data Criacao ...........: 17/08/2026
-- Autor(es) ..............: Beatriz Santos, Lucas Borges
-- Banco de Dados .........: MySQL 8.0
-- Base de Dados (nome) ...: aula1exer1_Evolucao2
--
-- PROJETO => 01 Base de Dados
--            8 Tabelas
--
-- Ultimas Alteracoes
-- 24/08/2026 => Correcao do cabecalho
-- 24/08/2026 => Evolucao do modelo para aula1exer1_Evolucao2
-- 24/08/2026 => Adicao do atributo nomeProduto
-- 24/08/2026 => Nomeacao das constraints de chave primaria
-- ---------------------------------------------------------


CREATE DATABASE
    IF NOT EXISTS aula1exer1_Evolucao2;

USE aula1exer1_Evolucao2;


-- ---------------------------------------------------------
-- Cria Tabela PESSOA
-- ---------------------------------------------------------

CREATE TABLE PESSOA (
    cpfPessoa VARCHAR(11) NOT NULL,
    nomePessoa VARCHAR(60) NOT NULL,
    senha VARCHAR(255) NOT NULL,

    CONSTRAINT PK_PESSOA
        PRIMARY KEY (cpfPessoa)
);


-- ---------------------------------------------------------
-- Cria Tabela EMPREGADO
-- ---------------------------------------------------------

CREATE TABLE EMPREGADO (
    matriculaEmpregado INT NOT NULL AUTO_INCREMENT,
    logradouro VARCHAR(50),
    numero VARCHAR(5),
    cep VARCHAR(8),
    bairro VARCHAR(18),
    cidade VARCHAR(30),
    estado CHAR(2),
    complemento VARCHAR(50),
    cpfPessoa VARCHAR(11) NOT NULL,

    CONSTRAINT PK_EMPREGADO
        PRIMARY KEY (matriculaEmpregado),

    CONSTRAINT FK_EMPREGADO_PESSOA
        FOREIGN KEY (cpfPessoa)
        REFERENCES PESSOA (cpfPessoa)
        ON DELETE CASCADE
);


-- ---------------------------------------------------------
-- Cria Tabela GERENTE
-- ---------------------------------------------------------

CREATE TABLE GERENTE (
    formacaoEscolar VARCHAR(50),
    email VARCHAR(100) NOT NULL,
    cpfPessoa VARCHAR(11) NOT NULL,

    CONSTRAINT PK_GERENTE
        PRIMARY KEY (cpfPessoa),

    CONSTRAINT FK_GERENTE_PESSOA
        FOREIGN KEY (cpfPessoa)
        REFERENCES PESSOA (cpfPessoa)
        ON DELETE CASCADE
);


-- ---------------------------------------------------------
-- Cria Tabela VENDA
-- ---------------------------------------------------------

CREATE TABLE VENDA (
    codVenda INT NOT NULL AUTO_INCREMENT,
    dataVenda DATE,
    precoTotal DECIMAL(8,2),
    matriculaEmpregado INT NOT NULL,

    CONSTRAINT PK_VENDA
        PRIMARY KEY (codVenda),

    CONSTRAINT FK_VENDA_EMPREGADO
        FOREIGN KEY (matriculaEmpregado)
        REFERENCES EMPREGADO (matriculaEmpregado)
        ON DELETE RESTRICT
);


-- ---------------------------------------------------------
-- Cria Tabela PRODUTO
-- ---------------------------------------------------------

CREATE TABLE PRODUTO (
    codProduto INT NOT NULL AUTO_INCREMENT,
    nomeProduto VARCHAR(50) NOT NULL,
    precoProduto DECIMAL(8,2),

    CONSTRAINT PK_PRODUTO
        PRIMARY KEY (codProduto)
);


-- ---------------------------------------------------------
-- Cria Tabela telefone
-- Atributo multivalorado de EMPREGADO
-- ---------------------------------------------------------

CREATE TABLE telefone (
    telefone VARCHAR(15) NOT NULL,
    matriculaEmpregado INT NOT NULL,

    CONSTRAINT PK_TELEFONE
        PRIMARY KEY (telefone, matriculaEmpregado),

    CONSTRAINT FK_TELEFONE_EMPREGADO
        FOREIGN KEY (matriculaEmpregado)
        REFERENCES EMPREGADO (matriculaEmpregado)
        ON DELETE CASCADE
);


-- ---------------------------------------------------------
-- Cria Tabela supervisiona
-- Relacionamento N:N entre GERENTE e EMPREGADO
-- ---------------------------------------------------------

CREATE TABLE supervisiona (
    cpfGerente VARCHAR(11) NOT NULL,
    matriculaEmpregado INT NOT NULL,
    area VARCHAR(50) NOT NULL,

    CONSTRAINT PK_SUPERVISIONA
        PRIMARY KEY (
            cpfGerente,
            matriculaEmpregado,
            area
        ),

    CONSTRAINT FK_SUPERVISIONA_GERENTE
        FOREIGN KEY (cpfGerente)
        REFERENCES GERENTE (cpfPessoa)
        ON DELETE RESTRICT,

    CONSTRAINT FK_SUPERVISIONA_EMPREGADO
        FOREIGN KEY (matriculaEmpregado)
        REFERENCES EMPREGADO (matriculaEmpregado)
        ON DELETE RESTRICT
);


-- ---------------------------------------------------------
-- Cria Tabela contem
-- Relacionamento N:N entre VENDA e PRODUTO
-- ---------------------------------------------------------

CREATE TABLE contem (
    codVenda INT NOT NULL,
    codProduto INT NOT NULL,
    quantidade INT,
    precoUnitario DECIMAL(8,2),

    CONSTRAINT PK_CONTEM
        PRIMARY KEY (
            codVenda,
            codProduto
        ),

    CONSTRAINT FK_CONTEM_VENDA
        FOREIGN KEY (codVenda)
        REFERENCES VENDA (codVenda)
        ON DELETE RESTRICT,

    CONSTRAINT FK_CONTEM_PRODUTO
        FOREIGN KEY (codProduto)
        REFERENCES PRODUTO (codProduto)
        ON DELETE RESTRICT
);