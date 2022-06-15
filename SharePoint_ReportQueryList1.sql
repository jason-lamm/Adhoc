/*
SharePoint_ReportQueryList1.sql

Backend T-SQL

6/15/2022		Jason Lamm			Initial
*/

--------------------------TOTAL UNIQUE USERS-------------------------------------------------------------------------
--Part 1
Use Internal_SharePoint
GO
INSERT INTO UsageAndHealth_Statistics_Total_Unique_Users_Weekly (ServerUrl, "Total Unique Users")

SELECT ServerURL, count(distinct UserLogin) as "Total Unique Users"
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://share.cms.gov' and UserLogin not like '%cms\svc-%'  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY ServerURL

/*
--ORIGINAL for above
SELECT count(distinct UserLogin) as "Total Unique Users"
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://share.cms.gov' and UserLogin not like '%cms\svc-%'  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
*/
Use Internal_SharePoint
GO
SELECT count(distinct UserLogin) as "Total Unique Users"
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://cmsintranet.share.cms.gov' and UserLogin not like '%cms\svc-%'  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)

Use Internal_SharePoint
GO
SELECT count(distinct UserLogin) as "Total Unique Users"
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://capms.cms.gov' and UserLogin not like '%cms\svc-%'  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)

---------------------------------------------------------------------------------------------------------------------





--------------------------DAILY UNIQUE USERS-------------------------------------------------------------------------
--Part 2
Use Internal_SharePoint
GO
SELECT FORMAT(logtime,'MM-dd') AS 'Day', DATENAME(WEEKDAY,logtime) AS 'Day of Week', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] 
WHERE ServerUrl = 'https://share.cms.gov' and UserLogin not like '%cms\svc-%' and siteurl != '/' and siteurl != ''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,'MM-dd'), DATENAME(WEEKDAY,logtime)
ORDER BY FORMAT(logtime,'MM-dd')


Use Internal_SharePoint
GO
SELECT FORMAT(logtime,'MM-dd') AS 'Day', DATENAME(WEEKDAY,logtime) AS 'Day of Week', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] 
WHERE ServerUrl = 'https://cmsintranet.share.cms.gov' and UserLogin not like '%cms\svc-%' and siteurl != '/' and siteurl != ''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,'MM-dd'), DATENAME(WEEKDAY,logtime)
ORDER BY FORMAT(logtime,'MM-dd')


Use Internal_SharePoint
GO
SELECT FORMAT(logtime,'MM-dd') AS 'Day', DATENAME(WEEKDAY,logtime) AS 'Day of Week', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] 
WHERE ServerUrl = 'https://capms.cms.gov' and UserLogin not like '%cms\svc-%' and siteurl != '/' and siteurl != ''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,'MM-dd'), DATENAME(WEEKDAY,logtime)
ORDER BY FORMAT(logtime,'MM-dd')


---------------------------------------------------------------------------------------------------------------------





----------------------------Peak Usage Date/Time--------------------------------------------------------------------
--Part 3
Use Internal_SharePoint
GO
SELECT TOP 1 FORMAT(logtime,'MM-dd hh tt') AS 'Day', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] 
WHERE ServerUrl = 'https://share.cms.gov' and UserLogin not like '%cms\svc-%' and siteurl != '/' and siteurl != ''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,'MM-dd hh tt')
ORDER BY UniqueUsers DESC


Use Internal_SharePoint
GO
SELECT TOP 1 FORMAT(logtime,'MM-dd hh tt') AS 'Day', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] 
WHERE ServerUrl = 'https://cmsintranet.share.cms.gov' and UserLogin not like '%cms\svc-%' and siteurl != '/' and siteurl != ''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,'MM-dd hh tt')
ORDER BY UniqueUsers DESC


Use Internal_SharePoint
GO
SELECT TOP 1 FORMAT(logtime,'MM-dd hh tt') AS 'Day', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] 
WHERE ServerUrl = 'https://capms.cms.gov' and UserLogin not like '%cms\svc-%' and siteurl != '/' and siteurl != ''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,'MM-dd hh tt')
ORDER BY UniqueUsers DESC


----------------------------------------------------------------------------------------------------------------------





--------------------------------Top Five Site URL----------------------------------------------------------------------
--Part 4
Use Internal_SharePoint
GO
SELECT TOP 5 LOWER(ServerUrl) as WebapplicationUrl, LOWER(SiteUrl) as SiteCollectionURL, LOWER(WebUrl) as WebSiteURL, count(distinct UserLogin) as Users
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://share.cms.gov' and UserLogin not like '%cms\svc-%' and WebUrl != ''  and WebUrl != '/'  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY ServerUrl,SiteUrl,WebUrl
ORDER BY Users desc


Use Internal_SharePoint
GO
SELECT TOP 5 LOWER(ServerUrl) as WebapplicationUrl, LOWER(SiteUrl) as SiteCollectionURL, LOWER(WebUrl) as WebSiteURL, count(distinct UserLogin) as Users
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://cmsintranet.share.cms.gov' and UserLogin not like '%cms\svc-%' and WebUrl != ''  and WebUrl != '/'  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY ServerUrl,SiteUrl,WebUrl
ORDER BY Users desc


Use Internal_SharePoint
GO
SELECT TOP 5 LOWER(ServerUrl) as WebapplicationUrl, LOWER(SiteUrl) as SiteCollectionURL, LOWER(WebUrl) as WebSiteURL, count(distinct UserLogin) as Users
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = 'https://capms.cms.gov' and UserLogin not like '%cms\svc-%' and WebUrl != ''  and WebUrl != '/'  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY ServerUrl,SiteUrl,WebUrl
ORDER BY Users desc

