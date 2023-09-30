USE FruitTech;

CREATE TABLE tbAgricultor (
  idAgricultor INT PRIMARY KEY AUTO_INCREMENT,
  nomeCompletoAgricultor VARCHAR(50) NOT NULL,
  cpfAgricultor CHAR(11) UNIQUE NOT NULL,
  cnpjAgricultor CHAR(14) UNIQUE DEFAULT 'Nenhum CNPJ.',
  senhaAgricultor VARCHAR(40) NOT NULL,
  nomeFazendaAgricultor VARCHAR(65) DEFAULT 'Nenhum nome de fazenda.',
  logradouroAgricultor VARCHAR(100) NOT NULL,
  numLogradouroAgricultor INT NOT NULL,
  complementoAgricultor VARCHAR(40) DEFAULT 'Nenhum complemento.',
  bairroAgricultor VARCHAR(60) NOT NULL,
  cidadeAgricultor VARCHAR(40) NOT NULL,
  estadoAgricultor VARCHAR(40) NOT NULL,
  cepAgricultor CHAR(8) UNIQUE NOT NULL
);

CREATE TABLE tbFoneAgricultor (
  idfoneAgricultor INT PRIMARY KEY AUTO_INCREMENT,
  numTelefoneAgricultor CHAR(13) NOT NULL,
  fkAgricultor INT,
  CONSTRAINT fkAgric FOREIGN KEY (fkAgricultor) REFERENCES tbAgricultor (idAgricultor)
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
  tipoCombustivelCaminhao VARCHAR(10) NOT NULL,
  CONSTRAINT chkTipoCombustivel CHECK (tipoCombustivelCaminhao IN ('Diesel Comum', 'Diesel S-10', 'Diesel aditivado', 'Diesel premium', 'Gás Natural', 'Eletricidade', 'Outro'))
);

CREATE TABLE Produto (
  idProduto INT PRIMARY KEY AUTO_INCREMENT,
  tipoProduto VARCHAR(10) NOT NULL,
  nomeProduto VARCHAR(80) NOT NULL,
  tempIdeal DECIMAL(5, 2) NOT NULL,
  umidIdeal DECIMAL(5, 2) NOT NULL,
  CONSTRAINT chkTipoProduto CHECK (tipoProduto IN ('Fruta')),
  fkAgricultor INT,
  CONSTRAINT fkAgric FOREIGN KEY (fkAgricultor) REFERENCES tbAgricultor (idAgricultor)
) AUTO_INCREMENT = 10;

CREATE TABLE Remessa (
  idRemessa INT PRIMARY KEY AUTO_INCREMENT,
  quantidade INT NOT NULL,
  dataEnvio DATE NOT NULL,
  dataRecebimento DATE NOT NULL,
  LogradourolocalOrigem VARCHAR(80) NOT NULL,
  numLogradouroLO INT NOT NULL,
  complementoLO VARCHAR(40) NOT NULL,
  bairroLO VARCHAR(40) NOT NULL,
  cidadeLO VARCHAR(40) NOT NULL,
  estadoLO VARCHAR(40) NOT NULL,
  cepLO CHAR(8) UNIQUE NOT NULL,
  LogradourolocalDestino VARCHAR(80) NOT NULL,
  numLogradouroLD INT NOT NULL,
  complementoLD VARCHAR(40),
  bairroLD VARCHAR(40) NOT NULL,
  cidadeLD VARCHAR(40) NOT NULL,
  estadoLD VARCHAR(40) NOT NULL,
  cepLD CHAR(8) UNIQUE NOT NULL,
  NCM VARCHAR(10) NOT NULL,
  distancia DOUBLE NOT NULL,
  fkProduto INT,
  CONSTRAINT fkProdut FOREIGN KEY (fkProduto) REFERENCES Produto (idProduto),
  fkCaminhao CHAR(7),
  CONSTRAINT fkCaminh FOREIGN KEY (fkCaminhao) REFERENCES tbCaminhao (placaCaminhao)
) AUTO_INCREMENT = 100;

CREATE TABLE Sensor (
  idSensor INT PRIMARY KEY AUTO_INCREMENT,
  tipo VARCHAR(5) NOT NULL,
  statusMonitoramento VARCHAR(7) NOT NULL,
  CONSTRAINT chktipo CHECK (tipo IN ('DHT11', 'LM35')),
  CONSTRAINT chkStatusMonitoramento CHECK (statusMonitoramento IN ('Ativo', 'Inativo')),
  fkCaminhao CHAR(7),
  CONSTRAINT fkCaminh FOREIGN KEY (fkCaminhao) REFERENCES tbCaminhao (placaCaminhao)
);

CREATE TABLE sensorDados (
  id_sensorDados INT PRIMARY KEY AUTO_INCREMENT,
  umidade DOUBLE NOT NULL,
  temperatura DOUBLE NOT NULL,
  data_Hora DATETIME DEFAULT CURRENT_TIMESTAMP,
  fkSensor CHAR(7),
  CONSTRAINT fkSensor FOREIGN KEY (fkSensor) REFERENCES tbSenor(idSensor)
);
