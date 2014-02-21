DROP TABLE Jogo CASCADE CONSTRAINTS;
DROP TABLE Campeonato CASCADE CONSTRAINTS;
DROP TABLE Arbitragem CASCADE CONSTRAINTS;
DROP TABLE Estadio CASCADE CONSTRAINTS;
DROP TABLE Time CASCADE CONSTRAINTS;
DROP TABLE ParticipaJogo CASCADE CONSTRAINTS;
DROP TABLE Profissional CASCADE CONSTRAINTS;
DROP TABLE Jogador CASCADE CONSTRAINTS;
DROP TABLE Tecnico CASCADE CONSTRAINTS;

DROP TABLE JogosArbitrados CASCADE CONSTRAINTS;
DROP TABLE ProfissionaisDosTimes CASCADE CONSTRAINTS;
DROP TABLE JogadoresEmJogos CASCADE CONSTRAINTS;
DROP TABLE Goleadores CASCADE CONSTRAINTS;
DROP TABLE AtuacaoTecnicos CASCADE CONSTRAINTS;

-- falta fazer o incrementar sozinho, pq nao ta aceitando o auto increment.

/*
    ENTIDADES
*/

CREATE TABLE Campeonato(
    id INT NOT NULL,
    ano INT NOT NULL,
    nome VARCHAR(255),
    dataInicio DATE NOT NULL,
    dataFim DATE NOT NULL,

    CONSTRAINT pk_Campeonato PRIMARY KEY (id)
);

CREATE TABLE Arbitragem(
    matricula INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    dataDeNascimento DATE,

    CONSTRAINT pk_Arbitragem PRIMARY KEY (matricula)
);

CREATE TABLE Jogo(
    numero INT NOT NULL,
    dataHora TIMESTAMP NOT NULL,
    id INT NOT NULL,

    CONSTRAINT pk_Jogo PRIMARY KEY (numero),
    CONSTRAINT fk_Jogo FOREIGN KEY (id) REFERENCES Campeonato(id)
);

CREATE TABLE Estadio(
    nome VARCHAR(255),
    capacidade INT NOT NULL,
    nomeEstadio VARCHAR(255) NOT NULL,
    cep CHAR(10) NOT NULL,
    logradouro VARCHAR(255),
    num INT,
    bairro VARCHAR(255),
    cidade VARCHAR(255) NOT NULL,
    estado CHAR(2) NOT NULL,
    
    CONSTRAINT pk_Estadio PRIMARY KEY (nome)
);

CREATE TABLE Time(
    numCadastro INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    cidade VARCHAR(255),
    nomeEstadio VARCHAR(255) NOT NULL,

    CONSTRAINT pk_Time PRIMARY KEY (numCadastro),
    CONSTRAINT fk_nomeEstadio FOREIGN KEY (nomeEstadio) REFERENCES Estadio(nome)
);

CREATE TABLE Profissional(
    numCadastro INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    apelido VARCHAR(255),
    nascimento DATE NOT NULL,
    
    CONSTRAINT pk_Profissional PRIMARY KEY (numCadastro)
);

CREATE TABLE Jogador(
    cadastro INT NOT NULL,
    donoDoPasse INT NOT NULL,
    dataInicialDoPasse DATE NOT NULL,
    dataFinalDoPasse DATE NOT NULL,
    
    CONSTRAINT pk_Jogador PRIMARY KEY (cadastro),
    CONSTRAINT fk_donoDoPasse FOREIGN KEY (donoDoPasse) REFERENCES Time(numCadastro),
    CONSTRAINT fk_cadastro FOREIGN KEY (cadastro) REFERENCES Profissional(numCadastro)
);

CREATE TABLE Tecnico(
    cadastro INT NOT NULL,
    
    CONSTRAINT pk_Tecnico PRIMARY KEY (cadastro),
    CONSTRAINT fk_Tecnico FOREIGN KEY (cadastro) REFERENCES Profissional(numCadastro)
);


/*
     RELACIONAMENTOS
*/

