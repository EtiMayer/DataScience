USE NoShow

--- Client Cancellation ---

Go
-- DROP VIEW cancel_service_v

CREATE VIEW cancel_service_v AS
SELECT  CAST(Booking_Date AS DATE) AS booking_date
       ,client_code
	   ,[Days] AS cancel_days
	   ,CAST(NULL AS TIME(0)) AS time_booked 
--Service
	   ,MAX(CASE WHEN (Service = 'CAL') THEN (1) ELSE (0) END) AS service_CAL
	   ,MAX(CASE WHEN (Service = 'CALC') THEN (1) ELSE (0) END) AS service_CALC
	   ,MAX(CASE WHEN (Service = 'CAS') THEN (1) ELSE (0) END) AS service_CAS
	   ,MAX(CASE WHEN (Service = 'CBAL') THEN (1) ELSE (0) END) AS service_CBAL
	   ,MAX(CASE WHEN (Service = 'CCAMO') THEN (1) ELSE (0) END) AS service_CCAMO
	   ,MAX(CASE WHEN (Service = 'CCO') THEN (1) ELSE (0) END) AS service_CCO
	   ,MAX(CASE WHEN (Service = 'CDPB') THEN (1) ELSE (0) END) AS service_CDPB
	   ,MAX(CASE WHEN (Service = 'CFC') THEN (1) ELSE (0) END) AS service_CFC
	   ,MAX(CASE WHEN (Service = 'CHLFH') THEN (1) ELSE (0) END) AS service_CHLFH
	   ,MAX(CASE WHEN (Service = 'CHLFHC') THEN (1) ELSE (0) END) AS service_CHLFHC
	   ,MAX(CASE WHEN (Service = 'CHLHH') THEN (1) ELSE (0) END) AS service_CHLHH
	   ,MAX(CASE WHEN (Service = 'CHLHHC') THEN (1) ELSE (0) END) AS service_CHLHHC
	   ,MAX(CASE WHEN (Service = 'CHLPHC') THEN (1) ELSE (0) END) AS service_CHLPHC
	   ,MAX(CASE WHEN (Service = 'CHLPL') THEN (1) ELSE (0) END) AS service_CHLPL
	   ,MAX(CASE WHEN (Service = 'CMT') THEN (1) ELSE (0) END) AS service_CMT
	   ,MAX(CASE WHEN (Service = 'CON') THEN (1) ELSE (0) END) AS service_CON
	   ,MAX(CASE WHEN (Service = 'CT') THEN (1) ELSE (0) END) AS service_CT
	   ,MAX(CASE WHEN (Service = 'CTU') THEN (1) ELSE (0) END) AS service_CTU
	   ,MAX(CASE WHEN (Service = 'EXT') THEN (1) ELSE (0) END) AS service_EXT
	   ,MAX(CASE WHEN (Service = 'F&F') THEN (1) ELSE (0) END) AS service_FF
	   ,MAX(CASE WHEN (Service = 'FRI') THEN (1) ELSE (0) END) AS service_FRI
	   ,MAX(CASE WHEN (Service = 'MISC') THEN (1) ELSE (0) END) AS service_MISC
	   ,MAX(CASE WHEN (Service = 'NECK') THEN (1) ELSE (0) END) AS service_NECK
	   ,MAX(CASE WHEN (Service = 'SBD') THEN (1) ELSE (0) END) AS service_SBD
	   ,MAX(CASE WHEN (Service = 'SBD5+1') THEN (1) ELSE (0) END) AS service_SBD5
	   ,MAX(CASE WHEN (Service = 'SDUD') THEN (1) ELSE (0) END) AS service_SDUD
	   ,MAX(CASE WHEN (Service = 'SHCC') THEN (1) ELSE (0) END) AS service_SHCC
	   ,MAX(CASE WHEN (Service = 'SHCM') THEN (1) ELSE (0) END) AS service_SHCM
	   ,MAX(CASE WHEN (Service = 'SHCW') THEN (1) ELSE (0) END) AS service_SHCW
	   ,MAX(CASE WHEN (Service = 'SMARTBOND') THEN (1) ELSE (0) END) AS service_SMARTBOND
	   ,MAX(CASE WHEN (Service = 'SMO') THEN (1) ELSE (0) END) AS service_SMO
	   ,MAX(CASE WHEN (Service = 'SSUD') THEN (1) ELSE (0) END) AS service_SSUD
