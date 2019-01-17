IF OBJECT_ID('tempdb..#ListStats') IS NOT NULL
	BEGIN
		DROP TABLE #ListStats
	END
	
IF OBJECT_ID('tempdb..#CallStats') IS NOT NULL
	BEGIN
		DROP TABLE #CallStats
	END

IF OBJECT_ID('tempdb..#DiallerCTA') IS NOT NULL
	BEGIN
		DROP TABLE #DiallerCTA
	END
	
IF OBJECT_ID('tempdb..#CiscoCTA') IS NOT NULL
	BEGIN
		DROP TABLE #CiscoCTA
	END

SELECT l.Id, COUNT(c.Id)TimesImported, MAX(c.CreatedDate) LastImported
INTO #ListStats
FROM Salesforce..Lead l
inner join Salesforce..CampaignMember cm ON l.Id = cm.LeadId
inner join Salesforce..Campaign c ON cm.CampaignId = c.Id
WHERE DATEPART(MONTH, Date_Made__c) < 4 and DATEPART(Year, Date_Made__c) = 2017 and c.[Type] = 'Telemarketing' and c.noblesys__listId__c is not null
GROUP BY l.Id

SELECT l.Id, 
DATEDIFF(day,MAX(ch.act_date),MAX(l.Date_Made__c)) [Last Call To Made],
SUM(case when ch.act_date between DATEADD(day,-30,Date_Made__c) and Date_Made__c then 1 else 0 end) [0 - 30 Days Dials],
SUM(case when ch.act_date between DATEADD(day,-60,Date_Made__c) and DATEADD(day,-30,Date_Made__c) then 1 else 0 end) [30 - 60 Days Dials],
SUM(case when ch.act_date between DATEADD(day,-90,Date_Made__c) and DATEADD(day,-60,Date_Made__c) then 1 else 0 end) [60 - 90 Days Dials],
SUM(case when ch.act_date between DATEADD(day,-120,Date_Made__c) and DATEADD(day,-90,Date_Made__c) then 1 else 0 end) [90 - 120 Days Dials],
SUM(case when ch.act_date between DATEADD(year,-1,Date_Made__c) and DATEADD(day,-120,Date_Made__c) then 1 else 0 end) [120 - 365 Days Dials],
SUM(case when ch.act_date < DATEADD(year,-1,Date_Made__c) then 1 else 0 end) [365+ Days Dials]
INTO #CallStats
FROM SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON LEFT(l.ID, 15) collate latin1_general_CS_AS = LEFT(ch.lm_filler2,15) collate latin1_general_CS_AS
WHERE DATEPART(MONTH, Date_Made__c) < 4 and DATEPART(Year, Date_Made__c) = 2017
GROUP BY l.Id

SELECT l.Id, COUNT(ch.seqno) DCalls
INTO #DiallerCTA
FROM SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS
WHERE DATEPART(MONTH, Date_Made__c) < 4 and DATEPART(Year, Date_Made__c) = 2017 and ch.act_date <= Date_Made__c and call_type in (0,2,4)
GROUP BY l.Id

SELECT Id, SUM(Calls) CCalls
INTO #CiscoCTA
FROM
(
	SELECT 
	ol.Id, COUNT(cc.Id) Calls
	
	FROM 
	SalesforceReporting..Contact_Centre cc
	inner join Salesforce..Lead ol ON cc.CallingId = ol.Id 
	inner join SalesforceReporting..BDC_Cisco el ON REPLACE(case when cc.CalledPhone like '0%' then cc.CalledPhone else '0'+cc.CalledPhone end,' ','') = REPLACE(el.DirectDial,' ','')
	
	WHERE 
	DATEPART(MONTH, Date_Made__c) < 4
	and DATEPART(Year, Date_Made__c) = 2017 
	and CONVERT(date, cc.StartDateTime, 103) <= Date_Made__c
	and CONVERT(VarChar, cc.[Type]) = 'Ext/In'
	
	GROUP BY 
	ol.Id
	
		UNION
		
	SELECT 
	ol.Id, COUNT(cc.Id) Calls
	
	FROM 
	SalesforceReporting..Contact_Centre cc
	inner join Salesforce..Lead ol ON cc.CalledId = ol.Id
	inner join SalesforceReporting..BDC_Cisco el ON REPLACE(case when cc.CallingPhone like '0%' then cc.CallingPhone else '0'+cc.CallingPhone end,' ','')  = REPLACE(el.DirectDial,' ','')
	
	WHERE 
	DATEPART(MONTH, Date_Made__c) < 4
	and DATEPART(Year, Date_Made__c) = 2017 
	and CONVERT(date, cc.StartDateTime, 103) <= Date_Made__c
	and CONVERT(VarChar, cc.[Type]) = 'Ext/Out'
	
	GROUP BY 
	ol.Id
) detail
GROUP BY Id

