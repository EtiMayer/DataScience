USE RenewableEnergy;

-- drop table tmp_indicator_iterator
SELECT DISTINCT [IndicatorCode], 0 AS status1
INTO tmp_indicator_iterator 
FROM [RenewableEnergy].[dbo].[EnergyIndicatorsFT]

select * from tmp_indicator_iterator

--- create the main ff table
SELECT DISTINCT
		[CountryName]
		, [CountryCode]
		, [Year]	
		--, MAX(CASE WHEN ([IndicatorCode] = 'EN_CO2_OTHX_ZS') THEN (Value) ELSE (0) END) AS EN_CO2_OTHX_ZS
INTO [RenewableEnergy].[dbo].[Energy_flatfile]
FROM EnergyIndicatorsFT

select * from [RenewableEnergy].[dbo].[Energy_flatfile]

-------------------------------------------------
--- begin inclussion of each measure as column
-------------------------------------------------

DECLARE @ind AS VARCHAR(MAX);
DECLARE @x AS INT;
DECLARE @sql AS VARCHAR(MAX);

SET @x = 0;

WHILE @x = 0
BEGIN
	SET @ind = (SELECT TOP 1 [IndicatorCode] FROM tmp_indicator_iterator WHERE status1 = 0) ;
	IF (@ind = '')
	BEGIN
		SET @x = 1;
	END
	
	SET @sql = 'ALTER TABLE [RenewableEnergy].[dbo].[Energy_flatfile] ADD ' + @ind + ' FLOAT;';

	EXEC( @sql );

	SET @sql = '
	UPDATE [RenewableEnergy].[dbo].[Energy_flatfile] 
	SET ' + @ind +  ' = (
	SELECT Value
	FROM  [RenewableEnergy].[dbo].EnergyIndicatorsFT a
	WHERE a.[CountryName] = [RenewableEnergy].[dbo].[Energy_flatfile].[CountryName]
	  AND a.[CountryCode] =[RenewableEnergy].[dbo].[Energy_flatfile].[CountryCode]
	  AND a.[Year] = [RenewableEnergy].[dbo].[Energy_flatfile].[Year]
	  AND [IndicatorCode] = '+ CHAR(39) + @ind + CHAR(39)+	'
	);';
	
	--UPDATE [RenewableEnergy].[dbo].[Energy_flatfile] 
	--SET SP_POP_TOTL = (
	--SELECT Value
	--FROM  [RenewableEnergy].[dbo].EnergyIndicatorsFT a
	--WHERE a.[CountryName] = [RenewableEnergy].[dbo].[Energy_flatfile].[CountryName]
	--	AND a.[CountryCode] =[RenewableEnergy].[dbo].[Energy_flatfile].[CountryCode]
	--	AND a.[Year] = [RenewableEnergy].[dbo].[Energy_flatfile].[Year]
	--	AND [IndicatorCode] = 'SP_POP_TOTL'
	--);

	EXEC( @sql );
	--SELECT ( @sql );

	UPDATE     SET status1 = 9 WHERE IndicatorCode = @ind;
	
END

----------------------------


		
		SET @sql = '

		SELECT 
			    [CountryName]
			  , [CountryCode]
			  , [Year]	
			  , MAX(CASE WHEN ([IndicatorCode] = ' + CHAR(39) + @ind + + CHAR(39) + ') THEN (Value) ELSE (0) END) AS ' + @ind + '
		FROM EnergyIndicatorsFT
		GROUP BY  [CountryName]
			  , [CountryCode]
			  , [Year]	
		';
	

	ALTER TABLE [RenewableEnergy].[dbo].[Energy_flatfile] ADD SP_POP_TOTL FLOAT;

	UPDATE [RenewableEnergy].[dbo].[Energy_flatfile] 
	SET SP_POP_TOTL = (
	SELECT Value
	FROM  [RenewableEnergy].[dbo].EnergyIndicatorsFT a
	WHERE a.[CountryName] = [RenewableEnergy].[dbo].[Energy_flatfile].[CountryName]
		AND a.[CountryCode] =[RenewableEnergy].[dbo].[Energy_flatfile].[CountryCode]
		AND a.[Year] = [RenewableEnergy].[dbo].[Energy_flatfile].[Year]
		AND [IndicatorCode] = 'SP_POP_TOTL'
	);

	SELECT * FROM [RenewableEnergy].[dbo].[Energy_flatfile]