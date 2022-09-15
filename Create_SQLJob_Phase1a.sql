/*
Phase 1a

Create_SQLJob_Phase1a.sql

This script creates the SQL Agent Job and schedule.

Steps:
1. Run this query.
2. Open Agent Job in SSMS then change the step to query in Phase 2.



*/




USE [msdb]
GO

/****** Object:  Job [ADMIN - ADHOC - SP STATISTICS GATHERING]    Script Date: 9/15/2022 2:11:27 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Data Collector]    Script Date: 9/15/2022 2:11:27 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Data Collector' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Data Collector'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'ADMIN - ADHOC - SP STATISTICS GATHERING', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Series of queries that collect data from SP Usage database and inserts results into Internal SharePoint database.', 
		@category_name=N'Data Collector', 
		@owner_login_name=N'dbsa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Query Set 1]    Script Date: 9/15/2022 2:11:27 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Query Set 1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=2, 
		@retry_interval=10, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'/*
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
Use Internal_SharePoint
GO
DELETE FROM UsageAndHealth_Statistics_Total_Unique_Users_Weekly WHERE "Date" = 
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GO

PRINT ''Completed removing duplicates from UsageAndHealth_Statistics_Total_Unique_Users_Weekly table''
PRINT ''''
PRINT ''Beginning Part 1 Queries''

Use Internal_SharePoint
GO
INSERT INTO UsageAndHealth_Statistics_Total_Unique_Users_Weekly (Date, ServerUrl, "Total Unique Users")

SELECT CONVERT(DATE,CURRENT_TIMESTAMP), ServerURL, count(distinct UserLogin) as "Total Unique Users"
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = ''https://share.cms.gov'' and UserLogin not like ''%cms\svc-%''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP) 
)
GROUP BY ServerURL
GO

Use Internal_SharePoint
GO
INSERT INTO UsageAndHealth_Statistics_Total_Unique_Users_Weekly (Date, ServerUrl, "Total Unique Users")

SELECT CONVERT(DATE,CURRENT_TIMESTAMP), ServerURL, count(distinct UserLogin) as "Total Unique Users"
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = ''https://cmsintranet.share.cms.gov'' and UserLogin not like ''%cms\svc-%''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY ServerURL
GO

Use Internal_SharePoint
GO
INSERT INTO UsageAndHealth_Statistics_Total_Unique_Users_Weekly (Date, ServerUrl, "Total Unique Users")

SELECT CONVERT(DATE,CURRENT_TIMESTAMP), ServerURL, count(distinct UserLogin) as "Total Unique Users"
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = ''https://capms.cms.gov'' and UserLogin not like ''%cms\svc-%''  and LogTime <
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

PRINT ''Completed removing duplicates from UsageAndHealth_Statistics_Daily_Unique_Users table''
PRINT ''''
PRINT ''Beginning Part 2 Queries''

INSERT INTO UsageAndHealth_Statistics_Daily_Unique_Users ("Date Collected", ServerURL, Day, "Day of Week", "Unique Users")

SELECT CONVERT(DATE,CURRENT_TIMESTAMP) AS "Date Collected", ServerURL, FORMAT(logtime, ''MM-dd'') AS ''Day'', DATENAME(WEEKDAY,logtime) AS ''Day of Week'', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = ''https://share.cms.gov'' and UserLogin not like ''%cms\svc-%'' and siteurl != ''/'' and siteurl != ''''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(LogTime, ''MM-dd''), DATENAME(WEEKDAY,logtime), ServerURL
ORDER BY FORMAT(logtime,''MM-dd'')
GO

--TRUNCATE TABLE UsageAndHealth_Statistics_Daily_Unique_Users
--SELECT * FROM UsageAndHealth_Statistics_Daily_Unique_Users
Use Internal_SharePoint
GO
INSERT INTO UsageAndHealth_Statistics_Daily_Unique_Users ("Date Collected", ServerURL, Day, "Day of Week", "Unique Users")

SELECT CONVERT(DATE,CURRENT_TIMESTAMP), ServerURL, FORMAT(logtime,''MM-dd'') AS ''Day'', DATENAME(WEEKDAY,logtime) AS ''Day of Week'', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = ''https://cmsintranet.share.cms.gov'' and UserLogin not like ''%cms\svc-%'' /*and siteurl != ''/'' and siteurl != ''''*/  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,''MM-dd''), DATENAME(WEEKDAY,logtime), ServerURL
ORDER BY FORMAT(logtime,''MM-dd'')
GO

--SELECT ServerURL, UserLogin, siteurl FROM [SP_UsageAndHealth].[dbo].[RequestUsage] WHERE ServerURL = ''https://cmsintranet.share.cms.gov'' and UserLogin not like ''%cms\svc-%'' and siteurl != ''/'' and siteurl != ''''  

Use Internal_SharePoint
GO
INSERT INTO UsageAndHealth_Statistics_Daily_Unique_Users ("Date Collected", ServerURL, Day, "Day of Week", "Unique Users")