SELECT 
l.Id,
l.Company,
Date_Made__c [Booked Date],
l.CreatedDate [Created Date],
ls.LastImported [Last Imported],
ls.TimesImported [Times Imported],
ISNULL(l.Source__c, '') [Source],
ISNULL(l.Data_Supplier__c, '') [Data Supplier],
ISNULL(l.LeadSource, '') [Prospect Source],
ISNULL(l.Prospect_Channel__c, '') [Prospect Channel],
ch.seqno [Call History ID],
ch.act_date [Call Date],
CONVERT(VarChar, ch.call_type) + ' - ' + Enterprise.dbo.udf_TranslateCallType(ch.call_type) [Call Type],
cs.[Last Call To Made],
cs.[0 - 30 Days Dials],
cs.[30 - 60 Days Dials],
cs.[60 - 90 Days Dials],
cs.[90 - 120 Days Dials],
cs.[120 - 365 Days Dials],
cs.[365+ Days Dials],
dca.DCalls [Dialler CTA],
cca.CCalls [Cisco CTA]

FROM 
Salesforce..Lead l
left outer join Salesforce..Opportunity o ON l.ConvertedOpportunityId = o.Id
left outer join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
left outer join #ListStats ls ON l.Id = ls.Id
left outer join #CallStats cs ON l.Id = cs.Id
left outer join	(
				SELECT seqno, act_date, act_time, call_type, lm_filler2
				FROM SalesforceReporting..call_history ch
				inner join Salesforce..Lead l ON LEFT(ch.lm_filler2,15) collate latin1_general_CS_AS = LEFT(l.ID, 15) collate latin1_general_CS_AS
				WHERE DATEPART(MONTH, Date_Made__c) = 3 and DATEPART(Year, Date_Made__c) = 2017
				UNION
				SELECT seqno, act_date, act_time, call_type, lm_filler2
				FROM SalesforceReporting..call_history ch
				inner join Salesforce..Lead l ON LEFT(ch.lm_filler2,15) collate latin1_general_CS_AS = LEFT(l.ID, 15) collate latin1_general_CS_AS
				WHERE DATEPART(MONTH, Date_Made__c) = 3 and DATEPART(Year, Date_Made__c) = 2017
				) ch ON LEFT(l.ID, 15) collate latin1_general_CS_AS = LEFT(ch.lm_filler2,15) collate latin1_general_CS_AS
				and ch.act_date <= l.Date_Made__c
left outer join #DiallerCTA dca ON l.Id = dca.Id
left outer join #CiscoCTA cca ON l.Id = cca.Id				

WHERE
o.BDC_Manager__c is not null
and
DATEPART(MONTH, Date_Made__c) < 4 
and 
DATEPART(Year, Date_Made__c) = 2017
and 
ISNULL(rt.Name,'') <> 'QMS Record Type'
and
l.Seminar_Status__c is null

ORDER BY
Date_Made__c,
l.Id,
act_date DESC,
act_time DESC

DROP TABLE #ListStats
DROP TABLE #CallStats
DROP TABLE #DiallerCTA
DROP TABLE #CiscoCTA