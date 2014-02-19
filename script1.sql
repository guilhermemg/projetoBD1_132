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
    ArbitragemDoJogo INT NOT NULL,
    jogoArbitrado INT NOT NULL,
    funcao VARCHAR(50) NOT NULL,
    
    CONSTRAINT pk_JogosArbitrados PRIMARY KEY (ArbitragemDoJogo, jogoArbitrado),
    CONSTRAINT fk_ArbitragemDoJogo FOREIGN KEY (ArbitragemDoJogo) REFERENCES Arbitragem(matricula),
    CONSTRAINT fk_jogoArbitrado FOREIGN KEY (jogoArbitrado) REFERENCES Jogo(numero)
);

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
    amarelos INT NOT NULL,
    vermelhos INT NOT NULL,
    
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
INSERT INTO Arbitragem VALUES (1, 'NArb1', TO_DATE('05.15.1989', 'MM.DD.YYYY'));
INSERT INTO Arbitragem VALUES (2, 'NArb2', TO_DATE('09.21.1960', 'MM.DD.YYYY'));
INSERT INTO Arbitragem VALUES (3, 'NArb3', TO_DATE('12.30.1982', 'MM.DD.YYYY'));

-----PROFISSIONAIS-------------------------------------------------

-- 24 jogadores profissionais
INSERT INTO Profissional VALUES(1, 'NP1', 'A1', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(2, 'NP2', 'A2', TO_DATE('12.17.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(3, 'NP3', 'A3', TO_DATE('11.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(4, 'NP4', 'A4', TO_DATE('07.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(5, 'NP5', 'A5', TO_DATE('12.29.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(6, 'NP6', 'A6', TO_DATE('12.12.1994', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(7, 'NP7', 'A7', TO_DATE('12.12.1993', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(8, 'NP8', 'A8', TO_DATE('12.12.1992', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(9, 'NP9', 'A9', TO_DATE('12.12.1990', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(10, 'NP10', 'A10', TO_DATE('12.12.1983', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(11, 'NP11', 'A11', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(12, 'NP12', 'A12', TO_DATE('12.17.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(13, 'NP13', 'A13', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(14, 'NP14', 'A14', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(15, 'NP15', 'A15', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(16, 'NP16', 'A16', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(17, 'NP17', 'A17', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(18, 'NP18', 'A18', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(19, 'NP19', 'A19', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(20, 'NP20', 'A20', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(21, 'NP21', 'A21', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(22, 'NP22', 'A22', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(23, 'NP23', 'A23', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(24, 'NP24', 'A24', TO_DATE('12.12.1991', 'MM.DD.YYYY'));

-- 6 tecnicos : 1 para cada time
INSERT INTO Profissional VALUES(25, 'NP25', 'A25', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(26, 'NP26', 'A26', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(27, 'NP27', 'A27', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(28, 'NP28', 'A28', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(29, 'NP29', 'A29', TO_DATE('12.12.1991', 'MM.DD.YYYY'));
INSERT INTO Profissional VALUES(30, 'NP30', 'A30', TO_DATE('12.12.1991', 'MM.DD.YYYY'));

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

---SELECTS------------------------------------------------------

SELECT * FROM Campeonato;
SELECT * FROM Estadio;
SELECT * FROM Time;
SELECT * FROM Arbitragem;
SELECT * FROM Jogador;
SELECT * FROM Tecnico;
SELECT * FROM Jogo;



​