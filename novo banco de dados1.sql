CREATE DATABASE hydracoffee;
USE hydracoffee;

CREATE TABLE cliente(
idCliente INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(60) NOT NULL,
senha VARCHAR(40) NOT NULL,
CNPJ CHAR(14) UNIQUE,
email VARCHAR(50) NOT NULL UNIQUE,
CONSTRAINT chkEmail CHECK (email LIKE '%@%')
);

CREATE TABLE endereco(
idEndereco INT PRIMARY KEY AUTO_INCREMENT,
fkCliente INT,
logradouro VARCHAR(60),
numero VARCHAR(5),
CEP CHAR(8),
cidade VARCHAR(30),
estado VARCHAR(20),
CONSTRAINT fkEnderecoCliente FOREIGN KEY (fkCliente)
	REFERENCES cliente(idCliente)
);

CREATE TABLE setor(
idSetor INT PRIMARY KEY AUTO_INCREMENT,
fkCliente INT,
areaPlantacao DECIMAL(8,2),
CONSTRAINT clienteFk FOREIGN KEY(fkCliente)
	REFERENCES cliente(idCliente)
);

CREATE TABLE sensor(
idSensor INT PRIMARY KEY AUTO_INCREMENT,
fkSetor INT,
statusSensor VARCHAR(10),
CONSTRAINT setorFk FOREIGN KEY(fkSetor)
	REFERENCES setor(idSetor),
CONSTRAINT chkStatus CHECK(statusSensor IN('ideal','atencao','risco'))
);

CREATE TABLE medicao(
idMedicao INT PRIMARY KEY AUTO_INCREMENT,
fkSensor INT,
umidade INT,
dtHrMedicao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT sensorFk FOREIGN KEY(fkSensor)
	REFERENCES sensor(idSensor)
);

INSERT INTO cliente (nome, senha, CNPJ, email) VALUES
('Cafe Bom Grão', '123456', '12345678000101', 'contato@bomgrao.com'),
('Fazenda Sol Nascente', 'abcdef', '98765432000199', 'sol@nascente.com'),
('Cafe Premium Brasil', 'senha123', '11223344000155', 'premium@cafe.com'),
('AgroTech Cafe', 'agro2024', '55667788000122', 'tech@agro.com'),
('Cafe da Serra', 'serra123', '99887766000144', 'serra@cafe.com'),
('Plantacao Verde', 'verde321', '44332211000166', 'verde@plant.com'),
('Cafe Export', 'export987', '66778899000111', 'export@cafe.com'),
('Cafe Orgânico Sul', 'organico', '10101010000110', 'org@cafe.com');

INSERT INTO endereco (fkCliente, logradouro, numero, CEP, cidade, estado) VALUES
(1, 'Rua A', '100', '01001000', 'São Paulo', 'SP'),
(2, 'Rua B', '200', '02002000', 'Campinas', 'SP'),
(3, 'Rua C', '300', '03003000', 'Belo Horizonte', 'MG'),
(4, 'Rua D', '400', '04004000', 'Curitiba', 'PR'),
(5, 'Rua E', '500', '05005000', 'Porto Alegre', 'RS'),
(6, 'Rua F', '600', '06006000', 'Salvador', 'BA'),
(7, 'Rua G', '700', '07007000', 'Rio de Janeiro', 'RJ'),
(8, 'Rua H', '800', '08008000', 'Florianópolis', 'SC');

INSERT INTO setor (fkCliente, areaPlantacao) VALUES
(1, 1500.50),
(2, 2000.00),
(3, 1750.75),
(4, 2200.10),
(5, 1600.00),
(6, 1900.25),
(7, 2100.80),
(8, 1800.60);

INSERT INTO sensor (fkSetor, statusSensor) VALUES
(1, 'ideal'),
(2, 'risco'),
(3, 'atencao'),
(4, 'ideal'),
(5, 'risco'),
(6, 'ideal'),
(7, 'atencao'),
(8, 'ideal');

INSERT INTO medicao (fkSensor, umidade) VALUES
(1, 65),
(2, 30),
(3, 45),
(4, 70),
(5, 25),
(6, 68),
(7, 50),
(8, 72);

