SELECT Id, Date_Made__c
INTO #Apps
FROM Salesforce..Lead
WHERE DATEPART(year,Date_Made__c) = 2014

SELECT LeadID, MIN(CreatedDate) AppDateTime
INTO #ADT
FROM Salesforce..LeadHistory lh
inner join #Apps a ON lh.LeadId = a.Id
WHERE NewValue in ('Data Quality','Approved')
GROUP BY LeadId

SELECT 
Id,
MIN(CallDate)FirstCall,
SUM(Calls)TotalCalls,
SUM(CallTime)/SUM(Calls) AverageCallTime
INTO #Calls
FROM
(
SELECT a.Id, MIN(act_date)CallDate, COUNT(seqno)Calls, SUM(time_connect)CallTime
FROM SalesforceReporting..call_history ch
inner join #Apps a ON ch.lm_filler2 = a.Id
WHERE call_type in (0,2,4)
GROUP BY a.Id
UNION
SELECT a.Id, MIN(act_date)CallDate, COUNT(seqno)Calls, SUM(time_connect)CallTime
FROM Enterprise..call_history ch
inner join #Apps a ON ch.lm_filler2 = a.Id
WHERE call_type in (0,2,4)
GROUP BY a.Id
) detail
GROUP BY detail.Id

SELECT lm_filler2, MAX(listId)List
INTO #Lists
FROM SalesforceReporting..call_history ch
inner join #Apps a ON ch.lm_filler2 = a.Id
WHERE ch.act_date = a.Date_Made__c
GROUP BY lm_filler2
UNION
SELECT lm_filler2, MAX(listId)List
FROM Enterprise..call_history ch
inner join #Apps a ON ch.lm_filler2 = a.Id
WHERE ch.act_date = a.Date_Made__c
GROUP BY lm_filler2

SELECT l.Id, case when cm.Name is null then CONVERT(varchar,lt.List) else cm.Name end List, c.FirstCall, CONVERT(date, adt.AppDateTime) AppDate, CONVERT(time, adt.AppDateTime) AppTime, c.TotalCalls, af.Sector, c.AverageCallTime, u.Name
FROM Salesforce..Lead l
inner join #Apps a ON l.Id = a.Id
left outer join Salesforce..[User] u ON l.BDC__c = u.Id
left outer join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code 2007]
left outer join #ADT adt ON l.Id = adt.LeadId
left outer join #Calls c ON l.Id = c.Id
left outer join #Lists lt ON l.Id = lt.lm_filler2
left outer join Salesforce..Campaign cm ON lt.list = cm.noblesys__listId__c

DROP TABLE #Apps
DROP TABLE #ADT
DROP TABLE #Calls
DROP TABLE #Lists