SELECT CONVERT(DATE,CURRENT_TIMESTAMP), ServerURL, FORMAT(logtime,''MM-dd'') AS ''Day'', DATENAME(WEEKDAY,logtime) AS ''Day of Week'', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = ''https://capms.cms.gov'' and UserLogin not like ''%cms\svc-%'' and siteurl != ''/'' and siteurl != ''''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,''MM-dd''), DATENAME(WEEKDAY,logtime), ServerURL
ORDER BY FORMAT(logtime,''MM-dd'')
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

PRINT ''Finished removing duplicates from UsageAndHealth_Statistics_PeakUsage_DateTime table''
PRINT ''''
PRINT ''Beginning Part 3 Queries''

Use Internal_SharePoint
GO
INSERT INTO UsageAndHealth_Statistics_PeakUsage_DateTime ("Date Collected", "ServerUrl", Day, "UniqueUsers")

SELECT TOP 1 CONVERT(DATE,CURRENT_TIMESTAMP) AS "Date Collected", ServerUrl, FORMAT(logtime,''MM-dd hh tt'') AS ''Day'', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = ''https://share.cms.gov'' and UserLogin not like ''%cms\svc-%'' and siteurl != ''/'' and siteurl != ''''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,''MM-dd hh tt''), ServerUrl
ORDER BY UniqueUsers DESC
GO

Use Internal_SharePoint
GO
INSERT INTO UsageAndHealth_Statistics_PeakUsage_DateTime ("Date Collected", "ServerUrl", Day, "UniqueUsers")

SELECT TOP 1 CONVERT(DATE,CURRENT_TIMESTAMP) AS "Date Collected", ServerUrl, FORMAT(logtime,''MM-dd hh tt'') AS ''Day'', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = ''https://cmsintranet.share.cms.gov'' and UserLogin not like ''%cms\svc-%'' /*and siteurl != ''/'' and siteurl != '''' */ and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,''MM-dd hh tt''), ServerUrl
ORDER BY UniqueUsers DESC
GO

Use Internal_SharePoint
GO
INSERT INTO UsageAndHealth_Statistics_PeakUsage_DateTime ("Date Collected", "ServerUrl", Day, "UniqueUsers")

SELECT TOP 1 CONVERT(DATE,CURRENT_TIMESTAMP) AS "Date Collected", ServerUrl, FORMAT(logtime,''MM-dd hh tt'') AS ''Day'', COUNT(DISTINCT(userlogin)) AS UniqueUsers
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = ''https://capms.cms.gov'' and UserLogin not like ''%cms\svc-%'' and siteurl != ''/'' and siteurl != ''''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY FORMAT(logtime,''MM-dd hh tt''), ServerUrl
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

PRINT ''Completed removing duplicates from UsageAndHealth_Statistics_Top_Five_Site_URL table''
PRINT ''''
PRINT ''Beginning Part 4 Queries''

Use Internal_SharePoint
GO
INSERT INTO UsageAndHealth_Statistics_Top_Five_Site_URL ("Date Collected", WebapplicationUrl, SiteCollectionUrl, WebSiteURL, Users)

SELECT TOP 5 CONVERT(DATE,CURRENT_TIMESTAMP) AS "Date Collected", LOWER(ServerUrl) as WebapplicationUrl, LOWER(SiteUrl) as SiteCollectionURL, LOWER(WebUrl) as WebSiteURL, count(distinct UserLogin) as Users
FROM [SP_UsageAndHealth].[dbo].[RequestUsage] with(nolock)
WHERE ServerUrl = ''https://share.cms.gov'' and UserLogin not like ''%cms\svc-%'' and WebUrl != ''''  and WebUrl != ''/''  and LogTime <
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
WHERE ServerUrl = ''https://cmsintranet.share.cms.gov'' and UserLogin not like ''%cms\svc-%'' and WebUrl != ''''  and WebUrl != ''/''  and LogTime <
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
WHERE ServerUrl = ''https://capms.cms.gov'' and UserLogin not like ''%cms\svc-%'' and WebUrl != ''''  and WebUrl != ''/''  and LogTime <
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY ServerUrl,SiteUrl,WebUrl
ORDER BY Users desc
GO

/*
Query takes 00:24 to complete
SELECT * FROM UsageAndHealth_Statistics_Total_Unique_Users_Weekly
SELECT * FROM UsageAndHealth_Statistics_Daily_Unique_Users
SELECT * FROM UsageAndHealth_Statistics_PeakUsage_DateTime
SELECT * FROM UsageAndHealth_Statistics_Top_Five_Site_URL

*/
--------------------------------------------------------------------------------------------


', 
		@database_name=N'master', 
		@flags=12
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'ADHOC Queries - Weekly', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20220628, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'92d638f6-dfe7-4269-9303-78a06d62d547'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


