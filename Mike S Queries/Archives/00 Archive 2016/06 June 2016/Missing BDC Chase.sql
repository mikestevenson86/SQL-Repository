SELECT OpportunityId, MAX(oh.CreatedDate) LastDate
INTO #LastSAT
FROM Salesforce..OpportunityFieldHistory oh
inner join Salesforce..[User] u ON oh.CreatedById = u.Id
WHERE Field = 'SAT_Date__c' and NewValue is not null and oh.CreatedDate > '2016-03-01' and u.Name = 'carole simister'
GROUP BY OpportunityId

SELECT o.Id, oh.NewValue, ls.LastDate, oh.CreatedDate, o.StageName
FROM Salesforce..Opportunity o
inner join #LastSAT ls ON o.Id = ls.OpportunityId
left outer join Salesforce..OpportunityFieldHistory oh ON o.Id = oh.OpportunityId and oh.Field = 'StageName'

WHERE oh.NewValue <> 'BDC Chase' and ls.LastDate <= DATEADD(day,-45,GETDATE()) and o.MADE_Criteria__c <> 'ISO SAT'

DROP TABLE #LastSAT