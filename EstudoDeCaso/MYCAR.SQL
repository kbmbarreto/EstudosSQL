/*
Individual ou em dupla.
Escolher um tema para o banco de dados;
Escolher um SGBD para uso, por exemplo: MySQL, Oracle, Postgres e etc;
Criar um banco de dados;
Criar, no mínimo, 3 tabelas;
Em cada tabela criar, no mínimo, 4 colunas sendo um delas chave primária;
Criar em cada coluna colocar os tipos delas e se permitirá campos nulos ou não;
Inserir dados em todas as tabelas;
Fazer algumas consultas nos dados;
Entrega:
Enviar o script de criação do banco já com os dados inseridos;
Enviar as consultas criadas e executadas no banco;
*/

-- CRIAÇÃO DO BANCO DE DADOS

CREATE DATABASE mycar
GO

USE mycar
GO

-- CRIAÇÃO DAS TABELAS

CREATE TABLE FABRICANTE
(
    IDFabricante INT IDENTITY PRIMARY KEY NOT NULL,
    Fabricante VARCHAR(75) NOT NULL,
    Cnpj VARCHAR(75) NOT NULL,
    Contato VARCHAR(75)
)

CREATE TABLE VEICULO
(
    IDVeiculo INT IDENTITY PRIMARY KEY NOT NULL,
    AnoModelo INT NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    KM INT NOT NULL,
    IDFabricante INT
)

CREATE TABLE COMPONENTE
(
    IDComponente INT IDENTITY PRIMARY KEY NOT NULL,
    NomeComponente VARCHAR(75) NOT NULL,
    Descricao VARCHAR(75) NULL,
    IDFabricante INT
)

CREATE TABLE MANUTENCOES
(
    IDManutencoes BIGINT IDENTITY PRIMARY KEY NOT NULL,
    Datamanutencao DATETIME NOT NULL,
    ValorManutencao DECIMAL(7,2) NULL,
    IDVeiculo INT,
    IDComponente INT
)

-- CRIAÇÃO DOS RELACIONAMENTOS

/* RELACIONAMENTO ENTRE VEICULO E FABRICANTE */

ALTER TABLE VEICULO ADD CONSTRAINT FKFABRICANTE FOREIGN KEY (IDFabricante)
REFERENCES FABRICANTE (IDFabricante)

/* RELACIONAMENTO ENTRE MANUTENCOES E VEICULO */

ALTER TABLE MANUTENCOES ADD CONSTRAINT FK_VEICULO FOREIGN KEY (IDVeiculo)
REFERENCES VEICULO (IDVeiculo)

/* RELACIONAMENTO ENTRE MANUTENCOES E COMPONENTE */

ALTER TABLE MANUTENCOES ADD CONSTRAINT FK_COMPONENTE FOREIGN KEY (IDComponente)
REFERENCES COMPONENTE (IDComponente)

-- INSERÇÃO DOS DADOS NAS TABELAS

/* POPULAR TABELA FABRICANTE */

INSERT INTO FABRICANTE (Fabricante, Cnpj, Contato) VALUES ('Chevrolet', '70.621.032/0001-90', '(28) 77099-8739'), ('Jeep', '68.760.011/0001-03', '(77) 64512-0978'), 
('MAHLE', '45.695.307/0001-92', '(79) 80588-8314')

/* POPULAR TABELA VEICULO */

INSERT INTO VEICULO (AnoModelo, Modelo, KM, IDFabricante) VALUES ('2022', 'Onix LT', '52000', 1), ('2020', 'Compass', '0', 2), 
('2021', 'Cobalt', '21000', 1)

/* POPULAR TABELA COMPONENTE */

INSERT INTO COMPONENTE (NomeComponente, Descricao, IDFabricante) VALUES ('Vela', 'Vela de Ignição', 3), ('Parabrisa', NULL, 1)

/* POPULAR TABELA MANUTENCOES */

INSERT INTO MANUTENCOES (Datamanutencao, ValorManutencao, IDVeiculo, IDComponente) VALUES ('2021-01-01', 150.00, 1, 2)


-- CONSULTAS DOS DADOS NAS TABELAS

/* CONSULTAR TABELA FABRICANTE */

SELECT * FROM FABRICANTE ORDER BY 1 DESC

/* CONSULTAR TABELA VEICULO */

SELECT V.IDVeiculo, V.AnoModelo, V.Modelo, V.KM, FAB.Fabricante FROM VEICULO AS V
INNER JOIN FABRICANTE AS FAB 
ON V.IDFabricante = FAB.IDFabricante


/* CONSULTAR TABELA COMPONENTE */

SELECT C.IDComponente, C.NomeComponente, C.Descricao, FAB.Fabricante FROM COMPONENTE AS C
INNER JOIN FABRICANTE AS FAB 
ON C.IDFabricante = FAB.IDFabricante

/* CONSULTAR TABELA MANUTENCOES */

SELECT MAN.IDManutencoes, MAN.Datamanutencao, V.Modelo, C.NomeComponente, C.Descricao,MAN.ValorManutencao FROM MANUTENCOES AS MAN
INNER JOIN VEICULO AS V 
ON MAN.IDVeiculo = V.IDVeiculo
INNER JOIN COMPONENTE AS C
ON MAN.IDComponente = C.IDComponente