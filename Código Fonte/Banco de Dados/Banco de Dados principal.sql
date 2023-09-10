create database FruitTechdb;

use FruitTechdb;

create table agricultor(
idAgricultor int primary key auto_increment,
nome varchar(50) not null,
cpf char(11) unique not null,
telefone varchar(15) unique not null,
fazenda varchar(65) not null,
cep char(9) not null,
uf char(2) not null,
caminhao varchar(3) not null,
constraint chkCaminhao check(caminhao in ('sim', 'não'))
);

create table caminhoes (
idCaminhao int primary key auto_increment,
idAgricultor int,
placa varchar(10) unique not null,
origem varchar(14) not null,
comprimento decimal(5, 2),
altura decimal(4, 2),
statusMonitoramento varchar(7),
foreign key (idAgricultor) references agricultor (idAgricultor),
constraint chkOrigem check (origem in ('Agricultor', 'Transportadora')),
constraint chkStatusMonitoramento check (statusMonitoramento in ('Ativo', 'Inativo'))
);

create table transportadora(
idTransportadora int primary key auto_increment,
nomeTransp varchar(65) not null,
telefoneTransp varchar(15) unique not null, 
cnpj char(14) unique not null,
cep char(9) not null,
uf char(2) not null
);

create table produto (
idProduto int primary key auto_increment,
idAgricultor int,
tipoProduto varchar(9),
nomeProduto varchar(80),
tempIdeal decimal(5, 2),
umidIdeal decimal(5, 2),
volumePlantio decimal(10, 2),
dataPlantio date,
condicaoAtual varchar(7),
constraint chkTipoProduto check (tipoProduto  in ('Fruta', 'Hortaliça')),
constraint chkCondicaoAtual check (condicaoAtual in ('Bom', 'Alerta', 'Crítico')),
foreign key (idAgricultor) references agricultor (idAgricultor)
);

create table alerta (
idAlerta int primary key auto_increment,   
tipoAlerta varchar(20),
descricaoAlerta text,
acoesTomadas text,
Timestamp timestamp
);

-- INSERTS 
insert into agricultor (nome, cpf, telefone, fazenda, cep, uf, caminhao) values
('João Silva', '12345678901', '11987654321', 'Fazenda do choro', '09876543', 'SP', 'sim'),
('Maria Santos', '23456789012', '21987654321', 'Fazenda da Alegria', '08765432', 'RJ', 'não'),
('Pedro Oliveira', '34567890123', '31987654321', 'Fazenda Rei Do Sol', '07654321', 'MG', 'sim');

insert into caminhoes (idAgricultor, placa, origem, comprimento, altura, statusMonitoramento) values
(1, 'ABC1234', 'Agricultor', 10.5, 4.2, 'Ativo'),
(2, 'DEF5678', 'Transportadora', 12.3, 4.5, 'Ativo'),
(3, 'GHI9012', 'Agricultor', 11.2, 4.3, 'Ativo');

insert into transportadora (nomeTransp, telefoneTransp, cnpj, cep, uf) values
('DHL', '11987654321', '12345678901234', '09876543', 'SP'),
('Lalamove', '21987654321', '23456789012345', '08765432', 'RJ'),
('AgroTransp', '31987654321', '34567890123456', '07654321', 'MG');

insert into Produto (idAgricultor, tipoProduto, nomeProduto, tempIdeal, umidIdeal, volumePlantio, dataPlantio, condicaoAtual) values
(1, 'Fruta', 'Maçã Gala', 20.5, 60.0, 1000.0, '2023-09-01','Bom'),
(2,'Hortaliça','Alface Crespa' ,18.0 ,70.0 ,500.0 ,'2023-09-11','Alerta'),
(3,'Fruta','Banana Prata' ,22.0 ,65.0 ,1500.0 ,'2023-09-17','Crítico');

insert into alerta (TipoAlerta ,DescricaoAlerta ,AcoesTomadas ,Timestamp ) values
('Temperatura','Temperatura acima do ideal para o produto','Abaixar temperatura local','2023-09-09 23:43:07'),
('Umidade','Umidade abaixo do ideal para o produto','Aumentar umidade local','2023-09-09 23:43:07'),
('Umidade','Umidade acima do ideal para o produto','Abaixar umidade local','2023-09-09 23:43:07');

-- SELECTS
select * from agricultor;
select * from transportadora;
select * from caminhoes;
select * from produto;
select * from alerta;


