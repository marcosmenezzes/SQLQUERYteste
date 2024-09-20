CREATE DATABASE dbIfood 
ON PRIMARY 
(
    NAME = dbIfood, 
    FILENAME = 'C:\BD\dbIfood.MDF',
    SIZE = 100MB,
    MAXSIZE = 500MB,
    FILEGROWTH = 5%
);
GO

USE dbIfood
GO

CREATE TABLE CategoriaLojista
(
    idCategoriaLojista INT IDENTITY (1,1) NOT NULL,
    descricao VARCHAR (50),
    nome VARCHAR (50),
    PRIMARY KEY (idCategoriaLojista)
);

CREATE TABLE InfoProprietario
(
    idProprietarioCpf INT IDENTITY (1,1) NOT NULL,
    RG INT, 
    orgaoEmissor VARCHAR (50),
    nome VARCHAR (50),
    contatoWhatsapp VARCHAR (50),
    PRIMARY KEY (idProprietarioCpf)
);

CREATE TABLE Lojista
(
    idLojistaCnpj INT IDENTITY (1,1) NOT NULL,
    idCategoriaLojista INT, 
    idProprietarioCpf INT,
    razaoSocial VARCHAR (50),
    nomeRestaurante VARCHAR (50),
    telefone VARCHAR (15),
    endereco VARCHAR(50),
    servicoEntrega BIT,
    tipoPlano BIT,
    tipoNegocio BIT,
    dadosBancarios VARCHAR (50),
    senha VARCHAR (20),
    PRIMARY KEY (idLojistaCnpj),
    FOREIGN KEY (idCategoriaLojista) REFERENCES CategoriaLojista (idCategoriaLojista),
    FOREIGN KEY (idProprietarioCpf) REFERENCES InfoProprietario (idProprietarioCpf)
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
    validade DATE,
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
    FOREIGN KEY (idDesconto) REFERENCES Desconto (idDesconto)
);

CREATE TABLE Entregador
(
    idEntregador INT IDENTITY (1,1) NOT NULL,
	nome VARCHAR(50),
    telefone CHAR(14),
    email VARCHAR (50),
    tipoVeiculo BIT,
    tipoEntrega BIT,
    UF CHAR (2),
    fotoCNH IMAGE,
    dadosBancarios VARCHAR(50),
    PRIMARY KEY (idEntregador)
);

CREATE TABLE Cliente
(
    idClienteCpf INT IDENTITY (1,1) NOT NULL, 
    email VARCHAR (50),
    nome VARCHAR (50),
    telefone VARCHAR (15),
    cartao VARCHAR (20),
    endereco VARCHAR (100),
    PRIMARY KEY (idClienteCpf)
);

CREATE TABLE Pagamentos
(
    idPagamento INT IDENTITY (1,1) NOT NULL,
    idClienteCpf INT,
    valor MONEY,
    dtPagamento DATE,
	hora TIME,
    formaPagamento VARCHAR(50),
    PRIMARY KEY (idPagamento),
    FOREIGN KEY (idClienteCpf) REFERENCES Cliente (idClienteCpf)
);

CREATE TABLE ProdutoPedido
(
    idProdutoPedido INT IDENTITY (1,1) NOT NULL,
    idProduto INT,
    qtde INT, 
    valor MONEY,
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
    idPagamento INT,  
    PRIMARY KEY (idPedido),
    FOREIGN KEY (idClienteCpf) REFERENCES Cliente (idClienteCpf),
    FOREIGN KEY (idLojistaCnpj) REFERENCES Lojista (idLojistaCnpj),
    FOREIGN KEY (idProdutoPedido) REFERENCES ProdutoPedido (idProdutoPedido),
    FOREIGN KEY (idEntregador) REFERENCES Entregador (idEntregador),
    FOREIGN KEY (idPagamento) REFERENCES Pagamentos (idPagamento)  
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
    FOREIGN KEY (idClienteCpf) REFERENCES Cliente (idClienteCpf),
    FOREIGN KEY (idLojistaCnpj) REFERENCES Lojista (idLojistaCnpj),
    FOREIGN KEY (idPedido) REFERENCES Pedido (idPedido)
);

