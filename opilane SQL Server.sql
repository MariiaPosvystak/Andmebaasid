--AB loomine
Create database PosvystakMariiaBaas;

use PosvystakMariiaBaas;
Create table opilane(
opilaneId int primary key identity(1,1),
eesnimi varchar(25) not null,
perenimi varchar(25) not null,
synniaeg date,
stip bit,
aadress text,
keskmine_hinne decimal(2,1)
)
select * from opilane; 
--andmete lisamine tabelisse
Insert into opilane(
eesnimi, 
perenimi, 
synniaeg, 
stip, 
keskmine_hinne)
Values(
'Nikita3',
'Nikita9',
'2000-03-29',
1,
4.4);

--tabeli kustumine
drop table opilane;
-- rida kustutamine, kus on õpilaneId=2
delete from opilane where opilaneId=6;
select * from opilane; 

--andmete uuendamine
update opilane set aadress='Tartu'
where opilaneId=3
--AB loomine
Create database PosvystakMariiaBaas;

use PosvystakMariiaBaas;
Create table opilane(
opilaneId int primary key identity(1,1),
eesnimi varchar(25) not null,
perenimi varchar(25) not null,
synniaeg date,
stip bit,
aadress text,
keskmine_hinne decimal(2,1)
)
select * from opilane; 
--andmete lisamine tabelisse
Insert into opilane(
eesnimi, 
perenimi, 
synniaeg, 
stip, 
keskmine_hinne)
Values(
'Nikita3',
'Nikita9',
'2000-03-29',
1,
4.4);

--tabeli kustumine
drop table opilane;
-- rida kustutamine, kus on õpilaneId=2
delete from opilane where opilaneId=6;
select * from opilane; 

--andmete uuendamine
update opilane set aadress='Tartu'
where opilaneId=3

CREATE TABLE Language
(
ID int NOT NULL PRIMARY KEY,
Code char(3) NOT NULL,
Language varchar(50) NOT NULL,
IsOfficial bit,
Percentage smallint
); 
select * from Language

insert into Language(ID, Code, Language)
Values (1, 'EE', 'eesti'), (2, 'RUS', 'vene'), (3, 'ENG', 'inglise'), (4, 'DE', 'saksa'), (5, 'UK', 'ukraina')

create table keeleValik(
keeleValikId int primary key identity (1,1),
valikuNimetus varchar(10) not null,
opilaneId int,
Foreign key (opilaneId) references opilane(opilaneId),
Language int,
Foreign key (Language) references Language(ID))

select * from keeleValik
select * from Language
select * from opilane

insert into keeleValik(valikuNimetus, opilaneId, Language)
Values('valik B', 5, 1)

update keeleValik set valikuNimetus='Valik C'
where keeleValikId=10

select * from opilane.eesnimi, Language.Language
From opilane, Language, keeleValik
where opilane.opilaneId=keeleValik.opilaneId
AND Language.ID=keeleValik.Language

create table oppimine(
oppimineId int primary key identity(1,1),
aine char (40),
aasta date,
opetaja char(30),
opilaneId ,
hinne decimal (2,0),
foreign key (opilaneId) references opilane(opilaneId))

select * from oppimine
drop table oppimine

insert into oppimine (aine, aasta, opetaja, opilaneId, hinne)
values ('Programmeerimine', 2025-01-15, 'Marina_Oleinik', 1, 5), ('Andmebaas', 2025-01-28, 'Irina_Merkulova', 2, 4)
