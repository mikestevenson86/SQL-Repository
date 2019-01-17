SELECT sj.Id, 
ca.Id + ' - ' + ca.Name SFDC_ContactAccount, CONVERT(VarChar, ca.Shorthorn_Id__c) + ' - ' + clc.companyName SH_ContactClient, 
sa.Id + ' - ' + sa.Name SFDC_SiteAccount, CONVERT(VarChar, sa.Shorthorn_Id__c) + ' - ' + cls.companyName SH_SiteClient
FROM Salesforce..Site_junction__c sj
inner join 
(
SELECT [Id]
FROM [Salesforce].[dbo].[SiteJunction_Update]
GROUP BY Id
) sju ON sj.Id = sju.Id
left outer join Salesforce..Contact c ON sj.Contact_Junction__c = c.Id
left outer join Salesforce..Account ca ON c.AccountId = ca.Id
left outer join [database].shorthorn.dbo.cit_sh_clients clc ON ca.Shorthorn_Id__c = clc.ClientId
left outer join Salesforce..Site__c s ON sj.Site_Junction__c = s.Id
left outer join Salesforce..Account sa ON s.Account__c = sa.Id
left outer join [database].shorthorn.dbo.cit_sh_clients cls ON sa.Shorthorn_Id__c = cls.ClientId
WHERE ca.Id is not null and sa.Id is not null and c.AccountId <> s.Account__c