/*
========================================================
create database and schemas 
========================================================
script purpose:
	this script creates a new database named 'datawarehouse'
	after checking if it already exists.
	if database exists, it is dropped and recreated. Additionally, the script sets up three schemas within the database : bronze, silver, gold. 

warning: 
	Running this script will drop the entire 'datawarehouse' database if it exists.
	all data in the database will be permanently deleted. Proceed with caution and ensure you have proper backups before executing this script. 
*/



-- create database DataWareHouse 

use master;

-- drop and recreate the database - datawarehouse
if exists (select 1 from sys.databases where name = 'datawarehouse')
begin 
	alter database datawarehouse set single_user with rollback immediate;
	drop database datawarehouse;
end;
go 

select * from sys.databases


create database DataWareHouse;

use datawarehouse;

create schema bronze;
go
create schema silver;
go
create schema gold;
go
