/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [IndicatorCode]
      ,[CountryName]
      ,[CountryCode]
      ,[IndicatorName]
      ,[Year]
      ,[Value]
  FROM [RenewableEnergy].[dbo].[EnergyIndicatorsFT]
  WHERE [CountryCode] = 'AFG'
	AND [Year] = 2015