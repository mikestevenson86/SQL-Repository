IF OBJECT_ID('tempdb..#FirstAdd') IS NOT NULL
	BEGIN
		DROP TABLE #FirstAdd
	END
	
IF OBJECT_ID('tempdb..#Calls') IS NOT NULL
	BEGIN
		DROP TABLE #Calls
	END
	
IF OBJECT_ID('tempdb..#Crit') IS NOT NULL
	BEGIN
		DROP TABLE #Crit
	END
	
IF OBJECT_ID('tempdb..#PrevStat') IS NOT NULL
	BEGIN
		DROP TABLE #PrevStat
	END
	
IF OBJECT_ID('SalesforceReporting..InsertsActivity') IS NOT NULL
	BEGIN
		DROP TABLE SalesforceReporting..InsertsActivity
	END
		
SELECT LeadId, MIN(StartDate) FirstAdd
INTO #FirstAdd
FROM Salesforce..CampaignMember cm
inner join Salesforce..Campaign c ON cm.CampaignId = c.Id
WHERE c.[Type] = 'Telemarketing'
GROUP BY LeadId

SELECT l.Id, COUNT(seqno) Dials, SUM(case when call_type in (0,2,4) then 1 else 0 end) Calls
INTO #Calls
FROM Salesforce..Lead l
inner join SalesforceReporting..call_history ch ON LEFT(l.Id, 15) collate latin1_general_CS_AS = LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS
GROUP BY l.Id

SELECT LeadId, OldValue
INTO #PrevStat
FROM Salesforce..LeadHistory lh
inner join	(
			SELECT LeadId Id, MAX(CreatedDate) CreatedDate
			FROM Salesforce..LeadHistory
			WHERE Field = 'Status'
			GROUP BY LeadId
			) detail ON lh.LeadId = detail.Id and lh.CreatedDate = detail.CreatedDate
WHERE Field = 'Status'
GROUP BY LeadId, OldValue

SELECT l.Id
INTO #Crit
FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.OwnerId = u.Id
inner join Salesforce..[Profile] p ON u.ProfileId = p.Id
WHERE SIC2007_Code3__c is not null and 
ISNULL(l.Phone,'') <> '' and 
Source__c not like 'LB%' and
Source__c not like 'Closed%' and
Source__c not like 'marketing%' and
Source__c not like 'toxic%' and
Source__c not like 'welcome%' and
p.Name like '%BDM%' and 
l.RecordTypeId = '012D0000000NbJsIAK' and 
IsTPS__c = 'No' and 
Toxic_SIC__c = 'false' and
(
	CitationSector__c = 'CARE'
	or
	(
		l.FT_Employees__c between 6 and 225 
		or 
		(l.FT_Employees__c = 5 and l.Country in ('Scotland','Northern Ireland'))
		or
		(CitationSector__c in ('CLEANING','HORTICULTURE') and l.FT_Employees__c between 4 and 225)
		or
		(CitationSector__c in ('DENTAL PRACTICE','DAY NURSERY','PHARMACY','FUNERAL SERVICES') and l.FT_Employees__c between 3 and 225)
	)
) and 
ISNULL(CitationSector__c,'') <> 'EDUCATION' 

SELECT 
ROW_NUMBER () OVER (PARTITION BY 1 ORDER BY l.CreatedDate) DS_Id,
l.Id,
DATENAME(Month, l.CreatedDate) [Month Added], 
case when cr.Id is not null then 'Yes' else 'No' end [In Crit],
--SUM(case when fa.FirstAdd > l.CreatedDate then 1 else 0 end) [Added To Campaign],
ISNULL(c.Calls, 0) [Dialler Connected Calls],
ISNULL(c.Dials, 0) [Dialler Dials],
case when o.DateMade__c is not null then 1 else 0 end Appointment,
case when o.SAT__c = 'true' then 1 else 0 end SAT,
case when o.Deal_Start_Date__c is not null or o.StageName = 'Closed Won' then 1 else 0 end Deals,
case when o.Deal_Start_Date__c is not null or o.StageName = 'Closed Won' then o.Amount else 0 end Revenue,
l.Status,
ISNULL(l.Suspended_Closed_Reason__c, 'No Reason Given') StatusReason,
l.FT_Employees__c,
CitationSector__c,
case when ISNULL(l.FT_Employees__c,'0') = '0' then 'Zero'
when l.FT_Employees__c between '1' and '2' then '1 to 2' 
when l.FT_Employees__c between '3' and '5' then '3 to 5'
when l.FT_Employees__c between '6' and '10' then '6 to 10'
when l.FT_Employees__c between '11' and '50' then '11 to 50'
when l.FT_Employees__c between '51' and '100' then '51 to 100'
when l.FT_Employees__c between '101' and '225' then '101 to 225'
when l.FT_Employees__c > '225' then '226 +'
else '' end CritFTERange,
bdc.Name BDC,
bdm.Name BDM,
l.Data_Supplier__c [Data Supplier],
l.Source__c [Data Source],
l.LeadSource [Prospect Source],
l.Prospect_Channel__c [Prospect Channel],
ps.OldValue [Previous Status]

INTO SalesforceReporting..InsertsActivity

FROM 
Salesforce..Lead l
left outer join #Calls c ON l.Id = c.Id
left outer join Salesforce..Opportunity o ON l.ConvertedOpportunityId = o.Id and o.MADE_Criteria__c like '%Outbound%'
left outer join #FirstAdd fa ON l.Id = fa.LeadId
left outer join Salesforce..[User] u ON l.OwnerId = u.Id
left outer join Salesforce..[Profile] p ON u.ProfileId = p.Id
left outer join #Crit cr ON l.Id = cr.Id
left outer join Salesforce..[User] bdc ON l.BDC__c = bdc.Id
left outer join Salesforce..[User] bdm ON l.OwnerId = bdm.Id
left outer join #PrevStat ps ON l.Id = ps.LeadId

WHERE 
DATEPART(Year, l.CreatedDate) >= DATEPART(Year, GETDATE())

ORDER BY 
l.CreatedDate

SELECT * FROM SalesforceReporting..InsertsActivity

DROP TABLE #FirstAdd
DROP TABLE #Calls
DROP TABLE #Crit
DROP TABLE #PrevStat