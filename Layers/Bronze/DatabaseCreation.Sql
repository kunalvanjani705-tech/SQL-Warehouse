/* 
================================================
Create Database and schemas
================================================

Script Purpose: This script create a new database named Datawarehouse
after checking if it already exists
if the database exists, it will drop the database and create a new one

==========================================================================
warning: this script will delete the database if it already exists, so be careful when running it
==========================================================================
*/

use master;
GO


--Drop Database if alreay exists
If DB_ID('DataWarehouse') is not null
BEGIN
    Alter DATABASE DataWarehouse SET SINGLE_USER with ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END
go

create Database DataWarehouse;
Go

Use DataWarehouse;
go

create Schema Bronze;
GO

create Schema Silver;
Go

create Schema Gold;
Go
