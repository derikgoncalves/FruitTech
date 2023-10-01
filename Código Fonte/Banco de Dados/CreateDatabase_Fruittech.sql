CREATE DATABASE FruitTech;
USE FruitTech;


CREATE TABLE tbAgricultor (
  idAgricultor INT PRIMARY KEY AUTO_INCREMENT,
  nomeAgricultor VARCHAR(50) NOT NULL,
  sobrenomeAgricultor VARCHAR(50) NOT NULL,
  cpfAgricultor CHAR(14) UNIQUE NOT NULL,
  cnpjAgricultor CHAR(18) UNIQUE DEFAULT 'Nenhum CNPJ.',
  senhaAgricultor VARCHAR(45) NOT NULL,
  nomeFazendaAgricultor VARCHAR(65) DEFAULT 'Nenhum nome de fazenda.',
  logradouroAgricultor VARCHAR(100) NOT NULL,
  numLogradouroAgricultor INT NOT NULL,
  complementoAgricultor VARCHAR(45) DEFAULT 'Nenhum complemento.',
  bairroAgricultor VARCHAR(65) NOT NULL,
  cidadeAgricultor VARCHAR(45) NOT NULL,
  estadoAgricultor VARCHAR(45) NOT NULL,
  cepAgricultor CHAR(9) UNIQUE NOT NULL
);

CREATE TABLE tbFoneAgricultor (
  idfoneAgricultor INT PRIMARY KEY AUTO_INCREMENT,
  numTelefoneAgricultor CHAR(11) NOT NULL,
  fkAgricultor INT,
  CONSTRAINT fkAgricultorFone FOREIGN KEY (fkAgricultor) REFERENCES tbAgricultor (idAgricultor)
);

CREATE TABLE tbCaminhao (
  placaCaminhao CHAR(7) PRIMARY KEY UNIQUE NOT NULL,
  marcaCaminhao VARCHAR(40) NOT NULL,
  modeloCaminhao VARCHAR(40) NOT NULL,
  anoFabricacaoCaminhao CHAR(4) NOT NULL,
  chassiCaminhao CHAR(17) UNIQUE NOT NULL,
  capacidadeCaminhao DECIMAL(4, 1) NOT NULL,
  comprimentoCaminhao DECIMAL(5, 2) NOT NULL,
  alturaCaminhao DECIMAL(4, 2) NOT NULL,
  odometroCaminhao INT NOT NULL,
  tipoCombustivelCaminhao VARCHAR(25) NOT NULL,
  CONSTRAINT chkTipoCombustivel CHECK (tipoCombustivelCaminhao IN ('Diesel Comum', 'Diesel S-10', 'Diesel aditivado', 'Diesel premium', 'Gás Natural', 'Eletricidade', 'Outro'))
);

CREATE TABLE tbProduto (
  idProduto INT PRIMARY KEY AUTO_INCREMENT,
  tipoProduto VARCHAR(15) NOT NULL,
  nomeProduto VARCHAR(80) NOT NULL,
  tempIdeal DECIMAL(5, 2) NOT NULL,
  umidIdeal DECIMAL(5, 2) NOT NULL,
  CONSTRAINT chkTipoProduto CHECK (tipoProduto IN ('Fruta')),
  fkAgricultor INT, CONSTRAINT fkAgricultorProduto FOREIGN KEY (fkAgricultor) REFERENCES tbAgricultor(idAgricultor)
) AUTO_INCREMENT = 10;

CREATE TABLE tbRemessa (
  idRemessa INT PRIMARY KEY AUTO_INCREMENT,
  quantidadeRemessa INT NOT NULL,
  dataEnvioRemessa DATE NOT NULL,
  dataRecebimentoRemessa DATE NOT NULL,
  LogradourolocalOrigem VARCHAR(80) NOT NULL,
  numLogradouroLO INT NOT NULL,
  complementoLO VARCHAR(40) NOT NULL,
  bairroLO VARCHAR(40) NOT NULL,
  cidadeLO VARCHAR(40) NOT NULL,
  estadoLO VARCHAR(40) NOT NULL,
  cepLO CHAR(9) UNIQUE NOT NULL,
  LogradourolocalDestino VARCHAR(80) NOT NULL,
  numLogradouroLD INT NOT NULL,
  complementoLD VARCHAR(40),
  bairroLD VARCHAR(40) NOT NULL,
  cidadeLD VARCHAR(40) NOT NULL,
  estadoLD VARCHAR(40) NOT NULL,
  cepLD CHAR(9) UNIQUE NOT NULL,
  NCMRemessa CHAR(10) NOT NULL,
  distanciaRemessa DOUBLE NOT NULL,
  fkProduto INT,
  CONSTRAINT fkProdutoRemessa FOREIGN KEY (fkProduto) REFERENCES tbProduto(idProduto),
  fkCaminhao CHAR(7),
  CONSTRAINT fkCaminhaoRemessa FOREIGN KEY (fkCaminhao) REFERENCES tbCaminhao(placaCaminhao)
) AUTO_INCREMENT = 100;

CREATE TABLE tbSensor (
  idSensor INT PRIMARY KEY AUTO_INCREMENT,
  tipo VARCHAR(5) NOT NULL,
  statusMonitoramento VARCHAR(7) NOT NULL,
  CONSTRAINT chktipo CHECK (tipo IN ('DHT11', 'LM35')),
  CONSTRAINT chkStatusMonitoramento CHECK (statusMonitoramento IN ('Ativo', 'Inativo')),
  fkCaminhao CHAR(7),
  CONSTRAINT fkCaminhaoSensor FOREIGN KEY (fkCaminhao) REFERENCES tbCaminhao (placaCaminhao)
);


CREATE TABLE tbSensorDados (
  id_sensorDados INT PRIMARY KEY AUTO_INCREMENT,
  umidade DOUBLE NOT NULL,
  temperatura DOUBLE NOT NULL,
  data_Hora DATETIME DEFAULT CURRENT_TIMESTAMP,
  fkSensor INT,
  CONSTRAINT fkSensorSensorDados FOREIGN KEY (fkSensor) REFERENCES tbSensor(idSensor)
);