CREATE TABLE ParticipaJogo(
    numCadastroTime INT NOT NULL,
    numeroJogo INT NOT NULL,

    CONSTRAINT pk_ParticipaJogo PRIMARY KEY (numCadastroTime, numeroJogo),
    --> CONSTRAINT pk_ParticipaJogo PRIMARY KEY (numeroJogo),
    CONSTRAINT fk_numeroJogo FOREIGN KEY (numeroJogo) REFERENCES Jogo(numero),
    CONSTRAINT fk_numCadastroTime FOREIGN KEY (numCadastroTime) REFERENCES Time(numCadastro)
);

CREATE TABLE JogosArbitrados(
    arbitragemDoJogo INT NOT NULL,
    jogoArbitrado INT NOT NULL,
    funcao VARCHAR(255) NOT NULL, -- existem valores default para funcao, colocar isso numa tabela a parte?
    
    CONSTRAINT pk_JogosArbitrados PRIMARY KEY (arbitragemDoJogo, jogoArbitrado),
    CONSTRAINT fk_ArbitragemDoJogo FOREIGN KEY (arbitragemDoJogo) REFERENCES Arbitragem(matricula),
    CONSTRAINT fk_jogoArbitrado FOREIGN KEY (jogoArbitrado) REFERENCES Jogo(numero)
);

-- fazer checagem sobre periodo de trabalho
CREATE TABLE ProfissionaisDosTimes(
    time INT NOT NULL,
    profissional INT NOT NULL,
    trabalhaDataInicial DATE NOT NULL,
    trabalhaDataFinal DATE NOT NULL,
    
    CONSTRAINT pk_ProfissionaisDostimes PRIMARY KEY (time, profissional),
    CONSTRAINT fk_time FOREIGN KEY (time) REFERENCES Time(numCadastro),
    CONSTRAINT fk_profissional FOREIGN KEY (profissional) REFERENCES Profissional(numCadastro)
);

CREATE TABLE JogadoresEmJogos(
    jogadorJogou INT NOT NULL,
    jogoJogado INT NOT NULL,
    camisa INT NOT NULL,
    amarelos INT DEFAULT 0 NOT NULL,
    vermelhos INT DEFAULT 0 NOT NULL,
    
    CONSTRAINT pk_JogadoresEmJogos PRIMARY KEY (jogadorJogou, jogoJogado),
    CONSTRAINT fk_jogadorJogou FOREIGN KEY (jogadorJogou) REFERENCES Jogador(cadastro),
    CONSTRAINT fk_jogoJogado FOREIGN KEY (jogoJogado) REFERENCES Jogo(numero)
);

CREATE TABLE Goleadores(
    jogadorGoleador INT NOT NULL,
    jogoDaGoleada INT NOT NULL,
    momento DATE NOT NULL,
    tipo VARCHAR(255),
   
    CONSTRAINT pk_Goleadores PRIMARY KEY (jogadorGoleador, jogoDaGoleada),
    CONSTRAINT fk_jogadorGoleador FOREIGN KEY (jogadorGoleador) REFERENCES Jogador(cadastro),
    CONSTRAINT fk_jogoDaGoleada FOREIGN KEY (jogoDaGoleada) REFERENCES Jogo(numero)
);

CREATE TABLE AtuacaoTecnicos(
    tecnicoAtuante INT NOT NULL,
    jogoDoTecnico INT NOT NULL,
     
    CONSTRAINT pk_AtuacaoTecnicos PRIMARY KEY (tecnicoAtuante, jogoDoTecnico),
    CONSTRAINT fk_tecnicoAtuante FOREIGN KEY (tecnicoAtuante) REFERENCES Tecnico(cadastro),
    CONSTRAINT fk_jogoDoTecnico FOREIGN KEY (jogoDoTecnico) REFERENCES Jogo(numero)
);

--======INSERCOES==========================================================

------CAMPEONATOS-----------------------------------------------

