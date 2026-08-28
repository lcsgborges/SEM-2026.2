-- === <<aula1exer1_Evolucao2_Popula>> ===
--
--   SCRIPT DE POPULACAO (DML)
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
-- 24/08/2026 => Alteracao do script de populacao
--            => Adiciona novos dados nas tabelas
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- Insere dados na tabela PESSOA
-- 10 tuplas
-- ---------------------------------------------------------

INSERT INTO PESSOA
    (cpfPessoa, nomePessoa, senha)
VALUES
    ('11111111111', 'Ana Souza',      'senha123'),
    ('22222222222', 'Bruno Lima',     'senha456'),
    ('33333333333', 'Carla Mendes',   'senha789'),
    ('44444444444', 'Diego Alves',    'senha321'),
    ('55555555555', 'Elisa Rocha',    'senha654'),
    ('66666666666', 'Fabio Costa',    'senha987'),
    ('77777777777', 'Gabriela Nunes', 'senha147'),
    ('88888888888', 'Hugo Martins',   'senha258'),
    ('99999999999', 'Isabela Torres', 'senha369'),
    ('12345678901', 'Joao Ribeiro',   'senha741');


-- ---------------------------------------------------------
-- Insere dados na tabela EMPREGADO
-- 7 tuplas
--
-- Ana Souza (CPF 11111111111) tambem sera GERENTE.
-- ---------------------------------------------------------

INSERT INTO EMPREGADO
    (matriculaEmpregado, logradouro, numero, cep, bairro, cidade, estado, complemento, cpfPessoa)
VALUES
    (1, 'Rua das Flores', '10', '70000001', 'Asa Sul', 'Brasilia', 'DF', 'Apto 101', '11111111111'),
    (2, 'Rua dos Ipes', '25', '70000002', 'Asa Norte', 'Brasilia', 'DF', 'Apto 202', '33333333333'),
    (3, 'Avenida Central', '150', '70000003', 'Taguatinga', 'Brasilia', 'DF', NULL, '44444444444'),
    (4, 'Rua Primavera', '88', '70000004', 'Guara', 'Brasilia', 'DF', 'Casa 2', '55555555555'),
    (5, 'Rua das Palmeiras', '42', '70000005', 'Ceilandia', 'Brasilia', 'DF', NULL, '66666666666'),
    (6, 'Avenida Brasil', '77', '70000006', 'Samambaia', 'Brasilia', 'DF', 'Bloco B', '77777777777'),
    (7, 'Rua do Comercio', '15', '70000007', 'Sobradinho', 'Brasilia', 'DF', NULL, '88888888888');


-- ---------------------------------------------------------
-- Insere dados na tabela GERENTE
-- 7 tuplas
--
-- Ana Souza (CPF 11111111111) e simultaneamente
-- EMPREGADO e GERENTE.
--
-- Bruno Lima (CPF 22222222222) sera GERENTE de
-- duas areas diferentes.
-- ---------------------------------------------------------

INSERT INTO GERENTE
    (formacaoEscolar, email, cpfPessoa)
VALUES
    ('Ensino Superior Completo', 'ana.souza@loja.com',      '11111111111'),
    ('Ensino Superior Completo', 'bruno.lima@loja.com',     '22222222222'),
    ('Ensino Medio Completo',    'carla.mendes@loja.com',   '33333333333'),
    ('Ensino Superior Completo', 'diego.alves@loja.com',    '44444444444'),
    ('Ensino Medio Completo',    'elisa.rocha@loja.com',    '55555555555'),
    ('Ensino Superior Incompleto','fabio.costa@loja.com',   '66666666666'),
    ('Ensino Medio Completo',    'gabriela.nunes@loja.com', '77777777777');


-- ---------------------------------------------------------
-- Insere dados na tabela PRODUTO
-- 7 tuplas
-- ---------------------------------------------------------

INSERT INTO PRODUTO
    (codProduto, nomeProduto, precoProduto)
VALUES
    (1, 'Caderno Universitario', 12.50),
    (2, 'Caneta Esferografica', 25.00),
    (3, 'Lapiseira', 8.90),
    (4, 'Mochila', 45.00),
    (5, 'Estojo', 18.75),
    (6, 'Calculadora', 60.00),
    (7, 'Agenda', 32.40);


-- ---------------------------------------------------------
-- Insere dados na tabela VENDA
-- 7 tuplas
--
-- A VENDA de codigo 1 possui dois produtos diferentes.
-- ---------------------------------------------------------

INSERT INTO VENDA
    (codVenda, dataVenda, precoTotal, matriculaEmpregado)
VALUES
    (1, '2026-08-01', 50.00, 1),
    (2, '2026-08-02', 26.70, 2),
    (3, '2026-08-03', 45.00, 3),
    (4, '2026-08-04', 37.50, 4),
    (5, '2026-08-05', 60.00, 5),
    (6, '2026-08-06', 64.80, 6),
    (7, '2026-08-07', 50.00, 7);


-- ---------------------------------------------------------
-- Insere dados na tabela telefone
-- 8 tuplas
--
-- O empregado de matricula 1 possui dois telefones,
-- representando o atributo multivalorado telefone.
-- ---------------------------------------------------------

INSERT INTO telefone
    (telefone, matriculaEmpregado)
VALUES
    ('61999990001', 1),
    ('61988880001', 1),
    ('61999990002', 2),
    ('61999990003', 3),
    ('61999990004', 4),
    ('61999990005', 5),
    ('61999990006', 6),
    ('61999990007', 7);


-- ---------------------------------------------------------
-- Insere dados na tabela supervisiona
-- 8 tuplas
-- ---------------------------------------------------------

INSERT INTO supervisiona
    (cpfGerente, matriculaEmpregado, area)
VALUES
    ('22222222222', 1, 'Informatica'),
    ('22222222222', 2, 'Livraria'),
    ('11111111111', 3, 'Papelaria'),
    ('33333333333', 4, 'Eletronicos'),
    ('44444444444', 5, 'Games'),
    ('55555555555', 6, 'Telefonia'),
    ('66666666666', 7, 'Acessorios'),
    ('77777777777', 1, 'Utilidades');


-- ---------------------------------------------------------
-- Insere dados na tabela contem
-- 8 tuplas
-- ---------------------------------------------------------

INSERT INTO contem
    (codVenda, codProduto, quantidade, precoUnitario)
VALUES
    (1, 1, 2, 12.50),
    (1, 2, 1, 25.00),
    (2, 3, 3, 8.90),
    (3, 4, 1, 45.00),
    (4, 5, 2, 18.75),
    (5, 6, 1, 60.00),
    (6, 7, 2, 32.40),
    (7, 2, 2, 25.00);