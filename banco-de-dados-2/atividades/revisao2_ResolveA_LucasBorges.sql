--  ===  Projeto Revisao 2 (Book-Crossing)  ===
--
--        SCRIPT DE RESOLUCAO DA ATIVIDADE (ResolveA)
--
-- Data Criacao ...........: 26/11/2026
-- Autor(es) ..............: Lucas Guimaraes Borges
-- Banco de Dados .........: MySQL 8.0
-- Base de Dados (nome) ...: books
--
-- PROJETO => 01 Base de Dados
--         => 03 Tabelas
--         => 01 Indice (ratings_UK, ja existente no backup)
--
-- ---------------------------------------------------------

USE books;


-- =========================================================
-- QUESTAO 01
-- =========================================================
-- Instrucao de restauracao do backup (executada no terminal,
-- fora do cliente MySQL, com a base books ja criada):
--
-- mysql -u root -p books < C:\Users\aluno\Desktop\revisaoProvas\backup_Projeto_2.sql


-- =========================================================
-- QUESTAO 02
-- =========================================================
-- Base de dados restaurada ......: books
-- Quantidade de tabelas .........: 03 tabelas
--
-- Tuplas em cada tabela imediatamente apos a restauracao:
--   books   => 19507 tuplas
--   ratings => 26711 tuplas
--   users   =>  9999 tuplas


-- =========================================================
-- QUESTAO 03
-- =========================================================
-- Remove todos os usuarios (users) que NAO fizeram nenhuma
-- avaliacao, ou seja, cujo UserID nao aparece em ratings.
-- Resultado: 6886 tuplas removidas, restando 3113 em users.
-- O modo de atualizacao segura e desligado para que o script
-- execute completamente no MySQL Workbench (erro 1175).

SET SQL_SAFE_UPDATES = 0;

DELETE FROM users
 WHERE UserID NOT IN (SELECT r.UserID
                        FROM ratings r);


-- =========================================================
-- QUESTAO 04
-- =========================================================
-- ISBN, titulo, avaliador, avaliacao e o Acumulador (funcao
-- de janela) que conta acumuladamente as obras avaliadas por
-- um mesmo avaliador, reiniciando em 1 para cada novo
-- avaliador. Retorna 102 tuplas, a ultima sendo:
-- 0312195516, The Red Tent (Bestselling Backlist), 9991, 0, 1

SELECT b.ISBN,
       b.BookTitle,
       r.UserID,
       r.BookRating,
       COUNT(*) OVER (PARTITION BY r.UserID
                          ORDER BY r.ISBN) AS Acumulador
  FROM books b
       INNER JOIN ratings r
               ON r.ISBN = b.ISBN
 WHERE b.ISBN IN ('0385504209', '0316666343', '0312195516')
 ORDER BY r.UserID, r.ISBN;

SHOW STATUS LIKE 'Last_query_cost';


-- =========================================================
-- QUESTAO 05
-- =========================================================
-- Consulta EQUIVALENTE a da questao 04, mantendo a mesma funcao
-- de janela (Acumulador) e as mesmas 102 tuplas na mesma ordem.
--
-- Justificativa tecnica: na questao 04 a janela e o ORDER BY
-- final ordenam por r.ISBN, coluna que nao esta na projecao
-- (a projecao usa b.ISBN). Por isso o otimizador calcula DUAS
-- ordenacoes (filesort): uma para a funcao de janela e outra
-- para o ORDER BY final. Como a juncao garante r.ISBN = b.ISBN,
-- nesta consulta a janela e o ORDER BY usam exatamente as mesmas
-- expressoes da projecao (r.UserID, b.ISBN). Assim o otimizador
-- reaproveita a ordenacao ja feita pela funcao de janela e cobra
-- somente uma ordenacao, reduzindo o custo (Last_query_cost) de
-- cerca de 10,5 para cerca de 6,5, sem precisar criar indice.

SELECT b.ISBN,
       b.BookTitle,
       r.UserID,
       r.BookRating,
       COUNT(*) OVER (PARTITION BY r.UserID
                          ORDER BY b.ISBN) AS Acumulador
  FROM books b
       INNER JOIN ratings r
               ON r.ISBN = b.ISBN
 WHERE b.ISBN IN ('0385504209', '0316666343', '0312195516')
 ORDER BY r.UserID, b.ISBN;

SHOW STATUS LIKE 'Last_query_cost';
