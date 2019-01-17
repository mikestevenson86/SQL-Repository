SELECT a.Id
INTO #Won
FROM Salesforce..Account a
left outer join Salesforce..Opportunity o ON a.Id = o.AccountId
WHERE IsActive__c = 'true' or o.StageName = 'Closed Won'
GROUP BY a.Id

SELECT o.AccountId
FROM Salesforce..Opportunity o
left outer join #Won w ON o.AccountId = w.Id
WHERE w.Id is null and StageName = 'Closed Lost' and CloseDate <= DATEADD(month,6,GETDATE())
GROUP BY o.AccountId

DROP TABLE #Won