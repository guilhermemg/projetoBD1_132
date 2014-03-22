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
 

-- Script de resposta (Insercoes)
-- As respostas esperadas são dadas com base no script gabarito.

-- Consulta 9
INSERT INTO "T_TIME_PASSE_JOG" VALUES (2, 2, TO_DATE('01.01.2000', 'MM.DD.YYYY'), NULL)
INSERT INTO "T_TIME_PASSE_JOG" VALUES (1, 4, TO_DATE('01.01.2000', 'MM.DD.YYYY'), NULL)
INSERT INTO "T_TIME_PASSE_JOG" VALUES (2, 4, TO_DATE('01.01.2000', 'MM.DD.YYYY'), NULL)
INSERT INTO "T_TIME_PASSE_JOG" VALUES (2, 5, TO_DATE('01.01.2000', 'MM.DD.YYYY'), NULL)
-- Resposta esperada
-- NP5

-- Consulta 14
INSERT INTO T_TIME_PASSE_JOG VALUES (2, 7, TO_DATE('11.09.2001', 'MM.DD.YYYY'), TO_DATE('11.09.2003', 'MM.DD.YYYY'))
INSERT INTO T_TIME_PASSE_JOG VALUES (3, 8, TO_DATE('11.09.2001', 'MM.DD.YYYY'), TO_DATE('11.09.2010', 'MM.DD.YYYY'))
-- Resposta esperada
-- NT2
-- NT3
