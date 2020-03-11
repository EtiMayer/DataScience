/* IncomeGroup One-Hot Encoding*/

CREATE VIEW IncomeGroup_v
AS
SELECT
	CountryCode,
	CASE WHEN (IncomeGroup = "Upper middle income") THEN (1) ELSE (0) End As Upper_middle_income,
	CASE WHEN (IncomeGroup = "Lower middle income") THEN (1) ELSE (0) End As Lower_middle_income,
	CASE WHEN (IncomeGroup = "Low income") THEN (1) ELSE (0) End As Low_income,
	CASE WHEN (IncomeGroup = "High income: nonOECD") THEN (1) ELSE (0) End As High_income_nonOECD
	
FROM
	Country
GROUP BY 
	CountryCode

/*	DROP VIEW IncomeGroup_V */
	
CREATE VIEW EnergyIndicators_v AS
SELECT
	CountryCode,
	CountryName,
	IndicatorCode,
	Year,
	Value,
	Topic,
	Upper_middle_income,
	Lower_middle_income,
	Low_income,
	High_income_nonOECD

FROM Indicators 
LEFT OUTER JOIN Series 
	ON  Indicators.IndicatorName = Series.IndicatorName
	WHERE Series.Topic LIKE '%Environment:%'
LEFT OUTER JOIN IncomeGroup_v 
	ON Indicators.CountryCode = IncomeGroup_v.CountryCode
	
DROP VIEW EnergyIndicators_v

/*Changing IndicatorsCode*/

UPDATE EnergyIndicatorsWB
SET INDICATOR_CODE  = replace (INDICATOR_CODE, '.', '_') 
WHERE INDICATOR_CODE Like '%.%'
;

UPDATE Indicators
SET IndicatorCode  = replace (IndicatorCode, '.', '_') 
WHERE IndicatorCode Like '%.%'
;	

UPDATE EnergyIndicators
SET IndicatorCode  = replace (IndicatorCode, '.', '_') 
WHERE IndicatorCode Like '%.%'
;	

UPDATE EnergyIndicators1
SET IndicatorCode  = replace (IndicatorCode, '.', '_') 
WHERE IndicatorCode Like '%.%'
;

UPDATE EnergyIndicatorsFT
SET IndicatorCode  = replace (IndicatorCode, '.', '_') 
WHERE IndicatorCode Like '%.%'
;



/***************************/
/**     FLAT-FILE         **/
/***************************/

ברקשCREATE VIEW RenewableEnergy_ff
AS
SELECT
country,





FROM
population_total a
INNER JOIN population_density_per_square_km b
	ON a.country=b.country





