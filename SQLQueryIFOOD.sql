CREATE DATABASE dbIfood
ON PRIMARY 
(
NAME = dbIfood, 
FILENAME = 'C:\BD\dbIfood.MRF',
SIZE = 100MB,
MAXSIZE = 500MB,
FILEGROWTH = 5%
);

USE dbIfood

CREATE TABLE CategoriaLojista
(
idCategoriaLojista INT IDENTITY (1,1) NOT NULL,
descricao VARCHAR (50),
nome VARCHAR (50)
PRIMARY KEY (idCategoriaLojista)
);

CREATE TABLE Lojista
(
idLojistaCnpj INT IDENTITY (1,1) NOT NULL,
idCategoriaLojista INT, 
idProprietarioCpf INT,
razaoSocial VARCHAR (50),
nomeRestaurante VARCHAR (50),
telefone INT, 
endereco VARCHAR(50),
servicoEntrega BIT,
tipoPlano BIT,
tipoNegocio BIT,
dadosBancarios VARCHAR (50),
senha INT,
PRIMARY KEY (idLojistaCnpj),
FOREIGN KEY (idCategoriaLojista) REFERENCES CategoriaLojista (idCategoriaLojista),
FOREIGN KEY (idProprietarioCpf) REFERENCES InfoProprietario (idProprietarioCpf)
);

CREATE TABLE InfoProprietario
(
idProprietarioCpf INT IDENTITY (1,1) NOT NULL,
RG INT, 
orgaoEmissor VARCHAR (50),
nome VARCHAR (50),
contatoWhatsapp VARCHAR (50)
PRIMARY KEY (idProprietarioCpf)
);

CREATE TABLE CategoriaProduto
(
idCategoriaProduto INT IDENTITY (1,1) NOT NULL,
idLojistaCnpj INT, 
nome VARCHAR(50),
descricao VARCHAR (50),
PRIMARY KEY (idCategoriaProduto),
FOREIGN KEY (idLojistaCnpj) REFERENCES Lojista (idLojistaCnpj)
);

CREATE TABLE Desconto
(
idDesconto INT IDENTITY (1,1) NOT NULL,
descricao VARCHAR (50),
valor MONEY,
validade DATE
PRIMARY KEY (idDesconto)
);

CREATE TABLE Produto 
(
idProduto INT IDENTITY (1,1) NOT NULL,
idCategoriaProduto INT,
idLojistaCnpj INT,
idDesconto INT,
nome VARCHAR (50),
descricao VARCHAR(50),
preco MONEY,
imagem IMAGE,
PRIMARY KEY (idProduto),
FOREIGN KEY (idCategoriaProduto) REFERENCES CategoriaProduto (idCategoriaProduto),
FOREIGN KEY (idLojistaCnpj) REFERENCES Lojista (idLojistaCnpj),
FOREIGN KEY (idDesconto) REFERENCES Desconto (idDesconto),
);

CREATE TABLE Entregador
(
idEntregador INT IDENTITY (1,1) NOT NULL,
telefone CHAR(14),
email VARCHAR (50),
tipoVeiculo BIT,
tipoEntrega BIT,
UF CHAR (2),
fotoCNH IMAGE,
dadosBancarios VARCHAR(50),
PRIMARY KEY (idEntregador)
);

CREATE TABLE Clinte
(
idClienteCpf INT IDENTITY (1,1) NOT NULL, 
email VARCHAR (50),
nome VARCHAR (50),
telefone INT,
cartao INT,
PRIMARY KEY (idClienteCpf)
);

CREATE TABLE ProdutoPedido
(
idProdutoPedido INT IDENTITY (1,1) NOT NULL,
idProduto INT,
qtde INT, 
valor MONEY 
PRIMARY KEY (idProdutoPedido),
FOREIGN KEY (idProduto) REFERENCES Produto (idProduto)
);

CREATE TABLE Pedido
(
idPedido INT IDENTITY (1,1) NOT NULL,
idClienteCpf INT,
idLojistaCnpj INT,
idProdutoPedido INT,
idEntregador INT,
endereco VARCHAR (50),
dtPedido DATE,
hora TIME,
statu TIME,
valorTotal MONEY,
PRIMARY KEY (idPedido),
FOREIGN KEY (idClienteCpf) REFERENCES Clinte (idClienteCpf),
FOREIGN KEY (idLojistaCnpj) REFERENCES Lojista (idLojistaCnpj),
FOREIGN KEY (idProdutoPedido) REFERENCES ProdutoPedido (idProdutoPedido),
FOREIGN KEY (idEntregador) REFERENCES Entregador (idEntregador),
);

CREATE TABLE Avaliacao
(
idAvaliacao INT IDENTITY (1,1) NOT NULL, 
idClienteCpf INT, 
idLojistaCnpj INT,
idPedido INT,
nota INT,
comentario VARCHAR (50),
PRIMARY KEY (idAvaliacao),
FOREIGN KEY (idClienteCpf) REFERENCES Clinte (idClienteCpf),
FOREIGN KEY (idLojistaCnpj) REFERENCES Lojista (idLojistaCnpj),
FOREIGN KEY (idPedido) REFERENCES Pedido (idPedido),
);