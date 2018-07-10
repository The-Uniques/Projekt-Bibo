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
,	(14.00,	2,	3)
,	(12.00,	2,	6)
,	(26.00,	13,	7)
,	(16.00,	15,	7)
,	(35.00,	4,	6)
,	(11.00,	12,	4)
,	(14.00,	15,	7)
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
	('Reifen',			24.99)
,	('Arm',				14.99)
,	('Sensor',			44.99)
,	('Display',			34.99)
,	('Motor',			84.99)
,	('Netzteil',		24.95)
,	('Prozessor',		64.98)
,	('Gelenk',			10.00)
,	('Verbindungsstück',10.00)
,	('Lackierung',		19.97)
,	('Lautsprecher',	28.90)
,	('Farbpatrone',		14.99)
,	('Magazin',			24.89)
,	('Greifarm',		29.99)
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
insert into Roboter(RBezeichnung, ProdKosten)
values
	('Aktenschwärzer',			50.00)
,	('Fill-Phil (Aufstocker)',	50.00)
,	('Sortierer',				70.00)
,	('Büro-Bote',				80.00)
,	('Disziplinierer',			40.00)
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
	while (@counter <= @AnzahlZeilen) --jede Zeile in Lagerbestand durchlaufen
		begin
			--wenn ein Bauteil noch nicht eingekauft wurde wird seine Iststückzahl im Lager nicht geändert,
			--sie ist per default 0
			if not exists (select * from Warenkorb w join Angebot a on w.AID = a.AID where BID = @counter)
				set @counter = @counter + 1
			--Eingekaufte Stückzahl für jedes Bauteil ermitteln, summieren und in Lagerbestand eintragen
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
,	constraint UK_LName unique (LName)
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



/******************************Erstellen der Funktionen/create function*******************************/
--Ermitteln des Preises für einen Roboter
	-- Parameter:	Robotername
	-- Rückgabe:	Preis, -1 falls falscher Name übergeben wurde
if exists (select * from sys.objects where name = 'FN_RoboterPreis' and type = 'FN')
begin
	drop function FN_RoboterPreis
end
go
create function FN_RoboterPreis(@RoboterName varchar(80))
returns decimal(7,2)
as
begin
	declare
	@preis decimal(7,2)

	if exists (select * from Roboter where RBezeichnung = @RoboterName)
		begin
			set @preis =	--Summe der Materialkosten der verwendeten Bauteile
							(select sum(VKPreis)
							from Roboter r join Roboterkomponenten rk on r.RID = rk.RID
										   join Bauteile b on rk.BID = b.BID
							where r.RBezeichnung = @RoboterName)
							+
							--Produktionskosten des Roboters
							(select ProdKosten
							from Roboter
							where RBezeichnung = @RoboterName)
		end
	else
		set @preis = -1

	return @preis
end
go

--Testfälle:
--select dbo.FN_RoboterPreis('Aktenschwärzer') --Engebnis: 399,84
--select dbo.FN_RoboterPreis('Sortierer') --Ergebnis: 409.85
--select dbo.FN_RoboterPreis('Diszipliniere') --falscher Name, Ergebnis: -1.00



--Anzeigen, ob für einen Roboter alle benötigten Bauteile auf Lager sind
	-- Parameter:	Robotername, Anzahl der Roboter
	-- Rückgabe:	0 falls alles vorhanden
	--				-1 wenn etwas fehlt
	--				-2 bei falschem Roboternamen
	--				-3 bei Anzahl < 1
if exists (select * from sys.objects where name = 'FN_BauteileVorhanden' and type = 'FN')
begin
	drop function FN_BauteileVorhanden
