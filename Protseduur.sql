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
