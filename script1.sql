DROP TABLE Jogo;
DROP TABLE Campeonato;
DROP TABLE Arbitragem;

-- falta fazer o incrementar sozinho, pq ao ta aceitando o auto increment. 
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
    nome VARCHAR(255) PRIMARY KEY,
    capacidade INT
);

CREATE TABLE Endereco(
    nomeEstadio VARCHAR(255),
    cep CHAR(10),
    logradouro VARCHAR(255),
    num INT,
    bairro VARCHAR(255),
    cidade VARCHAR(255),
    estado CHAR(2),
    
    CONSTRAINT pk_nomeEstadio PRIMARY KEY(nomeEstadio),
    CONSTRAINT pk_cep PRIMARY KEY(cep),
    CONSTRAINT pk_logradouro PRIMARY KEY(logradouro),
    CONSTRAINT pk_num PRIMARY KEY(num),
    CONSTRAINT pk_bairro PRIMARY KEY(bairro),
    CONSTRAINT pk_cidade PRIMARY KEY(cidade),
    CONSTRAINT pk_estado PRIMARY KEY(estado)
);

CREATE TABLE Time(
    numCadastro INT NOT NULL,
    nome VARCHAR(255),
    cidade VARCHAR(255),
    nomeEstadio VARCHAR(255) NOT NULL,

    CONSTRAINT pk_Time PRIMARY KEY (numCadastro),
    CONSTRAINT fk_nomeEstadio FOREIGN KEY (nomeEstadio) REFERENCES Estadio(nome)
);

CREATE TABLE ParticipaJogo(
    numCadastroTime INT NOT NULL,
    numeroJogo INT NOT NULL,

    CONSTRAINT pk_ParticipaJogo PRIMARY KEY (numCadastroTime),
    CONSTRAINT pk_ParticipaJogo PRIMARY KEY (numeroJogo),
    CONSTRAINT fk_numeroJogo FOREIGN KEY (numeroJogo) REFERENCES Jogo(numero),
    CONSTRAINT fk_numCadastroTime FOREIGN KEY (numCadastroTime) REFERENCES Time(numCadastro)
);

INSERT INTO Campeonato(id, ano, nome, dataInicio, dataFim) VALUES(1, 2014, 'Brasileiro', TO_DATE('04.02.2014'), TO_DATE('12.02.2014'));
INSERT INTO Campeonato(id, ano, nome, dataInicio, dataFim) VALUES(2, 2014, 'Paraibano', TO_DATE('04.12.2015'), TO_DATE('12.02.2014'));
INSERT INTO Campeonato(id, ano, nome, dataInicio, dataFim) VALUES(3, 2014, 'Carioca', TO_DATE('12.02.2014'), TO_DATE('12.02.2014'));
INSERT INTO Campeonato(id, ano, nome, dataInicio, dataFim) VALUES(4, 2014, 'Copa do Mundo', TO_DATE('02.12.2016'), TO_DATE('12.02.2014'));


SELECT * FROM Campeonato;