end
go
create function FN_BauteileVorhanden(@RoboterName varchar(80), @Anzahl int)
returns int
as
begin
	declare @rueck int = 0
	
	--falsche Bezeichnung abfangen
	if not exists (select * from Roboter where RBezeichnung = @RoboterName)
	begin
		set @rueck = -2
		return @rueck
	end
	--falsche Anzahl abfangen
	else if @Anzahl < 1
		begin
			set @rueck = -3
			return @rueck
		end

	declare
	BauteilCursor cursor
	scroll
	for			select IstStk, RKStückzahl
				from Roboter r join Roboterkomponenten rk on r.RID = rk.RID
							   join Lagerbestand l on rk.BID = l.BID
				where RBezeichnung = @RoboterName

	declare @istStk int, @rkStk int

	open BauteilCursor
	fetch first
	from BauteilCursor 
	into @istStk, @rkStk

	while @@FETCH_STATUS = 0
		begin
			--wenn die Iststückzahl kleiner als die benötigte Stückzahl ist, wirde der Rückgabewert -1 gesetzt,
			--die Schleife verlassen und der Wert zurückgegeben
			if (@istStk < @rkStk * @Anzahl)
				begin
					set @rueck = -1
					break
				end
			fetch next
			from BauteilCursor 
			into @istStk, @rkStk
		end
	return @rueck
end 
go

--Testfälle:
--select dbo.FN_BauteileVorhanden('Aktenschwärzer',7) --alles vorhanden, Ergbenis: 0
--select dbo.FN_BauteileVorhanden('Aktenschwärzer',8) --Bauteile fehlen, Ergebnis: -1
--select dbo.FN_BauteileVorhanden('Fill-Phil (Aufstocker)',1)	--Bauteile fehlen, Ergebnis: -1
--select dbo.FN_BauteileVorhanden('Sortieren',1)	--falscher Name, Ergebnis: -2
--select dbo.FN_BauteileVorhanden('Disziplinierer',0)	--falsche Anzahl, Ergebnis: -3
--select dbo.FN_BauteileVorhanden('Büro-Bote',-1)	--falsche Anzahl, Ergebnis: -3



--günstigsten Lieferanten für ein Bauteil ermitteln
	-- Parameter:	Bauteilname
	-- Rückgabe:	Lieferantenname, Null falls falscher Name übergeben wurde
if exists (select * from sys.objects where name = 'FN_Lieferantenauswahl' and type = 'FN')
begin
	drop function FN_Lieferantenauswahl
end
go
create function FN_Lieferantenauswahl(@Bauteil varchar(80))
returns varchar(50)
as
begin
	--den Günstigsten Lieferanten ermitteln und zurückgeben
	declare @Lieferant varchar(50) =	(select top 1 LName
										from Lieferanten l join Angebot a on l.LID = a.LID
														   join Bauteile b on a.BID = b.BID
										where BBezeichnung = @Bauteil
										order by APreis)
	return @Lieferant
end
go

--Testfälle:
--select dbo.FN_Lieferantenauswahl('Arm') --Ergebnis: Future Industrys
--select dbo.FN_Lieferantenauswahl('Netzteil') --Ergebnis: Trumpf
--select dbo.FN_Lieferantenauswahl('Moto') --Ergebnis: NULL



/******************************Erstellen der Prozeduren/create procedure******************************/
--Anzeigen, welche Bauteile in einem Roboter verbaut werden
	-- Parameter:	Robotername
	-- Rückgabe:	- 
if exists (select * from sys.objects where name = 'P_RoboterBauteile' and type = 'P')
drop procedure P_RoboterBauteile
go
create procedure P_RoboterBauteile(@RoboterName varchar(80))
as
begin try
	--falsche Eingaben abfangen
	--ungültiger Robotername
	if not exists (select * from Roboter where RBezeichnung = @RoboterName)
		throw 51000, 'Dieser Roboter ist nicht vorhanden', 0
	
	declare
	BauteileCursor cursor
	scroll
	for		select BBezeichnung, RKStückzahl
			from Roboter r join Roboterkomponenten rk on r.RID = rk.RID
						   join Bauteile b on rk.BID = b.BID
			where RBezeichnung = @RoboterName

	declare @bezeichnung varchar(80), @stückzahl int

	--Cursor auslesen
	open BauteileCursor
	fetch first
	from BauteileCursor 
	into @bezeichnung, @stückzahl

	print concat('Im Roboter ', @RoboterName, ' werden folgende Bauteile verbaut:')

	--Baueile aufgelistet ausgeben
	while @@FETCH_STATUS = 0
		begin
			print concat(@stückzahl, 'x ', @bezeichnung)
			fetch next
			from BauteileCursor 
			into @bezeichnung, @stückzahl
		end
	close BauteileCursor
	deallocate BauteileCursor