--Staff
	   ,MAX(CASE WHEN (Staff = 'BECKY') THEN (1) ELSE (0) END) AS staff_BECKY	   
	   ,MAX(CASE WHEN (Staff = 'HOUSE') THEN (1) ELSE (0) END) AS staff_HOUSE
	   ,MAX(CASE WHEN (Staff = 'JJ') THEN (1) ELSE (0) END) AS staff_JJ
	   ,MAX(CASE WHEN (Staff = 'JOANNE') THEN (1) ELSE (0) END) AS staff_JOANNE
	   ,MAX(CASE WHEN (Staff = 'KELLY') THEN (1) ELSE (0) END) AS staff_KELLY
	   ,MAX(CASE WHEN (Staff = 'SINEAD') THEN (1) ELSE (0) END) AS staff_SINEAD
--Canceled By
	   ,MAX(CASE WHEN (Canceled_By = 'BECKY') THEN (1) ELSE (0) END) AS Canceled_By_BECKY	   
	   ,MAX(CASE WHEN (Canceled_By = 'HOUSE') THEN (1) ELSE (0) END) AS Canceled_By_HOUSE
	   ,MAX(CASE WHEN (Canceled_By = 'JJ') THEN (1) ELSE (0) END) AS Canceled_By_JJ
	   ,MAX(CASE WHEN (Canceled_By = 'JOANNE') THEN (1) ELSE (0) END) AS Canceled_By_JOANNE
	   ,MAX(CASE WHEN (Canceled_By = 'KELLY') THEN (1) ELSE (0) END) AS Canceled_By_KELLY
	   ,MAX(CASE WHEN (Canceled_By = 'SINEAD') THEN (1) ELSE (0) END) AS Canceled_By_SINEAD

FROM [Client_Cancellations]
GROUP BY Booking_Date
		,Client_Code
		,[Days]

SELECT * FROM cancel_service_v


--- Future Booking ---

Go
-- DROP VIEW future_service_v

CREATE VIEW future_service_v AS
SELECT  CAST(Booking_Date AS DATE) AS Booking_Date
       ,Client_Code
	   ,NULL AS cancel_days
	   ,CAST([Time] AS TIME(0)) AS time_booked 
