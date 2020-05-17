SELECT DISTINCT [Booking Date]
		        ,[code]
				,1 AS sw_NOSHOW 
FROM [Client Cancellations] order by [Booking Date], [code]

SELECT * FROM [Client Cancellations]


SELECT a.[Date],
       a.Client_code, 
	   a.Amount,
	   (SELECT TOP 1 b.Amount FROM [Receipt_Transactions] b WHERE b.[Date] < a.[Date] AND b.Client_code = a.Client_code ORDER BY b.[Date] DESC) AS amount_old
FROM [Receipt_Transactions] a
ORDER BY a.Client_code, a.[Date]
--WHERE Date ='2018-06-07' AND CLient_Code='ALCV01'

SELECT  * FROM [Receipt_Transactions]
WHERE Date ='2018-06-07' AND CLient_Code='ALCV01'