end try
begin catch
	--Fehler abfangen
	--ungültiger Robotername
	if error_number()=51000
		begin
			print error_message()
			print concat('Der Roboter ', @RoboterName, ' ist nicht vorhanden, bitte überprüfen Sie den Namen!')
		end
	else
		print error_message()
end catch
go

--Testfälle:
--exec P_RoboterBauteile 'Aktenschwärzer' --funktioniert
--exec P_RoboterBauteile 'Büro-Bote' --funktioniert
--exec P_RoboterBauteile 'Disziplin' --funktioniert nicht, falscher Name



--Anzeigender Kontakdaten eines Lieferanten
	-- Parameter:	Lieferantenname
	-- Rückgabe:	- 
if exists (select * from sys.objects where name= 'P_KontakdatenAnzeigen' and type= 'P')
begin
	drop procedure P_KontakdatenAnzeigen
end
go
create procedure P_KontakdatenAnzeigen(@LieferantName varchar(80))
as
begin try
	--falsche Eingaben abfangen
	--ungültiger Lieferantenname
	if not exists (select * from Lieferanten where LName = @LieferantName)
		throw 51000, 'Dieser Lieferant ist nicht vorhanden', 0

	declare
	@Email varchar(50)
	,@TelFest varchar(20)
	,@akadTitel varchar(20)
	,@Vorname varchar(50)
	,@Nachname varchar(50)
	,@Land char(2)
	,@PLZ char(5)
	,@Ort varchar(50)
	,@Straße varchar(50)
	,@HNr varchar(10)

	select @Email = Email, @TelFest = TelFest, @akadTitel = akadTitel, @Vorname = Vorname
				   ,@Nachname = Nachname, @Land = Land, @PLZ = PLZ, @Ort = Ort, @Straße = Straße, @HNr = HNr
			from Lieferanten l join Ansprechpartner a on l.APartnerID = a.APartnerID
							   join Adressen adr on adr.AdrID = l.AdrID
			where LName = @LieferantName

	--Daten aufgelistet ausgeben
	print @LieferantName + ':'
	print concat('Adresse: ', @Straße, ' ', @HNr, ', ', @PLZ, ' ', @Ort, ', ', @Land)
	print concat('Tel.: ', @Telfest)
	print concat('EMail: ', @Email)
	print concat('Ansprechpartner: ', @akadTitel, ' ', @Vorname, ' ', @Nachname)

end try
begin catch
	--Fehler abfangen
	--ungültiger Lieferantenname
	if error_number()=51000
		begin
			print error_message()
			print concat('Der Lieferant ', @Lieferantname, ' ist nicht vorhnaden, bitte überprüfen Sie den Namen!')
		end
	else
		print error_message()
end catch
go

--Testfälle:
--exec P_KontakdatenAnzeigen 'Future Industrys' --funktioniert
--exec P_KontakdatenAnzeigen 'Ben Driesel und Sohn' --funktioniert
--exec P_KontakdatenAnzeigen 'Krup' --funktioniert nicht, falscher Name



--Materialbestellungen eines Monats auflisten
	-- Parameter:	Monatsnummer, Jahreszahl
	-- Rückgabe:	- 
if exists (select * from sys.objects where name= 'P_MaterialbestellungenAnzeigen' and type= 'P')
begin
	drop procedure P_MaterialbestellungenAnzeigen