--Service
	   ,MAX(CASE WHEN (Service = 'CAL') THEN (1) ELSE (0) END) AS service_CAL
	   ,MAX(CASE WHEN (Service = 'CALC') THEN (1) ELSE (0) END) AS service_CALC
	   ,MAX(CASE WHEN (Service = 'CAS') THEN (1) ELSE (0) END) AS service_CAS
	   ,MAX(CASE WHEN (Service = 'CBAL') THEN (1) ELSE (0) END) AS service_CBAL
	   ,MAX(CASE WHEN (Service = 'CCAMO') THEN (1) ELSE (0) END) AS service_CCAMO
	   ,MAX(CASE WHEN (Service = 'CCO') THEN (1) ELSE (0) END) AS service_CCO
	   ,MAX(CASE WHEN (Service = 'CDPB') THEN (1) ELSE (0) END) AS service_CDPB
	   ,MAX(CASE WHEN (Service = 'CFC') THEN (1) ELSE (0) END) AS service_CFC
	   ,MAX(CASE WHEN (Service = 'CHLFH') THEN (1) ELSE (0) END) AS service_CHLFH
	   ,MAX(CASE WHEN (Service = 'CHLFHC') THEN (1) ELSE (0) END) AS service_CHLFHC
	   ,MAX(CASE WHEN (Service = 'CHLHH') THEN (1) ELSE (0) END) AS service_CHLHH
	   ,MAX(CASE WHEN (Service = 'CHLHHC') THEN (1) ELSE (0) END) AS service_CHLHHC
	   ,MAX(CASE WHEN (Service = 'CHLPHC') THEN (1) ELSE (0) END) AS service_CHLPHC
	   ,MAX(CASE WHEN (Service = 'CHLPL') THEN (1) ELSE (0) END) AS service_CHLPL
	   ,MAX(CASE WHEN (Service = 'CMT') THEN (1) ELSE (0) END) AS service_CMT
	   ,MAX(CASE WHEN (Service = 'CON') THEN (1) ELSE (0) END) AS service_CON
	   ,MAX(CASE WHEN (Service = 'CT') THEN (1) ELSE (0) END) AS service_CT
	   ,MAX(CASE WHEN (Service = 'CTU') THEN (1) ELSE (0) END) AS service_CTU
	   ,MAX(CASE WHEN (Service = 'EXT') THEN (1) ELSE (0) END) AS service_EXT
	   ,MAX(CASE WHEN (Service = 'F&F') THEN (1) ELSE (0) END) AS service_FF
	   ,MAX(CASE WHEN (Service = 'FRI') THEN (1) ELSE (0) END) AS service_FRI
	   ,MAX(CASE WHEN (Service = 'MISC') THEN (1) ELSE (0) END) AS service_MISC
	   ,MAX(CASE WHEN (Service = 'NECK') THEN (1) ELSE (0) END) AS service_NECK
	   ,MAX(CASE WHEN (Service = 'SBD') THEN (1) ELSE (0) END) AS service_SBD
	   ,MAX(CASE WHEN (Service = 'SBD5+1') THEN (1) ELSE (0) END) AS service_SBD5
	   ,MAX(CASE WHEN (Service = 'SDUD') THEN (1) ELSE (0) END) AS service_SDUD
	   ,MAX(CASE WHEN (Service = 'SHCC') THEN (1) ELSE (0) END) AS service_SHCC
	   ,MAX(CASE WHEN (Service = 'SHCM') THEN (1) ELSE (0) END) AS service_SHCM
	   ,MAX(CASE WHEN (Service = 'SHCW') THEN (1) ELSE (0) END) AS service_SHCW
	   ,MAX(CASE WHEN (Service = 'SMARTBOND') THEN (1) ELSE (0) END) AS service_SMARTBOND
	   ,MAX(CASE WHEN (Service = 'SMO') THEN (1) ELSE (0) END) AS service_SMO
	   ,MAX(CASE WHEN (Service = 'SSUD') THEN (1) ELSE (0) END) AS service_SSUD
--Staff
	   ,MAX(CASE WHEN (Staff = 'BECKY') THEN (1) ELSE (0) END) AS staff_BECKY	   
	   ,MAX(CASE WHEN (Staff = 'HOUSE') THEN (1) ELSE (0) END) AS staff_HOUSE
	   ,MAX(CASE WHEN (Staff = 'JJ') THEN (1) ELSE (0) END) AS staff_JJ
	   ,MAX(CASE WHEN (Staff = 'JOANNE') THEN (1) ELSE (0) END) AS staff_JOANNE
	   ,MAX(CASE WHEN (Staff = 'KELLY') THEN (1) ELSE (0) END) AS staff_KELLY
	   ,MAX(CASE WHEN (Staff = 'SINEAD') THEN (1) ELSE (0) END) AS staff_SINEAD
--Canceled By
	   ,NULL AS Canceled_By_BECKY	   
	   ,NULL AS Canceled_By_HOUSE
	   ,NULL AS Canceled_By_JJ
	   ,NULL AS Canceled_By_JOANNE
	   ,NULL AS Canceled_By_KELLY
	   ,NULL AS Canceled_By_SINEAD

