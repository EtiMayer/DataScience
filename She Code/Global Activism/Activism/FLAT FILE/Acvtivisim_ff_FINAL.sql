USE Activism

-- DROP VIEW activist_holdings_v

CREATE VIEW activist_holdings_v_SC AS
SELECT  a.[Investor ID]

--- Activisit Lsit ---
	   ,a.Activist
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
	   ,CAST (i.[Date First Invested] AS date) AS FirstDateInvestedByActivisit
-- Current Holding
		,i.[Current Holding (%)]  AS CurrentHolding
		,CAST( CASE WHEN (a.[Status] = 'Current') THEN (1) ELSE (0) END AS binary) AS StatusCurrent
		,CASE WHEN (a.[Status] = 'Exited') THEN (1) ELSE (0) END AS StatusExisted
		,CAST (j.[Exited] AS Date) AS DateExited 
--		,CASE WHEN DATEDIFF(DAY, a.[Exited],i.[Date First Invested])IS NULL THEN (0) ELSE (DATEDIFF(DAY, a.[Exited],i.[Date First Invested])) END AS DaysOfInv 
		,i.[Exit Type] AS ExitType

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

--	   ,DATEDIFF(YYYY,2020,d.Founded) AS ActivistYaers

-- Shares				
		,i.[Price Per Share] AS AH_PricePerShareLocal
		,i.Currency
--		,CASE WHEN i.Currency = 'USD' THEN i.[Price Per Share] ELSE i.[Price Per Share] * 3.408 END AS AH_PricePerShareUSD --as of 31/7/2020
		,i.[Purchase Value (Mn)] AS AH_PruchaseValueMnLocal
--		,CASE WHEN i.Currency = 'USD' THEN i.[Purchase Value (Mn)] ELSE i.[Purchase Value (Mn)]* 3.408 END AS AH_PruchaseValueMnUSD --as of 31/7/2020
		,a.[Price Start Period] AS FR_PriceStart
		,a.[Price End Period] AS FR_PriceEnd
		,a.[% Change in Price Since Exit] AS PriceChangeSinceExitByCamp
		,a.[% Change in S&P Since Exit] AS SPChangeSinceExitByCamp

