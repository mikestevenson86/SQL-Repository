SELECT clientID
INTO #SHC
FROM [database].shorthorn.dbo.cit_sh_deals
WHERE renewDate > GETDATE() and dealStatus not in (2,5,10,18) 
GROUP BY clientId

SELECT s.siteID, sfs.ID, s.siteName, sfs.Name
FROM [database].shorthorn.dbo.cit_sh_sites s
inner join Salesforce..Site__c sfs ON s.siteId = sfs.SHsiteID__c
WHERE s.SFDC_SiteId is null

SELECT s.siteID, sfs.ID, s.siteName, sfs.Name
FROM [database].shorthorn.dbo.cit_sh_sites s
inner join Salesforce..Site__c sfs ON LEFT(s.SFDC_SiteID,15) collate latin1_general_CS_AS = LEFT(sfs.Id, 15) collate latin1_general_CS_AS
WHERE sfs.SHsiteID__c is null

SELECT s.siteId [Shorthorn ID], s.SFDC_SiteID [Shorthorn SF Link], sfs.Id [New Link], s.siteName [Shorthorn Name], sfs.Name [Linked SF Name],
case when shc.clientId is not null then 'Yes' else 'No' end ShorthornActive,
case when sfa.IsActive__c = 'true' then 'Yes' else 'No' end SalesforceActive
FROM [database].shorthorn.dbo.cit_sh_sites s
inner join Salesforce..Site__c sfs ON s.siteID = sfs.SHSiteId__c
inner join Salesforce..Account sfa ON sfs.Account__c = sfa.Id
left outer join #SHC shc ON s.clientID = shc.clientId
WHERE LEFT(sfs.Id, 15) collate latin1_general_CS_AS <> LEFT(s.SFDC_SiteID,15) collate latin1_general_CS_AS

SELECT s.siteId [Shorthorn ID], s.SFDC_SiteID [Shorthorn SF Link], s.siteName [Shorthorn Name], sfs.Name [Linked SF Name],
case when shc.clientId is not null then 'Yes' else 'No' end ShorthornActive,
case when sfa.IsActive__c = 'true' then 'Yes' else 'No' end SalesforceActive
FROM [database].shorthorn.dbo.cit_sh_sites s
inner join Salesforce..Site__c sfs ON LEFT(sfs.Id, 15) collate latin1_general_CS_AS = LEFT(s.SFDC_SiteID,15) collate latin1_general_CS_AS
inner join Salesforce..Account sfa ON sfs.Account__c = sfa.Id
left outer join #SHC shc ON s.clientID = shc.clientId
WHERE s.siteID <> sfs.SHSiteId__c

DROP TABLE #SHC