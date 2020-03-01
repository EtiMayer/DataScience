/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [IndicatorCode]
      ,[CountryName]
      ,[CountryCode]
      ,[IndicatorName]
      ,[Year]
      ,[Value]
  FROM [RenewableEnergy].[dbo].[EnergyIndicatorsFT]
  
  SELECT count(1)
FROM [RenewableEnergy].[dbo].[EnergyIndicatorsFT]