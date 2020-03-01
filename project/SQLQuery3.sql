/****** Script for SelectTopNRows command from SSMS  ******/

-- drop table ColChange
SELECT
	   [IndicatorCode]
      ,[CountryName]
      ,[CountryCode]
      ,[IndicatorName]
      ,[Year]
      ,[Value]
INTO ColChange
  FROM [RenewableEnergy].[dbo].[EnergyIndicatorsFT2]
WHERE [CountryCode] NOT IN ('Population, total','GDP at market prices (current US$)','Population density (people per sq. km of land area)');
--- (345334 row(s) affected)

INSERT INTO ColChange
SELECT
       [IndicatorName] AS [IndicatorCode]
	  ,[IndicatorCode] AS [CountryName]
      ,[CountryName] AS [CountryCode]
      ,[CountryCode] AS [IndicatorName]
      ,[Year]
      ,[Value]
  FROM [RenewableEnergy].[dbo].[EnergyIndicatorsFT2]
WHERE [CountryCode] IN ('Population, total','GDP at market prices (current US$)','Population density (people per sq. km of land area)');
--- (36818 row(s) affected)

select  [IndicatorCode]
      ,[CountryName]
      ,[CountryCode]
      ,[IndicatorName]
      ,[Year] from ColChange
--- 382152
select DISTINCT [IndicatorCode]
      ,[CountryName]
      ,[CountryCode]
      --,[IndicatorName]
      ,[Year] from ColChange


drop table [RenewableEnergy].[dbo].[EnergyIndicatorsFT2]

select *
INTO [RenewableEnergy].[dbo].[EnergyIndicatorsFT]
FROM ColChange