-- INSERTS --

INSERT INTO CategoriaLojista (descricao, nome) VALUES
('Restaurante de Comida Italiana', 'Italiano'),
('Restaurante de Comida Chinesa', 'Chinês'),
('Restaurante de Fast Food', 'Fast Food');

INSERT INTO InfoProprietario (RG, orgaoEmissor, nome, contatoWhatsapp) VALUES
(123456789, 'SSP', 'Marcos Menezzes', '+5511999999999'),
(987654321, 'SSP', 'Ana Luisa Garcia', '+5511988888888');

INSERT INTO Lojista (idCategoriaLojista, idProprietarioCpf, razaoSocial, nomeRestaurante, telefone, endereco, servicoEntrega, tipoPlano, tipoNegocio, dadosBancarios, senha) VALUES
(1, 1, 'Restaurante Bella Italia', 'Bella Italia', '123456789', 'Rua das Flores, 123', 1, 0, 1, 'Banco X - Conta 123', '1234'),
(2, 2, 'Chinês do Bairro', 'Chinês do Bairro', '987654321', 'Avenida Central, 456', 1, 1, 0, 'Banco Y - Conta 456', '5678');

INSERT INTO CategoriaProduto (idLojistaCnpj, nome, descricao) VALUES
(1, 'Massas', 'Massas e pratos italianos'),
(2, 'Arroz Frito', 'Arroz frito e pratos chineses');

INSERT INTO Desconto (descricao, valor, validade) VALUES
('10% de desconto em massas', 10.00, '2024-12-31'),
('15% de desconto em arroz frito', 15.00, '2024-12-31');

INSERT INTO Entregador (telefone, nome, email, tipoVeiculo, tipoEntrega, UF, fotoCNH, dadosBancarios) VALUES
('11987654321', 'Wenderson Souza', 'wenwen@exemplo.com', 1, 1, 'ES', NULL, 'Banco Z - Conta 789'),
('11976543210','Luis Gustavo Ferreira', 'luladoctds@exemplo.com', 0, 1, 'ES', NULL, 'Banco W - Conta 012');

INSERT INTO Cliente (email, nome, telefone, cartao, endereco) VALUES
('lukaneta@exemplo.com', 'Lucas Bernardo', '123456789', '12345678', 'Av. Judas, Bairro: Bota, Nº 30, Jerusálem - ES'),
('fiuseta@exemplo.com', 'Daniel Fiusa', '987654321', '654321', 'Av. Cocks House, Bairro: Israel, Nº 7070, Carrapicho - ES');

INSERT INTO Produto (idCategoriaProduto, idLojistaCnpj, idDesconto, nome, descricao, preco, imagem) VALUES
(1, 1, 1, 'Espaguete à Bolonhesa', 'Espaguete com molho bolonhesa', 30.00, NULL),
(2, 2, 2, 'Arroz Frito', 'Arroz frito com legumes', 25.00, NULL);

INSERT INTO ProdutoPedido (idProduto, qtde, valor) VALUES
(1, 2, 60.00),
(2, 1, 25.00);

INSERT INTO Pagamentos (idClienteCpf, valor, dtPagamento, hora, formaPagamento) VALUES
(1, 60.00, '2024-09-06', '22:20', 'Cartão de Crédito'),
(2, 25.00, '2024-09-06', '23:59', 'Dinheiro'),
(1, 70.00, '2024-09-07', '13:10', 'Cartão de Débito'),
(2, 30.00, '2024-09-08', '10:15', 'Pix'),
(1, 50.00, '2024-09-09', '21:30', 'Cartão de Crédito');

