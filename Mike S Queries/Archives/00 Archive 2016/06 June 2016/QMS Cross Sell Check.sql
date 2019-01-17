SELECT AccountId, MIN(CreatedDate) MinDate
INTO #Temp
FROM Salesforce..Contact
GROUP BY AccountId

SELECT t.AccountId, FirstName, LastName
INTO #Contacts
FROM Salesforce..Contact c
inner join #Temp t ON c.AccountId = t.AccountId and c.CreatedDate = t.MinDate

SELECT o.AccountId, o.CreatedDate, 'Citation Cross Sell' LeadSource, u.Name, 
c.FirstName, c.LastName, a.Name, l.Rating, a.StandardToProvide__c, l.Status, l.Callback_Date_Time__c
FROM Salesforce..Opportunity o
inner join Salesforce..[User] u ON o.OwnerId = u.Id
inner join Salesforce..RecordType rt ON o.RecordTypeId = rt.Id
inner join Salesforce..Account a ON o.AccountId = a.Id
left outer join Salesforce..Lead l ON o.Id = l.ConvertedOpportunityId
left outer join #Contacts c ON a.Id = c.AccountId
WHERE rt.Name like '%QMS%' and l.Id is null

DROP TABLE #Contacts
DROP TABLE #Temp