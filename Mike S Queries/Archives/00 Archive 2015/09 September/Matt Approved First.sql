SELECT LeadId
INTO #Pended
FROM Salesforce..LeadHistory
WHERE Field = 'Status' and NewValue = 'Pended'
GROUP BY LeadId

SELECT l.Id,
case when o.SAT_Date__c is not null then 'Yes' else 'No' end SAT,
case when l.Approved_Date__c <= DATEADD(day,7,l.Date_Made__c) then 'Yes' else 'No' end WithinSeven,
case when l.Approved_Date__c <= DATEADD(day,7,l.Date_Made__c) and o.StageName = 'Closed Won' then 'Yes' else 'No' end WithinSevenConverted,
case when l.Approved_Date__c > DATEADD(day,7,l.Date_Made__c) then 'Yes' else 'No' end OutsideSeven,
case when l.Approved_Date__c > DATEADD(day,7,l.Date_Made__c) and o.StageName = 'Closed Won' then 'Yes' else 'No' end OutsideSevenConverted
FROM Salesforce..Lead l
left outer join #Pended p ON l.Id = p.LeadId
left outer join Salesforce..Opportunity o ON l.ConvertedOpportunityId = o.Id
WHERE l.Approved_Date__c between '2015-08-01' and '2015-08-31' and p.LeadId is null

DROP TABLE #Pended