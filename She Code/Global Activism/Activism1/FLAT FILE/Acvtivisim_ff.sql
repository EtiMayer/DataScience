USE Activism

-- DROP VIEW activist_holdings_v

CREATE VIEW activist_holdings_v AS
SELECT  a.[Investor ID]

--- Activisit Lsit ---
	   ,d.Activist
	   ,d.Headoffice AS ActivistHQ
	   ,CASE WHEN d.Headoffice = 'Bahamas'
			   OR d.Headoffice = 'Barbados'
			   OR d.Headoffice = 'Bermuda'
			   OR d.Headoffice = 'British Virgin Islands'
			   OR d.Headoffice = 'Canada'
			   OR d.Headoffice = 'US' THEN ('NorthAmerica')
			 WHEN d.Headoffice = 'Austria'
			   OR d.Headoffice = 'Belgium'
			   OR d.Headoffice = 'Denmark'
			   OR d.Headoffice = 'Finland'
			   OR d.Headoffice = 'France'
			   OR d.Headoffice = 'Germany'
			   OR d.Headoffice = 'Gibraltar'
			   OR d.Headoffice = 'Guernsey'
			   OR d.Headoffice = 'Ireland'
			   OR d.Headoffice = 'Isle of Man'
			   OR d.Headoffice = 'Italy'
			   OR d.Headoffice = 'Jersey'
			   OR d.Headoffice = 'Liechtenstein'
			   OR d.Headoffice = 'Luxembourg'
			   OR d.Headoffice = 'Monaco'
			   OR d.Headoffice = 'Netherlands'
			   OR d.Headoffice = 'Norway'
			   OR d.Headoffice = 'Portugal'
			   OR d.Headoffice = 'Spain'
			   OR d.Headoffice = 'Sweden'
			   OR d.Headoffice = 'Switzerland'
			   OR d.Headoffice = 'UK' THEN ('WestEurope')
			 WHEN d.Headoffice = 'China'
			   OR d.Headoffice = 'Hong Kong'
			   OR d.Headoffice = 'India'
			   OR d.Headoffice = 'Indonesia'
			   OR d.Headoffice = 'Japan'
			   OR d.Headoffice = 'Korea, Republic of'
			   OR d.Headoffice = 'Malaysia'
			   OR d.Headoffice = 'Mongolia'
			   OR d.Headoffice = 'Singapore'
			   OR d.Headoffice = 'Taiwan'
			   OR d.Headoffice = 'Thailand' THEN ('FarEast')
			 WHEN d.Headoffice = 'Australia'
			   OR d.Headoffice = 'New Zealand' THEN ('AustraliaNZ') ELSE ('RestOfTheWorld') END AS ActivistRegion
	   ,d.Founded
	   ,DATEDIFF(YYYY,2020,d.Founded) AS ActivistYaers
	   ,d.[Activist Holdings] AS ActivistHoldings
	   ,e.[No# of Investments] AS NoOfInv
	   ,e.[Avg# Change Over Period of Investment (%)] AS AvgChangeOverPeriodOfInvByAct
	   ,e.[Avg# Return Annualised (%)] AS AvgReturnAnnualisedByAct
	   ,e.[Avg# S&P Return (%)*] AS AvgSPReturnByAct
	   ,e.[Avg# S&P Return Annualised(%)*] AS AvgSPReturnAnnualisedByAct
	   ,d.[Last Investment] AS LastInv
	   ,DATEDIFF(YYYY,2020,d.[Last Investment]) AS YearsFromLastInv

--- Activisit Holdings ---
-- Focused
	   ,CASE WHEN (a.Focused = 'Concerned Shareholder') THEN (1) ELSE (0) END AS ConcernedShareholder
	   ,CASE WHEN (a.Focused = 'Engagement') THEN (1) ELSE (0) END AS Engagement
	   ,CASE WHEN (a.Focused = 'Occasional') THEN (1) ELSE (0) END AS Occasional
	   ,CASE WHEN (a.Focused = 'Partial Focus') THEN (1) ELSE (0) END AS PartialFocus
	   ,CASE WHEN (a.Focused = 'Primary Focus') THEN (1) ELSE (0) END AS PrimaryFocus

--AUM - Asset Under Management
	   ,a.[AUM $mn] AS ActivistAUM
	   ,d.[AUM Date] AS ActivistAUMDate


-- Company Under Activism 
	   ,a.[Company]
	   ,a.[PID]
	   ,COUNT(DISTINCT(a.PID)) AS PID_COUNT
	   ,a.[Company HQ] AS CompanyHQ
	   ,CASE WHEN  a.[Company HQ] = 'Bahamas' 
				OR a.[Company HQ] = 'Barbados' 
				OR a.[Company HQ] = 'Bermuda' 
				OR a.[Company HQ] = 'British Virgin Islands' 
				OR a.[Company HQ] = 'Canada' 
				OR a.[Company HQ] = 'US' 
				OR a.[Company HQ] = 'US Virgin Islands' THEN ('NorthAmerica')
			 WHEN  a.[Company HQ] = 'Austria' 
				OR a.[Company HQ] = 'Belgium' 
				OR a.[Company HQ] = 'Finland' 
				OR a.[Company HQ] = 'France' 
				OR a.[Company HQ] = 'Germany' 
				OR a.[Company HQ] = 'Gibraltar' 
				OR a.[Company HQ] = 'Iceland' 
				OR a.[Company HQ] = 'Ireland' 
				OR a.[Company HQ] = 'Isle of Man' 
				OR a.[Company HQ] = 'Italy' 
				OR a.[Company HQ] = 'Jersey' 
				OR a.[Company HQ] = 'Luxembourg' 
				OR a.[Company HQ] = 'Monaco' 
				OR a.[Company HQ] = 'Netherlands' 
				OR a.[Company HQ] = 'Norway' 
				OR a.[Company HQ] = 'Portugal' 
				OR a.[Company HQ] = 'Spain' 
				OR a.[Company HQ] = 'Sweden' 
				OR a.[Company HQ] = 'Switzerland' 
				OR a.[Company HQ] = 'UK' THEN ('WestEurope') 
			 WHEN  a.[Company HQ] = 'China' 
				OR a.[Company HQ] = 'Hong Kong' 
				OR a.[Company HQ] = 'India' 
				OR a.[Company HQ] = 'Indonesia' 
				OR a.[Company HQ] = 'Japan' 
				OR a.[Company HQ] = 'Korea, Republic of' 
				OR a.[Company HQ] = 'Malaysia' 
				OR a.[Company HQ] = 'Singapore' 
				OR a.[Company HQ] = 'Taiwan' 
				OR a.[Company HQ] = 'Thailand' 
				OR a.[Company HQ] = 'Vietnam' THEN ('FarEast') ELSE ('RestOfTheWorld') END AS ConpanyRegion
-- Industry 
		,a.[Industry]
		,a.[Sector]
		,b.[No# of Investments] AS NoOfInvByInd
		,b.[Avg# Change Over Period of Investment (%)] AS AvgChangeOverPeriodOfInvByInd
		,b.[Avg# Return Annualised (%)] AS AvgReturnAnnualisedByInd
		,b.[Avg# S&P Return (%)] AS AvgSPReturnByInd
		,b.[Avg# S&P Return Annualised (%)] AS AvgSPReturnAnnualisedByInd

-- Market Cap
		,a.[Market Cap]
		,c.[No# of Investments] AS NoOfInvByMC
		,c.[Avg# Change Over Period of Investment (%)] AS AvgChangeOverPeriodOfInvByMC
		,c.[Avg# Annualised Return (%)] AS AvgAnnualisedReturnByMC
		,c.[Avg# S&P Return (%)] AS AvgSPReturnByMC
		
-- Investment dates
		,f.[Date 13D Filed] AS ThirteenD
		,a.[Date First Invested] AS FirstDateInvestedByActivisit
		,(SELECT DISTINCT COUNT (1) 
		  FROM [ActivistHoldings] 
		  WHERE a.[Date First Invested] BETWEEN DATEADD(YEAR, -5, a.[Date First Invested]) AND DATEADD(DAY,-1,a.[Date First Invested])
		  AND a.Company = (
			  SELECT TOP 1 a.Company
			  FROM [ActivistHoldings]
			  WHERE Company = a.Company)) AS CompanyInv5yCnt

-- Long/Short
		,a.[Long/ Short] AS LongShort

-- Current Holding
		,a.[Current Holding (%)]  AS CurrentHolding
		,CASE WHEN (a.[Status] = 'Current') THEN (1) ELSE (0) END AS StatusCurrent
		,CASE WHEN (a.[Status] = 'Exited') THEN (1) ELSE (0) END AS StatusExisted
		,a.[Date Exited] AS DateExited
		,CASE WHEN DATEDIFF(DAY, a.[Date Exited],a.[Date First Invested])IS NULL THEN (0) ELSE (DATEDIFF(DAY, a.[Date Exited],a.[Date First Invested])) END AS DaysOfInv 
		,a.[Exit Type] AS ExitType

-- Shares
		,a.[Price Per Share] AS AH_PricePerShareLocal
		,a.Currency
		,a.[Price Per Share] * 3.408 AS AH_PricePerShareUSD --as of 31/7/2020
		,a.[Purchase Value (Mn)] AS AH_PruchaseValueMnLocal
		,a.[Purchase Value (Mn)] * 3.408 AS AH_PruchaseValueMnUSD --as of 31/7/2020
		,f.[Price Start Period] AS FR_PriceStart
		,f.[Price End Period] AS FR_PriceEnd
		,f.[Follower Return (%)] AS FollowerReturnPCT
		,f.[Follower Return Annualised (%)] AS FollowerReturnAnnualisedPCT
		,f.[S&P Change (%)] AS SPChangePCT
		,f.[S&P Change Annualised (%)] AS SPChangeAnnualisedPCT
		,f.[% Change in Price Since Exit] AS PriceChangeSinceExitPCT
		,f.[% Change in S&P Since Exit] AS SPChangeSinceExitPCT

-- Activists Demands
		,f.[Gain Board Representation] AS GainBoardRepresentation
		,f.[Adopt Majority Vote Standard] AS AdoptMajorityVoteStandard
		,f.[Amend Bylaw] AS AmendByLaw
		,f.[Amend Listing Status] AS AmendListingStatus
		,f.[Board Independence] AS BoardIndependence
		,f.[Business Focus] AS BusinessFocus
		,f.[Business Restructuring] AS BusinessRestructuring
		,f.[Change Board Composition] AS ChangeBoardComposition
		,f.[Closure of Business Unit] AS ClosureOfBusinessUnit
		,f.[Dividends] AS Dividends
		,f.[Eliminate Staggered Board] AS EliminateStaggeredBoard
		,f.[Equity Issuance] AS EquityIssuance
		,f.[Excess Cash] AS ExcessCash 
		,f.[Focus on Growth Strategies] AS FocusOnGrowthStrategies
		,f.[General Cost Cutting] AS GeneralCostCutting
		,f.[Lack of/Inaccurate Information From Company] AS LackOfInaccurateInformationFromCompany
		,f.[Operational Efficiency] AS OperationalEfficiency
		,f.[Oppose Acquisition of Third Party] AS OpposeAcquisitionOfThirdParty
		,f.[Oppose Equity Issuance] AS OpposeEquityIssuance
		,f.[Oppose Proxy Contest] AS OpposeProxyContest
		,f.[Oppose Sale of Company] AS OpposeSaleOfCompany
		,f.[Push For Acquisition of Third Party] AS PushForAcquisitionOfThirdParty
		,f.[Push for Company Division] AS PushForCompanyDivision
		,f.[Push for Sale of Company] AS PushForSaleOfCompany
		,f.[Push For/Oppose Merging of Shares] AS PushForOpposeMergingOfShares
		,f.[Recapitalization] AS Recapitalization
		,f.[Redemption/Amendment of Poison Pill] AS RedemptionAmendmentOfPoisonPill
		,f.[REIT / MLP Conversion] AS REITorMLPConversion
		,f.[Removal of CEO or Other Board Member] AS RemovalOfCEOorOtherBoardMember
		,f.[Remuneration] AS Remuneration
		,f.[Replace Auditor] AS ReplaceAuditor
		,f.[Replace Management] AS ReplaceManagement
		,f.[Restructure Debt] AS RestructureDebt
		,f.[Return Cash to Shareholders] AS ReturnCashToShareholders
		,f.[Sell/Retain Assets] AS SellOrRetainAssets
		,f.[Separate Chairman & CEO] AS SeparateChairmanAndCEO
		,f.[Share Repurchase] AS ShareRepurchase
		,f.[Spin-Off/Sale of Business Division] AS SpinOffSaleOfBusinessDivision
		,f.[Succession Planning] AS SuccessionPlanning
		,f.[Terminate Investment Advisory Agreement] AS TerminateInvestmentAdvisoryAgreement
		,f.[Under Leverage] AS UnderLeverage
		,f.[Use Universal Ballot] AS UseUniversalBallot

-- Company Response
	    ,MAX(CASE WHEN (g.Response = 'AGM') THEN (1) ELSE (0) END) AS AGM
		,MAX(CASE WHEN (g.Response = 'Activist Withdrew Demands') THEN (1) ELSE (0) END) AS ActivistWithdrewDemands
		,MAX(CASE WHEN (g.Response = 'N/A') THEN (1) ELSE (0) END) AS NA
		,MAX(CASE WHEN (g.Response = 'AGM Result') THEN (1) ELSE (0) END) AS AGMResult
		,MAX(CASE WHEN (g.Response = 'Merger Completed') THEN (1) ELSE (0) END) AS MergerCompleted 
		,MAX(CASE WHEN (g.Response = 'EGM/Special Meeting') THEN (1) ELSE (0) END) AS EGMorSpecialMeeting
		,MAX(CASE WHEN (g.Response = 'Proxy Contest') THEN (1) ELSE (0) END) AS ProxyContest
		,MAX(CASE WHEN (g.Response = 'Activist Exits Stock') THEN (1) ELSE (0) END) AS ActivistExitsStock
		,MAX(CASE WHEN (g.Response = 'Merger or Takeover') THEN (1) ELSE (0) END) AS MergerOrTakeover
		,MAX(CASE WHEN (g.Response = 'Met with Activist''s Demands in Full') THEN (1) ELSE (0) END) AS MetWithDemandsInFull
		,MAX(CASE WHEN (g.Response = 'Public Disagreement') THEN (1) ELSE (0) END) AS PublicDisagreement
		,MAX(CASE WHEN (g.Response = 'No Public Response') THEN (1) ELSE (0) END) AS NoPublicResponse
		,MAX(CASE WHEN (g.Response = 'Compromise/Came to an Agreement') THEN (1) ELSE (0) END) AS CompromiseOrAgreement
		,MAX(CASE WHEN (g.Response = 'Shareholder Vote') THEN (1) ELSE (0) END) AS ShareholderVote
		,MAX(CASE WHEN (g.Response = 'Company Hires/Fires/Resignations') THEN (1) ELSE (0) END) AS CompanyHiresFiresResignations
		,MAX(CASE WHEN (g.Response = 'AGM') THEN (1) ELSE (0) END) AS ActivistHiresFiresResignations
		,MAX(CASE WHEN (g.Response = 'Engaged Activist Positively') THEN (1) ELSE (0) END) AS EngagedActivistPositively
		,MAX(CASE WHEN (g.Response = 'New CEO Appointed') THEN (1) ELSE (0) END) AS NewCEOAppointed
		,MAX(CASE WHEN (g.Response = 'Company Rejects Takeover Bid') THEN (1) ELSE (0) END) AS CompanyRejectsTakeoverBid
		,MAX(CASE WHEN (g.Response = 'Company Rejects Special Meeting') THEN (1) ELSE (0) END) AS CompanyRejectsSpecialMeeting
		,MAX(CASE WHEN (g.Response = 'Meetings with Board/Management') THEN (1) ELSE (0) END) AS MeetingsWithBoardOrManagement
		,MAX(CASE WHEN (g.Response = 'Activist Writes to Regulator') THEN (1) ELSE (0) END) AS ActivistWritesToRegulator
		,MAX(CASE WHEN (g.Response = 'Communication With Shareholders') THEN (1) ELSE (0) END) AS CommunicationWithShareholders
		,MAX(CASE WHEN (g.Response = 'Went to Vote - Let Shareholders Decide') THEN (1) ELSE (0) END) AS WentToVote
		,MAX(CASE WHEN (g.Response = 'Job Cuts') THEN (1) ELSE (0) END) AS JobCuts
		,MAX(CASE WHEN (g.Response = 'Sought external advice') THEN (1) ELSE (0) END) AS ExternalAdvice
		,MAX(CASE WHEN (g.Response = 'CEO/Chairman Departs') THEN (1) ELSE (0) END) AS CEOorChairmanDeparts
		,MAX(CASE WHEN (g.Response = 'Activist appeals to regulator/courts') THEN (1) ELSE (0) END) AS ActivistAppealsToRegulatorOrCourts
		,MAX(CASE WHEN (g.Response = 'Lawsuit') THEN (1) ELSE (0) END) AS Lawsuit
		,MAX(CASE WHEN (g.Response = 'Dividends') THEN (1) ELSE (0) END) AS CR_Dividends
		,MAX(CASE WHEN (g.Response = 'Dividend or Share Repurchase Change') THEN (1) ELSE (0) END) AS DividendOrShareRepurchaseChange
		,MAX(CASE WHEN (g.Response = 'Company Makes Acquisition') THEN (1) ELSE (0) END) AS CompanyMakesAcquisition
		,MAX(CASE WHEN (g.Response = 'Company Releases Financials') THEN (1) ELSE (0) END) AS CompanyReleasesFinancials
		,MAX(CASE WHEN (g.Response = 'Welcomed Activist') THEN (1) ELSE (0) END) AS WelcomedActivist
		,MAX(CASE WHEN (g.Response = 'Bankruptcy') THEN (1) ELSE (0) END) AS Bankruptcy
		,MAX(CASE WHEN (g.Response = 'Proxy Access') THEN (1) ELSE (0) END) AS ProxyAccess
		,MAX(CASE WHEN (g.Response = 'Implement/Amend Poison Pill') THEN (1) ELSE (0) END) AS ImplementAmendPoisonPill
		,MAX(CASE WHEN (g.Response = 'Activist wins board seats') THEN (1) ELSE (0) END) AS ActivistWinsBoardSeats
		,MAX(CASE WHEN (g.Response = 'Activist nominates board members') THEN (1) ELSE (0) END) AS ActivistNominatesBoardMembers
		,MAX(CASE WHEN (g.Response = 'Thanked Activist') THEN (1) ELSE (0) END) AS ThankedActivist
		,MAX(CASE WHEN (g.Response = 'Shareholder Proposal') THEN (1) ELSE (0) END) AS ShareholderProposal
		,MAX(CASE WHEN (g.Response = 'Results of Tender Offer') THEN (1) ELSE (0) END) AS TenderOffer
		,MAX(CASE WHEN (g.Response = 'Activist Drops Below Reporting Threshold') THEN (1) ELSE (0) END) AS ActivistDropsBelowReportingThreshold
		,MAX(CASE WHEN (g.Response = 'New Merger Announced ') THEN (1) ELSE (0) END) AS NewMergerAnnounced 
		,MAX(CASE WHEN (g.Response = 'Proxy advisor verdict') THEN (1) ELSE (0) END) AS ProxyAdvisorVerdict
		,MAX(CASE WHEN (g.Response = 'Activist Statement') THEN (1) ELSE (0) END) AS ActivistStatement
		,MAX(CASE WHEN (g.Response = 'Poison Pill Implemented') THEN (1) ELSE (0) END) AS PoisonPillImplemented
		,MAX(CASE WHEN (g.Response = 'Filed Lawsuit Against Activist') THEN (1) ELSE (0) END) AS LawsuitAgainstActivist
		,MAX(CASE WHEN (g.Response = 'Letter to Fellow Shareholders') THEN (1) ELSE (0) END) AS LetterToFellowShareholders
		,MAX(CASE WHEN (g.Response = 'Activist Nominees Appointed to Board') THEN (1) ELSE (0) END) AS ActivistNomineesAppointedToBoard
		,MAX(CASE WHEN (g.Response = 'Settlement Agreement Concluded') THEN (1) ELSE (0) END) AS SettlementAgreementConcluded
		,MAX(CASE WHEN (g.Response = 'Letter to Board/Management') THEN (1) ELSE (0) END) AS LetterToBoardOrManagement
		,MAX(CASE WHEN (g.Response = 'Company Rejects Board Nominations') THEN (1) ELSE (0) END) AS CompanyRejectsBoardNominations
		,MAX(CASE WHEN (g.Response = 'Delay Shareholder Meeting') THEN (1) ELSE (0) END) AS DelayShareholderMeeting
		,MAX(CASE WHEN (g.Response = 'Close Fund') THEN (1) ELSE (0) END) AS CloseFund
		,MAX(CASE WHEN (g.Response = 'Closed AGM') THEN (1) ELSE (0) END) AS ClosedAGM
		,MAX(CASE WHEN (g.Response = 'Activist Issues Public Letter') THEN (1) ELSE (0) END) AS ActivistIssuesPublicLetter
		,MAX(CASE WHEN (g.Response = 'Activist Letter to Regulatory Bodies') THEN (1) ELSE (0) END) AS ActivistLetterToRegulatoryBodies
		,MAX(CASE WHEN (g.Response = 'Litigation Initiated') THEN (1) ELSE (0) END) AS LitigationInitiated
		,MAX(CASE WHEN (g.Response = 'Consent Solicitation Initiated') THEN (1) ELSE (0) END) AS ConsentSolicitationInitiated
		,MAX(CASE WHEN (g.Response = 'SEC Filing') THEN (1) ELSE (0) END) AS SECFiling

-- Seats
		,g.[Seats Proposed (Gain Board Representation Only)] AS SeatsProposed
		,g.[Seats Gained (Gain Board Representation Only)] AS SeatsGained
		,g.[Seats Gained Method  (Gain Board Representation Only)] AS SeatsGainedMethod
		
-- Campaign Outcomes
		,f.[Ongoing] AS Ongoing
		,f.[Activist Withdrew Demands] AS WithdrewDemands
		,f.[Activist's Objectives Partially Successful] AS PartiallySuccessful
		,f.[Activist's Objectives Successful] AS Successful
		,f.[Activist's Objectives Unsuccessful] AS Unsuccessful
		,f.[Compromise / Settlement] AS CompromiseOrSettlement
		,f.[Unresolved] AS Unresolved
				
-- Buyer
		,a.Buyer
		,a.[Public Demand] AS PublicDemand
   
FROM [ActivistHoldingsFix] AS a
LEFT OUTER JOIN 
	 [FR_Industry] b
ON a.[Sector] = b.[Industry Sector]
LEFT OUTER JOIN 
	 [FR_MarketCap] c
ON a.[Category] = c.[Market Cap]
LEFT OUTER JOIN
	 [ActivistList] d
ON a.[Investor ID] = d.[Investor ID]
LEFT OUTER JOIN
	 [FR_ActivistList] e
ON a.[Investor ID] = e.[Investor ID] 
LEFT OUTER JOIN 
     [FR_Investments] f
ON a.[Investor ID] = f.[Investor ID] AND a.PID = f.PID
LEFT OUTER JOIN 
	 [ActivistsDemands] g
ON a.[Investor ID] = g.[Investor ID] AND a.PID = g.PID


GROUP BY a.[Investor ID]
		,d.Activist
		,d.Headoffice
		,d.Founded
		,d.[Activist Holdings]
	    ,e.[No# of Investments]
	    ,e.[Avg# Change Over Period of Investment (%)]
	    ,e.[Avg# Return Annualised (%)]
	    ,e.[Avg# S&P Return (%)*]
	    ,e.[Avg# S&P Return Annualised(%)*]
	    ,d.[Last Investment]
		,a.[Focused]
		,a.[AUM $mn]
	    ,d.[AUM Date]
		,a.[Company]
	    ,a.[PID]
		,a.[Company HQ]
	    ,a.[Industry]
		,a.[Sector]
		,b.[No# of Investments]
		,b.[Avg# Change Over Period of Investment (%)]
		,b.[Avg# S&P Return (%)]
		,b.[Avg# Return Annualised (%)]
		,b.[Avg# S&P Return Annualised (%)]
		,a.[Market Cap]
		,c.[No# of Investments]
		,c.[Avg# Change Over Period of Investment (%)]
		,c.[Avg# Annualised Return (%)]
		,c.[Avg# S&P Return (%)]
		,f.[Date 13D Filed]
		,a.[Date First Invested]
		,a.[Long/ Short]
		,a.[Current Holding (%)]
		,a.[Status]
		,a.[Date Exited]
		,a.[Exit Type]
		,a.[Price Per Share]
		,a.Currency
		,a.[Price Per Share]
		,a.[Purchase Value (Mn)]
		,f.[Price Start Period]
		,f.[Price End Period]
		,f.[Follower Return (%)]
		,f.[Follower Return Annualised (%)]
		,f.[S&P Change (%)]
		,f.[S&P Change Annualised (%)]
		,f.[% Change in Price Since Exit]
		,f.[% Change in S&P Since Exit]
		,f.[Gain Board Representation]
		,f.[Adopt Majority Vote Standard]
		,f.[Amend Bylaw]
		,f.[Amend Listing Status]
		,f.[Board Independence]
		,f.[Business Focus]
		,f.[Business Restructuring]
		,f.[Change Board Composition]
		,f.[Closure of Business Unit]
		,f.[Dividends]
		,f.[Eliminate Staggered Board]
		,f.[Equity Issuance]
		,f.[Excess Cash]
		,f.[Focus on Growth Strategies]
		,f.[General Cost Cutting]
		,f.[Lack of/Inaccurate Information From Company]
		,f.[Operational Efficiency]
		,f.[Oppose Acquisition of Third Party]
		,f.[Oppose Equity Issuance]
		,f.[Oppose Proxy Contest]
		,f.[Oppose Sale of Company]
		,f.[Push For Acquisition of Third Party]
		,f.[Push for Company Division]
		,f.[Push for Sale of Company]
		,f.[Push For/Oppose Merging of Shares]
		,f.[Recapitalization]
		,f.[Redemption/Amendment of Poison Pill]
		,f.[REIT / MLP Conversion]
		,f.[Removal of CEO or Other Board Member]
		,f.[Remuneration]
		,f.[Replace Auditor]
		,f.[Replace Management]
		,f.[Restructure Debt]
		,f.[Return Cash to Shareholders]
		,f.[Sell/Retain Assets]
		,f.[Separate Chairman & CEO]
		,f.[Share Repurchase]
		,f.[Spin-Off/Sale of Business Division]
		,f.[Succession Planning]
		,f.[Terminate Investment Advisory Agreement]
		,f.[Under Leverage]
		,f.[Use Universal Ballot]
		,g.Response
		,g.[Seats Proposed (Gain Board Representation Only)]
		,g.[Seats Gained (Gain Board Representation Only)]
		,g.[Seats Gained Method  (Gain Board Representation Only)]
		,f.[Ongoing]
		,f.[Activist Withdrew Demands]
		,f.[Activist's Objectives Partially Successful]
		,f.[Activist's Objectives Successful]
		,f.[Activist's Objectives Unsuccessful]
		,f.[Compromise / Settlement]
		,f.[Unresolved]
		,a.Buyer
		,a.[Public Demand] 


SELECT * FROM activist_holdings_v

------------------------------------------------------------------------------------------
ניסיון להמיר את העמודה לflaot
UPDATE ActivistHoldings 
 SET  [Current Holding (%)] = CASE WHEN [Current Holding (%)] = '<0.01' THEN ('0.0099') 
								   WHEN [Current Holding (%)] = '<1.00' THEN ('0.99')
							       WHEN [Current Holding (%)] = '<3.00' THEN ('2.99')
								   WHEN [Current Holding (%)] = '<5.00' THEN ('4.99')
								   WHEN [Current Holding (%)] = '<8.00' THEN ('7.99') 
								   ELSE ([Current Holding (%)]) 
							   END
WHERE [Current Holding (%)] IN ('<0.01','<1.00','<3.00','<5.00','<8.00')

UPDATE ActivistHoldings SET [Current Holding (%)]  = ISNULL( CAST ([Current Holding (%)] AS FLOAT),NULL)

SELECT ISNUMERIC([Current Holding (%)]) FROM ActivistHoldings
SELECT ISNULL([Current Holding (%)],NULL) FROM ActivistHoldings

ASE WHEN  a.[Company HQ] = 'Bahamas' 
				OR a.[Company HQ] = 'Barbados' 
				OR a.[Company HQ] = 'Bermuda' 
				OR a.[Company HQ] = 'British Virgin Islands' 
				OR a.[Company HQ] = 'Canada' 
				OR a.[Company HQ] = 'US' 
				OR a.[Company HQ] = 'US Virgin Islands' THEN ('NorthAmerica')



DELETE FROM ActivistHoldings
WHERE [Investor ID] IS NULL

SELECT   
    CASE WHEN TRY_CAST(DBO.aCTIVISTHOLDINGS.[INVESTOR ID] AS nvarchar) IS NULL   
    THEN 'Cast failed'  
    ELSE 'Cast succeeded'  
END AS Result;  



SELECT [Industry Sector],
[No# of Investments],
((([No# of Investments] )* 1.0) / SUM([No# of Investments] )TOTAL * 1.0)*100.0
FROM FR_Industry
Group By [Industry Sector],
[No# of Investments]

ALTER TABLE FR_MarketCap 
ADD MarketCapCategory varchar
UPDATE FR_MarketCap
SET [Market Cap] =  CASE
							 WHEN ([Market Cap] = 'Large Cap (>$10bn)') THEN ('Large-Cap')
							 WHEN ([Market Cap] = 'Micro-cap ($50-250mn)') THEN ('Micro-Cap')
							 WHEN ([Market Cap] = 'Mid-cap ($2-10bn)') THEN ('Mid-Cap')
	                         WHEN ([Market Cap] = 'Nano Cap (<$50mn)') THEN ('Nano-Cap') 
							 ELSE ('Small-Cap')
						 END 
WHERE [Market Cap] IN ('Large Cap (>$10bn)','Micro-cap ($50-250mn)','Mid-cap ($2-10bn)','Nano Cap (<$50mn)','Small-cap ($250-2bn)')


SELECT * FROM FR_Demands WHERE [Investor ID] IS NOT NULL Order By [Investor ID] 


