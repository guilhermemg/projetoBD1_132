-- Universidade Federal de Campina Grande
-- Centro de Engenharia Eletrica e Informatica
-- Departamento de Sistemas e Computacao
-- Curso de Ciência da Computacao

-- Disciplina: Banco de Dados 1
-- Professor: Claudio Baptista

-- Projeto Etapa 3
-- Equipe: Anderson Thelles Claudino da Silva
--         Armstrong Mardilson da Silva Goes 
--         Guilheme Monteiro Gadelha
--         Werton Guimarães Gomes 
 

-- Script de resposta (Consultas)


-- 1. Liste todos os arbitros cadastrados.
SELECT  * FROM T_ARBITRAGEM;

-- 2. Qual o arbitro com a menor matricula?
SELECT * FROM  T_ARBITRAGEM WHERE "matricula" IN (SELECT MIN("matricula") FROM  T_ARBITRAGEM);

-- 3. Crie uma view que liste o nome dos times por ordem alfabetica.
CREATE VIEW times(nome) AS
SELECT "nome" FROM  T_TIME
ORDER BY "nome" ASC;

-- 4. Faca uma trigger que obrigue que um jogo tenha somente jogadores dos dois times. 

-- 5. Faca uma trigger que obrigue que todos os profissionais sejam maiores de 18 anos considerando para este calculo a data de insercao do profissional.
-- 6. Liste todos os estadios ordenados, decrescentemente, pela capacidade de publico.
SELECT "nome" FROM  T_ESTADIO ORDER BY "capacidade" DESC;

-- 7. Qual a media de capacidade dos estadios cadastrados?
SELECT AVG("capacidade") FROM T_ESTADIO;

-- 8. Liste somente os jogadores que um time especifico possui passe no momento da consulta.
-- 9. Liste apenas os estadios cujo nome contenha as letras "P" ou "B".
SELECT * FROM "T_ESTADIO"
WHERE "nome" LIKE '%P%'
or "nome" LIKE'%B%';

-- 10. Liste apenas os jogos que serao encerrados entre 17h e 21h (considere que os jogos têm duração exata de 90 minutos).
SELECT * FROM "T_JOGO"
WHERE TO_CHAR("data", 'HH24:MI:SS') >= '15:30:00'
and TO_CHAR("data", 'HH24:MI:SS') <= '19:30:00'

-- 11. Liste o nome do jogador e o total de passes que ele ja teve com os times ao longo de sua carreira, por ordem decrescente do total de passes. 
-- So devem ser incluidos na lista os jogadores que tenham registrado passe com, pelo menos, dois times.

-- 12. Quais foram os jogadores que marcaram gols na rodada do dia 23/02/2014?

-- 13. Liste os jogadores com mais de 2 cartoes de vermelhos.
SELECT "nome", "vermelhos"
FROM
(
    SELECT "nome", SUM("vermelhos") AS "vermelhos"
    FROM T_PROFISSIONAL, T_JOGO_JOGADOR_JOGA
    WHERE "numCadastro" = "numJogador"
    GROUP BY "nome"
)
WHERE "vermelhos" > 2

-- 14. Crie uma view que liste os times que possuem contrato de 2 anos ou mais com pelo menos 1 jogador.

-- 15. Quais foram os tecnicos que treinaram mais de um time no campeonato?
SELECT T_PROFISSIONAL."nome"
FROM T_PROFISSIONAL
WHERE T_PROFISSIONAL."numCadastro" IN
(
    SELECT T_TECNICO."numCadastro"
    FROM T_TECNICO, T_TIME_PROFISSIONAL
    WHERE T_TECNICO."numCadastro" = T_TIME_PROFISSIONAL."numProfissional"
    GROUP BY T_TECNICO."numCadastro"
    HAVING COUNT(*) > 1
)

