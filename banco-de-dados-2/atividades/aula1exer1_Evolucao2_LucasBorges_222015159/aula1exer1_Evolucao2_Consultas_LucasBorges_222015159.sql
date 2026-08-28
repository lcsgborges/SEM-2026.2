-- === <<aula1exer1_Evolucao2_Consultas>> ===
--
--   SCRIPT DE CONSULTAS
--
-- Data Criacao ...........: 24/08/2026
-- Autor(es) ..............: Lucas Borges
-- Banco de Dados .........: MySQL 8.0
-- Base de Dados (nome) ...: aula1exer1_Evolucao2
--
-- PROJETO => 05 Consultas
--            01 View
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- A)
-- Consultar todas as vendas feitas por um empregado
-- especifico, definido pela chave primaria do empregado.
--
-- Empregado escolhido: matriculaEmpregado = 1
-- ---------------------------------------------------------

SELECT
    e.matriculaEmpregado,
    p.nomePessoa,
    v.codVenda,
    v.dataVenda,
    v.precoTotal
FROM EMPREGADO e
    JOIN PESSOA p
        ON e.cpfPessoa = p.cpfPessoa
    JOIN VENDA v
        ON e.matriculaEmpregado = v.matriculaEmpregado
WHERE e.matriculaEmpregado = 1
ORDER BY v.dataVenda ASC;


-- ---------------------------------------------------------
-- B)
-- Relacionar todos os dados da venda de codigo 1 com todas
-- as informacoes dos produtos comercializados nessa venda.
-- Apresentar tambem o preco total de cada item.
--
-- Venda escolhida: codVenda = 1
-- ---------------------------------------------------------

SELECT
    v.codVenda,
    v.dataVenda,
    v.precoTotal,
    v.matriculaEmpregado,
    p.codProduto,
    p.nomeProduto,
    p.precoProduto,
    c.quantidade,
    c.precoUnitario,
    (c.quantidade * c.precoUnitario) AS precoTotalItem
FROM VENDA v
    JOIN contem c
        ON v.codVenda = c.codVenda
    JOIN PRODUTO p
        ON c.codProduto = p.codProduto
WHERE v.codVenda = 1
ORDER BY p.nomeProduto ASC;


-- ---------------------------------------------------------
-- C)
-- Mostrar todos os empregados que NAO sejam gerentes,
-- em ordem alfabetica crescente pelo nome do empregado.
-- ---------------------------------------------------------

SELECT
    e.matriculaEmpregado,
    p.cpfPessoa,
    p.nomePessoa
FROM EMPREGADO e
    JOIN PESSOA p
        ON e.cpfPessoa = p.cpfPessoa
    LEFT JOIN GERENTE g
        ON p.cpfPessoa = g.cpfPessoa
WHERE g.cpfPessoa IS NULL
ORDER BY p.nomePessoa ASC;


-- ---------------------------------------------------------
-- D)
-- Criar uma VIEW que apresenta a quantidade total vendida
-- de cada produto comercializado pela empresa.
--
-- Sao apresentados o nome, codigo, preco e quantidade total
-- vendida de cada produto.
-- ---------------------------------------------------------

CREATE VIEW VW_QUANTIDADE_PRODUTOS_VENDIDOS AS
SELECT
    p.nomeProduto,
    p.codProduto,
    p.precoProduto,
    SUM(c.quantidade) AS quantidadeVendida
FROM PRODUTO p
    JOIN contem c
        ON p.codProduto = c.codProduto
GROUP BY
    p.nomeProduto,
    p.codProduto,
    p.precoProduto;


-- Consulta da VIEW criada no item D.

SELECT
    nomeProduto,
    codProduto,
    precoProduto,
    quantidadeVendida
FROM VW_QUANTIDADE_PRODUTOS_VENDIDOS
ORDER BY nomeProduto ASC;


-- ---------------------------------------------------------
-- E)
-- Consultar produtos utilizando qualquer parte do nome.
--
-- Ordenar pelo nome do produto em ordem alfabetica
-- decrescente.
-- ---------------------------------------------------------

SELECT
    p.codProduto,
    p.nomeProduto,
    COUNT(DISTINCT c.codVenda) AS quantidadeVendas
FROM PRODUTO p
    LEFT JOIN contem c
        ON p.codProduto = c.codProduto
WHERE p.nomeProduto LIKE '%azul%'
GROUP BY
    p.codProduto,
    p.nomeProduto
ORDER BY p.nomeProduto DESC;