/*
PHASE 1
SP_CreateStatisticsDB_Phase1.sql

Create tables to hold SP statistics

6/15/2022		Jason Lamm			Initial
6/23/2022   "               Implemented fixes
9/15/2022   "               Renamed database


**Creates database, tables to hold data.
*/
-----Create Database
CREATE DATABASE AST_Internal_UsageHealth
GO
--------------------------TOTAL UNIQUE USERS-------------------------------------------------------------------------
--Part 1
Use AST_Internal_UsageHealth
GO
Create Table UsageAndHealth_Statistics_Total_Unique_Users_Weekly (

ID INT IDENTITY(1,1),
Date date,
ServerUrl varchar(max),
"Total Unique Users" varchar(max)
)


--------------------------DAILY UNIQUE USERS-------------------------------------------------------------------------
--Part 2
Use AST_Internal_UsageHealth
GO
Create Table UsageAndHealth_Statistics_Daily_Unique_Users (

ID INT IDENTITY(1,1),
"Date Collected" date,
ServerUrl varchar(max),
"Day" varchar(max),
"Day of Week" varchar(max),
"Unique Users" varchar(max)
)


----------------------------Peak Usage Date/Time--------------------------------------------------------------------
--Part 3
Use AST_Internal_UsageHealth
GO
Create Table UsageAndHealth_Statistics_PeakUsage_DateTime (

ID INT IDENTITY(1,1),
"Date Collected" date,
ServerUrl varchar(max),
Day varchar(max),
UniqueUsers varchar(max)
)



--------------------------------Top Five Site URL----------------------------------------------------------------------
--Part 4
Use AST_Internal_UsageHealth
GO
Create Table UsageAndHealth_Statistics_Top_Five_Site_URL (

ID INT IDENTITY(1,1),
"Date Collected" date,
WebapplicationUrl varchar(max),
SiteCollectionUrl varchar(max),
WebSiteURL varchar(max),
Users varchar(max)
)

/*
TABLE CLEANUP
Use AST_Internal_UsageHealth
DROP TABLE UsageAndHealth_Statistics_Total_Unique_Users_Weekly
DROP TABLE UsageAndHealth_Statistics_Daily_Unique_Users
DROP TABLE UsageAndHealth_Statistics_PeakUsage_DateTime
DROP TABLE UsageAndHealth_Statistics_Top_Five_Site_URL

DROP DATABASE Internal_SharePoint
*/