--- Activist Return
	   ,e.[Avg# Change Over Period of Investment (%)] AS AvgChangeOverPeriodOfInvByAct
	   ,e.[Avg# Return Annualised (%)] AS AvgReturnAnnualisedByAct
	   ,e.[Avg# S&P Return (%)*] AS AvgSPReturnByAct
	   ,e.[Avg# S&P Return Annualised(%)*] AS AvgSPReturnAnnualisedByAct
	   ,e.[Avg# Change Over Period of Investment (%)] - e.[Avg# S&P Return (%)*] AS ExcessReturnByAct
	   ,d.[Last Investment] AS LastInv
--	   ,DATEDIFF(YEAR,YEAR(2020),d.[Last Investment])-109 AS YearsFromLastInv


-- Campaigns

		,a.[Follower Return (%)] AS ReturnByCamp
		,a.[Follower Return Annualised (%)] AS ReturnAnnualisedByCamp
		,a.[S&P Change (%)] AS SPChangeByCamp
		,a.[S&P Change Annualised (%)] AS SPChangeAnnualisedByCamp
		,COUNT (a.[Investor ID]) OVER (PARTITION BY a.[Investor ID]) AS NoOfCamp
		,(COUNT (CASE WHEN a.[Follower Return (%)] - a.[S&P Change (%)]   > 0 
				 THEN a.[Investor ID] ELSE NULL END) 
				 OVER (PARTITION BY a.[Investor ID])) AS PositiveReturnByCamp
		,a.[Follower Return (%)] - a.[S&P Change (%)]  AS ExcessReturnByCamp
		,CAST((COUNT (CASE WHEN a.[Follower Return (%)] - a.[S&P Change (%)]   > 0 
					  THEN a.[Investor ID] ELSE NULL END) 
					  OVER (PARTITION BY a.[Investor ID])) AS decimal(38,2))
					  /(CAST (COUNT (a.[Investor ID]) 
					  OVER (PARTITION BY a.[Investor ID])  AS decimal(8,2))) AS HitRatioByAct
		,COUNT (CASE WHEN YEAR(i.[Date First Invested]) >= 2018 
		        THEN 1 ELSE NULL END) 
				OVER (PARTITION BY a.[Investor ID]) AS NoOfCamp3Y
		,(COUNT (CASE WHEN a.[Follower Return (%)] - a.[S&P Change (%)]   > 0 AND YEAR(i.[Date First Invested]) >= 2018  
				 THEN a.[Investor ID] ELSE NULL END) 
				 OVER (PARTITION BY a.[Investor ID])) AS PositiveReturnByCamp3Y
		,CASE WHEN (COUNT (CASE WHEN a.[Follower Return (%)] - a.[S&P Change (%)]   > 0 AND YEAR(i.[Date First Invested]) >= 2018  
				 THEN a.[Investor ID] ELSE NULL END) 
				 OVER (PARTITION BY a.[Investor ID])) <= 0
		 THEN 0 ELSE (CAST((COUNT (CASE WHEN a.[Follower Return (%)] - a.[S&P Change (%)]   > 0 AND YEAR(i.[Date First Invested]) >= 2018 
					  THEN a.[Investor ID] ELSE NULL END) 
					  OVER (PARTITION BY a.[Investor ID])) AS decimal(38,2))
					  /(CAST (COUNT (CASE WHEN YEAR(i.[Date First Invested]) >= 2018 
									 THEN 1 ELSE NULL END) 
									 OVER (PARTITION BY a.[Investor ID])  AS decimal(8,2))))END AS HitRatioByAct3Y
		

-- Industry 
		,i.[Industry]
		,i.[Sector]
/*		,CASE WHEN a.Industry = 'Major Integrated Oil & Gas'
				OR a.Industry = 'Oil & Gas Drilling & Exploration'
				OR a.Industry = 'Oil & Gas Equipment & Services'
				OR a.Industry = 'Oil & Gas Pipelines'
				OR a.Industry = 'Independent Oil & Gas'
				OR a.Industry = 'Oil & Gas Refining & Marketing' THEN ('Basic Materials - Oil & Gas')
			  WHEN a.Industry = 'Semiconductor Equipment & Materials'
			    OR a.Industry = 'Semiconductor - Integrated Circuits'
				OR a.Industry = 'Printed Circuit Boards'
				OR a.Industry = 'Semiconductor- Memory Chips'
				OR a.Industry = 'Semiconductor - Broad Line'
				OR a.Industry = 'Semiconductor - Specialized' THEN ('Semiconductor')
			 ELSE a.Sector END AS SectorNEW */
		,(COUNT (a.[Investor ID]) OVER (PARTITION BY a.[Investor ID] ,i.[Sector])) AS CampByIND
		,(COUNT (CASE WHEN a.[Follower Return (%)] - a.[S&P Change (%)]  > 0 
				 THEN a.[Investor ID] ELSE NULL END) 
				 OVER (PARTITION BY a.[Investor ID], i.[Sector])) AS PositiveReturnByIND
		,CAST((COUNT (CASE WHEN  a.[Follower Return (%)] - a.[S&P Change (%)]  > 0 
					  THEN a.[Investor ID] ELSE NULL END) 
					  OVER (PARTITION BY a.[Investor ID], i.[Sector])) AS decimal(5,2))
					  /CAST (COUNT (a.[Investor ID]) 
					  OVER (PARTITION BY a.[Investor ID] ,i.[Sector]) AS decimal(5,2)) AS HitRatioByIND
		,COUNT (CASE WHEN YEAR(i.[Date First Invested]) >= 2018 
				THEN 1 ELSE NULL  END) 
				OVER (PARTITION BY a.[Investor ID],i.[Sector]) AS CampByIND3Y
		,(COUNT (CASE WHEN a.[Follower Return (%)] - a.[S&P Change (%)]   > 0 AND YEAR(i.[Date First Invested]) >= 2018  
				 THEN a.[Investor ID] ELSE NULL END) 
				 OVER (PARTITION BY a.[Investor ID],i.[Sector])) AS PositiveReturnByIND3Y
		,CASE WHEN (COUNT (CASE WHEN a.[Follower Return (%)] - a.[S&P Change (%)]   > 0 AND YEAR(i.[Date First Invested]) >= 2018  
				 THEN a.[Investor ID] ELSE NULL END) 
				 OVER (PARTITION BY a.[Investor ID],i.[Sector])) <= 0
		 THEN 0 ELSE (CAST((COUNT (CASE WHEN a.[Follower Return (%)] - a.[S&P Change (%)]   > 0 AND YEAR(i.[Date First Invested]) >= 2018 
					  THEN a.[Investor ID] ELSE NULL END) 
					  OVER (PARTITION BY a.[Investor ID],i.[Sector])) AS decimal(38,2))
					  /(CAST (COUNT (CASE WHEN YEAR(i.[Date First Invested]) >= 2018 
									 THEN 1 ELSE NULL END) 
									 OVER (PARTITION BY a.[Investor ID],i.[Sector])  AS decimal(8,2)))) END AS HitRatioByIND3Y
		,b.[No# of Investments] AS NoOfInvByIND
		,b.[Avg# Change Over Period of Investment (%)] AS AvgChangeOverPeriodOfInvByIND
		,b.[Avg# Return Annualised (%)] AS AvgReturnAnnualisedByIND
		,b.[Avg# S&P Return (%)] AS AvgSPReturnByIND
		,b.[Avg# S&P Return Annualised (%)] AS AvgSPReturnAnnualisedByIND
		
-- Market Cap
		,a.[Market Cap ($MN)] AS MarketCap
		,a.MarketCapCategory
		,(COUNT (a.[Investor ID]) OVER (PARTITION BY a.[Investor ID], a.MarketCapCategory)) AS CampByMC
		,(COUNT (CASE WHEN a.[Follower Return (%)] - a.[S&P Change (%)]  > 0 
				 THEN a.[Investor ID] ELSE NULL END) 
				 OVER (PARTITION BY a.[Investor ID], a.MarketCapCategory)) AS PositiveReturnByMC
		,CAST((COUNT (CASE WHEN  a.[Follower Return (%)] - a.[S&P Change (%)]  > 0 
					  THEN a.[Investor ID] ELSE NULL END) 
					  OVER (PARTITION BY a.[Investor ID], a.MarketCapCategory)) AS decimal(5,2))
					  /CAST (COUNT (a.[Investor ID]) 
					  OVER (PARTITION BY a.[Investor ID], a.MarketCapCategory) AS decimal(5,2) ) AS HitRatioByMC
		,COUNT (CASE WHEN YEAR(i.[Date First Invested]) >= 2018 
				THEN 1 ELSE NULL END) 
				OVER (PARTITION BY a.[Investor ID],a.MarketCapCategory) AS CampByMC3Y
		,(COUNT (CASE WHEN a.[Follower Return (%)] - a.[S&P Change (%)]   > 0 AND YEAR(i.[Date First Invested]) >= 2018  
				 THEN a.[Investor ID] ELSE NULL END) 
				 OVER (PARTITION BY a.[Investor ID],a.MarketCapCategory)) AS PositiveReturnByMC3Y
		,CASE WHEN (COUNT (CASE WHEN a.[Follower Return (%)] - a.[S&P Change (%)]   > 0 AND YEAR(i.[Date First Invested]) >= 2018  
				 THEN a.[Investor ID] ELSE NULL END) 
				 OVER (PARTITION BY a.[Investor ID],a.MarketCapCategory)) <= 0 
		 THEN 0 ELSE (CAST((COUNT (CASE WHEN a.[Follower Return (%)] - a.[S&P Change (%)]   > 0 AND YEAR(i.[Date First Invested]) >= 2018 
									 THEN a.[Investor ID] ELSE NULL END) 
									 OVER (PARTITION BY a.[Investor ID],a.MarketCapCategory)) AS decimal(38,2))
									 /(CAST (COUNT (CASE WHEN YEAR(i.[Date First Invested]) >= 2018 
													THEN 1 ELSE NULL END) 
													OVER (PARTITION BY a.[Investor ID],a.MarketCapCategory)  AS decimal(8,2)))) END AS HitRatioByMC3Y

		,c.[No# of Investments] AS NoOfInvByMC
		,c.[Avg# Change Over Period of Investment (%)] AS AvgChangeOverPeriodOfInvByMC
		,c.[Avg# Annualised Return (%)] AS AvgAnnualisedReturnByMC
		,c.[Avg# S&P Return (%)] AS AvgSPReturnByMC


--- Activisit Holdings ---
-- Focused
	   ,CASE WHEN (i.Focused = 'Concerned Shareholder') THEN (1) ELSE (0) END AS ConcernedShareholder
	   ,CASE WHEN (i.Focused = 'Engagement') THEN (1) ELSE (0) END AS Engagement
	   ,CASE WHEN (i.Focused = 'Occasional') THEN (1) ELSE (0) END AS Occasional
	   ,CASE WHEN (i.Focused = 'Partial Focus') THEN (1) ELSE (0) END AS PartialFocus
	   ,CASE WHEN (i.Focused = 'Primary Focus') THEN (1) ELSE (0) END AS PrimaryFocus

--AUM - Asset Under Management
	   ,d.[AUM $mn] AS ActivistAUM
	   ,d.[AUM Date] AS ActivistAUMDate


-- Investment dates
		,a.[Date 13D Filed] AS ThirteenD
		

-- Long/Short
		,CASE WHEN (a.[Long / Short] = 'Long' ) THEN (1) ELSE (0) END AS Long


-- Activists Demands
		,CASE WHEN (a.[Gain Board Representation] = 'No') THEN (0) ELSE (1) END AS GainBoardRepresentation
		,CASE WHEN (a.[Adopt Majority Vote Standard] = 'No') THEN (0) ELSE (1) END AS AdoptMajorityVoteStandard
		,CASE WHEN (a.[Amend Bylaw] = 'No') THEN (0) ELSE (1) END AS AmendByLaw
		,CASE WHEN (a.[Amend Listing Status] = 'No') THEN (0) ELSE (1) END AS AmendListingStatus
		,CASE WHEN (a.[Board Independence] = 'No') THEN (0) ELSE (1) END AS BoardIndependence
		,CASE WHEN (a.[Business Focus] = 'No') THEN (0) ELSE (1) END AS BusinessFocus
		,CASE WHEN (a.[Business Restructuring] = 'No') THEN (0) ELSE (1) END AS BusinessRestructuring
		,CASE WHEN (a.[Change Board Composition] = 'No') THEN (0) ELSE (1) END AS ChangeBoardComposition
		,CASE WHEN (a.[Closure of Business Unit] = 'No') THEN (0) ELSE (1) END AS ClosureOfBusinessUnit
		,CASE WHEN (a.[Dividends] = 'No') THEN (0) ELSE (1) END AS Dividends
		,CASE WHEN (a.[Eliminate Staggered Board] = 'No') THEN (0) ELSE (1) END AS EliminateStaggeredBoard
		,CASE WHEN (a.[Equity Issuance] = 'No') THEN (0) ELSE (1) END AS EquityIssuance
		,CASE WHEN (a.[Excess Cash] = 'No') THEN (0) ELSE (1) END AS ExcessCash 
		,CASE WHEN (a.[Focus on Growth Strategies] = 'No') THEN (0) ELSE (1) END AS FocusOnGrowthStrategies
		,CASE WHEN (a.[General Cost Cutting] = 'No') THEN (0) ELSE (1) END AS GeneralCostCutting
		,CASE WHEN (a.[Lack of/Inaccurate Information From Company] = 'No') THEN (0) ELSE (1) END AS LackOfInaccurateInformationFromCompany
		,CASE WHEN (a.[Operational Efficiency] = 'No') THEN (0) ELSE (1) END AS OperationalEfficiency
		,CASE WHEN (a.[Oppose Acquisition of Third Party] = 'No') THEN (0) ELSE (1) END AS OpposeAcquisitionOfThirdParty
		,CASE WHEN (a.[Oppose Equity Issuance] = 'No') THEN (0) ELSE (1) END AS OpposeEquityIssuance
		,CASE WHEN (a.[Oppose Proxy Contest] = 'No') THEN (0) ELSE (1) END AS OpposeProxyContest
		,CASE WHEN (a.[Oppose Sale of Company] = 'No') THEN (0) ELSE (1) END AS OpposeSaleOfCompany
		,CASE WHEN (a.[Push For Acquisition of Third Party] = 'No') THEN (0) ELSE (1) END AS PushForAcquisitionOfThirdParty
		,CASE WHEN (a.[Push for Company Division] = 'No') THEN (0) ELSE (1) END AS PushForCompanyDivision
		,CASE WHEN (a.[Push for Sale of Company] = 'No') THEN (0) ELSE (1) END AS PushForSaleOfCompany
		,CASE WHEN (a.[Push For/Oppose Merging of Shares] = 'No') THEN (0) ELSE (1) END AS PushForOpposeMergingOfShares
		,CASE WHEN (a.[Recapitalization] = 'No') THEN (0) ELSE (1) END AS Recapitalization
		,CASE WHEN (a.[Redemption/Amendment of Poison Pill] = 'No') THEN (0) ELSE (1) END AS RedemptionAmendmentOfPoisonPill
		,CASE WHEN (a.[REIT / MLP Conversion] = 'No') THEN (0) ELSE (1) END AS REITorMLPConversion
		,CASE WHEN (a.[Removal of CEO or Other Board Member] = 'No') THEN (0) ELSE (1) END AS RemovalOfCEOorOtherBoardMember
		,CASE WHEN (a.[Remuneration] = 'No') THEN (0) ELSE (1) END AS Remuneration
		,CASE WHEN (a.[Replace Auditor] = 'No') THEN (0) ELSE (1) END AS ReplaceAuditor
		,CASE WHEN (a.[Replace Management] = 'No') THEN (0) ELSE (1) END AS ReplaceManagement
		,CASE WHEN (a.[Restructure Debt] = 'No') THEN (0) ELSE (1) END AS RestructureDebt
		,CASE WHEN (a.[Return Cash to Shareholders] = 'No') THEN (0) ELSE (1) END AS ReturnCashToShareholders
		,CASE WHEN (a.[Sell/Retain Assets] = 'No') THEN (0) ELSE (1) END AS SellOrRetainAssets
		,CASE WHEN (a.[Separate Chairman & CEO] = 'No') THEN (0) ELSE (1) END AS SeparateChairmanAndCEO
		,CASE WHEN (a.[Share Repurchase] = 'No') THEN (0) ELSE (1) END AS ShareRepurchase
		,CASE WHEN (a.[Spin-Off/Sale of Business Division] = 'No') THEN (0) ELSE (1) END AS SpinOffSaleOfBusinessDivision
		,CASE WHEN (a.[Succession Planning] = 'No') THEN (0) ELSE (1) END AS SuccessionPlanning
		,CASE WHEN (a.[Terminate Investment Advisory Agreement] = 'No') THEN (0) ELSE (1) END AS TerminateInvestmentAdvisoryAgreement
		,CASE WHEN (a.[Under Leverage] = 'No') THEN (0) ELSE (1) END AS UnderLeverage
		,CASE WHEN (a.[Use Universal Ballot] = 'No') THEN (0) ELSE (1) END AS UseUniversalBallot

-- Activist Action Outcome


-- Company Response
		,g.AGM
		,g.ActivistWithdrewDemands
		,g.NA
		,g.AGMResult
		,g.MergerCompleted 
		,g.EGMorSpecialMeeting
		,g.ProxyContest
		,g.ActivistExitsStock
		,g.MergerOrTakeover
		,g.MetWithDemandsInFull
		,g.PublicDisagreement
		,g.NoPublicResponse
		,g.CompromiseOrAgreement
		,g.ShareholderVote
		,g.CompanyHiresFiresResignations
		,g.ActivistHiresFiresResignations
		,g.EngagedActivistPositively
		,g.NewCEOAppointed
		,g.CompanyRejectsTakeoverBid
		,g.CompanyRejectsSpecialMeeting
		,g.MeetingsWithBoardOrManagement
		,g.ActivistWritesToRegulator
		,g.CommunicationWithShareholders
		,g.WentToVote
		,g.JobCuts
		,g.ExternalAdvice
		,g.CEOorChairmanDeparts
		,g.ActivistAppealsToRegulatorOrCourts
		,g.Lawsuit
		,g.CR_Dividends
		,g.DividendOrShareRepurchaseChange
		,g.CompanyMakesAcquisition
		,g.CompanyReleasesFinancials
		,g.WelcomedActivist
		,g.Bankruptcy
		,g.ProxyAccess
		,g.ImplementAmendPoisonPill
		,g.ActivistWinsBoardSeats
		,g.ActivistNominatesBoardMembers
		,g.ThankedActivist
		,g.ShareholderProposal
		,g.TenderOffer
		,g.ActivistDropsBelowReportingThreshold
		,g.NewMergerAnnounced 
		,g.ProxyAdvisorVerdict
		,g.ActivistStatement
		,g.PoisonPillImplemented
		,g.LawsuitAgainstActivist
		,g.LetterToFellowShareholders
		,g.ActivistNomineesAppointedToBoard
		,g.SettlementAgreementConcluded
		,g.LetterToBoardOrManagement
		,g.CompanyRejectsBoardNominations
		,g.DelayShareholderMeeting
		,g.CloseFund
		,g.ClosedAGM
		,g.ActivistIssuesPublicLetter
		,g.ActivistLetterToRegulatoryBodies
		,g.LitigationInitiated
		,g.ConsentSolicitationInitiated
		,g.SECFiling

-- Seats
		,CAST (g.[SeatsProposed] AS int) AS SeatsProposed
		,CAST (g.[SeatsGained] AS int) AS SeatsGained
		,g.[SeatsGainedMethod]
		
-- Campaign Outcomes
		,a.[Ongoing] AS Ongoing
		,a.[Activist Withdrew Demands] AS WithdrewDemands
		,a.[Activist's Objectives Partially Successful] AS PartiallySuccessful
		,a.[Activist's Objectives Successful] AS Successful
		,a.[Activist's Objectives Unsuccessful] AS Unsuccessful
		,a.[Compromise / Settlement] AS CompromiseOrSettlement
		,a.[Unresolved] AS Unresolved
				
-- Buyer
		,i.Buyer

-- Succession

		,CASE WHEN (a.[Follower Return Annualised (%)]/ a.[S&P Change Annualised (%)]-1>0.5) THEN (1) ELSE (0) END AS Succession

   
FROM [FR_Investments] AS a
LEFT OUTER JOIN 
	 [FR_Industry] b
ON a.[Sector] = b.[Industry Sector]
LEFT OUTER JOIN 
	 [FR_MarketCap] c
ON a.MarketCapCategory = c.[Market Cap]
LEFT OUTER JOIN
	 [ActivistList] d
ON a.[Investor ID] = d.[Investor ID]
LEFT OUTER JOIN
	 [FR_ActivistList] e
ON a.[Investor ID] = e.[Investor ID] 
LEFT OUTER JOIN 
     [ActivistHoldingsFix] f
ON a.[Investor ID] = a.[Investor ID] AND a.PID = a.PID
LEFT OUTER JOIN 
	 [ActivistDemands1] g
ON a.[Investor ID] = g.[Investor ID] AND a.PID = g.PID
--LEFT OUTER JOIN 
--	 [ExcessReturn] h
--ON a.[Investor ID] = h.[Investor ID] 
LEFT OUTER JOIN 
	 [ActivistHoldingsFix] i
ON a.[Investor ID] = i.[Investor ID] AND a.PID = i.PID
LEFT OUTER JOIN 
	 [Exited] j
ON a.[Investor ID] = j.[Investor ID] AND a.PID = j.PID



GROUP BY a.[Investor ID]
		,a.Activist
		,d.Headoffice
		,d.Founded
		,d.[Activist Holdings]
	    ,e.[No# of Investments]
	    ,e.[Avg# Change Over Period of Investment (%)]
	    ,e.[Avg# Return Annualised (%)]
	    ,e.[Avg# S&P Return (%)*]
	    ,e.[Avg# S&P Return Annualised(%)*]
	    ,d.[Last Investment]
		,a.[Follower Return (%)]
		,a.[Follower Return Annualised (%)]
		,a.[S&P Change (%)]
		,a.[S&P Change Annualised (%)]
		,i.[Price Per Share]
		,i.Currency
		,i.[Price Per Share]
		,i.[Purchase Value (Mn)]
		,a.[Price Start Period]
		,a.[Price End Period]
		,a.[% Change in Price Since Exit]
		,a.[% Change in S&P Since Exit]
		,i.[Focused]
		,d.[AUM $mn]
	    ,d.[AUM Date]
		,a.[Company]
	    ,a.[PID]
		,a.[Company HQ]
	    ,i.[Industry]
		,i.[Sector]
		,b.[No# of Investments]
		,b.[Avg# Change Over Period of Investment (%)]
		,b.[Avg# S&P Return (%)]
		,b.[Avg# Return Annualised (%)]
		,b.[Avg# S&P Return Annualised (%)]
		,a.[Market Cap ($MN)]
		,a.MarketCapCategory
		,c.[No# of Investments]
		,c.[Avg# Change Over Period of Investment (%)]
		,c.[Avg# Annualised Return (%)]
		,c.[Avg# S&P Return (%)]
		,a.[Date 13D Filed]
		,i.[Date First Invested]
		,a.[Long / Short]
		,i.[Current Holding (%)]
		,a.[Status]
		,j.[Exited]
		,i.[Exit Type]
		,a.[Gain Board Representation]
		,a.[Adopt Majority Vote Standard]
		,a.[Amend Bylaw]
		,a.[Amend Listing Status]
		,a.[Board Independence]
		,a.[Business Focus]
		,a.[Business Restructuring]
		,a.[Change Board Composition]
		,a.[Closure of Business Unit]
		,a.[Dividends]
		,a.[Eliminate Staggered Board]
		,a.[Equity Issuance]
		,a.[Excess Cash]
		,a.[Focus on Growth Strategies]
		,a.[General Cost Cutting]
		,a.[Lack of/Inaccurate Information From Company]
		,a.[Operational Efficiency]
		,a.[Oppose Acquisition of Third Party]
		,a.[Oppose Equity Issuance]
		,a.[Oppose Proxy Contest]
		,a.[Oppose Sale of Company]
		,a.[Push For Acquisition of Third Party]
		,a.[Push for Company Division]
		,a.[Push for Sale of Company]
		,a.[Push For/Oppose Merging of Shares]
		,a.[Recapitalization]
		,a.[Redemption/Amendment of Poison Pill]
		,a.[REIT / MLP Conversion]
		,a.[Removal of CEO or Other Board Member]
		,a.[Remuneration]
		,a.[Replace Auditor]
		,a.[Replace Management]
		,a.[Restructure Debt]
		,a.[Return Cash to Shareholders]
		,a.[Sell/Retain Assets]
		,a.[Separate Chairman & CEO]
		,a.[Share Repurchase]
		,a.[Spin-Off/Sale of Business Division]
		,a.[Succession Planning]
		,a.[Terminate Investment Advisory Agreement]
		,a.[Under Leverage]
		,a.[Use Universal Ballot]
		,g.AGM
		,g.ActivistWithdrewDemands
		,g.NA
		,g.AGMResult
		,g.MergerCompleted 
		,g.EGMorSpecialMeeting
		,g.ProxyContest
		,g.ActivistExitsStock
		,g.MergerOrTakeover
		,g.MetWithDemandsInFull
		,g.PublicDisagreement
		,g.NoPublicResponse
		,g.CompromiseOrAgreement
		,g.ShareholderVote
		,g.CompanyHiresFiresResignations
		,g.ActivistHiresFiresResignations
		,g.EngagedActivistPositively
		,g.NewCEOAppointed
		,g.CompanyRejectsTakeoverBid
		,g.CompanyRejectsSpecialMeeting
		,g.MeetingsWithBoardOrManagement
		,g.ActivistWritesToRegulator
		,g.CommunicationWithShareholders
		,g.WentToVote
		,g.JobCuts
		,g.ExternalAdvice
		,g.CEOorChairmanDeparts
		,g.ActivistAppealsToRegulatorOrCourts
		,g.Lawsuit
		,g.CR_Dividends
		,g.DividendOrShareRepurchaseChange
		,g.CompanyMakesAcquisition
		,g.CompanyReleasesFinancials
		,g.WelcomedActivist
		,g.Bankruptcy
		,g.ProxyAccess
		,g.ImplementAmendPoisonPill
		,g.ActivistWinsBoardSeats
		,g.ActivistNominatesBoardMembers
		,g.ThankedActivist
		,g.ShareholderProposal
		,g.TenderOffer
		,g.ActivistDropsBelowReportingThreshold
		,g.NewMergerAnnounced 
		,g.ProxyAdvisorVerdict
		,g.ActivistStatement
		,g.PoisonPillImplemented
		,g.LawsuitAgainstActivist
		,g.LetterToFellowShareholders
		,g.ActivistNomineesAppointedToBoard
		,g.SettlementAgreementConcluded
		,g.LetterToBoardOrManagement
		,g.CompanyRejectsBoardNominations
		,g.DelayShareholderMeeting
		,g.CloseFund
		,g.ClosedAGM
		,g.ActivistIssuesPublicLetter
		,g.ActivistLetterToRegulatoryBodies
		,g.LitigationInitiated
		,g.ConsentSolicitationInitiated
		,g.SECFiling
		,g.SeatsProposed
		,g.SeatsGained 
		,g.SeatsGainedMethod
		,a.[Ongoing]
		,a.[Activist Withdrew Demands]
		,a.[Activist's Objectives Partially Successful]
		,a.[Activist's Objectives Successful]
		,a.[Activist's Objectives Unsuccessful]
		,a.[Compromise / Settlement]
		,a.[Unresolved]
		,i.Buyer
		    

SELECT * FROM activist_holdings_v_SC
WHere [Investor ID] = 5565

SELECT [Investor ID]
      ,Activist
	  ,(SELECT [ActivistHoldingsFix].[Date First Invested] FROM [ActivistHoldingsFix] WHERE [Investor ID] = [ActivistHoldingsFix].[Investor ID]) 
	  ,((COUNT (CASE WHEN  [ActivistHoldingsFix].[Date First Invested] BETWEEN DATEADD(YEAR, -5, [ActivistHoldingsFix].[Date First Invested]) AND DATEADD(DAY,-1,[ActivistHoldingsFix].[Date First Invested]) THEN [Investor ID] ELSE NULL END) OVER (PARTITION BY [Investor ID])) )

 FROM activist_holdings_v
WHere [Investor ID] = 5565

SELEct
    , (SELECT DISTINCT COUNT(1) -- as actor_movies_cnt
        FROM movie_actor_date_revenue
        WHERE release_date BETWEEN DATEADD(YEAR, -5, a.release_date) AND DATEADD(DAY,-1,a.release_date) 
        AND actor_id = (
            SELECT TOP 1 actor_id 
            FROM movie_actor_date_revenue
            WHERE movie_id = a.movie_id AND [order] = 0
      )) AS actor0_movies_5y_cnt 
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

CASE WHEN  a.[Company HQ] = 'Bahamas' 
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

---
UPDATE FR_Investments
SET [Market Cap ($MN)] = 5256 WHERE [Market Cap ($MN)] = 5256450

SELECT * from FR_Investments WHERE [Market Cap ($MN)] = 5256


ALTER TABLE FR_Investments
ADD MarketCapCategory VARCHAR (255)

UPDATE FR_Investments
SET MarketCapCategory =  CASE
							 WHEN ([Market Cap ($MN)] > 1000000) THEN ('Large-Cap')
							 WHEN ([Market Cap ($MN)] BETWEEN 200001 AND 1000000 ) THEN ('Mid-Cap')
							 WHEN ([Market Cap ($MN)] BETWEEN 25001 AND 200000 ) THEN ('Small-Cap')
							 WHEN ([Market Cap ($MN)] BETWEEN 50001 AND 25000 ) THEN ('Micro-Cap')
	                         ELSE ('Nano-Cap') 
						 END 
WHERE [Market Cap] IN ('Large Cap (>$10bn)','Mid-cap ($2-10bn)','Small-cap ($250-2bn)','Micro-cap ($50-250mn)','Nano Cap (<$50mn)')

select*from FR_Investments where [Market Cap ($MN)] > 1000000

UPDATE ActivistHoldingsFix
SET Industry = CASE
					WHEN (Company = 'Hornby PLC') THEN ('Specialty Retail')
				    WHEN (Company = 'Enzon Pharmaceuticals Inc.') THEN ('Biotechnology')
				    WHEN (Company = 'TESSCO Technologies Incorporated') THEN ('Communication Equipment')
					WHEN (Company = 'Emeco Holdings Limited') THEN ('Rental & Leasing Services')
					ELSE (Industry)
					END
UPDATE ActivistHoldingsFix
SET Sector = CASE
				 WHEN (Company = 'Hornby PLC') THEN ('Consumer Cyclical')
				 WHEN (Company = 'Enzon Pharmaceuticals Inc.') THEN ('Healthcare')
				 WHEN (Company = 'TESSCO Technologies Incorporated') THEN ('Technology')
				 WHEN (Company = 'Emeco Holdings Limited') THEN ('Industrials')
				 ELSE (Sector)
				 END

SELECT * FROM ActivistHoldingsFix WHERE Company = 'Hornby PLC'
SELECT * FROM FR_Demands WHERE [Investor ID] IS NOT NULL Order By [Investor ID] 
---Excess Return
---DROP TABLE ExcessReturn
SELECT   a.[Investor ID] AS InvestorID
		,a.PID
		,b.[No# of Investments] AS NoOfInv
		,(COUNT (CASE WHEN (a.[Follower Return Annualised (%)] - a.[S&P Change Annualised (%)]) > 0 THEN a.[Investor ID] ELSE NULL END) OVER (PARTITION BY a.[Investor ID])) AS PsitiveReturn
		,a.[Follower Return (%)] AS ReturnByCamp
		,a.[Follower Return Annualised (%)] AS ReturnAnnualisedByCamp
		,a.[S&P Change (%)] AS SPChangeByCamp
		,a.[S&P Change Annualised (%)] AS SPChangeAnnualisedByCamp
		,a.[Follower Return (%)] - a.[S&P Change (%)] AS ExcessReturnByCamp
	    ,(COUNT (CASE WHEN (a.[Follower Return (%)] - a.[S&P Change (%)] ) > 0 THEN a.[Investor ID] ELSE NULL END ) OVER (PARTITION BY a.[Investor ID])) / b.[No# of Investments] AS HitRatio 

INTO ExcessReturn
FROM     [FR_Investments] a
LEFT OUTER JOIN
		[FR_ActivistList] b
ON a.[Investor ID] = b.[Investor ID] 

GROUP BY a.[Investor ID]
		,a.PID
		,b.[No# of Investments]
		,a.[Follower Return (%)]
		,a.[Follower Return Annualised (%)]
		,a.[S&P Change (%)]
		,a.[S&P Change Annualised (%)]

SELECT * FROM ExcessReturn
where [InvestorID] = 5565



---החלק הזה שייך לטבלת ה-FF
,(SELECT (COUNT (CASE WHEN ExRe.[ExcessReturnByCamp] > 0 THEN ExRe.[Investor ID] ELSE NULL END) OVER (PARTITION BY ExRe.[Investor ID]))/ExRe.[No# of Investments] AS HitRatioByAct
		  FROM
		 (SELECT  i.[Investor ID]
		         ,i.[Follower Return Annualised (%)] - i.[S&P Change Annualised (%)] AS ExcessReturnByCamp
				 ,j.[No# of Investments]
		
		 FROM [FR_Investments] i
		 LEFT OUTER JOIN
		 [FR_ActivistList] j
         ON i.[Investor ID] = j.[Investor ID] 
		 GROUP BY i.[Investor ID]
				 ,i.[Follower Return Annualised (%)]
				 ,i.[S&P Change Annualised (%)]
				 ,j.[No# of Investments]) AS ExRe
		 GROUP BY ExRe.[Investor ID]
				 ,ExRe.[ExcessReturnByCamp]
			     ,ExRe.[No# of Investments] ) AS HitRatioByAct
		

-- HIT RATIO
SELECT InvestorID
	  
	  ,NoOfInv
	  ,ExcessReturnByCamp
	  ,(COUNT (CASE WHEN ExcessReturnByCamp > 0 THEN InvestorID ELSE NULL END) OVER (PARTITION BY InvestorID)) AS PsitiveReturn
	  ,(COUNT (CASE WHEN ExcessReturnByCamp > 0 THEN InvestorID ELSE NULL END ) OVER (PARTITION BY InvestorID)) / NoOfInv AS HitRatio 

 FROM ExcessReturn

 GROUP BY InvestorID
		 ,NoOfInv
		 ,ExcessReturnByCamp
		 

Order By InvestorID












(SELECT DISTINCT COUNT([Investor ID]) 
	     FROM [ExcessReturn]
		 WHERE [ExcessReturnByCamp] > 0 
		 GROUP BY [Investor ID] ) / (SELECT [No# of Investments] FROM FR_Investments GROUP BY [Investor ID]) AS HitRatio
	   
--Company Response
Drop table ActivistDemands1
SELECT   a.[Investor ID]
		,a.[Activist]
		,a.[Company]
		,a.[PID]
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
		,MAX(CASE WHEN (g.Response = 'Activist Hires/Fires/Resignations') THEN (1) ELSE (0) END) AS ActivistHiresFiresResignations
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
		,MAX(g.[Seats Proposed (Gain Board Representation Only)]) AS SeatsProposed
	    ,MAX(g.[Seats Gained (Gain Board Representation Only)]) AS SeatsGained
        ,MAX(g.[Seats Gained Method  (Gain Board Representation Only)] ) AS SeatsGainedMethod
INTO ActivistDemands1
FROM [ActivistHoldingsFix] AS a
LEFT OUTER JOIN 
	 [ActivistsDemands] g
ON a.[Investor ID] = g.[Investor ID] AND a.PID = g.PID

GROUP BY a.[Investor ID]
		,a.[Activist]
		,a.[Company]
		,a.[PID]
--		,g.[Seats Proposed (Gain Board Representation Only)]
--		,g.[Seats Gained (Gain Board Representation Only)]
--		,g.[Seats Gained Method  (Gain Board Representation Only)]
ORDER BY a.[Investor ID] 
		,a.[PID]
		
select * from ActivistDemands1
WHERE [Investor ID] = 5565
ORDER BY [Investor ID] 
		,[PID]


select [Investor ID]
      ,[PID] 
      ,MAX([Seats Proposed (Gain Board Representation Only)]) AS SeatsProposed
	  ,MAX([Seats Gained (Gain Board Representation Only)]) AS SeatsGained
      ,MAX([Seats Gained Method  (Gain Board Representation Only)] ) AS SeatsGainedMethod
from ActivistsDemands
WHERE [Investor ID] = 5565 AND [PID] = 212
GROUP BY [Investor ID] 
		,[PID]
ORDER BY [Investor ID] 
		,[PID]

		,g.AGM
		,g.ActivistWithdrewDemands
		,g.NA
		,g.AGMResult
		,g.MergerCompleted 
		,g.EGMorSpecialMeeting
		,g.ProxyContest
		,g.ActivistExitsStock
		,g.MergerOrTakeover
		,g.MetWithDemandsInFull
		,g.PublicDisagreement
		,g.NoPublicResponse
		,g.CompromiseOrAgreement
		,g.ShareholderVote
		,g.CompanyHiresFiresResignations
		,g.ActivistHiresFiresResignations
		,g.EngagedActivistPositively
		,g.NewCEOAppointed
		,g.CompanyRejectsTakeoverBid
		,g.CompanyRejectsSpecialMeeting
		,g.MeetingsWithBoardOrManagement
		,g.ActivistWritesToRegulator
		,g.CommunicationWithShareholders
		,g.WentToVote
		,g.JobCuts
		,g.ExternalAdvice
		,g.CEOorChairmanDeparts
		,g.ActivistAppealsToRegulatorOrCourts
		,g.Lawsuit
		,g.CR_Dividends
		,g.DividendOrShareRepurchaseChange
		,g.CompanyMakesAcquisition
		,g.CompanyReleasesFinancials
		,g.WelcomedActivist
		,g.Bankruptcy
		,g.ProxyAccess
		,g.ImplementAmendPoisonPill
		,g.ActivistWinsBoardSeats
		,g.ActivistNominatesBoardMembers
		,g.ThankedActivist
		,g.ShareholderProposal
		,g.TenderOffer
		,g.ActivistDropsBelowReportingThreshold
		,g.NewMergerAnnounced 
		,g.ProxyAdvisorVerdict
		,g.ActivistStatement
		,g.PoisonPillImplemented
		,g.LawsuitAgainstActivist
		,g.LetterToFellowShareholders
		,g.ActivistNomineesAppointedToBoard
		,g.SettlementAgreementConcluded
		,g.LetterToBoardOrManagement
		,g.CompanyRejectsBoardNominations
		,g.DelayShareholderMeeting
		,g.CloseFund
		,g.ClosedAGM
		,g.ActivistIssuesPublicLetter
		,g.ActivistLetterToRegulatoryBodies
		,g.LitigationInitiated
		,g.ConsentSolicitationInitiated
		,g.SECFiling
		