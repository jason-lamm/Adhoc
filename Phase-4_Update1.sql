--Creates views to add additional functionality to Executive Dashboard.

  --Create view with detailed query
--There are two views. Run create view command independently. Switch to Ast_Internal database first.
 
 

CREATE VIEW vw_UsageAndHealth_Statistics_Daily_Unique_Users_v1 AS
  SELECT [ID]
      ,[Date Collected]
      ,[ServerUrl]
      ,[Day]
,CASE
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '25' AND [Day] = '12-25' THEN Year([Date Collected])
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '25' AND [Day] = '12-26' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '25' AND [Day] = '12-27' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '25' AND [Day] = '12-28' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '25' AND [Day] = '12-29' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '25' AND [Day] = '12-30' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '25' AND [Day] = '12-31' THEN Year([Date Collected])	

	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '26' AND [Day] = '12-25' THEN Year([Date Collected])
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '26' AND [Day] = '12-26' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '26' AND [Day] = '12-27' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '26' AND [Day] = '12-28' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '26' AND [Day] = '12-29' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '26' AND [Day] = '12-30' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '26' AND [Day] = '12-31' THEN Year([Date Collected])

	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '27' AND [Day] = '12-25' THEN Year([Date Collected])
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '27' AND [Day] = '12-26' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '27' AND [Day] = '12-27' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '27' AND [Day] = '12-28' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '27' AND [Day] = '12-29' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '27' AND [Day] = '12-30' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '27' AND [Day] = '12-31' THEN Year([Date Collected])

	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '28' AND [Day] = '12-25' THEN Year([Date Collected])
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '28' AND [Day] = '12-26' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '28' AND [Day] = '12-27' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '28' AND [Day] = '12-28' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '28' AND [Day] = '12-29' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '28' AND [Day] = '12-30' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '28' AND [Day] = '12-31' THEN Year([Date Collected])

	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '29' AND [Day] = '12-25' THEN Year([Date Collected])
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '29' AND [Day] = '12-26' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '29' AND [Day] = '12-27' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '29' AND [Day] = '12-28' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '29' AND [Day] = '12-29' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '29' AND [Day] = '12-30' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '29' AND [Day] = '12-31' THEN Year([Date Collected])

	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '30' AND [Day] = '12-25' THEN Year([Date Collected])
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '30' AND [Day] = '12-26' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '30' AND [Day] = '12-27' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '30' AND [Day] = '12-28' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '30' AND [Day] = '12-29' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '30' AND [Day] = '12-30' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '30' AND [Day] = '12-31' THEN Year([Date Collected])

	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '31' AND [Day] = '12-25' THEN Year([Date Collected])
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '31' AND [Day] = '12-26' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '31' AND [Day] = '12-27' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '31' AND [Day] = '12-28' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '31' AND [Day] = '12-29' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '31' AND [Day] = '12-30' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '31' AND [Day] = '12-31' THEN Year([Date Collected])

	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '01' AND [Day] = '12-25' THEN (Year([Date Collected]) - 1)
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '01' AND [Day] = '12-26' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '01' AND [Day] = '12-27' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '01' AND [Day] = '12-28' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '01' AND [Day] = '12-29' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '01' AND [Day] = '12-30' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '01' AND [Day] = '12-31' THEN (Year([Date Collected]) - 1)

	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '02' AND [Day] = '12-25' THEN (Year([Date Collected]) - 1)
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '02' AND [Day] = '12-26' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '02' AND [Day] = '12-27' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '02' AND [Day] = '12-28' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '02' AND [Day] = '12-29' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '02' AND [Day] = '12-30' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '02' AND [Day] = '12-31' THEN (Year([Date Collected]) - 1)

	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '03' AND [Day] = '12-25' THEN (Year([Date Collected]) - 1)
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '03' AND [Day] = '12-26' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '03' AND [Day] = '12-27' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '03' AND [Day] = '12-28' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '03' AND [Day] = '12-29' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '03' AND [Day] = '12-30' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '03' AND [Day] = '12-31' THEN (Year([Date Collected]) - 1)

	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '04' AND [Day] = '12-25' THEN (Year([Date Collected]) - 1)
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '04' AND [Day] = '12-26' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '04' AND [Day] = '12-27' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '04' AND [Day] = '12-28' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '04' AND [Day] = '12-29' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '04' AND [Day] = '12-30' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '04' AND [Day] = '12-31' THEN (Year([Date Collected]) - 1)

	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '05' AND [Day] = '12-25' THEN (Year([Date Collected]) - 1)
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '05' AND [Day] = '12-26' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '05' AND [Day] = '12-27' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '05' AND [Day] = '12-28' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '05' AND [Day] = '12-29' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '05' AND [Day] = '12-30' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '05' AND [Day] = '12-31' THEN (Year([Date Collected]) - 1)

	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '06' AND [Day] = '12-25' THEN (Year([Date Collected]) - 1)
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '06' AND [Day] = '12-26' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '06' AND [Day] = '12-27' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '06' AND [Day] = '12-28' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '06' AND [Day] = '12-29' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '06' AND [Day] = '12-30' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '06' AND [Day] = '12-31' THEN (Year([Date Collected]) - 1)

	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '07' AND [Day] = '12-25' THEN (Year([Date Collected]) - 1)
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '07' AND [Day] = '12-26' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '07' AND [Day] = '12-27' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '07' AND [Day] = '12-28' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '07' AND [Day] = '12-29' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '07' AND [Day] = '12-30' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '07' AND [Day] = '12-31' THEN (Year([Date Collected]) - 1)

	ELSE YEAR([Date Collected])
