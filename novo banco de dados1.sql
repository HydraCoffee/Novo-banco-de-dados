CREATE DATABASE hydracoffee;
USE hydracoffee;

CREATE TABLE empresa(
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(60),
cnpj CHAR(14),
email VARCHAR(60),
senha VARCHAR(45)
);

CREATE TABLE funcionario(
idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(60),
senha VARCHAR(40),
cpf CHAR(11) UNIQUE,
fkEmpresa INT,
CONSTRAINT empresaFk FOREIGN KEY(fkEmpresa) 
	REFERENCES empresa(idEmpresa)
);

CREATE TABLE endereco(
idEndereco INT PRIMARY KEY AUTO_INCREMENT,
fkEmpresa INT,
CONSTRAINT empresaFk FOREIGN KEY(fkEmpresa) 
	REFERENCES empresa(idEmpresa),
CEP CHAR(8),
cidade VARCHAR(30),
estado VARCHAR(20)
);

CREATE TABLE setor(
idSetor INT PRIMARY KEY AUTO_INCREMENT,
fkFuncionario INT,
areaPlantacao DECIMAL(8,2),
CONSTRAINT funcionarioFk FOREIGN KEY(fkfuncionario)
	REFERENCES funcionario(idfuncionario)
);

CREATE TABLE sensor(
idSensor INT PRIMARY KEY AUTO_INCREMENT,
fkSetor INT,
statusSensor VARCHAR(10),
CONSTRAINT setorFk FOREIGN KEY(fkSetor)
	REFERENCES setor(idSetor),
CONSTRAINT chkStatusS CHECK(statusSensor IN('operante','reparo','inativo'))
);

CREATE TABLE medicao(
idMedicao INT PRIMARY KEY AUTO_INCREMENT,
fkSensor INT,
umidade INT,
dtHrMedicao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
statusMedicao VARCHAR(10),
CONSTRAINT chkStatusM CHECK(statusMedicao IN('ideal','atenção','risco')),
CONSTRAINT sensorFk FOREIGN KEY(fkSensor)
	REFERENCES sensor(idSensor)
);

CREATE TABLE localSensor(
idLocal INT PRIMARY KEY AUTO_INCREMENT,
talhão VARCHAR(45),
fila VARCHAR(45),
planta INT,
fkSensor INT,
CONSTRAINT sensorlocalFk FOREIGN KEY(fkSensor)
	REFERENCES sensor(idSensor)
);

