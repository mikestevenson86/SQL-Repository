SELECT c.Id, c.Email, c2.Email
FROM Salesforce..Contact c
inner join Salesforce..Account a ON c.AccountId = a.Id
inner join Salesforce..Contact c2 ON c.Email = c2.Email and c2.Active__c = 'true'
WHERE c.Active__c = 'false' and ISNULL(c.Email, '') <> ''