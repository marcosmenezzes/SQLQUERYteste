CREATE DATABASE dbEmpresa
ON PRIMARY(
	NAME = 'dbEmpresa',
	FILENAME = 'C:\BD\dbEmpresa.MDF',
	SIZE = 10MB,
	MAXSIZE = 50MB,
	FILEGROWTH = 10%
);

GO
USE dbEmpresa;
GO

CREATE TABLE tblFuncionario
(
	id_fun INT NOT NULL IDENTITY(1,1),
	nm_fun VARCHAR(20) NOT NULL,
	segundo_nm_fun VARCHAR(20) NULL,
	ultimo_nm_fun VARCHAR(40) NOT NULL,
	dt_nasc DATE NOT NULL,
	cpf CHAR(11) NOT NULL UNIQUE,
	rg VARCHAR(20) NOT NULL UNIQUE,
	logradouro VARCHAR(30) NOT NULL,
	cep CHAR(8) NOT NULL,
	cidade VARCHAR(40) NOT NULL,
	uf CHAR(2) NOT NULL,
	fone CHAR(11) NOT NULL,
	id_dep CHAR(3) NOT NULL,
	funcao VARCHAR(30) NOT NULL,
	salario MONEY NOT NULL
);


ALTER TABLE tblFuncionario
ADD CONSTRAINT pk_id_fun_tblFuncionario
PRIMARY KEY(id_fun);

CREATE TABLE tblDepartamento
(
	id_dep CHAR(3) NOT NULL UNIQUE,
	nm_dep VARCHAR(20) NOT NULL,
	localizacao VARCHAR(10) NOT NULL,
	id_fun_gerente INT NULL
);

ALTER TABLE tblDepartamento
ADD CONSTRAINT pk_id_dep_tblDepartamento
PRIMARY KEY(id_dep);

ALTER TABLE tblDepartamento
ADD CONSTRAINT fk_id_fun_gerente
FOREIGN KEY(id_fun_gerente)
REFERENCES tblFuncionario(id_fun);

ALTER TABLE tblFuncionario
ADD CONSTRAINT fk_id_dep_tblFuncionario
FOREIGN KEY(id_dep)
REFERENCES tblDepartamento(id_dep);

INSERT INTO tblDepartamento
VALUES('PDG','PEDAG�GICO','BLOCO A',NULL);
INSERT INTO tblDepartamento
VALUES('ADM','ADMINISTRATIVO','BLOCO B',NULL);
INSERT INTO tblDepartamento
VALUES('RCM','RELA��ES COM MERCADO','BLOCO A',NULL);
INSERT INTO tblDepartamento
VALUES('IST','INSTRUTORES','BLOCO A',NULL);
INSERT INTO tblDepartamento
VALUES('SRV','SERVI�OS GERAIS','BLOCO C',NULL);

INSERT INTO tblFuncionario
VALUES('Bruno','Cezar','Manzoli Ferreira','1977/09/23','08545192808','221312-SPTC-ES',
'Rua Espanha, 83','29900210','Linhares','ES','27999990806','IST','Instrutor',1080);

INSERT INTO tblFuncionario
VALUES('Carlos','Alexandre','Loureiro Faria','1982/05/09','77766655512','32445-SPTC-ES',
'Rua Borba Gato, 352','29900345','Linhares','ES','27999992222','IST','Instrutor',2880);

INSERT INTO tblFuncionario
VALUES('Marcos','Carlesso','Deocl�cio','1971/10/05','11122233309','124873-SPTC-ES',
'Avenida das Na��es, 183','29902090','Linhares','ES','27999991010','ADM','Analista T�cnico',3080);

INSERT INTO tblFuncionario
VALUES('Uilton','Jos�','Mendon�a de Jesus','1977/02/17','12398755320','998120-SPTC-ES',
'Rua Tupinangui, 1020','29920076','S�o Mateus','ES','27999991100','RCM','Consultor',2300);

INSERT INTO tblFuncionario
VALUES('Isabel ',NULL,'Rodrigues Almeida','1977/06/11','5542906711','220912-SPTC-ES',
'Rua Valdir Dur�o, 1090','29900220','Linhares','ES','27998120901','SRV','Auxiliar Serv. Gerais',3080);


SELECT * FROM tblFuncionario

UPDATE tblDepartamento 
SET id_fun_gerente = 3
WHERE id_dep = 'ADM'

--------------------------------------------TRABALHANDO COM COMANDOS DQL-----------------------------------------
--QUEST�O 01
SELECT nm_fun , segundo_nm_fun, ultimo_nm_fun
FROM tblFuncionario
ORDER BY (ultimo_nm_fun);
---- QUEST�O 2
SELECT * FROM tblFuncionario
ORDER BY (cidade)
----QUEST�O 3
SELECT nm_fun,	segundo_nm_fun, ultimo_nm_fun 
FROM tblFuncionario 
WHERE salario > 1000
ORDER BY (nm_fun)
--- QUEST�O 4
SELECT dt_nasc, nm_fun
FROM tblFuncionario
ORDER BY (dt_nasc) DESC
---- QUEST�O 5
SELECT ultimo_nm_fun, nm_fun, segundo_nm_fun, fone, logradouro, cidade
FROM tblFuncionario
----QUEST�O 06
SELECT SUM(salario)
FROM tblFuncionario
---QUEST�O 7 
----UTILIZANDO WHERE
SELECT F.nm_fun, D.nm_dep,	F.funcao
FROM tblDepartamento AS D, tblFuncionario AS F
WHERE F.id_dep = D.id_dep;
-------UTILIZANDO INNER JOIN
SELECT F.nm_fun, D.nm_dep, F.funcao
FROM tblDepartamento AS D 
INNER JOIN tblFuncionario AS F 
ON D.id_dep = F.id_dep;

----QUEST�O 8
SELECT D.nm_dep, F.nm_fun
FROM tblDepartamento AS D
INNER JOIN tblFuncionario AS F
ON D.id_fun_gerente = F.id_fun;

----QUEST�O 9 
SELECT D.nm_dep, SUM(F.salario)
FROM tblDepartamento AS D 
INNER JOIN tblFuncionario AS F
ON F.id_dep = D.id_dep
GROUP BY (D.nm_dep);

----QUESTAO 10 
SELECT D.nm_dep
FROM tblDepartamento AS D 
INNER JOIN tblFuncionario AS F
ON D.id_dep = F.id_dep
WHERE F.funcao = 'Consultor'

---QUESTAO 11

SELECT COUNT (id_fun)
FROM tblFuncionario

---QUESTAO 12
SELECT AVG (salario)
FROM tblFuncionario
----QUESTAO 13

SELECT D.nm_dep, MIN (F.salario)
FROM tblDepartamento AS D
INNER JOIN tblFuncionario AS F
ON F.id_dep = D.id_dep
GROUP BY (D.nm_dep);

----QUEST�O 14
SELECT D.nm_dep, F.nm_fun
FROM tblDepartamento AS D
INNER JOIN tblFuncionario AS F
ON F.id_dep = D.id_dep
ORDER BY D.nm_dep DESC, F.nm_fun

----QUEST�O 15

---QUEST�O 16
SELECT F.nm_fun
FROM tblDepartamento AS D
INNER JOIN tblFuncionario AS F
ON F.id_dep = D.id_dep
WHERE D.nm_dep = 'Administrativo'







