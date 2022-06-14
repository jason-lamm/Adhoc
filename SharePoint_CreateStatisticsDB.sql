Use Internal_SharePoint
GO
Create Table UsageAndHealth_Statistics_Total_Unique_Users_Weekly (

share varchar(max), 
cmsintranet varchar(max), 
capms varchar(max) 
)



Use Internal_SharePoint
GO
Create Table UsageAndHealth_Statistics_Daily_Unique_Users (

ServerUrl varchar(max),
"Day" varchar(max),
"Day of Week" varchar(max),
"Unique Users" varchar(max)
)



Use Internal_SharePoint
GO
Create Table UsageAndHealth_Statistics_PeakUsage_DateTime (

Day varchar(max),
UniqueUsers varchar(max)
)




Use Internal_SharePoint
GO
Create Table UsageAndHealth_Statistics_Top_Five_Site_URL (

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


