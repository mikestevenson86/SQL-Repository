IF OBJECT_ID('tempdb..#AccountContacts') IS NOT NULL
	BEGIN
		DROP TABLE #AccountContacts
	END

IF OBJECT_ID('tempdb..#SiteContacts') IS NOT NULL
	BEGIN
		DROP TABLE #SiteContacts
	END
	
IF OBJECT_ID('Salesforce..Site_Junction__c_Load') IS NOT NULL
	BEGIN
		DROP TABLE Salesforce..Site_Junction__c_Load
	END

SELECT ISNULL(cl1.clientId, cl2.clientId) clientId, a.Id AccountId, sfc.Id SF_ContactId, sfc.FirstName, sfc.LastName
INTO #AccountContacts
FROM Salesforce..Contact sfc
left outer join Salesforce..Account a ON sfc.AccountId = a.Id
left outer join [database].shorthorn.dbo.cit_sh_clients cl1 ON a.Shorthorn_Id__c = cl1.clientId
left outer join [database].shorthorn.dbo.cit_sh_clients cl2 ON LEFT(a.Id, 15) collate latin1_general_CS_AS = LEFT(cl2.SFDC_AccountId, 15) collate latin1_general_CS_AS
WHERE a.IsActive__c = 'true'

SELECT ac.*, c.contactId, ISNULL(sfs1.Id, sfs2.ID) SF_SiteId, s.siteId, s.siteName
INTO #SiteContacts
FROM #AccountContacts ac
left outer join [database].shorthorn.dbo.cit_sh_sites s ON ac.clientId = s.clientId
left outer join [database].shorthorn.dbo.cit_sh_contacts c ON s.siteId = c.siteId and ac.FirstName = c.fName and ac.LastName = c.sName
left outer join Salesforce..Site__c sfs1 ON s.siteId = sfs1.SHsiteID__c
left outer join Salesforce..Site__c sfs2 ON LEFT(s.SFDC_SiteID, 15) collate latin1_general_CS_AS = LEFT(sfs2.Id, 15) collate latin1_general_CS_AS
WHERE ISNULL(sfs1.Id, sfs2.ID) is not null
ORDER BY FirstName, LastName

SELECT 
CAST('' as NCHAR(18)) Id,
nsc.AccountId Account__c, 
nsc.SF_ContactId Contact_Junction__c, 
nsc.SF_SiteId Site_Junction__c, 
nsc.contactId SH_Contact_Id__c, 
'true' IsActive__c,
case when shs.mainContactHS = nsc.ContactId then 1 else 0 end Main_H_S_Contact__c,
case when shs.secContactHS = nsc.ContactId then 1 else 0 end Secondary_H_S_Contact__c,
case when shs.mainContactPEL = nsc.ContactId then 1 else 0 end Main_PEL_Contact__c,
case when shs.secContactPEL = nsc.ContactId then 1 else 0 end Secondary_PEL_Contact__c,
case when shs.genContact = nsc.ContactId then 1 else 0 end Main_Site_Contact__c,
case when shs.SecContact = nsc.ContactId then 1 else 0 end Secondary_Site_Contact__c,
case when shs.citManSuper = nsc.ContactId then 1 else 0 end Citweb_Super_User__c,
CAST('' as NVarChar(255)) Error

INTO
Salesforce..Site_Junction__c_Load

FROM 
#SiteContacts nsc
left outer join Salesforce..Site_Junction__c sj ON nsc.SF_ContactId = sj.Contact_Junction__c and nsc.SF_SiteId = sj.Site_Junction__c
left outer join [database].shorthorn.dbo.cit_sh_sites shs ON nsc.siteId = shs.siteId
WHERE sj.Id is null and nsc.contactId is not null

exec Salesforce..SF_BulkOps 'Insert:batchsize(100)','Salesforce','Site_Junction__c_Load'