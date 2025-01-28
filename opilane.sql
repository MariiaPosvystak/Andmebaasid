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