end
go
create procedure P_MaterialbestellungenAnzeigen(@Monat tinyint, @Jahr int)
as
begin try
	--falsche Eingaben abfangen
	--ungültige Monatsnummer
	if @Monat < 1 or @Monat > 12
		throw 51000, 'Falsche Eingabe', 0
	--Eingaben von Monaten und/oder Jahren in der Zukunft abfangen
	else if (@Jahr = YEAR(GETDATE()) and @Monat > MONTH(GETDATE())) or @Jahr > YEAR(GETDATE())
		throw 51001, 'Falsche Eingabe', 0
	--Bieb.O wurde 10.2017 gegründet, frühere Eingaben abfangen
	else if (@Jahr = 2017 and @Monat < 10) or @Jahr < 2017
		throw 51002, 'Falsche Eingabe', 0
				
	declare 
	BestellungCursor cursor
	scroll
	for		select Bestelldatum, BBezeichnung, WStückzahl, LName, APreis
			from Warenkorb w join Einkaeufe e on w.EID = e.EID
							 join Angebot a on w.AID = a.AID
							 join Bauteile b on b.BID = a.BID
							 join Lieferanten l on a.LID = l.LID
			where MONTH(Bestelldatum) = @Monat
	
	declare @Bestelldatum date, @BBezeichnung varchar(80), @WStückzahl int, @LName varchar(80), @APreis decimal(7,2)
	
	--Cursor auslesen		
	open BestellungCursor
	fetch first
	from BestellungCursor
	into @Bestelldatum, @BBezeichnung, @WStückzahl, @LName, @APreis

	print concat('In ', @Monat, ' ', @Jahr, ' wurden bestellt:') 

	--Meldung ausgeben dass nichts bestellt wurde, falls nichts im Cursor steht
	if @@FETCH_STATUS != 0
		print 'Es gab in diesem Monat keine Bestellungen'

	--Daten aufgelistet ausgeben
	else
		begin
			while @@FETCH_STATUS = 0
				begin
					print concat(@Bestelldatum, '   ', @WStückzahl, 'x ',@BBezeichnung, ' von '
								, @LName, ' zu ', @APreis, '€ pro Stück')
					fetch next
					from BestellungCursor
					into @Bestelldatum, @BBezeichnung, @WStückzahl, @LName, @APreis
				end
		end
	close BestellungCursor
	deallocate BestellungCursor
end try
begin catch
	--Fehler abfangen
	--ungültige Monatsnummer
	if error_number()=51000
		begin
			print error_message()
			print concat('Der Monat ', @Monat, ' existiert nicht, bitte überprüfen Sie die Eingabe!')
		end
	--Abfrage liegt in der zukunft
	if error_number()=51001
		begin
			print error_message()
			print concat('Der Monat ', @Monat, ' ', @Jahr, ' liegt in der Zukunft, bitte überprüfen Sie die Eingabe!')
		end
	--ungültiges jahr
	else if error_number()=51002
		begin
			print error_message()
			print concat('Der Monat ', @Monat, ' ', @Jahr, ' liegt vor der Gründung von Bieb.O, bitte überprüfen Sie die Eingabe!')
		end
	else
		print error_message()
end catch
go

--Testfälle:
--exec P_MaterialbestellungenAnzeigen 5, 2018 --es gab Bestellungen, funktioniert
--exec P_MaterialbestellungenAnzeigen 1, 2018 --es gab keine Bestellungen, funktioniert
--exec P_MaterialbestellungenAnzeigen 10, 2017 --gültiges Jahr, gültiger Monat, es gab keine Bestellungen
--exec P_MaterialbestellungenAnzeigen 5, 2016 --Fehler: ungültiges Jahr
--exec P_MaterialbestellungenAnzeigen 9, 2017 --Fehler: gültiges Jahr, ungültiger Monat
--exec P_MaterialbestellungenAnzeigen 0, 2018 --Fehler: falscher Monat
--exec P_MaterialbestellungenAnzeigen 13, 2018 --Fehler: falscher Monat
--exec P_MaterialbestellungenAnzeigen 8, 2018 --Fehler: Monat im gegeben Jahr noch nicht erreicht



