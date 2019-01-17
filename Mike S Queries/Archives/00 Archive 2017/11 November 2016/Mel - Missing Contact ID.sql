/*
SELECT c.ID, FirstName, LastName, AccountId, ISNULL(shc.contactId, sfc.contactId) ContactId
FROM Salesforce..Contact c
left outer join Salesforce..Account a ON c.AccountId = a.Id
left outer join	(
				SELECT c.contactId, fName, sName, SFDC_AccountId
				FROM [database].shorthorn.dbo.cit_sh_contacts c
				inner join [database].shorthorn.dbo.cit_sh_sites s ON c.siteId = s.siteId
				inner join [database].shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientId
				) sfc ON REPLACE(c.FirstName+c.LastName+c.AccountId,' ','') = REPLACE(sfc.fName+sfc.sName+sfc.SFDC_AccountId,' ','')
left outer join	(
				SELECT c.contactId, fName, sName, clientId
				FROM [database].shorthorn.dbo.cit_sh_contacts c
				inner join [database].shorthorn.dbo.cit_sh_sites s ON c.siteId = s.siteId
				) shc  ON REPLACE(c.FirstName+c.LastName+CONVERT(VarChar, a.Shorthorn_Id__c),' ','') = REPLACE(shc.fName+shc.sName+CONVERT(VarChar, shc.clientId),' ','')
WHERE Active__c = 'true' and ISNULL(c.Shorthorn_Id__c, 0) = 0 --and ISNULL(a.Shorthorn_Id__c, 0) <> 0

SELECT c.ID, FirstName, LastName, AccountId
FROM Salesforce..Contact c
left outer join Salesforce..Account a ON c.AccountId = a.Id
WHERE Active__c = 'true' and ISNULL(c.Shorthorn_Id__c, 0) = 0 and ISNULL(a.Shorthorn_Id__c, 0) = 0 and a.IsActive__c = 'true'
*/

SELECT Id, Shorthorn_Id__c, a.Name, cl.companyName, cl.clientId, s.siteName, s.clientId
FROM Salesforce..Account a
left outer join [database].shorthorn.dbo.cit_sh_clients cl ON REPLACE(REPLACE(REPLACE(REPLACE(a.Name,' ',''),'Limted',''),'Ltd',''),'.','') 
																= 
																REPLACE(REPLACE(REPLACE(REPLACE(cl.companyName,' ',''),'Limted',''),'Ltd',''),'.','')
left outer join [database].shorthorn.dbo.cit_sh_sites s ON REPLACE(REPLACE(REPLACE(REPLACE(a.Name,' ',''),'Limted',''),'Ltd',''),'.','') 
																= 
																REPLACE(REPLACE(REPLACE(REPLACE(s.siteName,' ',''),'Limted',''),'Ltd',''),'.','')
WHERE IsActive__c = 'true' and ISNULL(Shorthorn_Id__c, 0) = 0