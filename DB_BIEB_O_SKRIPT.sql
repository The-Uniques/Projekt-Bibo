
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
--Erstellen der Tabelle bauteile
if exists (select * from sys.objects where name = 'bauteile')
drop table bauteile
go
create table bauteile
(

)
go

--Erstellen der Tabelle roboterkomponenten
if exists (select * from sys.objects where name = 'roboterkomponenten')
drop table roboterkomponenten
go
create table roboterkomponenten
(

)
go

--Erstellen der Tabelle roboter
if exists (select * from sys.objects where name = 'roboter')
drop table roboter
go
create table roboter
(

)
go

--Erstellen der Tabelle lieferanten
if exists (select * from sys.objects where name = 'lieferanten')
drop table lieferanten
go
create table lieferanten
(

)
go

--Erstellen der Tabelle ansprechpartner
if exists (select * from sys.objects where name = 'ansprechpartner')
drop table ansprechpartner
go
create table ansprechpartner
(

)
go

--Erstellen der Tabelle adressen
if exists (select * from sys.objects where name = 'adressen')
drop table adressen
go
create table adressen
(

)
go

--Erstellen der Tabelle angebot
if exists (select * from sys.objects where name = 'angebot')
drop table angebot
go
create table angebot
(
	AID				int				not null	identity(1,1)
,	Angebotspreis	decimal(7,2)	not null		
)
go

--Erstellen der Tabelle warenkorb
if exists (select * from sys.objects where name = 'warenkorb')
drop table warenkorb
go
create table warenkorb
(
	Pos			tinyint		not null
,	Stückzahl	int			not null
)
go

--Erstellen der Tabelle einkaeufe
if exists (select * from sys.objects where name = 'einkaeufe')
drop table einkaeufe
go
create table einkaeufe
(
	EID				int		not null	identity(1000,1)
,	Bestelldatum	date	not null
)
go

--Erstellen der Tabelle lager
if exists (select * from sys.objects where name = 'lager')
drop table lager
go
create table lager
(

)
go
