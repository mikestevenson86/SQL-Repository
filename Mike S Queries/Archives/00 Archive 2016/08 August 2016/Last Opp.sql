SELECT AccountId, MAX(o.CreatedDate) LastDate
INTO #LatestOpp
FROM Salesforce..Opportunity o
inner join Salesforce..RecordType rt ON o.RecordTypeId = rt.Id
WHERE rt.Name in ('Default Citation Opportunity','Renewal / Retention Opportunity - Non-Auto','Renewal / Retention Opportunity - Auto')
GROUP BY AccountId

SELECT 
a.Id, o.Id, o.CreatedDate
FROM 
Salesforce..Account a
inner join #LatestOpp lo ON a.Id = lo.AccountId
inner join Salesforce..Opportunity o ON a.Id = o.AccountId and lo.LastDate = o.CreatedDate
WHERE 
o.StageName = 'Closed Won'
ORDER BY
CloseDate DESC

DROP TABLE #LatestOpp