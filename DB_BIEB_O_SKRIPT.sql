--Erstellungsskript für die Datenbank BIEB_O
--erstellt am: 21.06.2018
--erstellt von: Markus Weißflog



/*******************************Erstellen der Datenbank/create database*******************************/
use master
go
--Datenbank löschen und Löschen der Backups
exec msdb.dbo.sp_delete_database_backuphistory @database_name='BIEB_O'
go
if exists (select * from sys.databases where name = 'BIEB_O')
drop database BIEB_O
go
--Erstellen der Datenbank mit Hilfe des Templates model
--alle Einstellungen von model werden verwendet
create database BIEB_O
go



/*********************************Erstellen der Tabellen/create table*********************************/
--ohne Constraints

use BIEB_O
go
--Erstellen der Tabelle Angebot
if exists (select * from sys.objects where name = 'Angebot')
drop table Angebot
go
create table Angebot
(
	AID				int				not null	identity(1,1)
,	APreis			decimal(7,2)	not null
,	BID				int				not null
,	LID				int				not null
)
go

--Erstellen der Tabelle Warenkorb
if exists (select * from sys.objects where name = 'Warenkorb')
drop table Warenkorb
go
create table Warenkorb
(
	Pos				tinyint			not null
,	WStückzahl		int				not null
,	AID				int				not null
,	EID				int				not null
)
go

--Erstellen der Tabelle Einkaeufe
if exists (select * from sys.objects where name = 'Einkaeufe')
drop table Einkaeufe
go
create table Einkaeufe
(
	EID				int				not null	identity(1,1)
,	Bestelldatum	date			not null
)
go

--Erstellen der Tabelle Bauteile
if exists (select * from sys.objects where name = 'Bauteile')
drop table Bauteile
go
create table Bauteile
(
	BID				int				not null	identity(1,1)
,	BBezeichnung	varchar(80)		not null
,	VKPreis			decimal(7,2)	not null
)
go

--Erstellen der Tabelle Roboterkomponenten
if exists (select * from sys.objects where name = 'Roboterkomponenten')
drop table Roboterkomponenten
go
create table Roboterkomponenten
(
	RKStückzahl		int				not null
,	BID				int				not null
,	RID				int				not null
)
go

--Erstellen der Tabelle Roboter
if exists (select * from sys.objects where name = 'Roboter')
drop table Roboter
go
create table Roboter
(
	RID				int				not null	identity(1,1)
,	RBezeichnung	varchar(80)		not null
,	MatKosten		decimal(7,2)	not null	default 0
,	ProdKosten		decimal(7,2)	not null
)
go

--Erstellen der Tabelle Ansprechpartner
if exists (select * from sys.objects where name = 'Ansprechpartner')
drop table Ansprechpartner
go
create table Ansprechpartner
(
	APartnerID		int 			not null	identity(1,1)
,	akadTitel		varchar(20)		null
,	Vorname			varchar(50)		not null
,	Nachname		varchar(50)		not null
)
go

--Erstellen der Tabelle Lieferanten
if exists (select * from sys.objects where name = 'Lieferanten')
drop table Lieferanten
go
create table Lieferanten
(
	LID				int				not null	identity(1,1)
,	LName			varchar(80)		not null
,	AdrID			int				not null
,	APartnerID		int 			not null
,	Email			varchar(50)		not null
,	TelFest			varchar(20)		not null
)
go


--Erstellen der Tabelle Adressen
if exists (select * from sys.objects where name = 'Adressen')
drop table Adressen
go
create table Adressen
(
	AdrID			int				not null	identity(1,1)
,	Land			char(2)			not null
,	PLZ				char(5)			not null
,	Ort				varchar(50)		not null
,	Straße			varchar(50)		not null
,	HNr				varchar(10)		not null
)
go

--Erstellen der Tabelle Lager
if exists (select * from sys.objects where name = 'Lager')
drop table Lager
go
create table Lager
(
	LagerID			int				not null	identity(1,1)
,	AdrID			int				not null
)
go

--Erstellen der Tabelle Lagerbestand
if exists (select * from sys.objects where name = 'Lagerbestand')
drop table Lagerbestand
go
create table Lagerbestand
(
	LagerID			int				not null
,	BID				int				not null
,	IstStk			int				not null	default 0
,	MdstStk			int				not null
)
go



/***********************************Testdaten einfügen/insert into************************************/
--Einfügen für Tabelle Angebot
insert into Angebot (APreis, BID, LID)
values
	(5.00,	9,	3)
