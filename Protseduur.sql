(localdb)\mssqllocaldb
--SQL salvestatud protseduur - funktsioon, mis käivitab serveris mitu SQL tegevust järjest
Kasutame SQL Server
Create database protseduurPosvystak;
use protseduurPosvystak;
Create table linn(
linnId int Primary key identity(1,1),
linnNimi varchar(30),
rahvaArv int);
Select * from linn;
Insert into linn(linnNimi, rahvaArv)
values ('Pärnu', 30000), ('Rakvere', 1284), ('Maardu', 9658), ('Tallinn', 60000), ('Tartu', 50000), ('Narva', 45000);
--protseduur loomine
--protseduur, mis lisab uus linn ja kohe näitab tabelis

create procedure lisaLinn
@lnimi varchar (30),
@rArv int
as
begin

Insert into linn(linnNimi, rahvaArv)
values (@lnimi, @rArv);
select * from linn;

end;
delete from linn where linnId=4;
--protseduuri kutse
EXEC lisaLinn @lnimi='Pärnu', @rArv=20000;
--lihtsam
Exec lisaLinn 'Tartu2', 1256;
--kirje kustutamine 
delete from linn where linnId=4;
select * from linn;

create procedure kustutaLinn
@deleteId int
as
begin
select * from linn;
delete from linn where linnId=@deleteId;
select * from linn;
end;

--kustuta
Exec kustutaLinn 5;
--protseduri kustutamine
Drop Procedure kustutaLinn
drop table linn

--protseduur, mis otsib linn esimene tähte järgi
create procedure linnaOtsing
@taht Char (1)
as
begin
select * from linn
where linnNimi like @taht + '%';
--% - kõik teised tähed
end;
--kutse
exec linnaOtsing T;

--tabeli uuendamine - rahvaarv kasvab 10%võrra 
update linn set rahvaArv=rahvaArv*1.1;
select * from linn
update linn set rahvaArv=rahvaArv*1.1
where linnId=2;

create procedure rahvuArvuUuendus
@linnId int,
@koef decimal(2,1)
as
begin
select * from linn;
update linn set rahvaArv=rahvaArv*@koef
where linnId=@linnId;
select * from linn;
end;
drop procedure rahvuArvuUuendus
exec rahvuArvuUuendus 2, 1.2;

Create table linn(
linnId int Primary key identity(1,1),
linnNimi varchar(30),
rahvaArv int);
Select * from linn;
Insert into linn(linnNimi, rahvaArv)
values ('Pärnu', 30000), ('Rakvere', 1284), 
('Maardu', 9658), ('Tallinn', 60000), 
('Tartu', 50000), ('Narva', 45000);

-- uue veeru lisamine
alter table  linn add test int;

-- veeru kustutamine
alter table linn drop column test;
create procedure veeruLisaKustuta
@valik varchar (20),
@tabelinimi varchar (20),
@veeruNimi varchar (20),
@tyyp varchar (20) =null
as
begin
declare @sqltegevus as varchar(max)
set @sqltegevus=case
when @valik='add' then concat ('alter table ', @tabelinimi, ' add ', @veeruNimi, ' ', 
@tyyp)
when @valik='drop' then concat ('alter table ', @tabelinimi, ' drop column ', @veeruNimi)
end;
print @sqltegevus;
begin
Exec (@sqltegevus)
end;
end;

drop procedure veeruLisaKustuta
--kutse
exec veeruLisaKustuta @valik='add', @tabelinimi='linn', @veeruNimi='col', @tyyp='int';
select * from linn;

exec veeruLisaKustuta @valik='drop', @tabelinimi='linn', @veeruNimi='col', @tyyp=' ';
select * from linn;

--protseduur tingimusega
create procedure rahvahinnang
@piir int
as
begin 
select linnNimi, rahvaArv, iif(rahvaArv<@piir, 'väike linn', 'suur linn') as Hinnang
from linn;
end;
drop procedure rahvahinnang;
exec rahvahinnang 2000;

--Agregaat funktsioonid: sum(), AVG(), min(), max(), count()

create procedure kokkuRahvaarv

as
begin
select Sum(rahvaArv) as 'kokku rahvaArv', avg(rahvaArv) as 'keskmine rahvaArv'
from linn;
end;

exec kokkuRahvaarv;
select * from linn;
--------------------------------------------------------------------------

kasutame XAMPP / localhost
use protseduurPosvystak;
Create table linn(
linnId int Primary key AUTO_INCREMENT,
linnNimi varchar(30),
rahvaArv int);
Insert into linn(linnNimi, rahvaArv)
values ('Pärnu', 30000), ('Rakvere', 1284), ('Maardu', 9658), ('Tallinn', 60000), ('Tartu', 50000), ('Narva', 45000);
{create procedure lisaLinn
@lnimi varchar (30),
@rArv int
as
begin
Insert into linn(linnNimi, rahvaArv)
values (@lnimi, @rArv);
select * from linn;
end;}


create table Raamatatud(
Id int Primary key AUTO_INCREMENT,
Pealkiri varchar (30),
Autor varchar (30),
Aasta int);
insert into Raamatatud(Pealkiri, Autor, Aasta)
values ('Nad mõlemad surevad lõpus', 'Adam Silvera', 2017), 
('Mara ja Morok', 'Lea Arden', 2020),
('Kuus varest', 'Lee Bardugo', 2015),
('Korrumpeerunud kuningriik', 'Lee Bardugo', 2016),
('Neljas tiivas', 'Rebecca Jarros', 2023),
('Raudne leek', 'Rebecca Jarros', 2024),
('Imetlene nõid', 'Anna Jane', 2020),
('Armunud nõid', 'Anna Jane', 2022);
