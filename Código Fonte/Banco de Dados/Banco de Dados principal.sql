create database FruitTech;

use FruitTech;

create table agricultor(
idAgricultor int primary key auto_increment,
nome varchar(50) not null,
cpf char(11) unique not null,
telefone varchar(15) unique not null,
fazenda varchar(65) not null,
cep char(9) not null,
uf char(2) not null
);

create table transportadora(
idTransportadora int primary key auto_increment,
nomeTransp varchar(65) not null,
telefoneTransp varchar(15) unique not null, 
cnpj char(14) unique not null,
cep char(9) not null,
uf char(2) not null
);

create table caminhao(
placa char(7) primary key,
comprimento decimal(5, 2),
altura decimal(4, 2),
statusMonitoramento varchar(7),
fkAgricultor int,
constraint fkAgri foreign key (fkAgricultor) references agricultor(idAgricultor),
fkTransportadora int,
constraint fkTransp foreign key (fkTransportadora) references transportadora(idTransportadora), 
constraint chkStatusMonitoramento check (statusMonitoramento in ('Ativo', 'Inativo'))
);
        
create table alerta (
idAlerta int primary key auto_increment,   
tipoAlerta varchar(20),
descricaoAlerta text,
acoesTomadas text,
Timestamp timestamp
);

create table produto (
idProduto int primary key auto_increment,
tipoProduto varchar(9),
nomeProduto varchar(80),
tempIdeal decimal(5, 2),
umidIdeal decimal(5, 2),
volumePlantio decimal(10, 2),
dataPlantio date,
condicaoAtual varchar(7),
constraint chkTipoProduto check (tipoProduto  in ('Fruta', 'Hortaliça')),
constraint chkCondicaoAtual check (condicaoAtual in ('Bom', 'Alerta', 'Crítico'))
);
  
-- INSERTS
insert into agricultor (nome, cpf, telefone, fazenda, cep, uf) values
('João Silva', '12345678901', '11987654321', 'Fazenda do choro', '09876543', 'SP'),
('Maria Santos', '23456789012', '21987654321', 'Fazenda da Alegria', '08765432', 'RJ'),
('Pedro Oliveira', '34567890123', '31987654321', 'Fazenda Rei Do Sol', '07654321', 'MG');

insert into transportadora (nomeTransp, telefoneTransp, cnpj, cep, uf) values
('DHL', '11987654321', '12345678901234', '09876543', 'SP'),
('Lalamove', '21987654321', '23456789012345', '08765432', 'RJ'),
('AgroTransp', '31987654321', '34567890123456', '07654321', 'MG');

insert into caminhao (placa, comprimento, altura, statusMonitoramento, fkAgricultor, fkTransportadora) values
('ABC1234', 10.5, 4.2, 'Ativo', 1, null),
('DEF5678', 12.3, 4.5, 'Ativo', 2, null),
('GHI9012', 11.2, 4.3, 'Ativo', null, 3),
('JKL0123', 15.0, 5.0, 'Ativo', 2, null),
('MNO4567', 6.0, 4.0, 'Inativo', null, 3),
('PQR5678', 28.8, 5.0, 'Ativo', null, 1),
('STU6789', 17.1, 4.5, 'Ativo', null, 2),
('VWX7890', 12.0, 4.7, 'Ativo', null, 1),
('YZA8901', 15.9, 4.5, 'Ativo', null, 2);

insert into alerta (TipoAlerta ,DescricaoAlerta ,AcoesTomadas ,Timestamp ) values
('Temperatura','Temperatura acima do ideal para o produto','Abaixar temperatura local','2023-09-09 23:43:07'),
('Umidade','Umidade abaixo do ideal para o produto','Aumentar umidade local','2023-09-09 23:43:07'),
('Umidade','Umidade acima do ideal para o produto','Abaixar umidade local','2023-09-09 23:43:07');

insert into Produto (tipoProduto, nomeProduto, tempIdeal, umidIdeal, volumePlantio, dataPlantio, condicaoAtual) values
('Fruta', 'Maçã Gala', 20.5, 60.0, 1000.0, '2023-09-01','Bom'),
('Hortaliça','Alface Crespa' ,18.0 ,70.0 ,500.0 ,'2023-09-11','Alerta'),
('Fruta','Banana Prata' ,22.0 ,65.0 ,1500.0 ,'2023-09-17','Crítico');

-- SELECTS
select nome, fazenda, placa, statusMonitoramento from agricultor join caminhao on fkAgricultor = idAgricultor;
select nomeTransp, placa, statusMonitoramento from transportadora join caminhao on fkTransportadora = idTransportadora;
select DescricaoAlerta ,AcoesTomadas, Timestamp from alerta;
select nomeProduto, dataPlantio, condicaoAtual from produto;