END AS "Year"
      ,[Day of Week]
      ,[Unique Users]
  FROM [UsageAndHealth_Statistics_Daily_Unique_Users]



  --------WORK ON UsageAndHealth_Statistics_PeakUsage_DateTime
  --Break out month like 09-20
  --break out year to stand alone column
  --break out time 


  
  

CREATE VIEW vw_UsageAndHealth_Statistics_PeakUsage_DateTime_v1 AS
  SELECT [ID]
      ,[Date Collected]
      ,[ServerUrl]
      ,[Day]
	  ,LEFT([DAY], 5) AS "Month-Day"
	  ,RIGHT([DAY], 5) AS "Time"
,CASE
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '25' AND [Day] LIKE '12-25%' THEN Year([Date Collected])
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '25' AND [Day] LIKE '12-26%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '25' AND [Day] LIKE '12-27%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '25' AND [Day] LIKE '12-28%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '25' AND [Day] LIKE '12-29%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '25' AND [Day] LIKE '12-30%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '25' AND [Day] LIKE '12-31%' THEN Year([Date Collected])	

	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '26' AND [Day] LIKE '12-25%' THEN Year([Date Collected])
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '26' AND [Day] LIKE '12-26%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '26' AND [Day] LIKE '12-27%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '26' AND [Day] LIKE '12-28%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '26' AND [Day] LIKE '12-29%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '26' AND [Day] LIKE '12-30%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '26' AND [Day] LIKE '12-31%' THEN Year([Date Collected])

	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '27' AND [Day] LIKE '12-25%' THEN Year([Date Collected])
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '27' AND [Day] LIKE '12-26%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '27' AND [Day] LIKE '12-27%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '27' AND [Day] LIKE '12-28%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '27' AND [Day] LIKE '12-29%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '27' AND [Day] LIKE '12-30%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '27' AND [Day] LIKE '12-31%' THEN Year([Date Collected])

	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '28' AND [Day] LIKE '12-25%' THEN Year([Date Collected])
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '28' AND [Day] LIKE '12-26%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '28' AND [Day] LIKE '12-27%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '28' AND [Day] LIKE '12-28%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '28' AND [Day] LIKE '12-29%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '28' AND [Day] LIKE '12-30%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '28' AND [Day] LIKE '12-31%' THEN Year([Date Collected])

	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '29' AND [Day] LIKE '12-25%' THEN Year([Date Collected])
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '29' AND [Day] LIKE '12-26%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '29' AND [Day] LIKE '12-27%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '29' AND [Day] LIKE '12-28%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '29' AND [Day] LIKE '12-29%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '29' AND [Day] LIKE '12-30%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '29' AND [Day] LIKE '12-31%' THEN Year([Date Collected])

	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '30' AND [Day] LIKE '12-25%' THEN Year([Date Collected])
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '30' AND [Day] LIKE '12-26%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '30' AND [Day] LIKE '12-27%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '30' AND [Day] LIKE '12-28%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '30' AND [Day] LIKE '12-29%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '30' AND [Day] LIKE '12-30%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '30' AND [Day] LIKE '12-31%' THEN Year([Date Collected])

	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '31' AND [Day] LIKE '12-25%' THEN Year([Date Collected])
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '31' AND [Day] LIKE '12-26%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '31' AND [Day] LIKE '12-27%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '31' AND [Day] LIKE '12-28%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '31' AND [Day] LIKE '12-29%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '31' AND [Day] LIKE '12-30%' THEN Year([Date Collected])	
	WHEN Month([Date Collected]) = '12'  AND Day([Date Collected]) = '31' AND [Day] LIKE '12-31%' THEN Year([Date Collected])

	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '01' AND [Day] LIKE '12-25%' THEN (Year([Date Collected]) - 1)
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '01' AND [Day] LIKE '12-26%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '01' AND [Day] LIKE '12-27%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '01' AND [Day] LIKE '12-28%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '01' AND [Day] LIKE '12-29%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '01' AND [Day] LIKE '12-30%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '01' AND [Day] LIKE '12-31%' THEN (Year([Date Collected]) - 1)

	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '02' AND [Day] LIKE '12-25%' THEN (Year([Date Collected]) - 1)
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '02' AND [Day] LIKE '12-26%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '02' AND [Day] LIKE '12-27%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '02' AND [Day] LIKE '12-28%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '02' AND [Day] LIKE '12-29%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '02' AND [Day] LIKE '12-30%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '02' AND [Day] LIKE '12-31%' THEN (Year([Date Collected]) - 1)

	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '03' AND [Day] LIKE '12-25%' THEN (Year([Date Collected]) - 1)
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '03' AND [Day] LIKE '12-26%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '03' AND [Day] LIKE '12-27%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '03' AND [Day] LIKE '12-28%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '03' AND [Day] LIKE '12-29%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '03' AND [Day] LIKE '12-30%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '03' AND [Day] LIKE '12-31%' THEN (Year([Date Collected]) - 1)

	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '04' AND [Day] LIKE '12-25%' THEN (Year([Date Collected]) - 1)
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '04' AND [Day] LIKE '12-26%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '04' AND [Day] LIKE '12-27%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '04' AND [Day] LIKE '12-28%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '04' AND [Day] LIKE '12-29%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '04' AND [Day] LIKE '12-30%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '04' AND [Day] LIKE '12-31%' THEN (Year([Date Collected]) - 1)

	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '05' AND [Day] LIKE '12-25%' THEN (Year([Date Collected]) - 1)
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '05' AND [Day] LIKE '12-26%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '05' AND [Day] LIKE '12-27%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '05' AND [Day] LIKE '12-28%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '05' AND [Day] LIKE '12-29%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '05' AND [Day] LIKE '12-30%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '05' AND [Day] LIKE '12-31%' THEN (Year([Date Collected]) - 1)

	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '06' AND [Day] LIKE '12-25%' THEN (Year([Date Collected]) - 1)
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '06' AND [Day] LIKE '12-26%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '06' AND [Day] LIKE '12-27%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '06' AND [Day] LIKE '12-28%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '06' AND [Day] LIKE '12-29%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '06' AND [Day] LIKE '12-30%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '06' AND [Day] LIKE '12-31%' THEN (Year([Date Collected]) - 1)

	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '07' AND [Day] LIKE '12-25%' THEN (Year([Date Collected]) - 1)
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '07' AND [Day] LIKE '12-26%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '07' AND [Day] LIKE '12-27%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '07' AND [Day] LIKE '12-28%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '07' AND [Day] LIKE '12-29%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '07' AND [Day] LIKE '12-30%' THEN (Year([Date Collected]) - 1)	
	WHEN Month([Date Collected]) = '01'  AND Day([Date Collected]) = '07' AND [Day] LIKE '12-31%' THEN (Year([Date Collected]) - 1)

	ELSE YEAR([Date Collected])
END AS "Year"
      ,[UniqueUsers]
  FROM UsageAndHealth_Statistics_PeakUsage_DateTime


