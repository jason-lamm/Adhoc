Use Internal_SharePoint
GO
Create Table UsageAndHealth_Statistics_Total_Unique_Users
(

share varchar(max), 
cmsintranet varchar(max), 
capms varchar(max) 

)



Use Internal_SharePoint
GO
Create Table UsageAndHealth_Statistics_Daily_Unique_Users
(

ServerUrl varchar(max),
Day varchar(max),
"Day of Week" varchar(max),
"Unique Users" varchar(max)

)
--DROP Table UsageAndHealth_Statistics_Daily_Unique_Users



Use Internal_SharePoint
GO
Create Table UsageAndHealth_Statistics_TopDay_Unique_Users
(

Day varchar(max),
UniqueUsers varchar(max)

)



SELECT TOP 1 FORMAT(logtime,'MM-dd hh tt') AS 'Day', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] 
WHERE ServerUrl = 'https://share.cms.gov' and UserLogin not like '%cms\svc-%' and siteurl != '/' and siteurl != ''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,'MM-dd hh tt')
ORDER BY UniqueUsers DESC