INSERT INTO Pedido (idClienteCpf, idLojistaCnpj, idProdutoPedido, idEntregador, endereco, dtPedido, hora, statu, valorTotal, idPagamento) VALUES
(1, 1, 1, 1, 'Rua das Flores, 123', '2024-09-06', '18:30:00', '18:45:00', 60.00, 1),
(2, 2, 2, 2, 'Avenida Central, 456', '2024-09-06', '19:00:00', '19:30:00', 25.00, 2);

INSERT INTO Avaliacao (idClienteCpf, idLojistaCnpj, idPedido, nota, comentario) VALUES
(1, 1, 1, 5, 'Excelente comida!'),
(2, 2, 2, 0, 'Horrivel, desistam!.');

-- UPDATE -- 
UPDATE 
Cliente SET email = 'carrapicho123@exemplo.com' WHERE nome = 'Daniel Fiusa'

-- DELETE --
DELETE FROM CategoriaLojista
WHERE idCategoriaLojista = 3 

-- COMANDOS DQL --
-- (1) SELECIONAR TODOS OS CLIENTES -- 
SELECT * FROM Cliente

-- (2) QUAL AVALIAÇÃO FOI FEITA POR UM CLIENTE ESPECÍFICO --
SELECT A.comentario, C.nome
FROM Avaliacao AS A INNER JOIN Cliente AS C 
ON A.idClienteCpf =  C.idClienteCpf
WHERE C.idClienteCpf = 2

-- (3) SOMA DAS VENDAS REALIZADAS EM UM DETERMINADO DIA --
SELECT SUM(P.valorTotal)
FROM Pedido AS P 
WHERE dtPedido = '2024-09-06'

-- (4) QUAIS PEDIDOS FORAM ENTREGUES POR UM ENTREGADOR ESPECÍFICO --
SELECT P.idPedido, E.nome
FROM Pedido AS P INNER JOIN Entregador AS E 
ON P.idEntregador =  E.idEntregador 
WHERE E.idEntregador = 2

-- (5) QUAL O TOTAL DE PAGAMENTOS FEITOS POR TODOS OS CLIENTES --
SELECT SUM(P.valor)
FROM Pagamentos AS P

-- (6) QUAIS PRODUTOS PERTENCEM A UMA CATEGORIA ESPECÍFICA --
SELECT C.nome, P.nome
FROM CategoriaProduto AS C INNER JOIN Produto AS P 
ON C.idCategoriaProduto = P.idCategoriaProduto
WHERE C.idCategoriaProduto = 1

-- (7) QUAIS PEDIDOS TEM UM VALOR TOTAL ACIMA DE UM DETERMINADO VALOR -- 
SELECT P.idPedido, P.valorTotal
FROM Pedido AS P 
WHERE P.valorTotal > 50

-- (8) QUAIS SÃO OS ENDEREÇOS DOS CLIENTES CADASTRADOS -- 
SELECT C.endereco
FROM Cliente AS C 

-- (9) QUAIS CLIENTES FIZERAM AVALIAÇÕES E QUAIS FORAM SUAS NOTAS -- 
SELECT C.nome, A.nota
FROM Cliente AS C INNER JOIN Avaliacao AS A
ON A.idClienteCpf = C.idClienteCpf

-- (10) QUAL PEDIDO TEM UM VALOR TOTAL INFERIOR À MÉDIA DOS PEDIDOS --
SELECT P.idPedido, P.valorTotal 
FROM Pedido AS P
WHERE P.valorTotal >  
(
	SELECT AVG(P.valorTotal)
	FROM Pedido AS P
)


SELECT * FROM CategoriaLojista;
SELECT * FROM InfoProprietario;
SELECT * FROM Lojista;
SELECT * FROM CategoriaProduto;
SELECT * FROM Desconto;
SELECT * FROM Produto;
SELECT * FROM Entregador;
SELECT * FROM Cliente;
SELECT * FROM ProdutoPedido;
SELECT * FROM Pedido;
SELECT * FROM Avaliacao;
SELECT * FROM Pagamentos;

