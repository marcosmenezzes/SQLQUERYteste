CREATE DATABASE bdRevendedora
ON PRIMARY (
NAME = 'bdRevendedora',
FILENAME = 'c:\BD\bdRevendedora.MDF',
SIZE = 20MB,
MAXSIZE = 50MB,
FILEGROWTH = 5%
);

GO 
USE bdRevendedora
GO

CREATE TABLE Cliente
(
rgCliente CHAR (7) NOT NULL,
nome VARCHAR (50) NOT NULL,
sobrenome VARCHAR (50) NOT NULL,
PRIMARY KEY (rgCliente)
);

CREATE TABLE Revendedora 
(
cnpjRevendedora CHAR (14) NOT NULL,
nome VARCHAR (20) NOT NULL,
sobrenome VARCHAR (20) NOT NULL,
proprietario VARCHAR (50) NOT NULL,
cidade VARCHAR (50) NOT NULL,
estado CHAR (2) NOT NULL
PRIMARY KEY (cnpjRevendedora)
);

CREATE TABLE Automoveis
(
idAutomovel INT IDENTITY (1000,1) NOT NULL,
fabricante VARCHAR (50) NOT NULL,
modelo VARCHAR (20) NOT NULL,
ano DATE,
pais VARCHAR(50),
preco MONEY
PRIMARY KEY (idAutomovel)
);

CREATE TABLE Estoque 
(
idEstoque INT IDENTITY (1,1) NOT NULL,
cnpjRevendedora CHAR (14) NOT NULL,
idAutomovel INT,
quantidade int
PRIMARY KEY (idEstoque)
);

ALTER TABLE Estoque
ADD CONSTRAINT fk_idAutomovel_Estoque
FOREIGN KEY (idAutomovel)
REFERENCES Automoveis (idAutomovel)

CREATE TABLE Vendas
(
idVenda INT IDENTITY (1,1) NOT NULL,
rgCliente CHAR (7) NOT NULL UNIQUE,
cnpjRevendedora CHAR (14) UNIQUE NOT NULL,
idAutomovel INT,
dt DATE,
precoPago MONEY,
anoAutomovel DATE
PRIMARY KEY (idVenda)
);

alter table Vendas 
ADD CONSTRAINT fk_idAutomovel_Vendas
FOREIGN KEY (idAutomovel)
REFERENCES Automoveis (idAutomovel)

-- INSERINDO DADOS NA TABELA CLIENTE
INSERT INTO Cliente (rgCliente, nome, sobrenome) 
VALUES 
('9987008', 'ANA LUISA', 'GARCIA MENDONÇA'),
('2234567', 'ANDERSON', 'SANTANA DOS SANTOS'),
('1212435', 'DANIEL', 'FIUSA XAVIER'),
('0987766', 'DAVI', 'DE SOUZA SANTANA'),
('7692827', 'JEAN', 'COSME JANUARIO DE OLIVEIRA'),
('2989276', 'JOÃO AUGUSTO', 'BENEVIDES DE SOUZA'),
('0590584', 'KEVIN', 'SUAVE'),
('9898876', 'LUCAS', 'BERNARDO RAMOS'),
('1280126', 'LUIS GUSTAVO', 'FERREIRA FILHO'),
('2121215', 'MARCOS VINICIUS', 'MENEZES DA SILVA'),
('8121318', 'MATHEUS HENRIQUE', 'DE AZEVEDO CARVALHO'),
('0254489', 'MATHEUS', 'SANTOS GERALDINO'),
('2154887', 'RAFAEL', 'MARINATO ASSIS'),
('1025454', 'RAIANE', 'GOMES DE OLIVEIRA'),
('1352488', 'RAYNARA', 'LISBOA EVANGELISTA'),
('4102563', 'ROMULO', 'DAS CHAGAS NUNE'),
('1325468', 'VICTOR MANOEL', 'DE SANTANA ROCHA'),
('0157899', 'WELLINGTON', 'FELIX CORREIA'),
('1323489', 'WENDERSON', 'DOS SANTOS DE AQUINO'),
('1280120', 'BRUNO CEZAR', 'MANZOLI FERREIRA');

-- INSERINDO DADOS NA TABELA REVENDEDORAS
INSERT INTO Revendedora (cnpjRevendedora, nome, sobrenome, proprietario, cidade, estado) VALUES
('99877601123399', 'B&C', 'Veículos', 'JOAQUIM GOMES', 'Linhares', 'ES'),
('09987765009879', 'Voar', 'Auto', 'PEDRO CALISTO', 'Colatina', 'ES'),
('11120009001239', '4 Rodas', '', 'MAURÍCIO CHAVES', 'Eunápolis', 'BA');

-- INSERINDO DADOS NA TABELA AUTOMOVEIS
INSERT INTO Automoveis (fabricante, modelo, ano, pais, preco) VALUES 
('FIAT', 'Siena', '2012', 'Itália', 35000.00),
('GM', 'Cruze', '2014', 'EUA', 55000.00),
('GM', 'Cobalt', '2009', 'EUA', 21000.00),
('Ford', 'Focus', '2010', 'Alemanha', 28000.00),
('Toyota', 'Corolla', '2011', 'Japão', 42000.00);

SELECT * FROM Cliente



