/*
PHASE 3
ReportingServices_QuerySet1.sql



6/17/2022		Jason Lamm			Initial
6/23/2022		"					Implemented Fixes, cleanup


Queries for Reporting Services
*/


--------------------------TOTAL UNIQUE USERS-------------------------------------------------------------------------
--Part 1

SELECT "Total Unique Users"
FROM UsageAndHealth_Statistics_Total_Unique_Users_Weekly with(nolock)
WHERE ServerUrl = 'https://share.cms.gov' and Date =
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)


SELECT "Total Unique Users"
FROM UsageAndHealth_Statistics_Total_Unique_Users_Weekly with(nolock)
WHERE ServerUrl = 'https://cmsintranet.share.cms.gov' and Date =
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)


SELECT "Total Unique Users"
FROM UsageAndHealth_Statistics_Total_Unique_Users_Weekly with(nolock)
WHERE ServerUrl = 'https://capms.cms.gov' and Date =
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)

/*
INTERNAL TESTING:

TRUNCATE TABLE UsageAndHealth_Statistics_Total_Unique_Users_Weekly
SELECT * FROM UsageAndHealth_Statistics_Total_Unique_Users_Weekly

*/
---------------------------------------------------------------------------------------------




--------------------------DAILY UNIQUE USERS-------------------------------------------------------------------------
--Part 2

SELECT Day, "Day of Week", "Unique Users"
FROM UsageAndHealth_Statistics_Daily_Unique_Users with(nolock)
WHERE ServerUrl = 'https://share.cms.gov' and "Date Collected" =
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)


SELECT Day, "Day of Week", "Unique Users"
FROM UsageAndHealth_Statistics_Daily_Unique_Users with(nolock)
WHERE ServerUrl = 'https://cmsintranet.share.cms.gov' and "Date Collected" =
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)


SELECT Day, "Day of Week", "Unique Users"
FROM UsageAndHealth_Statistics_Daily_Unique_Users with(nolock)
WHERE ServerUrl = 'https://capms.cms.gov' and "Date Collected" =
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)


/*
INTERNAL TESTING
TRUNCATE TABLE UsageAndHealth_Statistics_Daily_Unique_Users 
SELECT * FROM UsageAndHealth_Statistics_Daily_Unique_Users 

*/
---------------------------------------------------------------------------------------------




----------------------------Peak Usage Date/Time--------------------------------------------------------------------
--Part 3

SELECT Day, UniqueUsers
FROM UsageAndHealth_Statistics_PeakUsage_DateTime with(nolock)
WHERE ServerUrl = 'https://share.cms.gov' and "Date Collected" =
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)


SELECT Day, UniqueUsers
FROM UsageAndHealth_Statistics_PeakUsage_DateTime with(nolock)
WHERE ServerUrl = 'https://cmsintranet.share.cms.gov' and "Date Collected" =
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)


SELECT Day, UniqueUsers
FROM UsageAndHealth_Statistics_PeakUsage_DateTime with(nolock)
WHERE ServerUrl = 'https://capms.cms.gov' and "Date Collected" =
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)


/*
INTERNAL TESTING

TRUNCATE TABLE UsageAndHealth_Statistics_PeakUsage_DateTime
SELECT * FROM UsageAndHealth_Statistics_PeakUsage_DateTime

*/
---------------------------------------------------------------------------------------------




--------------------------------Top Five Site URL----------------------------------------------------------------------
--Part 4

SELECT WebapplicationUrl, SiteCollectionURL, WebSiteURL, Users
FROM UsageAndHealth_Statistics_Top_Five_Site_URL with(nolock)
WHERE WebapplicationUrl = 'https://share.cms.gov' and "Date Collected" =
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY WebapplicationUrl, SiteCollectionURL, WebSiteURL, Users
ORDER BY Users desc



SELECT WebapplicationUrl, SiteCollectionURL, WebSiteURL, Users
FROM UsageAndHealth_Statistics_Top_Five_Site_URL with(nolock)
WHERE WebapplicationUrl = 'https://cmsintranet.share.cms.gov' and "Date Collected" =
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY WebapplicationUrl, SiteCollectionURL, WebSiteURL, Users
ORDER BY Users desc



SELECT WebapplicationUrl, SiteCollectionURL, WebSiteURL, Users
FROM UsageAndHealth_Statistics_Top_Five_Site_URL with(nolock)
WHERE WebapplicationUrl = 'https://capms.cms.gov' and "Date Collected" =
(
	SELECT CONVERT(DATE,CURRENT_TIMESTAMP)
)
GROUP BY WebapplicationUrl, SiteCollectionURL, WebSiteURL, Users
ORDER BY Users desc


/*
INTERNAL TESTING

SELECT * FROM UsageAndHealth_Statistics_Top_Five_Site_URL
TRUNCATE TABLE UsageAndHealth_Statistics_Top_Five_Site_URL

*/