,	(20.00,	6,	6)
,	(10.00,	2,	7)
,	(40.00,	3,	6)
,	(5.00,	8,	7)
,	(5.00,	15,	3)
,	(10.00,	12,	4)
,	(25.00,	14,	7)
,	(15.00,	10,	4)
,	(60.00,	7,	6)
,	(30.00,	4,	6)
,	(20.00,	1,	1)
,	(25.00,	11,	6)
,	(80.00,	5,	5)
,	(20.00,	13,	7)
go

--Einfügen für Tabelle Warenkorb
insert into Warenkorb
values
	(1,	135,	12,	1)
,	(1,	56,		1,	2)
,	(2,	13,		6,	2)
,	(1,	64,		9,	3)
,	(2,	10,		7,	3)
,	(1,	163,	3,	4)
,	(2,	47,		5,	4)
,	(3,	15,		8,	4)
,	(1,	58,		2,	5)
,	(2,	23,		10,	5)
,	(1,	100,	12,	6)
,	(1,	110,	14,	7)
,	(1,	0,		15,	8)
,	(1,	45,		11,	9)
,	(2,	50,		4,	9)
,	(3,	13,		13,	9)
go

--Einfügen für Tabelle Einkaeufe
insert into Einkaeufe (Bestelldatum)
values
	('22.02.2018')
,	('31.03.2018')
,	('12.04.2018')
,	('04.05.2018')
,	('15.05.2018')
,	('15.05.2018')
,	('31.05.2018')
,	('02.06.2018')
,	('03.06.2018')
go

--Einfügen für Tabelle Bauteile
insert into Bauteile (BBezeichnung, VKPreis)
values
	('Reifen',			25.00)
,	('Arm',				15.00)
,	('Sensor',			45.00)
,	('Display',			35.00)
,	('Motor',			85.00)
,	('Netzteil',		25.00)
,	('Prozessor',		65.00)
,	('Gelenk',			10.00)
,	('Verbindungsstück',10.00)
,	('Lackierung',		20.00)
,	('Lautsprecher',	30.00)
,	('Farbpatrone',		15.00)
,	('Magazin',			25.00)
,	('Greifarm',		30.00)
,	('Objektbehälter',	10.00)
go

--Einfügen für Tabelle Roboterkomponenten
insert into Roboterkomponenten
values
	(4,	1,	1)
,	(1,	3,	1)
,	(1,	5,	1)
,	(1,	4,	1)
,	(2,	2,	1)
,	(1,	6,	1)
,	(1,	7,	1)
,	(2,	8,	1)
,	(1,	10,	1)
,	(8,	9,	1)
,	(1,	12,	1)
,	(4,	1,	2)
,	(1,	3,	2)
,	(1,	5,	2)
,	(1,	4,	2)
,	(1,	2,	2)
,	(1,	6,	2)
,	(1,	7,	2)
,	(1,	8,	2)
,	(1,	10,	2)
,	(7,	9,	2)
,	(1,	13,	2)
,	(3,	1,	3)
,	(1,	3,	3)
,	(1,	5,	3)
,	(1,	4,	3)
,	(1,	6,	3)
,	(1,	7,	3)
,	(1,	10,	3)
,	(5,	9,	3)
,	(1,	14,	3)
,	(6,	1,	4)
,	(3,	3,	4)
,	(2,	5,	4)
,	(1,	4,	4)
,	(1,	2,	4)
,	(1,	6,	4)
,	(1,	7,	4)
,	(2,	8,	4)
,	(1,	10,	4)
,	(9,	9,	4)
,	(1,	11,	4)
,	(1,	15,	4)
,	(4,	1,	5)
,	(2,	3,	5)
,	(1,	5,	5)
,	(2,	4,	5)
,	(1,	6,	5)
,	(1,	7,	5)
,	(2,	8,	5)
,	(1,	10,	5)
,	(5,	9,	5)
,	(2,	11,	5)
go

--Einfügen für Tabelle Roboter
insert into Roboter(RBezeichnung, MatKosten, ProdKosten)
values
	('Aktenschwärzer',			0,	50.00)
,	('Fill-Phil (aufstocker)',	0,	50.00)
,	('Sortierer',				0,	70.00)
,	('Büro-Bote',				0,	80.00)
,	('Disziplinierer',			0,	40.00)
go

--Einfügen für Tabelle Ansprechpartner
insert into Ansprechpartner(akadTitel, Vorname, Nachname)
values
	('Dr.',			'Rolf',		'Lange')
