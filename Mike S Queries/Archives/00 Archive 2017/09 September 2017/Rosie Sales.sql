SELECT ao.[Item Ref], ao.[Company Name], ao.[Sage Code], ISNULL(a.Id, sha.Id) [SFDC Account ID], ISNULL(a.Name, sha.Name) [Account Name]
FROM SalesforceReporting..Sales_New_August2017 ao
left outer join Salesforce..Account a ON ao.[Sage Code] = a.Sage_Id__c
left outer join [database].shorthorn.dbo.cit_sh_clients cl ON ao.[Sage Code] = cl.sagecode
left outer join Salesforce..Account sha ON cl.clientId = sha.Shorthorn_Id__c
WHERE a.Id is not null or sha.ID is not null