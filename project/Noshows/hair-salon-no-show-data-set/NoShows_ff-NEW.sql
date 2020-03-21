USE NoShow

---------------------------------
--------    FLAT FILE    --------
---------------------------------

-- DROP TABLE NoShow_ff
SELECT a.*
	  ,b.quantity
	  ,b.amount
	  ,CASE WHEN (AVG(c.amount) IS NULL) THEN (0) ELSE (AVG(c.amount)) END as avg_receipt
	  ,CASE WHEN (AVG(c.quantity) IS NULL) THEN (0) ELSE (AVG(c.quantity)) END as avg_quantity
	  ,CASE WHEN (COUNT(d.cancel_days) IS NULL) THEN (0) ELSE (COUNT(d.cancel_days)) END as total_cancel12
INTO NoShow_ff
FROM (
SELECT *
FROM [future_service_v] 
UNION ALL
SELECT *
FROM [cancel_service_v] 
UNION ALL
SELECT *
FROM [NoShow_v]) AS a
LEFT OUTER JOIN 
	receipt_total b
ON b.Client_Code = a.Client_Code AND b.[Date]=a.Booking_Date
LEFT OUTER JOIN
	receipt_total c
ON a.Client_Code = c.Client_Code AND c.[Date] BETWEEN DATEADD(MONTH, -6, a.booking_date) AND DATEADD(DAY, -1, a.booking_date) 
LEFT OUTER JOIN 
	NoShow_ff_2 d
ON a.Client_Code = d.Client_Code 

GROUP BY a.[Client_Code]
      ,a.[Booking_Date]
      ,a.[sunday]
      ,a.[monday]
      ,a.[wednesday]
      ,a.[thursday]
      ,a.[friday]
	  ,a.[saturday]
      ,a.[time_booked]
      ,a.[cancel_days]
      ,a.[NoShow]
      ,a.[service_CAL]
      ,a.[service_CALC]
      ,a.[service_CAS]
      ,a.[service_CBAL]
      ,a.[service_CCAMO]
      ,a.[service_CCO]
      ,a.[service_CDPB]
      ,a.[service_CFC]
      ,a.[service_CHLFH]
      ,a.[service_CHLFHC]
      ,a.[service_CHLHH]
      ,a.[service_CHLHHC]
      ,a.[service_CHLPHC]
      ,a.[service_CHLPL]
      ,a.[service_CMT]
      ,a.[service_CON]
      ,a.[service_CT]
      ,a.[service_CTU]
      ,a.[service_EXT]
      ,a.[service_FF]
      ,a.[service_FRI]
      ,a.[service_MISC]
      ,a.[service_NECK]
      ,a.[service_SBD]
      ,a.[service_SBD5]
      ,a.[service_SDUD]
      ,a.[service_SHCC]
      ,a.[service_SHCM]
      ,a.[service_SHCW]
      ,a.[service_SMARTBOND]
      ,a.[service_SMO]
      ,a.[service_SSUD]
      ,a.[staff_BECKY]
      ,a.[staff_HOUSE]
      ,a.[staff_JJ]
      ,a.[staff_JOANNE]
      ,a.[staff_KELLY]
      ,a.[staff_SINEAD]
      ,a.[Canceled_By_BECKY]
      ,a.[Canceled_By_HOUSE]
      ,a.[Canceled_By_JJ]
      ,a.[Canceled_By_JOANNE]
      ,a.[Canceled_By_KELLY]
      ,a.[Canceled_By_SINEAD]
      ,b.[quantity]
      ,b.[amount]
	  

SELECT * FROM NoShow_ff
WHERE Client_code = 'NELT01' AND NoShow = 1



