--COMANDOS DDL
CREATE DATABASE db_Revenda_Automoveis
ON PRIMARY(
	NAME = db_Revenda_Automoveis,
	FILENAME = 'C:\BD\db_Revenda_Automoveis.MDF',
	SIZE = 10MB,
	MAXSIZE = 30MB,
	FILEGROWTH = 10%
);

GO
USE db_Revenda_Automoveis;
GO

CREATE TABLE tbl_Automoveis
(
	cod_automovel INT PRIMARY KEY IDENTITY(1010,1),
	nm_fabricante VARCHAR(30) NOT NULL,
	nm_modelo VARCHAR(30) NOT NULL UNIQUE,
	ano CHAR(4) NOT NULL,
	pais VARCHAR(30) NOT NULL,
	preco_tabela MONEY NOT NULL
);

CREATE TABLE tbl_Revendedoras
(
	cnpj CHAR(14) PRIMARY KEY,
	nm_revendedora VARCHAR(30) NOT NULL,
	nm_proprietario VARCHAR(30) NOT NULL,
	nm_cidade VARCHAR(30) NOT NULL,
	uf CHAR(2) NOT NULL
);

CREATE TABLE tbl_Clientes
(
	rg VARCHAR(20) PRIMARY KEY,
	nm_cliente VARCHAR(30) NOT NULL,
	sm_cliente VARCHAR(30) NOT NULL
);

CREATE TABLE tbl_Vendas
(
	rg_cliente VARCHAR(20) NOT NULL,
	cnpj_revenda CHAR(14) NOT NULL,
	cod_automovel INT NOT NULL,
	ano SMALLINT NOT NULL,
	dt_venda DATE NOT NULL,
	preco_venda MONEY NOT NULL
);

CREATE TABLE tbl_Estoque
(
cnpj_revenda CHAR(14) NOT NULL,
cod_automovel INT NOT NULL,
qtde SMALLINT NOT NULL
);

ALTER TABLE tbl_Vendas
ADD CONSTRAINT pk_tbl_vendas_clientes
PRIMARY KEY (rg_cliente,cnpj_revenda,cod_automovel,dt_venda);

ALTER TABLE tbl_Vendas
ADD CONSTRAINT fk_rg_tbl_vendas_clientes
FOREIGN KEY (rg_cliente)
REFERENCES tbl_Clientes(rg);

ALTER TABLE tbl_Vendas
ADD CONSTRAINT fk_cnpj_tbl_vendas_revendedora
FOREIGN KEY (cnpj_revenda)
REFERENCES tbl_Revendedoras(cnpj);

ALTER TABLE tbl_Vendas
ADD CONSTRAINT fk_cod_automovel_tbl_vendas_automoveis
FOREIGN KEY (cod_automovel)
REFERENCES tbl_Automoveis(cod_automovel);

ALTER TABLE tbl_Estoque
ADD CONSTRAINT pk_cnpj_cod_automovel_tbl_estoque_revenda
PRIMARY KEY (cnpj_revenda,cod_automovel);

ALTER TABLE tbl_Estoque
ADD CONSTRAINT fk_cnpj_revenda_tbl_estoque_revenda
FOREIGN KEY (cnpj_revenda)
REFERENCES tbl_Revendedoras(cnpj);

ALTER TABLE tbl_Estoque
ADD CONSTRAINT fk_cod_automovel_tbl_estoque_automovel
FOREIGN KEY (cod_automovel)
REFERENCES tbl_Automoveis(cod_automovel);

--COMANDOS DML
INSERT INTO tbl_Automoveis
VALUES('FIAT','Siena','2012','Itália',35000);
INSERT INTO tbl_Automoveis(nm_fabricante,nm_modelo,ano,preco_tabela,pais)
VALUES('GM','Cruze','2014',55000,'EUA');
INSERT INTO tbl_Automoveis(nm_fabricante,nm_modelo,ano,preco_tabela,pais)
VALUES('Toyota','Corolla','2015',70000,'Japão');
INSERT INTO tbl_Automoveis(nm_fabricante,nm_modelo,ano,preco_tabela,pais)
VALUES('Toyota','Hilux','2013',70000,'Japão');
INSERT INTO tbl_Automoveis(nm_fabricante,nm_modelo,ano,preco_tabela,pais)
VALUES('Toyota','SW4','2011',90000,'Japão');
INSERT INTO tbl_Automoveis(nm_fabricante,nm_modelo,ano,preco_tabela,pais)
VALUES('Toyota','Etios','2011',45000,'Japão');
INSERT INTO tbl_Automoveis(nm_fabricante,nm_modelo,ano,preco_tabela,pais)
VALUES('Volkswagem','Fusca','2011',40000,'Alemanha');
INSERT INTO tbl_Automoveis(nm_fabricante,nm_modelo,ano,preco_tabela,pais)
VALUES('GM','Cobalt','2009',21000,'EUA');
INSERT INTO tbl_Automoveis(nm_fabricante,nm_modelo,ano,preco_tabela,pais)
VALUES('Ford','Focus','2010',28000,'Alemanha');

