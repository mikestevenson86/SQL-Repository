SELECT a.Id, a.Name, COUNT(ah.Id)
FROM Salesforce..Account a
inner join Salesforce..[User] u ON a.CreatedById = u.Id
left outer join Salesforce..Opportunity o ON a.Id = o.AccountId
left outer join Salesforce..AccountHistory ah ON a.Id = ah.AccountId
WHERE u.Name = 'salesforce admin' and a.TYPE <> 'Client' and o.AccountId is null
GROUP BY a.Id, a.Name