--alle benötigeten Bauteile für einen Roboter aus dem Lager nehmen
	-- Parameter:	Robotername, Anzahl der Roboter
	-- Rückgabe:	- 
if exists (select * from sys.objects where name= 'P_MaterialReservieren' and type= 'P')
begin
	drop procedure P_MaterialReservieren
end
go
create procedure P_MaterialReservieren(@RoboterName varchar(80), @Anzahl int)
as
begin try
	--Fehler auslösen
	--Roboter nicht vorhanden
	if not exists (select * from Roboter where RBezeichnung = @RoboterName)
		throw 51000, 'Falsche Eingabe', 0
	--Bauteile fehlen
	else if (select dbo.FN_BauteileVorhanden(@RoboterName, @Anzahl)) < 0
		throw 51001, 'Bauteile fehlen', 0

	declare
	BauteileCursor cursor
	scroll
	for		select b.BID, RKStückzahl
			from Roboter r join Roboterkomponenten rk on r.RID = rk.RID
						   join Bauteile b on rk.BID = b.BID
			where RBezeichnung = @RoboterName

	declare @bid int, @rkStück int

	open BauteileCursor
	fetch first 
	from BauteileCursor
	into @bid, @rkStück

	--Cursor auslesen, Stückzahl in Lagerbestand ändern
	while @@FETCH_STATUS = 0
		begin
			update Lagerbestand
			set IstStk -= @rkStück * @Anzahl
			where BID = @bid
			
			fetch next
			from BauteileCursor
			into @bid, @rkStück 
		end

	close BauteileCursor
	deallocate BauteileCursor
end try
begin catch
	--Fehler abfangen
	--Falscher Robotername
	if error_number()=51000
		begin
			print error_message()
			print concat('Der Roboter ', @RoboterName, ' existiert nicht, bitter überprüfen Sie die Eingabe!')
		end
	--Bauteile fehlen
	else if error_number()=51001
		begin
			print error_message()
			print concat('Für den Roboter ', @RoboterName, ' fehlen folgende Bauteile:')

			declare
			FehlteileCursor cursor
			scroll
					--Bauteile ermitteln, die nicht mehr ausreichend vorhanden sind
			for		select BBezeichnung, RKStückzahl, IstStk
					from Roboter r join Roboterkomponenten rk on r.RID = rk.RID
								   join Bauteile b on rk.BID = b.BID
								   join Lagerbestand lb on rk.BID = lb.BID
					where RBezeichnung = @RoboterName and  IstStk < RKStückzahl * @Anzahl

			declare @bezeichnung varchar(80), @stückBenötigt int, @stückVorhanden int

			open FehlteileCursor
			fetch first
			from FehlteileCursor 
			into @bezeichnung, @stückBenötigt, @stückVorhanden

			--Cursor auslesen, Bauteile auflisten
			while @@FETCH_STATUS = 0
				begin
					print concat(@stückBenötigt * @Anzahl - @stückVorhanden , 'x ', @bezeichnung)
					fetch next
					from FehlteileCursor 
					into @bezeichnung, @stückBenötigt, @stückVorhanden
				end
			close FehlteileCursor
			deallocate FehlteileCursor
		end
	else
		print error_message()
end catch
go

--Testfälle:
--exec P_MaterialReservieren 'Kaffeeholer', 1 --Fehler, Roboter existiert nicht
--exec P_MaterialReservieren 'Fill-Phil (Aufstocker)', 1 --Fehler, es fehlt 1x Magazin
--exec P_MaterialReservieren 'Aktenschwärzer', 5 --funktioniert, 2x Meldung Mindestbestand unterschritten



--neue Bauteile aufnehmen
	-- Parameter:	Bauteilname, Verkaufspreis, Mindeststückzahl im Lager
	-- Rückgabe:	- 
if exists (select * from sys.objects where name= 'P_BauteilEinfügen' and type= 'P')
begin
	drop procedure P_BauteilEinfügen
