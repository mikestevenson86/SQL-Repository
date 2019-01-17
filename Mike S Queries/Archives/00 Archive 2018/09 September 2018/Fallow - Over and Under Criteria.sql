IF OBJECT_ID('LeadChangeReview..Fallow_UnderOverCrit') IS NOT NULL DROP TABLE LeadChangeReview..Fallow_UnderOverCrit
IF OBJECT_ID('tempdb..#SCDChanges') IS NOT NULL DROP TABLE #SCDChanges
IF OBJECT_ID('tempdb..#NewFTE') IS NOT NULL DROP TABLE #NewFTE
IF OBJECT_ID('tempdb..#MaxDate') IS NOT NULL DROP TABLE #MaxDate

SELECT URN, scd.CreatedDate
INTO #NewFTE
FROM [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd with(nolock)
inner join Salesforce..Lead l with(nolock) ON scd.URN collate latin1_general_CI_AS = l.Market_Location_URN__c collate latin1_general_CI_AS									
WHERE Field = 'Nat Employees' and OldValue <> NewValue and CONVERT(VarChar, NewValue) = CONVERT(VarChar, FT_Employees__c)

SELECT URN, MAX(CreatedDate) MaxDate
INTO #MaxDate
FROM #NewFTE
GROUP BY URN

SELECT scd.CreatedDate, scd.URN, scd.Field, scd.OldValue, scd.NewValue
INTO #SCDChanges
FROM [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_History scd
inner join #MaxDate md ON scd.URN = md.URN and CONVERT(date, scd.CreatedDate) = CONVERT(date, md.MaxDate)
WHERE Field = 'Nat Employees' and OldValue <> NewValue
GROUP BY scd.CreatedDate, scd.URN, scd.Field, scd.OldValue, scd.NewValue

SELECT 
l.Id
,l.Status
,Suspended_Closed_Reason__c [Suspended/Closed Reason]
,FT_Employees__c [FT Employees]
,CitationSector__c [Citation Sector]
,l.Status_Changed_Date__c [Status Changed Date]
,scd.CreatedDate [FTE Update Date]
,scd.OldValue [Old Value]
,scd.NewValue [New Value]
INTO 
LeadChangeReview..Fallow_UnderOverCrit
FROM 
Salesforce..Lead l
left outer join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
left outer join #SCDChanges scd ON l.Market_Location_URN__c collate latin1_general_CI_AS = scd.URN collate latin1_general_CI_AS 
WHERE 
CONVERT(date, scd.CreatedDate) > CONVERT(date, l.Status_Changed_Date__c) 
and Status in ('Closed','Suspended') 
and Suspended_Closed_Reason__c in ('Over Criteria','Under Criteria')
and Status_Changed_Date__c < DATEADD(day,-30,GETDATE())
and rt.Name = 'Default Citation Record Type'
and IsConverted = 'false'
and 
(
	(
		Toxic_SIC__c = 'true' 
		and 
		CitationSector__c = 'ACCOMODATION' 
		and 
		CONVERT(decimal(18,0), SIC2007_Code3__c) in (55100,56101,26302) 
		and 
		CONVERT(decimal(18,0), FT_Employees__c) between 10 and 225 	 
	)
	or
	(
		CONVERT(decimal(18,0), FT_Employees__c) < 225 
		and 
		CitationSector__c = 'CARE'
	)
	or 
	CONVERT(decimal(18,0), FT_Employees__c) between 6 and 225
	or
	(
		CONVERT(decimal(18,0), FT_Employees__c) between 5 and 225 
		and 
		TEXT_BDM__c in ('William McFaulds','Scott Roberts','Dominic Miller','Gary Smith')
	)
	or 
	(
		CONVERT(decimal(18,0), FT_Employees__c) between 10 and 225 
		and 
		CONVERT(decimal(18,0), SIC2007_Code3__c) in (56101,55900,55100,56302)
	)
	or 
	(
		CONVERT(decimal(18,0), FT_Employees__c) between 4 and 225 
		and 
		ISNULL(CitationSector__c, '') in ('CLEANING','HORTICULTURE')
	)
	or 
	(
		CONVERT(decimal(18,0), FT_Employees__c) between 3 and 225 
		and 
		ISNULL(CitationSector__c, '') in ('DENTAL PRACTICE','DAY NURSERY','PHARMACY')
	)
	or 
	(
		CONVERT(decimal(18,0), FT_Employees__c) between 3 and 225 
		and 
		ISNULL(CitationSector__c, '') like '%FUNERAL%'
	)
)