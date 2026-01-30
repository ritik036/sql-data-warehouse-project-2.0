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
