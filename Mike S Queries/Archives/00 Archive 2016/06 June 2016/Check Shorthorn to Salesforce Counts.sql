SELECT COUNT(Id)
FROM Salesforce..Contact
WHERE Shorthorn_Id__c is not null

SELECT COUNT(contactId)
FROM [database].shorthorn.dbo.cit_sh_contacts
WHERE contactId is not null

SELECT COUNT(Id)
FROM Salesforce..Site__c
WHERE site__c.SHsiteID__c is not null

SELECT COUNT(SiteID)
FROM [database].shorthorn.dbo.cit_sh_sites
WHERE SiteId is not null

SELECT COUNT(Id)
FROM Salesforce..Account
WHERE Shorthorn_Id__c is not null

SELECT COUNT(clientId)
FROM [database].shorthorn.dbo.cit_sh_clients
WHERE clientID is not null

SELECT COUNT(Id)
FROM Salesforce..Contract
WHERE Shorthorn_Deal_Id__c is not null

SELECT COUNT(dealId)
FROM [database].shorthorn.dbo.cit_sh_deals
WHERE dealId is not null