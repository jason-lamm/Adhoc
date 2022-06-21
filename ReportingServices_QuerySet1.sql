/*
PHASE 3
ReportingServices_QuerySet1.sql

Backend T-SQL

6/21/2022		Jason Lamm			Initial
*/


--------------------------TOTAL UNIQUE USERS-------------------------------------------------------------------------
--Part 1
---share.cms.gov 
---ORIGINAL
SELECT count(distinct UserLogin) as "Total Unique Users"
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://share.cms.gov' and UserLogin not like '%cms\svc-%'  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)

---NEW
SELECT "Total Unique Users"
FROM UsageAndHealth_Statistics_Total_Unique_Users_Weekly with(nolock)
WHERE ServerUrl = 'https://share.cms.gov' and Date =
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)


---------------------------------------------------------------------------------------------
---ORIGINAL
SELECT count(distinct UserLogin) as "Total Unique Users"
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://cmsintranet.share.cms.gov' and UserLogin not like '%cms\svc-%'  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)

---NEW
SELECT "Total Unique Users"
FROM UsageAndHealth_Statistics_Total_Unique_Users_Weekly with(nolock)
WHERE ServerUrl = 'https://cmsintranet.share.cms.gov' and Date =
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
---------------------------------------------------------------------------------------------
---ORIGINAL
SELECT count(distinct UserLogin) as "Total Unique Users"
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://capms.cms.gov' and UserLogin not like '%cms\svc-%'  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)

---NEW
SELECT "Total Unique Users"
FROM UsageAndHealth_Statistics_Total_Unique_Users_Weekly with(nolock)
WHERE ServerUrl = 'https://capms.cms.gov' and Date =
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)

/*
TRUNCATE TABLE UsageAndHealth_Statistics_Total_Unique_Users_Weekly
SELECT * FROM UsageAndHealth_Statistics_Total_Unique_Users_Weekly

*/
---------------------------------------------------------------------------------------------





--------------------------DAILY UNIQUE USERS-------------------------------------------------------------------------
--Part 2
SELECT FORMAT(logtime,'MM-dd') AS 'Day', DATENAME(WEEKDAY,logtime) AS 'Day of Week', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] 
WHERE ServerUrl = 'https://share.cms.gov' and UserLogin not like '%cms\svc-%' and siteurl != '/' and siteurl != ''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,'MM-dd'), DATENAME(WEEKDAY,logtime)
ORDER BY FORMAT(logtime,'MM-dd')

---------------------------------------------------------------------------------------------

SELECT FORMAT(logtime,'MM-dd') AS 'Day', DATENAME(WEEKDAY,logtime) AS 'Day of Week', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] 
WHERE ServerUrl = 'https://cmsintranet.share.cms.gov' and UserLogin not like '%cms\svc-%' and siteurl != '/' and siteurl != ''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,'MM-dd'), DATENAME(WEEKDAY,logtime)
ORDER BY FORMAT(logtime,'MM-dd')

---------------------------------------------------------------------------------------------

SELECT FORMAT(logtime,'MM-dd') AS 'Day', DATENAME(WEEKDAY,logtime) AS 'Day of Week', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] 
WHERE ServerUrl = 'https://capms.cms.gov' and UserLogin not like '%cms\svc-%' and siteurl != '/' and siteurl != ''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,'MM-dd'), DATENAME(WEEKDAY,logtime)
ORDER BY FORMAT(logtime,'MM-dd')

---------------------------------------------------------------------------------------------






----------------------------Peak Usage Date/Time--------------------------------------------------------------------
--Part 3

SELECT TOP 1 FORMAT(logtime,'MM-dd hh tt') AS 'Day', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] 
WHERE ServerUrl = 'https://share.cms.gov' and UserLogin not like '%cms\svc-%' and siteurl != '/' and siteurl != ''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,'MM-dd hh tt')
ORDER BY UniqueUsers DESC

---------------------------------------------------------------------------------------------

SELECT TOP 1 FORMAT(logtime,'MM-dd hh tt') AS 'Day', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] 
WHERE ServerUrl = 'https://cmsintranet.share.cms.gov' and UserLogin not like '%cms\svc-%' and siteurl != '/' and siteurl != ''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,'MM-dd hh tt')
ORDER BY UniqueUsers DESC

---------------------------------------------------------------------------------------------

SELECT TOP 1 FORMAT(logtime,'MM-dd hh tt') AS 'Day', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] 
WHERE ServerUrl = 'https://capms.cms.gov' and UserLogin not like '%cms\svc-%' and siteurl != '/' and siteurl != ''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,'MM-dd hh tt')
ORDER BY UniqueUsers DESC

---------------------------------------------------------------------------------------------




--------------------------------Top Five Site URL----------------------------------------------------------------------
--Part 4

SELECT TOP 5 LOWER(ServerUrl) as WebapplicationUrl, LOWER(SiteUrl) as SiteCollectionURL, LOWER(WebUrl) as WebSiteURL, count(distinct UserLogin) as Users
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://share.cms.gov' and UserLogin not like '%cms\svc-%' and WebUrl != ''  and WebUrl != '/'  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY ServerUrl,SiteUrl,WebUrl
ORDER BY Users desc

---------------------------------------------------------------------------------------------

SELECT TOP 5 LOWER(ServerUrl) as WebapplicationUrl, LOWER(SiteUrl) as SiteCollectionURL, LOWER(WebUrl) as WebSiteURL, count(distinct UserLogin) as Users
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://cmsintranet.share.cms.gov' and UserLogin not like '%cms\svc-%' and WebUrl != ''  and WebUrl != '/'  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY ServerUrl,SiteUrl,WebUrl
ORDER BY Users desc

---------------------------------------------------------------------------------------------

SELECT TOP 5 LOWER(ServerUrl) as WebapplicationUrl, LOWER(SiteUrl) as SiteCollectionURL, LOWER(WebUrl) as WebSiteURL, count(distinct UserLogin) as Users
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://capms.cms.gov' and UserLogin not like '%cms\svc-%' and WebUrl != ''  and WebUrl != '/'  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY ServerUrl,SiteUrl,WebUrl
ORDER BY Users desc


