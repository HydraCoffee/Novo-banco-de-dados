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
CONSTRAINT empresaEndFk FOREIGN KEY(fkEmpresa) 
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

INSERT INTO empresa (nome, cnpj, email, senha) VALUES
('Grão Nobre', '12345678000101', 'contato@graonobre.com', 'senha123'),
('Café Horizonte', '23456789000102', 'admin@cafehoriz.com', 'cafe2024'),
('Fazenda Arábica', '34567890000103', 'sac@arabica.com', 'fazenda99'),
('EcoCoffee Ltda', '45678901000104', 'info@ecocoffee.br', 'eco#789'),
('Terra Roxa S.A.', '56789012000105', 'diretoria@terraroxa.com', 'terra456'),
('Minas Grãos', '67890123000106', 'vendas@minasgraos.com', 'minas321'),
('Sabor do Campo', '78901234000107', 'campo@sabor.com', 'campo1010'),
('Aliança Cafeeira', '89012345000108', 'gestao@alianca.com', 'ali@2026'),
('Portal do Café', '90123456000109', 'atendimento@portal.com', 'port_88'),
('Raízes de Ouro', '01234567000110', 'admin@raizes.com', 'ouro_pure');

INSERT INTO funcionario (nome, senha, cpf, fkEmpresa) VALUES
('Carlos Silva', 'car123', '11122233344', 1),
('Ana Souza', 'ana999', '22233344455', 2),
('Beto Oliveira', 'beto88', '33344455566', 3),
('Daniela Lima', 'dani77', '44455566677', 4),
('Eduardo Costa', 'edu666', '55566677788', 5),
('Fernanda Rocha', 'fer555', '66677788899', 6),
('Gabriel Neves', 'gab444', '77788899900', 7),
('Helena Dias', 'hel333', '88899900011', 8),
('Igor Santos', 'igo222', '99900011122', 9),
('Julia Melo', 'jul111', '00011122233', 10);

INSERT INTO endereco (fkEmpresa, CEP, cidade, estado) VALUES
(1, '37130000', 'Alfenas', 'MG'),
(2, '14400000', 'Franca', 'SP'),
(3, '36900000', 'Manhuaçu', 'MG'),
(4, '37500000', 'Itajubá', 'MG'),
(5, '14000000', 'Ribeirão Preto', 'SP'),
(6, '37000000', 'Varginha', 'MG'),
(7, '86000000', 'Londrina', 'PR'),
(8, '29300000', 'Cachoeiro de Itapemirim', 'ES'),
(9, '36880000', 'Muriaé', 'MG'),
(10, '37190000', 'Três Pontas', 'MG');

INSERT INTO setor (fkFuncionario, areaPlantacao) VALUES
(1, 15.50), 
(2, 22.10), 
(3, 10.00), 
(4, 45.30), 
(5, 30.00),
(6, 18.75), 
(7, 50.00), 
(8, 12.40), 
(9, 28.90), 
(10, 35.60);

INSERT INTO sensor (fkSetor, statusSensor) VALUES
(1, 'operante'), 
(2, 'operante'), 
(3, 'reparo'), 
(4, 'inativo'), 
(5, 'operante'),
(6, 'operante'), 
(7, 'reparo'), 
(8, 'operante'), 
(9, 'inativo'), 
(10, 'operante');

INSERT INTO medicao (fkSensor, umidade, statusMedicao) VALUES
(1, 65, 'ideal'), 
(2, 40, 'atenção'), 
(3, 20, 'risco'), 
(5, 68, 'ideal'), 
(6, 62, 'ideal'),
(8, 38, 'atenção'), 
(10, 70, 'ideal'), 
(1, 64, 'ideal'), 
(5, 42, 'atenção'), 
(8, 15, 'risco');

INSERT INTO localSensor (talhão, fila, planta, fkSensor) VALUES
('Norte 01', 'A-12', 10, 1),
('Sul 04', 'B-05', 25, 2),
('Leste 02', 'F-09', 5, 3),
('Oeste 01', 'G-11', 42, 4),
('Central', 'C-01', 50, 5),
('Vale Verde', 'V-20', 38, 6),
('Encosta', 'E-03', 14, 7),
('Planalto', 'P-15', 33, 8),
('Baixada', 'L-07', 21, 9),
('Topo Sul', 'T-02', 47, 10);

SELECT 
    m.idMedicao,
    s.idSensor,
    m.umidade,
    CASE 
        WHEN m.umidade < 40 THEN 'CRÍTICO: Irrigação Imediata!'
        WHEN m.umidade BETWEEN 41 AND 60 THEN 'ALERTA: Solo secando'
        WHEN m.umidade BETWEEN  61 AND 80 THEN 'ÓTIMO: Nível ideal'
        ELSE 'ATENÇÃO: Possível excesso de água'
    END AS analise_agronomica,
    m.statusMedicao
FROM medicao m
JOIN sensor s ON m.fkSensor = s.idSensor;

SELECT 
    idSensor,
    statusSensor,
    CASE statusSensor
        WHEN 'operante' THEN 'Equipamento Ativo'
        WHEN 'reparo' THEN 'Técnico em Deslocamento'
        WHEN 'inativo' THEN 'Substituição Necessária'
        ELSE 'Desconhecido'
    END AS acao_manutencao
FROM sensor;

SELECT 
    l.talhão,
    l.fila,
    l.planta,
    s.statusSensor,
    CASE 
        WHEN s.statusSensor = 'inativo' THEN 'ALTA PRIORIDADE'
        WHEN s.statusSensor = 'reparo' THEN 'MÉDIA PRIORIDADE'
        ELSE 'Monitoramento de Rotina'
    END AS prioridade_visita
FROM localSensor l
JOIN sensor s ON l.fkSensor = s.idSensor;