end
go
create procedure P_BauteilEinfügen(@Bauteil varchar(80), @VKPreis decimal(7,2), @MdstStk int)
as
begin try
	--Fehler auslösen
	--Bauteil existiert bereits
	if exists (select * from Bauteile where BBezeichnung = @Bauteil)
		throw 51000, 'Bauteil existiert bereis', 0
	--negativer Verkaufspreis
	else if @VKPreis < 0
		throw 51001, 'Falsche Eingabe', 0
	--negative Mindeststückzahl
	else if @MdstStk < 0
		throw 51002, 'Falsche Eingabe', 0

	--Einfügen für Tabelle Bauteile
	insert into Bauteile (BBezeichnung, VKPreis)
	values (@Bauteil, @VKPreis)

	--Einfügen für Tabelle Lagerbestand
	insert into Lagerbestand (LagerID, BID, MdstStk)
	values (1, (select BID from Bauteile where BBezeichnung = @Bauteil), @MdstStk) 
	--LagerID = 1, da zwar für mehrere Lager vorbereitet, aber noch nicht im Detail implementiert

	print concat('Bauteil ', @Bauteil, ' erfolgreich eingefügt.')
	print concat('VKPreis: ', @VKPreis, '	Mindestbestand: ', @MdstStk)
end try
begin catch
	--Fehler abfangen
		--Bauteil bereits vorhanden
	if error_number()=51000
		begin
			print error_message()
			print concat('Das Bauteil ', @Bauteil, ' existiert bereits!')
		end
	--negativer Verkaufspreis
	else if error_number()=51001
		begin
			print error_message()
			print concat('Der Verkaufspreis ', @VKPreis, '€ ist negativ, bitte überprüfen Sie die Eingabe!')
		end
	--negative Mindeststückzahl
	else if error_number()=51002
		begin
			print error_message()
			print concat('Die Mindeststückzahl ', @MdstStk, ' ist negativ, bitte überprüfen Sie die Eingabe!')
		end
	else
		print error_message()
end catch
go

--Testfälle:
--exec P_BauteilEinfügen 'Stange', 13.99, 23 --funktioniert
--exec P_BauteilEinfügen 'Antenne', -9.99, 12 --funktioniert nicht, negativer Preis
--exec P_BauteilEinfügen 'Kamera3', 19.99, -15 --funktioniert nicht, negative Mindeststückzahl
--exec P_BauteilEinfügen 'Arm', 17.98, 23 --funktioniert nicht, Bauteil ist bereits vorhanden



/********************************Erstellen der Trigger/create trigger*********************************/
--Ausgeben einer Meldung, wenn im Lager die Iststückzahl unter die Sollstückzahl fällt
if exists (select * from sys.triggers where name = 'TR_Stückzahl')
begin
	drop trigger TR_Stückzahl
end
go
create trigger TR_Stückzahl
on lagerbestand
after update
as
begin
	declare 
	@istStk int
	--betreffende Werte aus inserted auslesen
	,@mdstStk int = (select MdstStk from Lagerbestand where BID = (select BID from inserted))
	,@Bauteil varchar(80) = (select BBezeichnung from Bauteile where BID = (select BID from inserted))

	if exists (select * from inserted) and exists (select * from deleted)
		begin
			select @istStk = IstStk
			from inserted

			--falls Stückzahl unter die Mindeststückzahl fällt wird eine Meldung ausgegeben
			if @istStk < @mdstStk --(select MdstStk from Lagerbestand where BID = (select BID from inserted))
				begin
					print concat('Mindestbestand von ', @Bauteil,' unterschritten, bitte nachbestellen!')
					print concat('Mdst: ', @mdstStk)
					print concat('Ist: ', @istStk)
				end
		end
end
go

--Testfälle:
/*
update Lagerbestand
set IstStk = 0
where BID = 13
*/
--Meldung wird ausgegeben

/*
update Lagerbestand
set IstStk = 20
where BID = 13
*/
--keine Meldung wird ausgegeben