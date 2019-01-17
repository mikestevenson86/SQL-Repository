SELECT clientID
INTO #SHC
FROM [database].shorthorn.dbo.cit_sh_deals
WHERE renewDate > GETDATE() and dealStatus not in (2,5,10,18) 
GROUP BY clientId

SELECT cl.clientID, sfa.ID, cl.companyName, sfa.Name
FROM [database].shorthorn.dbo.cit_sh_clients cl
inner join Salesforce..Account sfa ON cl.clientId = sfa.Shorthorn_Id__c
WHERE SFDC_AccountID is null

SELECT cl.clientID, sfa.ID, cl.companyName, sfa.Name
FROM [database].shorthorn.dbo.cit_sh_clients cl
inner join Salesforce..Account sfa ON LEFT(cl.SFDC_AccountID,15) collate latin1_general_CS_AS = LEFT(sfa.Id, 15) collate latin1_general_CS_AS
WHERE sfa.Shorthorn_Id__c is null

SELECT cl.clientId [Shorthorn ID], cl.SFDC_AccountID [Shorthorn Salesforce ID], sfa.Id [Linked SF ID], cl.companyName [Shorthorn Name], sfa.Name [Linked SF Name],
case when shc.clientId is not null then 'Yes' else 'No' end ShorthornActive,
case when sfa.IsActive__c = 'true' then 'Yes' else 'No' end SalesforceActive
FROM [database].shorthorn.dbo.cit_sh_clients cl
inner join Salesforce..Account sfa ON cl.clientID = sfa.Shorthorn_Id__c
left outer join #SHC shc ON cl.clientID = shc.clientId
WHERE LEFT(sfa.Id, 15) collate latin1_general_CS_AS <> LEFT(cl.SFDC_AccountID,15) collate latin1_general_CS_AS

SELECT sfa.Id [Salesforce ID], sfa.Shorthorn_Id__c [Salesforce Shorthorn ID], cl.clientID [Linked SH ID], sfa.Name [Salesforce Name], cl.companyName [Linked SH Name],
case when shc.clientId is not null then 'Yes' else 'No' end ShorthornActive,
case when sfa.IsActive__c = 'true' then 'Yes' else 'No' end SalesforceActive
FROM [database].shorthorn.dbo.cit_sh_clients cl
inner join Salesforce..Account sfa ON LEFT(sfa.Id, 15) collate latin1_general_CS_AS = LEFT(cl.SFDC_AccountID,15) collate latin1_general_CS_AS
left outer join #SHC shc ON cl.clientID = shc.clientId
WHERE cl.clientID <> sfa.Shorthorn_Id__c

DROP TABLE #SHC