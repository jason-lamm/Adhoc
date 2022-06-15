/*
SharePoint_CreateStatisticsDB.sql

Create tables to hold SP statistics

6/15/2022		Jason Lamm			Initial
*/

--------------------------TOTAL UNIQUE USERS-------------------------------------------------------------------------
--Part 1
Use Internal_SharePoint
GO
Create Table UsageAndHealth_Statistics_Total_Unique_Users_Weekly (

ID INT IDENTITY(1,1),
Date date,
ServerUrl varchar(max),
"Total Unique Users" varchar(max)
)


--------------------------DAILY UNIQUE USERS-------------------------------------------------------------------------
--Part 2
Use Internal_SharePoint
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
Use Internal_SharePoint
GO
Create Table UsageAndHealth_Statistics_PeakUsage_DateTime (

ID INT IDENTITY(1,1),
ServerUrl varchar(max),
Day varchar(max),
UniqueUsers varchar(max)
)



--------------------------------Top Five Site URL----------------------------------------------------------------------
--Part 4
Use Internal_SharePoint
GO
Create Table UsageAndHealth_Statistics_Top_Five_Site_URL (

ID INT IDENTITY(1,1),
Date date,
WebapplicationUrl varchar(max),
SiteCollectionUrl varchar(max),
WebSiteURL varchar(max),
Users varchar(max)
)

/*
TABLE CLEANUP

DROP TABLE UsageAndHealth_Statistics_Total_Unique_Users_Weekly
DROP TABLE UsageAndHealth_Statistics_Daily_Unique_Users
DROP TABLE UsageAndHealth_Statistics_PeakUsage_DateTime
DROP TABLE UsageAndHealth_Statistics_Top_Five_Site_URL
*/


