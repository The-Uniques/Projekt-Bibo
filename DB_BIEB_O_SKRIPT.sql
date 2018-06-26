
--Erstellungsskript für die Datenbank WG
--erstellt am: 21.06.2018
--erstellt von: Markus Weißflog

/********************Erstellen der Datenbank******************************/
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



/****************Erstellen der Tabellen***************************/
use BIEB_O
go
--Erstellen der Tabelle Bauteile
if exists (select * from sys.objects where name = 'Bauteile')
drop table Bauteile
go
create table Bauteile
(
	BID				int				not null	identity(1,1)
,	Bezeichnung		varchar(80)		not null	
)
go

--Erstellen der Tabelle Roboterkomponenten
if exists (select * from sys.objects where name = 'Roboterkomponenten')
drop table Roboterkomponenten
go
create table Roboterkomponenten
(
	Stückzahl	int		not null
)
go

--Erstellen der Tabelle Roboter
if exists (select * from sys.objects where name = 'Roboter')
drop table Roboter
go
create table Roboter
(
	RID				int				not null	identity(1,1)
,	Bezeichnung		varchar(80)		not null	
,	MatKosten		decimal(7,2)	null	
,	ProdKosten		decimal(7,2)	not null	
)
go

--Erstellen der Tabelle Lieferanten
if exists (select * from sys.objects where name = 'Lieferanten')
drop table Lieferanten
go
create table Lieferanten
(
	LID			int				not null	identity(1,1)
,	LName		varchar(80)		not null	
,	Email		varchar(50)		not null	
,	TelFest		varchar(20)		not null	
)
go

--Erstellen der Tabelle Ansprechpartner
if exists (select * from sys.objects where name = 'Ansprechpartner')
drop table Ansprechpartner
go
create table Ansprechpartner
(
	APartnerID	int 			not null	identity(1,1)
,	akadTitel	varchar(20)		null	
,	Vorname		varchar(50)		not null	
,	Nachname	varchar(50)		not null	
)
go

--Erstellen der Tabelle Adressen
if exists (select * from sys.objects where name = 'Adressen')
drop table Adressen
go
create table Adressen
(
	AdrID	int				not null	identity(1,1)
,	Land	char(2)			not null	
,	PLZ		char(5)			not null	
,	Straße	varchar(50)		not null	
,	HNr		varchar(10)		not null	
)
go

--Erstellen der Tabelle Angebot
if exists (select * from sys.objects where name = 'Angebot')
drop table Angebot
go
create table Angebot
(
	AID				int		not null	identity(1,1)
,	APreis	decimal(7,2)	not null		
)
go

--Erstellen der Tabelle Warenkorb
if exists (select * from sys.objects where name = 'Warenkorb')
drop table Warenkorb
go
create table Warenkorb
(
	Pos			tinyint		not null	identity(1,1)
,	Stückzahl	int			not null
)
go

--Erstellen der Tabelle Einkaeufe
if exists (select * from sys.objects where name = 'Einkaeufe')
drop table Einkaeufe
go
create table Einkaeufe
(
	EID				int		not null	identity(1,1)
,	Bestelldatum	date	not null
)
go

--Erstellen der Tabelle Lager
if exists (select * from sys.objects where name = 'Lager')
drop table Lager
go
create table Lager
(
	LagerID		int		not null	identity(1,1)
,	IstStk		int		not null	
,	MdstStk		int		not null	
)
go