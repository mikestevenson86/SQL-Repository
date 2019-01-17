SELECT
bdm.Name,
l.CitationSector__c,
bdc.Name BDC,
SUM(case when l.Date_Made__c is not null then 1 else 0 end) Appointments,
SUM(case when o.Deal_Start_Date__c is not null then 1 else 0 end) Deals

INTO
#Prospects

FROM Salesforce..Lead l
inner join Salesforce..[User] bdm ON l.OwnerId = bdm.Id
inner join Salesforce..[Profile] pr ON bdm.ProfileId = pr.Id
left outer join Salesforce..Opportunity o ON l.ConvertedOpportunityId = o.Id
left outer join Salesforce..[User] bdc ON l.BDC__c = bdc.Id

WHERE
Date_Made__c between '2016-10-01' and '2016-12-31'
and
pr.Name = 'Citation BDM'

GROUP BY
bdm.Name,
l.CitationSector__c,
bdc.Name

-- Final Output

SELECT 
bdm.Name, 
l.CitationSector__c,
bdc.Name BDC,
SUM(case when call_Type in (0,2,4) then 1 else 0 end) ConnectedCalls, 
ISNULL(p.Appointments, 0) Appts, 
ISNULL(p.Deals, 0) Deals

FROM
SalesforceReporting..call_history ch
left outer join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS
left outer join Salesforce..[User] bdm ON l.OwnerId = bdm.Id
left outer join Salesforce..[Profile] pr ON bdm.ProfileId = pr.Id
left outer join Salesforce..[User] bdc ON ch.tsr = bdc.DiallerFK__c
left outer join #Prospects p ON bdm.Name = p.Name
								and l.CitationSector__c = p.CitationSector__c
								and bdc.Name = p.BDC

WHERE
act_date between '2016-10-01' and '2016-12-31'
and
pr.Name = 'Citation BDM'

GROUP BY
bdm.Name,
l.CitationSector__c,
bdc.Name,
p.Appointments, 
p.Deals

ORDER BY
bdm.Name,
l.CitationSector__c,
bdc.Name

DROP TABLE #Prospects