CREATE TABLE RenewableEnergy_ff ADD COLUMN (
CountryCode VARCHAR(50) PRIMARY KEY,
CountryName VARCHAR(50),
Year NUMERIC NULL, 
PopulationTotal FLOAT NULL,
PopulationGrow FLOAT NULL,

Upper_middle_income NUMERIC NULL,
Lower_middle_income NUMERIC NULL,
Low_income NUMERIC NULL,
High_income_nonOECD NUMERIC NULL,
SP_URB.TOTL.IN.ZS FLOAT NULL,
SP.URB.TOTL FLOAT NULL,
SP.URB.GROW FLOAT NULL,
SI.POV.DDAY FLOAT NULL,
SH.STA.MALN.ZS FLOAT NULL,
SH.MED.CMHW.P3 FLOAT NULL,
SH.DYN.MORT FLOAT NULL,
SE.PRM.CMPT.ZS FLOAT NULL,
SE.ENR.PRSC.FM.ZS FLOAT NULL,
NV.AGR.TOTL.ZS FLOAT NULL,
IQ.CPA.PUBS.XQ FLOAT NULL,
IC.BUS.EASE.XQ FLOAT NULL,
ER.PTD.TOTL.ZS FLOAT NULL,
ER.MRN.PTMR.ZS FLOAT NULL,
ER.LND.PTLD.ZS FLOAT NULL,
ER.H2O.FWTL.ZS FLOAT NULL,
ER.H2O.FWTL.K3 FLOAT NULL,
EN.URB.MCTY.TL.ZS FLOAT NULL,
EN.POP.EL5M.ZS FLOAT NULL,
EN.POP.EL5M.UR.ZS FLOAT NULL,
EN.POP.EL5M.RU.ZS FLOAT NULL,
EN.CLC.MDAT.ZS FLOAT NULL,
EN.CLC.GHGR.MT.CE FLOAT NULL,
EN.CLC.DRSK.XQ FLOAT NULL,
EN.ATM.SF6G.KT.CE FLOAT NULL,
EN.ATM.PFCG.KT.CE FLOAT NULL,
EN.ATM.NOXE.ZG FLOAT NULL,
EN.ATM.NOXE.KT.CE FLOAT NULL,
EN.ATM.METH.ZG FLOAT NULL,
EN.ATM.METH.KT.CE FLOAT NULL,
EN.ATM.HFCG.KT.CE FLOAT NULL,
EN.ATM.GHGT.ZG FLOAT NULL,
EN.ATM.GHGT.KT.CE FLOAT NULL,
EN.ATM.GHGO.ZG FLOAT NULL,
EN.ATM.GHGO.KT.CE FLOAT NULL,
EN.ATM.CO2E.SF.ZS FLOAT NULL,
EN.ATM.CO2E.SF.KT FLOAT NULL,
EN.ATM.CO2E.PP.GD.KD FLOAT NULL,
EN.ATM.CO2E.PP.GD FLOAT NULL,
EN.ATM.CO2E.PC FLOAT NULL,
EN.ATM.CO2E.LF.ZS FLOAT NULL,
EN.ATM.CO2E.LF.KT FLOAT NULL,
EN.ATM.CO2E.KT FLOAT NULL,
EN.ATM.CO2E.KD.GD FLOAT NULL,
EN.ATM.CO2E.GF.ZS FLOAT NULL,
EN.ATM.CO2E.GF.KT FLOAT NULL,
EN.ATM.CO2E.EG.ZS FLOAT NULL,
EG.USE.PCAP.KG.OE FLOAT NULL,
EG.USE.ELEC.KH.PC FLOAT NULL,
EG.USE.COMM.GD.PP.KD FLOAT NULL,
EG.FEC.RNEW.ZS FLOAT NULL,
EG.ELC.RNWX.ZS FLOAT NULL,
EG.ELC.RNWX.KH FLOAT NULL,
EG.ELC.RNEW.ZS FLOAT NULL,
EG.ELC.PETR.ZS FLOAT NULL,
EG.ELC.NUCL.ZS FLOAT NULL,
EG.ELC.NGAS.ZS FLOAT NULL,
EG.ELC.HYRO.ZS FLOAT NULL,
EG.ELC.COAL.ZS FLOAT NULL,
EG.ELC.ACCS.ZS FLOAT NULL,
BX.KLT.DINV.WD.GD.ZS FLOAT NULL,
AG.YLD.CREL.KG FLOAT NULL,
AG.LND.PRCP.MM FLOAT NULL,
AG.LND.IRIG.AG.ZS FLOAT NULL,
AG.LND.FRST.ZS FLOAT NULL,
AG.LND.FRST.K2 FLOAT NULL,
AG.LND.EL5M.ZS FLOAT NULL,
AG.LND.EL5M.UR.ZS FLOAT NULL,
AG.LND.EL5M.UR.K2 FLOAT NULL,
AG.LND.EL5M.RU.ZS FLOAT NULL,
AG.LND.EL5M.RU.K2 FLOAT NULL,
AG.LND.ARBL.ZS FLOAT NULL,
AG.LND.AGRI.ZS FLOAT NULL,
AG.LND.AGRI.K2 FLOAT NULL,


SELECT
	CountryCode,
	ShortName,
	

FROM Country a
LEFT OUTER JOIN Indicators b ON a.Countrycode=b.Countrycode
LEFT OUTER JOIN IncomeGroup c on a.Countrycode =c.Countrycode

	