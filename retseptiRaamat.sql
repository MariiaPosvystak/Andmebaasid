SQL Server
create database retseptiRaamatPosvystak;
use retseptiRaamatPosvystak;

create table kasutaja(
kasutaja_id int primary key identity (1,1),
eesnimi varchar(50),
perenimi varchar(50) not null,
email varchar (150));

insert into kasutaja(eesnimi, perenimi, email)
values ('Kira', 'Kira', 'kira@tthk.ee'), ('Nikita', 'Nikita', 'nikita@tthk.ee'), 
('Mark', 'Mark', 'mark@tthk.ee'), ('Roman', 'Roman', '´roman@tthk.ee'),
('Mariia', 'Mariia', 'mariia@tthk.ee');
select * from kasutaja;

create table kategooria(
kategooria_id int primary key identity(1,1),
kategooria_nimi varchar(50));

insert into kategooria(kategooria_nimi)
values ('kondiitritooted'), ('magus'),('supid'),('röstitud'),('salatid');

create table toiduaine(
toiduaine_id int primary key identity(1,1),
toiduaine_nimi varchar (100));

insert into toiduaine(toiduaine_nimi)
values('juust'), ('liha'), ('tomatid'), ('munad'),('leivapuru');

create table yhik(
yhik_id int primary key identity(1,1),
yhik_nimi varchar(100));

insert into yhik(yhik_nimi)
values ('ml'),('g'),('kg'),('tl'),('sl');

create table retsept(
retsept_id int primary key identity(1,1),
retsepti_nimi varchar(100),
kirjeldus varchar(200),
juhend varchar(500),
sisestatud_kp date,
kasutaja_id int,
foreign key (kasutaja_id) references kasutaja(kasutaja_id),
kategooria_id int,
foreign key (kategooria_id) references kategooria(kategooria_id));

insert into retsept(retsepti_nimi, kirjeldus, juhend, 
sisestatud_kp, kasutaja_id, kategooria_id)
values ('supp', 'maitsev supp', 'keeta koostisained', '2003-01-01',1,2), 
('Caesar', 'maitsev salat', 'tükeldage köögivilju', '2008-10-12',5,4),
('Steak', 'maitsev steak', 'praetud liha', '2009-08-21',2,3), 
('juustukook', 'maitsev magus', 'segage koostisosad kokku', '2025-10-25',3,1),
('supp', 'maitsev supp', 'keeta koostisained', '2023-12-15',4,1);

create table koostis(
koostis_id int primary key identity(1,1),
kogus int,
retsept_retsept_id int,
foreign key (retsept_retsept_id) references retsept(retsept_id),
toiduaine_id int,
foreign key (toiduaine_id) references toiduaine(toiduaine_id),
yhik_id int,
foreign key (yhik_id) references yhik(yhik_id));

insert into koostis(kogus, retsept_retsept_id, toiduaine_id, yhik_id)
values (3,1,1,1),(2,4,5,1),(2,3,1,4),(1,5,2,3),(5,1,3,2);

create table tehtud(
tehtud_id int primary key identity(1,1),
tehtud_kp date,
retsept_id int,
foreign key (retsept_id) references retsept(retsept_id));

insert into tehtud(tehtud_kp, retsept_id)
values('2023-10-30',1),('2015-06-03',2),('2018-05-13',3),
('2020-11-26',4),('2021-02-24',5);

create procedure addRetsept
@Rnimi varchar(100),
@kirjeldus varchar(200),
@juhend varchar(500),
@sis_kp date,
@kas_id int,
@kat_id int
as
begin
select * from retsept;
insert into retsept(retsepti_nimi, kirjeldus, juhend, 
sisestatud_kp, kasutaja_id,kategooria_id)
values (@Rnimi, @kirjeldus, @juhend, @sis_kp, @kas_id, @kat_id)
select * from retsept;
end;

create procedure addKoostis
@kogus int,
@retsept_retsept_id int,
@toiduaine_id int,
@yhik_id int
as
begin 
select * from koostis;
insert into koostis(kogus,retsept_retsept_id,toiduaine_id,yhik_id)
values(@kogus,@retsept_retsept_id,@toiduaine_id,@yhik_id);
select * from koostis;
end;

create procedure addTehtud
@tehtud_kp date,
@retsept_id int
as
begin 
select * from tehtud;
insert into tehtud(tehtud_kp, retsept_id)
values (@tehtud_kp, @retsept_id);
select * from tehtud;
end;

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

create table soovitatav_jook(
jook_id int primary key identity(1,1),
jook_nimi varchar (50),
retsept_id int,
foreign key (retsept_id) references retsept(retsept_id));

insert into soovitatav_jook(jook_nimi,retsept_id)
values ('ouzvar',1),('tee',2),('punane vein',3),('kohv',4),('ouzvar',5);

create table hind(
hind_id int primary key identity (1,1),
retsept_id int,
foreign key (retsept_id) references retsept(retsept_id),
hind decimal (3,1));


create procedure jookid
@jook_id int
as
begin
select * from soovitatav_jook;
delete from soovitatav_jook Where jook_id=@jook_id;
select * from soovitatav_jook;
end;

create procedure lisajookid
@jook_nimi varchar (50),
@retsept_id int
as
begin
select * from soovitatav_jook;
insert into  soovitatav_jook(jook_nimi,retsept_id)
values (@jook_nimi,@retsept_id);
select * from soovitatav_jook;
end;

exec lisajookid 'vein', 4
exec jookid 6
exec addRetsept
exec addKoostis
exec addTehtud
exec veeruLisaKustuta 'drop','kasutaja','Telefoni_number', 'varchar(50)'


select * from kasutaja;
select * from kategooria;
select * from toiduaine;
select * from yhik;
select * from retsept;
select * from koostis;
select * from tehtud;