INSERT INTO Campeonato VALUES(1, 2014, 'Brasileiro', TO_DATE('04.02.2014', 'MM.DD.YYYY'), TO_DATE('12.02.2014', 'MM.DD.YYYY'));
INSERT INTO Campeonato VALUES(2, 2014, 'Paraibano', TO_DATE('04.12.2015', 'MM.DD.YYYY'), TO_DATE('12.02.2014', 'MM.DD.YYYY'));
INSERT INTO Campeonato VALUES(3, 2014, 'Carioca', TO_DATE('12.02.2014', 'MM.DD.YYYY'), TO_DATE('12.02.2014', 'MM.DD.YYYY'));
INSERT INTO Campeonato VALUES(4, 2014, 'Copa do Mundo', TO_DATE('02.12.2016', 'MM.DD.YYYY'), TO_DATE('12.02.2014', 'MM.DD.YYYY'));

-------ESTADIOS--------------------------------------------------

INSERT INTO Estadio VALUES ('E1', 40000, 'N1', '11.111-11', 'R1' , 1245, 'B1', 'C1', 'E1');
INSERT INTO Estadio VALUES ('E2', 75000, 'N1', '11.141-11', 'R2' , 54, 'B2', 'C2', 'E1');
INSERT INTO Estadio VALUES ('E3', 50000, 'N1', '11.131-11', 'R3' , 74, 'B3', 'C3', 'E2');

---------TIMES--------------------------------------------------

-- colocar restricao para cada time ter um estadio diferente?
INSERT INTO Time VALUES (1, 'NT1', 'C1', 'E1');
INSERT INTO Time VALUES (2, 'NT2', 'C2', 'E2');
INSERT INTO Time VALUES (3, 'NT3', 'C3', 'E3');
INSERT INTO Time VALUES (4, 'NT4', 'C4', 'E1');
INSERT INTO Time VALUES (5, 'NT5', 'C5', 'E1');
INSERT INTO Time VALUES (6, 'NT6', 'C6', 'E2');

-----ARBITRAGEM---------------------------------------------------

-- podem arbitros terem o mesmo nome?
INSERT INTO Arbitragem VALUES (1, 'NomArb1', TO_DATE('05.15.1989', 'MM.DD.YYYY'));
INSERT INTO Arbitragem VALUES (2, 'NomArb2', TO_DATE('09.21.1960', 'MM.DD.YYYY'));
INSERT INTO Arbitragem VALUES (3, 'NomArb3', TO_DATE('12.30.1982', 'MM.DD.YYYY'));

-----PROFISSIONAIS-------------------------------------------------