FROM [Future_Bookings_(All_Clients)]
GROUP BY Booking_Date
		,Client_Code
		,[Time]

SELECT * FROM future_service_v

--Counting Cancellations and Future Booking by Service

SELECT [Service]
	  ,1 AS sw_NOSHOW 
INTO #Service_cancel_cnt
FROM [Client Cancellations] 
ORDER BY [Service]

SELECT * FROM #Service_cancel_cnt

SELECT
	  ,[Service]
	  ,SUM (sw_NOSHOW) as total_cancel
INTO #Service_total_cancel
FROM #Service_cancel_cnt
GROUP BY [Service]

SELECT * FROM #Service_total_cancel ORDER BY total_cancel DESC

SELECT [Service]
	  ,COUNT([Service]) AS Service_cnt 
INTO #Service_cnt
FROM [Future Bookings (All Clients)] 
ORDER BY [Service]

--Cancellation Percent By Service
SELECT a.[Service]
	  ,c.[Desc]
	  ,SUM (COUNT(a.Service) + MAX(b.total_cancel)) As service_cnt 
	  ,MAX(b.total_cancel) as cancel
	  ,CASE WHEN (COUNT(b.total_cancel)>0) THEN ((COUNT(b.total_cancel) *1.0/(SUM (COUNT(a.Service) + MAX(b.total_cancel))*1.0) *100)) ELSE (0) END AS cancel_pct
INTO #Cancellation_percent
FROM [Future Bookings (All Clients)] a
LEFT OUTER JOIN 
	 [#Service_total_cancel] b
ON   a.Service = b.Service
LEFT OUTER JOIN 
	 [Service Listing] c
ON   a.Service = c.Code
GROUP BY a.Service
		,c.[Desc]
		,SUM (COUNT(a.Service) + MAX(b.total_cancel))

SELECT * FROM [#Cancellation_percent] ORDER BY cancel_pct DESC


--Counting Cancellations by Client

SELECT DISTINCT [Booking Date]
		        ,[code]
				,1 AS sw_NOSHOW 
INTO #client_cancel_cnt
FROM [Client Cancellations] 
ORDER BY [Booking Date] 
        ,[code]

SELECT Code
	  ,SUM (sw_NOSHOW) as total_cancel
INTO #client_total_cancel
FROM #client_cancel_cnt
GROUP BY [Code]
ORDER BY total_cancel DESC

SELECT * FROM #client_total_cancel ORDER BY total_cancel DESC

--Cancellation Percent By Client
SELECT a.Code
	  ,COUNT(1) As client_cnt 
	  ,COUNT(b.Code) as cancel
	  ,CASE WHEN (COUNT(b.Code)>0) THEN ((COUNT(b.Code) *1.0/(COUNT(1)*1.0) *100)) ELSE (0) END AS cancel_pct
INTO #Cancellation_client_percent
FROM [Future Bookings (All Clients)] a
LEFT OUTER JOIN 
	 [Client Cancellations] b
ON   a.Code = b.Code
GROUP BY a.Code

DROP TABLE #Cancellation_client_percent
SELECT * FROM [#Cancellation_client_percent] ORDER BY cancel_pct DESC









	  CASE WHEN ((SELECT Code FROM [Service Listing] WHERE a.Service]=c.Code AND iso_639_1 = 'en') = 'en') THEN (1) ELSE (0) END AS lang_US
FRI
SBD5+1
CCAMO
CMT
SBD
CTU
CALC
CON
CT
CBAL
SMARTBOND
SMO
CHLPL
CHLFH
CDPB
CHLHHC
CFC
SHCM
TRE 1
SHCW
CHLPHC

INNER JOIN 
	[Service Listing] c
ON a.[Service] = c.Code
