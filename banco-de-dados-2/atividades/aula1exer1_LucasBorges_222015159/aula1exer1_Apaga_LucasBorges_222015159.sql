-- ------------------------------------------------------
-- Projeto de Banco de Dados - Banco MySQL
-- Base de Dados = aula1exer1
--   04 = Remocao das Tabelas
--
-- Aluno: Lucas Borges
-- Matricula: 22/2015159
--
-- A base de dados aula1exer1 NAO e removida, permanecendo
-- no SGBD apos a execucao deste script.
--
-- A ordem de remocao e a inversa da ordem de criacao: toda
-- tabela que possui chave estrangeira e removida antes da
-- tabela que ela referencia, evitando erro de integridade
-- referencial.
--
-- SGBD: MySQL 8.4
-- Criado: 17/08/2026 - remocao das tabelas
-- ------------------------------------------------------
---

USE aula1exer1;

-- Apaga Tabela POSSUI
--
DROP TABLE `possui`;

-- Apaga Tabela NOTAFISCAL
--
DROP TABLE `notafiscal`;

-- Apaga Tabela PRODUTO
--
DROP TABLE `produto`;

-- Apaga Tabela SUPERVISIONA
--
DROP TABLE `supervisiona`;

-- Apaga Tabela ENDERECO
--
DROP TABLE `endereco`;

-- Apaga Tabela TELEFONE
--
DROP TABLE `telefone`;

-- Apaga Tabela GERENTE
--
DROP TABLE `gerente`;

-- Apaga Tabela EMPREGADO
--
DROP TABLE `empregado`;

-- Apaga Tabela PESSOA
--
DROP TABLE `pessoa`;