,	('',			'Martin',	'Groß')
,	('Prof.',		'Lara',		'Müller')
,	('Prof.',		'Steffen',	'Kraft')
,	('Prof. Dr.',	'Peter',	'Meier')
,	('',			'Ines',		'Ludwig')
,	('Dr.',			'Ole',		'Müller')
go

--Einfügen für Tabelle Lieferanten
insert into Lieferanten(LName, AdrID, APartnerID, Email, TelFest)
values
	('Rudis Reifen',			2,	4,	'HansMüller@rudi-reifen.com',				'+49 139 1234 13')
,	('Mecha Corp',				4,	3,	'workslave34601@mechaCorp.com',				'+49 133 3124493')
,	('Krupp',					3,	1,	'elly.steel@kripp.com',						'+49 2134 324123')
,	('Luckys Lack',				1,	5,	'bradFoster@luckys-lack.com',				'+49 1393912')
,	('Ben Driesel und Sohn',	8,	2,	'drieselsSohn@aol.com',						'+49 392 391244')
,	('Trumpf',					5,	6,	'anettaGorodetzki@info-trumpf.com',			'+49 124 2342')
,	('Future Industrys',		6,	7,	'luiseFetcher@contact-futureIndustrys.com',	'+31 11 1432983')
go

--Einfügen für Tabelle Adressen
insert into Adressen(Land, PLZ, Ort, Straße, HNr)
values
	('DE',	'99084',	'Erfurt',	'Juri-Gagarin-Ring',	'12')
,	('DE',	'44137',	'Dortmund',	'Petergasse',			'128')
,	('DE',	'10115',	'Berlin',	'Liesenstraße',			'3a')
,	('DE',	'20144',	'Hamburg',	'Parkallee',			'14')
,	('DE',	'99086',	'Erfurt',	'Breitscheidstraße',	'45c')
,	('DE',	'01067',	'Dresden',	'Roßthaler Straße',		'56')
,	('DE',	'99086',	'Erfurt',	'Am Roten Berg',		'13')
,	('DE',	'80333',	'München',	'Finkenstraße',			'48')
go

--Einfügen für Tabelle Lager
insert into Lager (AdrID)
values
	(7)
go

--Einfügen für Tabelle Lagerbestand
insert into Lagerbestand (LagerID, BID, MdstStk)
values
	(1,	1,	50)
,	(1,	9,	30)
,	(1,	15,	10)
,	(1,	10,	30)
,	(1,	12,	10)
,	(1,	2,	50)
,	(1,	8,	30)
,	(1,	14,	10)
,	(1,	6,	30)
,	(1,	7,	15)
,	(1,	5,	50)
,	(1,	13,	10)
,	(1,	4,	30)
,	(1,	3,	30)
,	(1,	11,	10)
go

--Nacharbeiten der Testdaten in Ansprechpartner
update Ansprechpartner
set akadTitel = null
where akadTitel = ''



/**********************************Tabellen modifizieren/alter table**********************************/
--Integritätssicherung, Constraints hinzufügen

--Bauteile
	--> Primärschlüssel
	--> Unique Key auf BBezeichnung
alter table Bauteile
	add
	constraint PK_Bauteile primary key (BID)
,	constraint UK_BBezeichnung unique (BBezeichnung)
go

--Adressen
	--> Primärschlüssel
	--> Check auf Land
	--> Check auf PLZ
alter table Adressen
	add
	constraint PK_Adressen primary key (AdrID)
,	constraint CK_Land check (Land like '[A-Z][A-Z]')
,	constraint CK_PLZ check (PLZ like '[0-9][0-9][0-9][0-9][0-9]')
go

--Ansprechpartner
	--> Primärschlüssel
	--> Check auf akadTitel
alter table Ansprechpartner
	add 
	constraint PK_Ansprechpartner primary key (APartnerID)
,	constraint CK_akadTitel check (akadTitel in ('Prof.', 'Dr.', 'Prof. Dr.'))
go

--Lieferanten
	--> Primärschlüssel
	--> Fremdschlüssel mit Referenz auf Adressen
	--> Fremdschlüssel mit Referenz auf Ansprechpartner
alter table Lieferanten
	add
	constraint PK_Lieferanten primary key (LID)
,	constraint FK_Lieferanten_Adressen foreign key (AdrID) references Adressen (AdrID)
,	constraint FK_Lieferanten_Ansprechpartner foreign key (APartnerID) references Ansprechpartner (APartnerID)
go

