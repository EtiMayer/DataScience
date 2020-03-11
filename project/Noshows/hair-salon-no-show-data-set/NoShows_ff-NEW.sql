USE NoShow

---------------------------------
--------    FLAT FILE    --------
---------------------------------

--DROP TABLE NoShow_ff
SELECT a.*
INTO NoShow_ff
FROM (
SELECT *
FROM [future_service_v] 
UNION ALL
SELECT *
FROM [cancel_service_v] 
 
) AS a 

SELECT * FROM NoShow_ff



--DROP TABLE NoShow_ff

SELECT a.*
	  ,b.Amount
FROM NoShow_ff a
LEFT OUTER JOIN 
[Receipt_Transactions] b
ON a.[Client_Code] = b.[Client_Code]
WHERE a.Booking_Date=b.[Date] AND a.Client_Code=b.Client_Code




SELECT * FROM  NoShow_ff