INSERT INTO tbl_Revendedoras
VALUES('99877601123398','B&C Veículos','Joaquim Gomes','Linhares','ES');
INSERT INTO tbl_Revendedoras
VALUES('09987765009876','Voar Auto','Pedro Calisto','Colatina','ES');
INSERT INTO tbl_Revendedoras
VALUES('11120009001233','4 Rodas','Maurício Chaves','Eunápolis','BA');
INSERT INTO tbl_Revendedoras
VALUES('11111111111111','Brasil Automóveis','Altemar Felix','Colatina','ES');
INSERT INTO tbl_Revendedoras
VALUES('22222222222222','JBL Veículos','Julio Mancini Neves','São Mateus','ES');
INSERT INTO tbl_Revendedoras
VALUES('33333333333333','Multivel','Daniel Alves Rocha','Vitória','ES');

INSERT INTO tbl_Clientes
VALUES('1280126','Bruno Cezar','Manzoli Ferreira');
INSERT INTO tbl_Clientes
VALUES('9987008','Junior','da Silva');
INSERT INTO tbl_Clientes
VALUES('4762522','Carlos','Alberto Torres');
INSERT INTO tbl_Clientes
VALUES('0998373','Lucas','Abreu Filho');
INSERT INTO tbl_Clientes
VALUES('2984711','Antonio','Mello Soares');

INSERT INTO tbl_Estoque
VALUES('99877601123398',1011,3);
INSERT INTO tbl_Estoque
VALUES('99877601123398',1012,4);
INSERT INTO tbl_Estoque
VALUES('11111111111111',1011,5);
INSERT INTO tbl_Estoque
VALUES('11111111111111',1014,2);
INSERT INTO tbl_Estoque
VALUES('99877601123398',1016,5);
INSERT INTO tbl_Estoque
VALUES('22222222222222',1015,6);

INSERT INTO tbl_Vendas
VALUES('9987008','99877601123398',1011,2014,'11/28/2016',65500);
INSERT INTO tbl_Vendas
VALUES('9987008','99877601123398',1016,2011,'11/28/2015',39000);
INSERT INTO tbl_Vendas
VALUES('2984711','22222222222222',1015,2011,'11/28/2013',43000);

----QUESTÃO 1
SELECT DISTINCT A.nm_fabricante, A.pais
FROM tbl_Automoveis AS A;
----QUESTÃO 2
SELECT R.uf
FROM tbl_Automoveis AS A, tbl_Estoque AS E, tbl_Revendedoras AS R
WHERE A.cod_automovel = E.cod_automovel AND E.cnpj_revenda = R.cnpj
AND A.nm_modelo = 'Corolla' AND A.nm_fabricante = 'Toyota'
----QUESTÃO 3
SELECT R.nm_revendedora
FROM tbl_Revendedoras AS R
WHERE 
R.nm_revendedora NOT IN
(
SELECT R.nm_revendedora
FROM tbl_Automoveis AS A, tbl_Estoque AS E, tbl_Revendedoras AS R
WHERE A.cod_automovel = E.cod_automovel AND E.cnpj_revenda = R.cnpj
AND A.pais = 'Japão'
)
----QUESTÃO 4
SELECT R.nm_revendedora, R.nm_proprietario
FROM tbl_Revendedoras AS R INNER JOIN 
tbl_Vendas AS V  ON R.cnpj = V.cnpj_revenda INNER JOIN
tbl_Automoveis AS A ON V.cod_automovel = A.cod_automovel
WHERE YEAR (V.dt_venda) = '2015'AND V.ano = '2011' AND V.preco_venda <	A.preco_tabela
----QUESTÃO 5
SELECT nm_modelo, A.nm_fabricante, a.ano, a.preco_tabela
FROM tbl_Automoveis AS A
WHERE A.pais = 'Japão' or A.pais = 'Itália' 
ORDER BY A.nm_fabricante, A.ano DESC, A.preco_tabela DESC
---- QUESTÃO 6
SELECT A.nm_modelo
FROM tbl_Automoveis AS A  ----PRIMEIRO ESCOLHER A COLUNA (DO QUE(CARRO)) SERA MAIS CARO
WHERE
A.preco_tabela IN
(
SELECT MAX (A.preco_tabela) ----- DENTRO DA COLUNA DO CARRO SELECT USANDO (MAX) DA COLUNA PREÇO
FROM tbl_Automoveis AS A
)
---- QUESTÃO 7
SELECT SUM (E.qtde)
FROM tbl_Estoque AS E 
---- QUESTÃO 8

---- QUESTÃO 9
SELECT A.nm_modelo, A.preco_tabela
FROM tbl_Automoveis AS A
WHERE preco_tabela > '40000' AND preco_tabela < '50000' 
---- QUESTÃO 10
SELECT A.nm_modelo
FROM tbl_Automoveis AS A 
WHERE nm_modelo LIKE 'F_%'