-- 24 jogadores profissionais
INSERT INTO Profissional VALUES(1, 'NP1', 'Ap1', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(2, 'NP2', 'Ap2', TO_DATE('12.17.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(3, 'NP3', 'Ap3', TO_DATE('11.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(4, 'NP4', 'Ap4', TO_DATE('07.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(5, 'NP5', 'Ap5', TO_DATE('12.29.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(6, 'NP6', 'Ap6', TO_DATE('12.12.1994', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(7, 'NP7', 'Ap7', TO_DATE('12.12.1993', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(8, 'NP8', 'Ap8', TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(9, 'NP9', 'Ap9', TO_DATE('12.12.1990', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(10, 'NP10', 'Ap10', TO_DATE('12.12.1983', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(11, 'NP11', 'Ap11', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(12, 'NP12', 'Ap12', TO_DATE('12.17.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(13, 'NP13', 'Ap13', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(14, 'NP14', 'Ap14', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(15, 'NP15', 'Ap15', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(16, 'NP16', 'Ap16', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(17, 'NP17', 'Ap17', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(18, 'NP18', 'Ap18', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(19, 'NP19', 'Ap19', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(20, 'NP20', 'Ap20', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(21, 'NP21', 'Ap21', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(22, 'NP22', 'Ap22', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(23, 'NP23', 'Ap23', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(24, 'NP24', 'Ap24', TO_DATE('12.12.1991', 'MM.DD.YYYY'));

-- 6 tecnicos : 1 para cada time
INSERT INTO Profissional VALUES(25, 'NP25', 'Ap25', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(26, 'NP26', 'Ap26', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(27, 'NP27', 'Ap27', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(28, 'NP28', 'Ap28', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(29, 'NP29', 'Ap29', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(30, 'NP30', 'Ap30', TO_DATE('12.12.1991', 'MM.DD.YYYY'));

-----JOGADORES----------------------------------------------------

-- colocar restricao em Jogador para dataInicialDoPasse < dataFinalDoPasse

INSERT INTO Jogador VALUES (1, 1, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO Jogador VALUES (2, 1, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO Jogador VALUES (3, 1, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO Jogador VALUES (4, 1, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));

INSERT INTO Jogador VALUES (5, 2, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO Jogador VALUES (6, 2, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO Jogador VALUES (7, 2, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO Jogador VALUES (8, 2, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));

INSERT INTO Jogador VALUES (9, 3, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO Jogador VALUES (10, 3, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO Jogador VALUES (11, 3, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO Jogador VALUES (12, 3, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));

INSERT INTO Jogador VALUES (13, 4, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO Jogador VALUES (14, 4, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO Jogador VALUES (15, 4, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO Jogador VALUES (16, 4, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));

INSERT INTO Jogador VALUES (17, 5, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO Jogador VALUES (18, 5, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO Jogador VALUES (19, 5, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO Jogador VALUES (20, 5, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));

INSERT INTO Jogador VALUES (21, 6, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO Jogador VALUES (22, 6, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO Jogador VALUES (23, 6, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO Jogador VALUES (24, 6, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));

-- TECNICOS -------------------------------------------

INSERT INTO Tecnico VALUES (25);
INSERT INTO Tecnico VALUES (26);
INSERT INTO Tecnico VALUES (27);
INSERT INTO Tecnico VALUES (28);
INSERT INTO Tecnico VALUES (29);
INSERT INTO Tecnico VALUES (30);

-- JOGOS ----------------------------------------------

-- colocar restricoes de data: a horaData do jogo deve estar dentro da dataInicio e dataFim do Campeonato
-- colocar restricao: dois jogos nao podem ocorrer no mesmo horario no mesmo estadio

INSERT INTO Jogo VALUES (1, TO_TIMESTAMP('12.12.1991 20:00:00', 'MM.DD.YYYY HH24:MI:SS'), 1);
INSERT INTO Jogo VALUES (2, TO_TIMESTAMP('12.12.1991 20:00:00', 'MM.DD.YYYY HH24:MI:SS'), 1);
INSERT INTO Jogo VALUES (3, TO_TIMESTAMP('12.12.1991 20:00:00', 'MM.DD.YYYY HH24:MI:SS'), 1);

INSERT INTO Jogo VALUES (4, TO_TIMESTAMP('12.12.1991 20:00:00', 'MM.DD.YYYY HH24:MI:SS'), 2);
INSERT INTO Jogo VALUES (5, TO_TIMESTAMP('12.12.1991 20:00:00', 'MM.DD.YYYY HH24:MI:SS'), 2);
INSERT INTO Jogo VALUES (6, TO_TIMESTAMP('12.12.1991 20:00:00', 'MM.DD.YYYY HH24:MI:SS'), 2);

INSERT INTO Jogo VALUES (7, TO_TIMESTAMP('12.12.1991 20:00:00', 'MM.DD.YYYY HH24:MI:SS'), 3);
INSERT INTO Jogo VALUES (8, TO_TIMESTAMP('12.12.1991 20:00:00', 'MM.DD.YYYY HH24:MI:SS'), 3);

INSERT INTO Jogo VALUES (9, TO_TIMESTAMP('12.12.1991 20:00:00', 'MM.DD.YYYY HH24:MI:SS'), 4);
INSERT INTO Jogo VALUES (10, TO_TIMESTAMP('12.12.1991 20:00:00', 'MM.DD.YYYY HH24:MI:SS'), 4);


--= INSERCOES DE RELACIONAMENTOS ==============================================

-- ParticipaJogo ------------------------------------

-- campeonato 1 ---------------------------

-- jogo 1 : time 1 x time 2 : campeonato 1
INSERT INTO ParticipaJogo VALUES (1, 1);
INSERT INTO ParticipaJogo VALUES (2, 1);

-- jogo 2: time 3 x time 4 : campeonato 1
INSERT INTO ParticipaJogo VALUES (4, 2);
INSERT INTO ParticipaJogo VALUES (3, 2);

-- jogo 3: time 5 x time 6 : campeonato 1
INSERT INTO ParticipaJogo VALUES (5, 3);
INSERT INTO ParticipaJogo VALUES (6, 3);


-- campeonato 2 ---------------------------

-- jogo 1 : time 1 x time 2 : campeonato 1
INSERT INTO ParticipaJogo VALUES (1, 4);
INSERT INTO ParticipaJogo VALUES (2, 4);

-- jogo 2: time 3 x time 4 : campeonato 1
INSERT INTO ParticipaJogo VALUES (4, 5);
INSERT INTO ParticipaJogo VALUES (3, 5);

-- jogo 3: time 5 x time 6 : campeonato 1
INSERT INTO ParticipaJogo VALUES (5, 6);
INSERT INTO ParticipaJogo VALUES (6, 6);


-- campeonato 3 ---------------------------

-- jogo 1 : time 1 x time 2 : campeonato 1
INSERT INTO ParticipaJogo VALUES (1, 7);
INSERT INTO ParticipaJogo VALUES (2, 7);

-- jogo 2: time 3 x time 4 : campeonato 1
INSERT INTO ParticipaJogo VALUES (4, 8);
INSERT INTO ParticipaJogo VALUES (3, 8);

-- jogo 3: time 5 x time 6 : campeonato 1
INSERT INTO ParticipaJogo VALUES (5, 9);
INSERT INTO ParticipaJogo VALUES (6, 9);


-- campeonato 4 ---------------------------
INSERT INTO ParticipaJogo VALUES (5, 10);
INSERT INTO ParticipaJogo VALUES (6, 10);


-- JogosArbitrados ------------------------------------

INSERT INTO JogosArbitrados VALUES (1, 1, 'F1');
INSERT INTO JogosArbitrados VALUES (2, 1, 'F2');
INSERT INTO JogosArbitrados VALUES (3, 1, 'F3');
INSERT INTO JogosArbitrados VALUES (1, 2, 'F1');
INSERT INTO JogosArbitrados VALUES (2, 2, 'F2');
INSERT INTO JogosArbitrados VALUES (3, 2, 'F3');
INSERT INTO JogosArbitrados VALUES (1, 3, 'F1');
INSERT INTO JogosArbitrados VALUES (2, 3, 'F2');
INSERT INTO JogosArbitrados VALUES (3, 3, 'F3');
INSERT INTO JogosArbitrados VALUES (1, 4, 'F1');
INSERT INTO JogosArbitrados VALUES (2, 4, 'F2');

-- ProfissionaisDosTimes ------------------------------

INSERT INTO ProfissionaisDosTimes VALUES (1, 1, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (1, 2, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (1, 3, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (1, 4, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (1, 25, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));

INSERT INTO ProfissionaisDosTimes VALUES (2, 5, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (2, 6, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (2, 7, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (2, 8, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (2, 26, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));

INSERT INTO ProfissionaisDosTimes VALUES (3, 9, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (3, 10, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (3, 11, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (3, 12, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (3, 27, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));

INSERT INTO ProfissionaisDosTimes VALUES (4, 13, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (4, 14, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (4, 15, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (4, 16, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (4, 28, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));

INSERT INTO ProfissionaisDosTimes VALUES (5, 17, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (5, 18, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (5, 19, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (5, 20, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (5, 29, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));

INSERT INTO ProfissionaisDosTimes VALUES (6, 21, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (6, 22, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (6, 23, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (6, 24, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO ProfissionaisDosTimes VALUES (6, 30, TO_DATE('12.12.1991', 'MM.DD.YYYY'), TO_DATE('12.12.1992', 'MM.DD.YYYY'));

    
-- JogadoresEmJogos -----------------------
    
-- JOGO 1 ---------------------------------
-- Jogadores Time 1
INSERT INTO JogadoresEmJogos VALUES (1, 1, 1, 1, 0);
INSERT INTO JogadoresEmJogos VALUES (2, 1, 2, 0, 1);
INSERT INTO JogadoresEmJogos VALUES (3, 1, 3, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (4, 1, 4, 0, 0);

-- Jogadores Time 2
INSERT INTO JogadoresEmJogos VALUES (5, 1, 1, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (6, 1, 2, 2, 0);
INSERT INTO JogadoresEmJogos VALUES (7, 1, 3, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (8, 1, 4, 1, 0);

-- JOGO 2 ---------------------------------
-- Jogadores Time 3
INSERT INTO JogadoresEmJogos VALUES (9, 2, 1, 1, 0);
INSERT INTO JogadoresEmJogos VALUES (10, 2, 2, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (11, 2, 3, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (12, 2, 4, 1, 0);

-- Jogadores Time 4
INSERT INTO JogadoresEmJogos VALUES (13, 2, 1, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (14, 2, 2, 1, 0);
INSERT INTO JogadoresEmJogos VALUES (15, 2, 3, 1, 0);
INSERT INTO JogadoresEmJogos VALUES (16, 2, 4, 0, 0);

-- JOGO 3 --------------------------------
-- Jogadores Time 5
INSERT INTO JogadoresEmJogos VALUES (17, 3, 1, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (18, 3, 2, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (19, 3, 3, 1, 0);
INSERT INTO JogadoresEmJogos VALUES (20, 3, 4, 0, 0);

-- Jogadores Time 6
INSERT INTO JogadoresEmJogos VALUES (21, 3, 1, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (22, 3, 2, 2, 0);
INSERT INTO JogadoresEmJogos VALUES (23, 3, 3, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (24, 3, 4, 1, 0);

-- JOGO 4 --------------------------------
-- Jogadores Time 1
INSERT INTO JogadoresEmJogos VALUES (1, 4, 7, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (2, 4, 2, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (3, 4, 5, 1, 0);
INSERT INTO JogadoresEmJogos VALUES (4, 4, 4, 1, 0);

-- Jogadores Time 2
INSERT INTO JogadoresEmJogos VALUES (5, 4, 1, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (6, 4, 11, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (7, 4, 15, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (8, 4, 5, 0, 0);

-- JOGO 5 --------------------------------
-- Jogadores Time 3
INSERT INTO JogadoresEmJogos VALUES (9, 5, 1, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (10, 5, 5, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (11, 5, 3, 0, 1);
INSERT INTO JogadoresEmJogos VALUES (12, 5, 10, 0, 0);

-- Jogadores Time 4
INSERT INTO JogadoresEmJogos VALUES (13, 5, 1, 1, 0);
INSERT INTO JogadoresEmJogos VALUES (14, 5, 6, 1, 0);
INSERT INTO JogadoresEmJogos VALUES (15, 5, 3, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (16, 5, 2, 0, 0);

-- JOGO 6 -------------------------------
-- Jogadores Time 5
INSERT INTO JogadoresEmJogos VALUES (17, 6, 1, 1, 0);
INSERT INTO JogadoresEmJogos VALUES (18, 6, 2, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (19, 6, 3, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (20, 6, 4, 1, 0);

-- Jogadores Time 6
INSERT INTO JogadoresEmJogos VALUES (21, 6, 1, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (22, 6, 2, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (23, 6, 3, 1, 0);
INSERT INTO JogadoresEmJogos VALUES (24, 6, 4, 1, 0);

-- JOGO 7 ------------------------------
-- Jogadores Time 1
INSERT INTO JogadoresEmJogos VALUES (1, 7, 12, 1, 0);
INSERT INTO JogadoresEmJogos VALUES (2, 7, 2, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (3, 7, 7, 1, 0);
INSERT INTO JogadoresEmJogos VALUES (4, 7, 9, 0, 0);

-- Jogadores Time 2
INSERT INTO JogadoresEmJogos VALUES (5, 7, 1, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (6, 7, 2, 1, 0);
INSERT INTO JogadoresEmJogos VALUES (7, 7, 11, 0, 1);
INSERT INTO JogadoresEmJogos VALUES (8, 7, 4, 0, 0);

-- JOGO 8 ------------------------------
-- Jogadores Time 3
INSERT INTO JogadoresEmJogos VALUES (9, 8, 1, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (10, 8, 2, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (11, 8, 3, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (12, 8, 4, 1, 0);

-- Jogadores Time 4
INSERT INTO JogadoresEmJogos VALUES (13, 8, 1, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (14, 8, 2, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (15, 8, 3, 1, 0);
INSERT INTO JogadoresEmJogos VALUES (16, 8, 4, 1, 0);

-- JOGO 9 ------------------------------
-- Jogadores Time 5
INSERT INTO JogadoresEmJogos VALUES (17, 9, 1, 1, 0);
INSERT INTO JogadoresEmJogos VALUES (18, 9, 2, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (19, 9, 3, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (20, 9, 4, 0, 1);

-- Jogadores Time 6
INSERT INTO JogadoresEmJogos VALUES (21, 9, 12, 1, 0);
INSERT INTO JogadoresEmJogos VALUES (22, 9, 9, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (23, 9, 11, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (24, 9, 20, 1, 0);

-- JOGO 10 -----------------------------
-- Jogadores Time 5
INSERT INTO JogadoresEmJogos VALUES (17, 10, 1, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (18, 10, 2, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (19, 10, 3, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (20, 10, 4, 1, 0);

-- Jogadores Time 6
INSERT INTO JogadoresEmJogos VALUES (21, 10, 1, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (22, 10, 2, 0, 1);
INSERT INTO JogadoresEmJogos VALUES (23, 10, 3, 0, 0);
INSERT INTO JogadoresEmJogos VALUES (24, 10, 4, 0, 0);


-- Goleadores -------------------------------

INSERT INTO Goleadores VALUES (2, 1, TO_DATE('12.12.1991', 'MM.DD.YYYY'), '');
INSERT INTO Goleadores VALUES (11, 2, TO_DATE('12.12.1991', 'MM.DD.YYYY'), '');
INSERT INTO Goleadores VALUES (20, 6, TO_DATE('12.12.1991', 'MM.DD.YYYY'), '');
INSERT INTO Goleadores VALUES (15, 8, TO_DATE('12.12.1991', 'MM.DD.YYYY'), '');
INSERT INTO Goleadores VALUES (23, 9, TO_DATE('12.12.1991', 'MM.DD.YYYY'), '');
    

-- AtuacaoTecnicos --------------------------

INSERT INTO AtuacaoTecnicos VALUES (25, 1);
INSERT INTO AtuacaoTecnicos VALUES (25, 4);
INSERT INTO AtuacaoTecnicos VALUES (25, 7);

INSERT INTO AtuacaoTecnicos VALUES (26, 1);
INSERT INTO AtuacaoTecnicos VALUES (26, 4);
INSERT INTO AtuacaoTecnicos VALUES (26, 7);

INSERT INTO AtuacaoTecnicos VALUES (27, 2);
INSERT INTO AtuacaoTecnicos VALUES (27, 5);
INSERT INTO AtuacaoTecnicos VALUES (27, 8);

INSERT INTO AtuacaoTecnicos VALUES (28, 2);
INSERT INTO AtuacaoTecnicos VALUES (28, 5);
INSERT INTO AtuacaoTecnicos VALUES (28, 8);

INSERT INTO AtuacaoTecnicos VALUES (29, 3);
INSERT INTO AtuacaoTecnicos VALUES (29, 6);
INSERT INTO AtuacaoTecnicos VALUES (29, 9);
INSERT INTO AtuacaoTecnicos VALUES (29, 10);

INSERT INTO AtuacaoTecnicos VALUES (30, 3);
INSERT INTO AtuacaoTecnicos VALUES (30, 6);
INSERT INTO AtuacaoTecnicos VALUES (30, 9);
INSERT INTO AtuacaoTecnicos VALUES (30, 10);



--====SELECTS==================================================================

SELECT * FROM Campeonato;
SELECT * FROM Estadio;
SELECT * FROM Time;
SELECT * FROM Arbitragem;
SELECT * FROM Jogador;
SELECT * FROM Tecnico;
SELECT * FROM Jogo;

SELECT * FROM ParticipaJogo;
SELECT * FROM JogosArbitrados;
SELECT * FROM ProfissionaisDosTimes;
SELECT * FROM JogadoresEmJogos;
SELECT * FROM Goleadores;
SELECT * FROM AtuacaoTecnicos;
