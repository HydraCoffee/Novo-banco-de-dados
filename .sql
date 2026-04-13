CREATE DATABASE hydracoffee;
USE hydracoffee;

CREATE TABLE cliente(
idCliente INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(60) NOT NULL,
senha VARCHAR(40) NOT NULL,
CNPJ CHAR(14) NOT NULL,
email VARCHAR(50) NOT NULL UNIQUE,
CONSTRAINT chkEmail CHECK (email LIKE '%@%')
);

CREATE TABLE endereco(
logradouro VARCHAR(60),
numero VARCHAR(5),
CEP FLOAT(8),
cidade VARCHAR(30),
estado VARCHAR(20)
);

CREATE TABLE setor(
idSetor INT,
fkCliente INT,
PRIMARY KEY (idSetor, fkCliente),
CONSTRAINT clienteFk FOREIGN KEY(fkCliente)
	REFERENCES cliente(idCliente),
areaPlantacao CHAR(8)
);

CREATE TABLE sensor(
idSensor INT PRIMARY KEY AUTO_INCREMENT,
fkSetor INT,
CONSTRAINT setorFk FOREIGN KEY(fkSetor)
	REFERENCES setor(idSetor),
statusSensor CHAR(7),
CONSTRAINT chkStatus CHECK(statusSensor IN('ideal','atenção','risco'))
);

CREATE TABLE medicao(
idMedicao INT,
fkSensor INT,
PRIMARY KEY (fkSensor, idMedicao),
CONSTRAINT sensorFk FOREIGN KEY(fkSensor)
	REFERENCES sensor(idSensor),
umidade INT,
dtHrMedicao DATETIME
);


