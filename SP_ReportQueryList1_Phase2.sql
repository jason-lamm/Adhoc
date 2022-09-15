/*
PHASE 2
SP_ReportQueryList1_Phase2.sql

Backend T-SQL

6/15/2022		Jason Lamm			Initial
6/23/2022		"					Implemented fixes, cleanup

*Gathers data from SP Usage database and inserts into internal SharePoint database for retention
*/



SET QUOTED_IDENTIFIER ON; 
--------------------------TOTAL UNIQUE USERS-------------------------------------------------------------------------
--Part 1

--Cleanup duplicates
Use AST_Internal_UsageHealth
GO
DELETE FROM UsageAndHealth_Statistics_Total_Unique_Users_Weekly WHERE "Date" = 
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GO

PRINT 'Completed removing duplicates from UsageAndHealth_Statistics_Total_Unique_Users_Weekly table'
PRINT ''
PRINT 'Beginning Part 1 Queries'

Use AST_Internal_UsageHealth
GO
INSERT INTO UsageAndHealth_Statistics_Total_Unique_Users_Weekly (Date, ServerUrl, "Total Unique Users")

SELECT CONVERT(DATE,CURRENT_TIMESTAMP), ServerURL, count(distinct UserLogin) as "Total Unique Users"
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://share.cms.gov' and UserLogin not like '%cms\svc-%'  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP) 
)
GROUP BY ServerURL
GO

Use AST_Internal_UsageHealth
GO
INSERT INTO UsageAndHealth_Statistics_Total_Unique_Users_Weekly (Date, ServerUrl, "Total Unique Users")

SELECT CONVERT(DATE,CURRENT_TIMESTAMP), ServerURL, count(distinct UserLogin) as "Total Unique Users"
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://cmsintranet.share.cms.gov' and UserLogin not like '%cms\svc-%'  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY ServerURL
GO

Use AST_Internal_UsageHealth
GO
INSERT INTO UsageAndHealth_Statistics_Total_Unique_Users_Weekly (Date, ServerUrl, "Total Unique Users")

SELECT CONVERT(DATE,CURRENT_TIMESTAMP), ServerURL, count(distinct UserLogin) as "Total Unique Users"
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://capms.cms.gov' and UserLogin not like '%cms\svc-%'  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY ServerURL
GO
--SELECT * FROM UsageAndHealth_Statistics_Total_Unique_Users_Weekly
--Takes 3:45 to complete query
--Verified insert process
--Verified duplicate cleanup process
--Verified each query for results
---------------------------------------------------------------------------------------------------------------------





--------------------------DAILY UNIQUE USERS-------------------------------------------------------------------------
--Part 2

Use Internal_SharePoint
GO
DELETE FROM UsageAndHealth_Statistics_Daily_Unique_Users WHERE "Date Collected" = 
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GO

PRINT 'Completed removing duplicates from UsageAndHealth_Statistics_Daily_Unique_Users table'
PRINT ''
PRINT 'Beginning Part 2 Queries'

INSERT INTO UsageAndHealth_Statistics_Daily_Unique_Users ("Date Collected", ServerURL, Day, "Day of Week", "Unique Users")

SELECT CONVERT(DATE,CURRENT_TIMESTAMP) AS "Date Collected", ServerURL, FORMAT(logtime, 'MM-dd') AS 'Day', DATENAME(WEEKDAY,logtime) AS 'Day of Week', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://share.cms.gov' and UserLogin not like '%cms\svc-%' and siteurl != '/' and siteurl != ''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(LogTime, 'MM-dd'), DATENAME(WEEKDAY,logtime), ServerURL
ORDER BY FORMAT(logtime,'MM-dd')
GO

--TRUNCATE TABLE UsageAndHealth_Statistics_Daily_Unique_Users
--SELECT * FROM UsageAndHealth_Statistics_Daily_Unique_Users
Use Internal_SharePoint
GO
INSERT INTO UsageAndHealth_Statistics_Daily_Unique_Users ("Date Collected", ServerURL, Day, "Day of Week", "Unique Users")

SELECT CONVERT(DATE,CURRENT_TIMESTAMP), ServerURL, FORMAT(logtime,'MM-dd') AS 'Day', DATENAME(WEEKDAY,logtime) AS 'Day of Week', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://cmsintranet.share.cms.gov' and UserLogin not like '%cms\svc-%' /*and siteurl != '/' and siteurl != ''*/  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,'MM-dd'), DATENAME(WEEKDAY,logtime), ServerURL
ORDER BY FORMAT(logtime,'MM-dd')
GO

--SELECT ServerURL, UserLogin, siteurl FROM [SP_UsageAndHealth].[dbo].[RequestUsage] WHERE ServerURL = 'https://cmsintranet.share.cms.gov' and UserLogin not like '%cms\svc-%' and siteurl != '/' and siteurl != ''  

Use Internal_SharePoint
GO
INSERT INTO UsageAndHealth_Statistics_Daily_Unique_Users ("Date Collected", ServerURL, Day, "Day of Week", "Unique Users")

SELECT CONVERT(DATE,CURRENT_TIMESTAMP), ServerURL, FORMAT(logtime,'MM-dd') AS 'Day', DATENAME(WEEKDAY,logtime) AS 'Day of Week', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://capms.cms.gov' and UserLogin not like '%cms\svc-%' and siteurl != '/' and siteurl != ''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,'MM-dd'), DATENAME(WEEKDAY,logtime), ServerURL
ORDER BY FORMAT(logtime,'MM-dd')
GO

--SELECT * FROM UsageAndHealth_Statistics_Daily_Unique_Users
--TRUNCATE TABLE UsageAndHealth_Statistics_Daily_Unique_Users
--Takes 00:59 to complete query.
--Days with 0 results do not return a line
---------------------------------------------------------------------------------------------------------------------





