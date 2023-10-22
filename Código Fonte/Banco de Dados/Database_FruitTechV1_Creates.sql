drop database FruitTechV1;

create database FruitTechV1;

use FruitTechV1;

-- ENTIDADES
create table Transportadora (
idTransportadora int primary key auto_increment,
nomeTransp varchar(45),
cnpj char(14),
RNTRC varchar(14),
categoriaRNTRC char(3),
emailTransp varchar(60),
senhaTransp varchar(30)
);

create table Usuario (
idUsuario int auto_increment,
fkTransportadora int,
primary key (idUsuario, fkTransportadora),
nomeUsuario varchar(40),
sobrenomeUsuario varchar(40),
cpf char(11),
senhaUsuario varchar(30),
constraint fkTransportadora foreign key (fkTransportadora) references Transportadora(idTransportadora)
);

create table Endereco (
idEndereco int primary key auto_increment,
estado varchar(30),
cep char(8),
cidade varchar(30),
rua varchar(45),
bairro varchar(45),
numero int,
complemento varchar(45),
fkTranspEnd int, 
constraint fkTranspEnd foreign key (fkTranspEnd) references Transportadora(idTransportadora)
);

create table Caminhao (
idCaminhao int primary key auto_increment,
marcaCaminhao varchar(40),
modeloCaminhao varchar(40),
chassiCaminhao char(17),
comprimentoCaminhao decimal(5,3),
alturaCaminhao decimal(4,2),
fkTranspCam int, 
constraint fkTranspCam foreign key (fkTranspCam) references Transportadora(idTransportadora)
);

create table Telefone (
idTelefone int primary key auto_increment,
telefoneFixo char(10),
telefoneCelular char(11),
fkTranspTel int, 
constraint fkTranspTel foreign key (fkTranspTel) references Transportadora(idTransportadora)
);

create table Produto (
idProduto int primary key auto_increment,
nomeProduto varchar(40),
tipoProduto varchar(30),
tempIdeal decimal (5,2),
umidIdeal decimal(5,2),
fkCaminhaoProd int, 
constraint fkCaminhaoProd foreign key (fkCaminhaoProd) references Caminhao(idCaminhao)
);

create table Sensor (
idSensor int primary key auto_increment,
tipo varchar(5),
statusMonitoramento char(7),
fkCaminhaoSens int, 
constraint fkCaminhaoSens foreign key (fkCaminhaoSens) references Caminhao(idCaminhao)
);

create table SensorDados (
idSensorDados int auto_increment,
fkSensor int,
primary key (idSensorDados, fkSensor),
umidade double,
temperatura double,
data_hora timestamp,
constraint fkSensor foreign key (fkSensor) references Sensor(idSensor)
);

-- DESCRIBES
describe Transportadora;
describe Usuario;
describe Endereco;
describe Caminhao;
describe Telefone;
describe Produto;
describe Sensor;
describe SensorDados;
