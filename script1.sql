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

-- falta fazer o incrementar sozinho, pq ao ta aceitando o auto increment.

/*
   
    ENTIDADES
    
    
*/

CREATE TABLE Campeonato(
    id INT NOT NULL,
    ano INT NOT NULL,
    nome VARCHAR(50),
    dataInicio DATE NOT NULL,
    dataFim DATE NOT NULL,

    CONSTRAINT pk_Campeonato PRIMARY KEY (id)
);

CREATE TABLE Arbitragem(
    matricula INT NOT NULL,
    nome VARCHAR(50),
    dataDeNascimento DATE,

    CONSTRAINT pk_Arbitragem PRIMARY KEY (matricula)
);

CREATE TABLE Jogo(
    numero INT NOT NULL,
    DataHora TIMESTAMP NOT NULL,
    id INT NOT NULL,

    CONSTRAINT pk_Jogo PRIMARY KEY (numero),
    CONSTRAINT fk_Jogo FOREIGN KEY (id) REFERENCES Campeonato(id)
);

CREATE TABLE Estadio(
    nome VARCHAR(255),
    capacidade INT,
    nomeEstadio VARCHAR(255),
    cep CHAR(10),
    logradouro VARCHAR(255),
    num INT,
    bairro VARCHAR(255),
    cidade VARCHAR(255),
    estado CHAR(2),
    
    CONSTRAINT pk_Estadio PRIMARY KEY (nome)
);

CREATE TABLE Time(
    numCadastro INT NOT NULL,
    nome VARCHAR(255),
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
    arbitroDoJogo INT NOT NULL,
    jogoArbitrado INT NOT NULL,
    funcao VARCHAR(50) NOT NULL,
    
    CONSTRAINT pk_JogosArbitrados PRIMARY KEY (arbitroDoJogo, jogoArbitrado),
    CONSTRAINT fk_arbitroDoJogo FOREIGN KEY (arbitroDoJogo) REFERENCES Arbitragem(matricula),
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

INSERT INTO Campeonato(id, ano, nome, dataInicio, dataFim) VALUES(1, 2014, 'Brasileiro', TO_DATE('04.02.2014'), TO_DATE('12.02.2014'));
INSERT INTO Campeonato(id, ano, nome, dataInicio, dataFim) VALUES(2, 2014, 'Paraibano', TO_DATE('04.12.2015'), TO_DATE('12.02.2014'));
INSERT INTO Campeonato(id, ano, nome, dataInicio, dataFim) VALUES(3, 2014, 'Carioca', TO_DATE('12.02.2014'), TO_DATE('12.02.2014'));
INSERT INTO Campeonato(id, ano, nome, dataInicio, dataFim) VALUES(4, 2014, 'Copa do Mundo', TO_DATE('02.12.2016'), TO_DATE('12.02.2014'));


SELECT * FROM Campeonato;