----------------------------Peak Usage Date/Time--------------------------------------------------------------------
--Part 3
Use Internal_SharePoint
GO
DELETE FROM UsageAndHealth_Statistics_PeakUsage_DateTime WHERE "Date Collected" = 
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GO

PRINT 'Finished removing duplicates from UsageAndHealth_Statistics_PeakUsage_DateTime table'
PRINT ''
PRINT 'Beginning Part 3 Queries'

Use Internal_SharePoint
GO
INSERT INTO UsageAndHealth_Statistics_PeakUsage_DateTime ("Date Collected", "ServerUrl", Day, "UniqueUsers")

SELECT TOP 1 CONVERT(DATE,CURRENT_TIMESTAMP) AS "Date Collected", ServerUrl, FORMAT(logtime,'MM-dd hh tt') AS 'Day', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://share.cms.gov' and UserLogin not like '%cms\svc-%' and siteurl != '/' and siteurl != ''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,'MM-dd hh tt'), ServerUrl
ORDER BY UniqueUsers DESC
GO

Use Internal_SharePoint
GO
INSERT INTO UsageAndHealth_Statistics_PeakUsage_DateTime ("Date Collected", "ServerUrl", Day, "UniqueUsers")

SELECT TOP 1 CONVERT(DATE,CURRENT_TIMESTAMP) AS "Date Collected", ServerUrl, FORMAT(logtime,'MM-dd hh tt') AS 'Day', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://cmsintranet.share.cms.gov' and UserLogin not like '%cms\svc-%' /*and siteurl != '/' and siteurl != '' */ and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,'MM-dd hh tt'), ServerUrl
ORDER BY UniqueUsers DESC
GO

Use Internal_SharePoint
GO
INSERT INTO UsageAndHealth_Statistics_PeakUsage_DateTime ("Date Collected", "ServerUrl", Day, "UniqueUsers")

SELECT TOP 1 CONVERT(DATE,CURRENT_TIMESTAMP) AS "Date Collected", ServerUrl, FORMAT(logtime,'MM-dd hh tt') AS 'Day', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://capms.cms.gov' and UserLogin not like '%cms\svc-%' and siteurl != '/' and siteurl != ''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,'MM-dd hh tt'), ServerUrl
ORDER BY UniqueUsers DESC
GO

/*
SELECT * FROM UsageAndHealth_Statistics_PeakUsage_DateTime
Takes 1:00 to complete query.
*/

----------------------------------------------------------------------------------------------------------------------





--------------------------------Top Five Site URL----------------------------------------------------------------------
--Part 4
Use Internal_SharePoint
GO
DELETE FROM UsageAndHealth_Statistics_Top_Five_Site_URL WHERE "Date Collected" = 
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GO

PRINT 'Completed removing duplicates from UsageAndHealth_Statistics_Top_Five_Site_URL table'
PRINT ''
PRINT 'Beginning Part 4 Queries'

Use Internal_SharePoint
GO
INSERT INTO UsageAndHealth_Statistics_Top_Five_Site_URL ("Date Collected", WebapplicationUrl, SiteCollectionUrl, WebSiteURL, Users)

SELECT TOP 5 CONVERT(DATE,CURRENT_TIMESTAMP) AS "Date Collected", LOWER(ServerUrl) as WebapplicationUrl, LOWER(SiteUrl) as SiteCollectionURL, LOWER(WebUrl) as WebSiteURL, count(distinct UserLogin) as Users
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://share.cms.gov' and UserLogin not like '%cms\svc-%' and WebUrl != ''  and WebUrl != '/'  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY ServerUrl,SiteUrl,WebUrl
ORDER BY Users desc
GO

Use Internal_SharePoint
GO
INSERT INTO UsageAndHealth_Statistics_Top_Five_Site_URL ("Date Collected", WebapplicationUrl, SiteCollectionUrl, WebSiteURL, Users)

SELECT TOP 5 CONVERT(DATE,CURRENT_TIMESTAMP) AS "Date Collected", LOWER(ServerUrl) as WebapplicationUrl, LOWER(SiteUrl) as SiteCollectionURL, LOWER(WebUrl) as WebSiteURL, count(distinct UserLogin) as Users
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://cmsintranet.share.cms.gov' and UserLogin not like '%cms\svc-%' and WebUrl != ''  and WebUrl != '/'  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY ServerUrl,SiteUrl,WebUrl
ORDER BY Users desc
GO

Use Internal_SharePoint
GO
INSERT INTO UsageAndHealth_Statistics_Top_Five_Site_URL ("Date Collected", WebapplicationUrl, SiteCollectionUrl, WebSiteURL, Users)

SELECT TOP 5 CONVERT(DATE,CURRENT_TIMESTAMP) AS "Date Collected", LOWER(ServerUrl) as WebapplicationUrl, LOWER(SiteUrl) as SiteCollectionURL, LOWER(WebUrl) as WebSiteURL, count(distinct UserLogin) as Users
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://capms.cms.gov' and UserLogin not like '%cms\svc-%' and WebUrl != ''  and WebUrl != '/'  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY ServerUrl,SiteUrl,WebUrl
ORDER BY Users desc
GO


PRINT 'COMPLETED'
/*
Query takes 00:24 to complete
SELECT * FROM UsageAndHealth_Statistics_Total_Unique_Users_Weekly
SELECT * FROM UsageAndHealth_Statistics_Daily_Unique_Users
SELECT * FROM UsageAndHealth_Statistics_PeakUsage_DateTime
SELECT * FROM UsageAndHealth_Statistics_Top_Five_Site_URL

*/
--------------------------------------------------------------------------------------------


