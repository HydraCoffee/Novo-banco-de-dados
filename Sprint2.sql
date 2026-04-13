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

CREATE TABLE sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
numSerie VARCHAR(45),
setor VARCHAR(50)
);

CREATE TABLE baseIntegrada (
idBaseInt INT PRIMARY KEY,
fkSensor INT,
fkCliente INT,
CONSTRAINT clienteFK FOREIGN KEY (fkCliente)
	REFERENCES cliente(idCliente),
CONSTRAINT sensorFK FOREIGN KEY (fkSensor)
	REFERENCES sensor(idSensor)
    );
    
CREATE TABLE medicao (
idMedicao INT PRIMARY KEY AUTO_INCREMENT,
medida INT,
dtHrMedicao DATETIME,
fkBi INT,
CONSTRAINT fkBaseInt FOREIGN KEY (fkBi)
	REFERENCES baseIntegrada(idBaseInt)
);	






