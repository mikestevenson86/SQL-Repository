SELECT a.Id, a.Name, c.Id, c.Name, c.Active__c
FROM Salesforce..Account a
left outer join Salesforce..Contact c ON a.Id = c.AccountId
WHERE a.Citation_Client__c = 'true' and c.Active__c = 'true' and c.Email not like '%citation%'
ORDER BY a.Name, c.Name

SELECT a.Id, a.Name, c.Id, c.Name, c.Active__c
FROM Salesforce..Account a
left outer join Salesforce..Contact c ON a.Id = c.AccountId
left outer join Salesforce..Site_Junction__c sj ON c.Id = sj.Contact_Junction__c
WHERE a.Citation_Client__c = 'true' and a.IsActive__c = 'true' and c.Active__c = 'true' and sj.Id is null
ORDER BY a.Name, c.Name

SELECT a.Id, a.Name, c.Id, c.Name, c.Active__c, sj.Site_Junction__c
FROM Salesforce..Account a
left outer join Salesforce..Contact c ON a.Id = c.AccountId
left outer join Salesforce..Site_Junction__c sj ON c.Id = sj.Contact_Junction__c
WHERE a.Citation_Client__c = 'true' and a.IsActive__c = 'true' and c.Active__c = 'true' and sj.Id is not null
ORDER BY a.Name, c.Name