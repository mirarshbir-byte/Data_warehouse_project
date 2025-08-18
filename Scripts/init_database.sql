/*
==========================================
Create and replace database 'Datawarehouse'
==========================================

Purpose: 
This script first checks if a database named Datawarehouse already exists. If it does, the script drops the existing database and then creates a new instance of it.

After creating the database, it sets up three schemas:

bronze – for raw/staging data

silver – for cleansed and standardized data

gold – for aggregated, business-ready data

!!WARNING!!
  THIS SCRIPT WILL DROP THE ENTIRE DATABASE 'Datawarehouse' IF IT EXISIT.
  ALL DATA IN THE DATABASE WILL BE PERMANENTLY DELETED, PROCEED WITH CAUTION.
*/




use master;
go


--drop and recreate the database 
if exists (select 1 from sys.databases where name = 'Datawarehouse')
begin
	alter database Datawarehouse set single_user with rollback immediate;
	drop database Datawarehouse;
end;
go


-- create database 'Datawarehouse'
create database Datawarehouse;
go

use Datawarehouse;
go


--create schemas

create schema bronze;
go

create schema silver;
go

create schema gold;
go
