-- ------------------------------------------------------
-- Projeto de Banco de Dados - Banco MySQL
-- Base de Dados = aula1exer1
--   03 = Povoamento das Tabelas
--
-- Aluno: Lucas Borges
-- Matricula: 22/2015159
--
-- SGBD: MySQL 8.4
-- Criado: 17/08/2026 - insercao das tuplas iniciais
-- ------------------------------------------------------
---

USE aula1exer1;

-- Insere Tuplas na Tabela PESSOA
--
INSERT INTO `pessoa` (`cpf`, `nome`, `senha`) VALUES
  ('11122233344', 'Ana Lima Ferreira',      'senha@Ana2026'),
  ('22233344455', 'Bruno Souza Martins',    'senha@Bruno2026'),
  ('33344455566', 'Carla Dias Nogueira',    'senha@Carla2026'),
  ('44455566677', 'Diego Rocha Almeida',    'senha@Diego2026'),
  ('55566677788', 'Elisa Prado Cavalcanti', 'senha@Elisa2026'),
  ('66677788899', 'Fabio Nunes Barreto',    'senha@Fabio2026');

-- Insere Tuplas na Tabela EMPREGADO
--
INSERT INTO `empregado` (`cpf`, `matricula`) VALUES
  ('11122233344', 'EMP0001'),
  ('22233344455', 'EMP0002'),
  ('33344455566', 'EMP0003'),
  ('66677788899', 'EMP0004');

-- Insere Tuplas na Tabela GERENTE
--
-- O cpf 66677788899 consta em EMPREGADO e em GERENTE,
-- comprovando a especializacao sobreposta do modelo.
--
INSERT INTO `gerente` (`cpf`, `email`, `formacaoEscolar`) VALUES
  ('44455566677', 'diego.rocha@empresa.com.br', 'Superior'),
  ('55566677788', 'elisa.prado@empresa.com.br', 'Pos-Graduacao'),
  ('66677788899', 'fabio.nunes@empresa.com.br', 'Medio');

-- Insere Tuplas na Tabela TELEFONE
--
INSERT INTO `telefone` (`cpf`, `telefone`) VALUES
  ('11122233344', '61988887777'),
  ('11122233344', '6133334444'),
  ('22233344455', '61977776666'),
  ('33344455566', '61966665555'),
  ('66677788899', '61955554444');

-- Insere Tuplas na Tabela ENDERECO
--
INSERT INTO `endereco`
  (`cpf`, `cep`, `rua`, `numero`, `bairro`, `cidade`, `estado`) VALUES
  ('11122233344', '72220140', 'Quadra 200 Conjunto 5', '12',  'Ceilandia',  'Brasilia', 'DF'),
  ('22233344455', '70830020', 'SQN 410 Bloco B',       '204', 'Asa Norte',  'Brasilia', 'DF'),
  ('33344455566', '71900100', 'Avenida das Araucarias','1500','Aguas Claras','Brasilia','DF'),
  ('66677788899', '72015115', 'Quadra 15 Lote 3',      '7',   'Taguatinga', 'Brasilia', 'DF');

-- Insere Tuplas na Tabela SUPERVISIONA
--
-- O empregado 11122233344 possui dois gerentes, por atuar
-- em areas diferentes, e o gerente 44455566677 supervisiona
-- o empregado 33344455566 em duas areas distintas.
--
INSERT INTO `supervisiona` (`cpfGerente`, `cpfEmpregado`, `area`) VALUES
  ('44455566677', '11122233344', 'Informatica'),
  ('55566677788', '11122233344', 'Eletrodomesticos'),
  ('44455566677', '22233344455', 'Informatica'),
  ('44455566677', '33344455566', 'Moveis'),
  ('44455566677', '33344455566', 'Informatica'),
  ('66677788899', '22233344455', 'Telefonia');

-- Insere Tuplas na Tabela PRODUTO
--
INSERT INTO `produto` (`idProduto`, `nomeProduto`) VALUES
  (1, 'Notebook 15 polegadas'),
  (2, 'Mouse sem fio'),
  (3, 'Geladeira Frost Free 400L'),
  (4, 'Cadeira de escritorio'),
  (5, 'Smartphone 128GB');

-- Insere Tuplas na Tabela NOTAFISCAL
--
INSERT INTO `notafiscal` (`idNotaFiscal`, `dataVenda`, `cpfEmpregado`) VALUES
  (1, '2026-03-10', '11122233344'),
  (2, '2026-03-11', '22233344455'),
  (3, '2026-04-02', '33344455566'),
  (4, '2026-04-15', '66677788899'),
  (5, '2026-05-08', '11122233344');

-- Insere Tuplas na Tabela POSSUI
--
-- A coluna precoTotalItem nao e informada por ser atributo
-- derivado, calculado automaticamente pelo SGBD.
--
INSERT INTO `possui`
  (`idNotaFiscal`, `idProduto`, `quantidade`, `precoUnitario`) VALUES
  (1, 1, 1,  4250.00),
  (1, 2, 2,    89.90),
  (2, 3, 1,  3199.00),
  (3, 4, 6,   749.50),
  (3, 2, 6,    85.00),
  (4, 5, 3,  2100.00),
  (5, 1, 2,  4180.00),
  (5, 5, 1,  2050.00);
