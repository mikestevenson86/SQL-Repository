-- Weeks Calls

SELECT l.Id, MAX(act_date) LastCall
INTO #Calls
FROM Salesforce..Lead l
inner join SalesforceReporting..call_history ch ON LEFT(l.ID, 15) collate latin1_general_CS_AS = LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS
WHERE act_date between DATEADD(ww, DATEDIFF(ww,0,GETDATE())-1,0) and DATEADD(ww, DATEDIFF(ww,0,GETDATE())-1,4) and
l.Source__c = 'Toxic Release'
GROUP BY l.Id

-- Weeks Callbacks

SELECT LeadID, lh.CreatedDate
INTO #Callbacks
FROM Salesforce..LeadHistory lh
inner join Salesforce..Lead l ON lh.LeadId = l.Id
WHERE Field = 'Status' and NewValue = 'Callback Requested' and l.Source__c = 'Toxic Release' and
CONVERT(date, lh.CreatedDate) between DATEADD(ww, DATEDIFF(ww,0,GETDATE())-1,0) and DATEADD(ww, DATEDIFF(ww,0,GETDATE())-1,4)

-- Weeks Appointments

SELECT Id, Date_Made__c
INTO #Appts
FROM Salesforce..Lead
WHERE Source__c = 'Toxic Release' and Date_Made__c between DATEADD(ww, DATEDIFF(ww,0,GETDATE())-1,0) and DATEADD(ww, DATEDIFF(ww,0,GETDATE())-1,4)

-- Weeks Deals

SELECT l.Id, o.CloseDate, o.Amount
INTO #Deals
FROM Salesforce..Opportunity o
inner join Salesforce..Lead l ON o.Id = l.ConvertedOpportunityId
WHERE CloseDate between DATEADD(ww, DATEDIFF(ww,0,GETDATE())-1,0) and DATEADD(ww, DATEDIFF(ww,0,GETDATE())-1,4)
and StageName like '%Closed Won%' and l.Source__c = 'Toxic Release'

-- Weeks Deal Starts

SELECT l.Id, o.Deal_Start_Date__c, o.Amount
INTO #DealStart
FROM Salesforce..Opportunity o
inner join Salesforce..Lead l ON o.Id = l.ConvertedOpportunityId
WHERE Deal_Start_Date__c between DATEADD(ww, DATEDIFF(ww,0,GETDATE())-1,0) and DATEADD(ww, DATEDIFF(ww,0,GETDATE())-1,4)
and StageName like '%Closed Won%' and l.Source__c = 'Toxic Release'

-- Final Query

SELECT l.Id, 
ISNULL(u.Name, g.Name) BDM,
l.CitationSector__c [Citation Sector],
case when c.Id is not null then 'Yes' else 'No' end Called, 
cb.CreatedDate Callbacked,
ap.Date_Made__c AppMade,
dl.CloseDate DealMade,
dl.Amount Revenue
FROM Salesforce..Lead l
left outer join Salesforce..[User] u ON l.OwnerId = u.Id
left outer join Salesforce..[Group] g ON l.OwnerId = g.Id
left outer join #Calls c ON l.Id = c.Id
left outer join #Callbacks cb ON l.Id = cb.LeadId
left outer join #Appts ap ON l.Id = ap.Id
left outer join #Deals dl ON l.Id = dl.Id
left outer join #DealStart ds ON l.Id = ds.Id
WHERE Source__c = 'Toxic Release'

-- Drop tables

DROP TABLE #Calls
DROP TABLE #Callbacks
DROP TABLE #Appts
DROP TABLE #Deals