--Angebot
	--> Primärschlüssel
	--> Fremdschlüssel mit Referanz auf Bauteile
	--> Fremdschlüssel mit Referanz auf Lieferanten
alter table Angebot
	add
	constraint PK_Angebot primary key (AID)
,	constraint FK_Angebot_Bauteile foreign key (BID) references Bauteile (BID)
,	constraint FK_Angebaot_Lieferanten foreign key (LID) references Lieferanten (LID)
go

--Einkaeufe
	--> Primärschlüssel
alter table Einkaeufe
	add
	constraint PK_Einkaeufe primary key (EID)
go

--Warenkorb
	--> Fremdschlüssel mit Referanz auf Angebote
	--> Fremdschlüssel mit Referanz auf Einkaeufe
alter table Warenkorb
	add
	constraint FK_Warenkorb_Angebot foreign key (AID) references Angebot (AID)
,	constraint FK_Warenkorb_Einkaeufe foreign key (EID) references Einkaeufe (EID)
go

--Roboter
	--> Primärschlüssel
	--> Unique Key auf RBezeichnung
alter table Roboter
	add
	constraint PK_Roboter primary key (RID)
,	constraint UK_RBezeichnung unique (RBezeichnung)
go

--Roboterkomponenten
	--> Fremdschlüssel mit Referenz auf Bauteile
	--> Fremdschlüssel mit Referenz auf Roboter
alter table Roboterkomponenten
	add
	constraint FK_Roboterkomponenten_Bauteile foreign key (BID) references Bauteile (BID)
,	constraint FK_Roboterkomponenten_Roboter foreign key (RID) references Roboter (RID)
go

--Lager
	--> Primärschlüssel
	--> Fremdschlüssel mit Referenz auf Adressen
alter table Lager
	add
	constraint PK_Lager primary key (LagerID)
,	constraint FK_Lager_Adressen foreign key (AdrID) references Adressen (AdrID)
go

--Lagerbestand
	--> Fremdschlüssel mit Referenz auf Lager
	--> Fremdschlüssel mit Referanz auf Bauteile
alter table Lagerbestand
	add
	constraint FK_Lagerbestand_Lager foreign key (LagerID) references Lager (LagerID)
,	constraint FK_Lagerbestand_Bauteile foreign key (BID) references Bauteile (BID)
go




--Nacharbeiten der Testdaten in Roboter
	--> Ermitteln und Setzen der Materialkosten für alle Roboter
if exists (select * from sys.objects where name= 'P_MatPreisSetzen' and type= 'P')
begin
	drop procedure P_MatPreisSetzen
end
go
create procedure P_MatPreisSetzen
as
begin
	declare
	@counter int = 1,
	@AnzahlZeilen int =(select count(*) from Roboter)
	while (@counter < @AnzahlZeilen+1)
	begin
		update Roboter
		set MatKosten = (select sum(VKPreis)
						from Roboter r join Roboterkomponenten rk on r.RID = rk.RID
						join Bauteile b on rk.BID = b.BID
						where r.RID = @counter)
		where RID = @counter
		set @counter = @counter +1
	end
end
go
exec P_MatPreisSetzen

--Nacharbeiten der Testdaten in Lagerbestand
	--> Ermitteln und Setzen der vorhandenen Stückzahl für alle Bauteile
if exists (select * from sys.objects where name= 'P_EinkaufszahlenSetzen' and type= 'P')
begin
	drop procedure P_EinkaufszahlenSetzen
end
go
create procedure P_EinkaufszahlenSetzen
as
begin
	declare
	@counter int = 1,
	@AnzahlZeilen int =(select count(*) from Lagerbestand)
	while (@counter <= @AnzahlZeilen)
	begin
		update Lagerbestand
		set IstStk = (select sum(WStückzahl)
					 from Warenkorb w join Angebot a on w.AID = a.AID
					 where BID = @counter)
		where BID = @counter
		set @counter = @counter + 1
	end
end
go
exec P_EinkaufszahlenSetzen
--Prozedur wieder löschen, da sie nur einmalig gültig aufgerufen werden kann, um den Lagerbestand aus
--allen Einkäufen zu ermitteln
drop procedure P_EinkaufszahlenSetzen



/**********************************Erstellen der Sichten/create view**********************************/



/******************************Erstellen der Funktionen/create function*******************************/




/******************************Erstellen der Prozeduren/create procedure******************************/



/********************************Erstellen der Trigger/create trigger*********************************/