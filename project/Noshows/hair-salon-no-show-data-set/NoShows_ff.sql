USE NoShow

--- Client Cancellation ---

Go
-- DROP VIEW cancel_service_v

CREATE VIEW cancel_service_v AS
SELECT  client_code
	   ,CAST(Booking_Date AS DATE) AS booking_date
--Days of Week
	   ,MAX(CASE WHEN ((DATENAME(weekday,Booking_Date) = 'sunday')) THEN (1) ELSE (0) END) AS sunday
	   ,MAX(CASE WHEN ((DATENAME(weekday,Booking_Date) = 'monday')) THEN (1) ELSE (0) END) AS monday
	   ,MAX(CASE WHEN ((DATENAME(weekday,Booking_Date) = 'wednesday')) THEN (1) ELSE (0) END) AS wednesday
	   ,MAX(CASE WHEN ((DATENAME(weekday,Booking_Date) = 'thursday')) THEN (1) ELSE (0) END) AS thursday
	   ,MAX(CASE WHEN ((DATENAME(weekday,Booking_Date) = 'friday')) THEN (1) ELSE (0) END) AS friday
	   ,MAX(CASE WHEN ((DATENAME(weekday,Booking_Date) = 'saturday')) THEN (1) ELSE (0) END) AS saturday
	   ,CAST(NULL AS TIME(0)) AS time_booked 
	   ,[Days] AS cancel_days
	   ,CASE WHEN ([Days] < 2) THEN (1) ELSE (0) END AS NoShow
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
SELECT  Client_Code
	   ,CAST(Booking_Date AS DATE) AS Booking_Date
--Days of Week
	   ,MAX(CASE WHEN ((DATENAME(weekday,Booking_Date) = 'sunday')) THEN (1) ELSE (0) END) AS sunday
	   ,MAX(CASE WHEN ((DATENAME(weekday,Booking_Date) = 'monday')) THEN (1) ELSE (0) END) AS monday
	   ,MAX(CASE WHEN ((DATENAME(weekday,Booking_Date) = 'wednesday')) THEN (1) ELSE (0) END) AS wednesday
	   ,MAX(CASE WHEN ((DATENAME(weekday,Booking_Date) = 'thursday')) THEN (1) ELSE (0) END) AS thursday
	   ,MAX(CASE WHEN ((DATENAME(weekday,Booking_Date) = 'friday')) THEN (1) ELSE (0) END) AS friday
	   ,MAX(CASE WHEN ((DATENAME(weekday,Booking_Date) = 'saturday')) THEN (1) ELSE (0) END) AS saturday
	   ,CAST([Time] AS TIME(0)) AS time_booked 
	   ,NULL AS cancel_days
	   ,0 AS NoShow
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
GROUP BY Client_Code
		,Booking_Date
		,[Time]
			

SELECT * FROM future_service_v

--NoShow Veiw

--DROP VIEW NoShow_v

CREATE VIEW NoShow_v AS
SELECT [Client_Code]
	  ,CAST(Booking_Date AS DATE) AS booking_date
--Days of Week
	   ,MAX(CASE WHEN ((DATENAME(weekday,Booking_Date) = 'sunday')) THEN (1) ELSE (0) END) AS sunday
	   ,MAX(CASE WHEN ((DATENAME(weekday,Booking_Date) = 'monday')) THEN (1) ELSE (0) END) AS monday
	   ,MAX(CASE WHEN ((DATENAME(weekday,Booking_Date) = 'wednesday')) THEN (1) ELSE (0) END) AS wednesday
	   ,MAX(CASE WHEN ((DATENAME(weekday,Booking_Date) = 'thursday')) THEN (1) ELSE (0) END) AS thursday
	   ,MAX(CASE WHEN ((DATENAME(weekday,Booking_Date) = 'friday')) THEN (1) ELSE (0) END) AS friday
	   ,MAX(CASE WHEN ((DATENAME(weekday,Booking_Date) = 'saturday')) THEN (1) ELSE (0) END) AS saturday
	  ,CAST(NULL AS TIME(0)) AS time_booked 
	  ,0 AS cancel_days
	  ,1 AS NoShow
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

FROM [No-Show Report]
GROUP BY [Client_Code]
		,booking_date
		

SELECT * FROM NoShow_v


---Receipt

SELECT [Receipt]
      ,[Date]
      ,[Client_Code]
      ,SUM([Quantity]) AS quantity
      ,SUM([Amount]) AS amount
INTO receipt_total  
FROM [NoShow].[dbo].[Receipt_Transactions]
GROUP BY [Receipt]
        ,[Date]
        ,[Client_Code]

SELECT * FROM receipt_total
SELECT * FROM Receipt_Transactions
ORDER BY Receipt ASC