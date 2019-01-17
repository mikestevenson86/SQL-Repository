IF OBJECT_ID('Salesforce..Site_Junction__c_Load') IS NOT NULL
	BEGIN
		DROP TABLE Salesforce..Site_Junction__c_Load
	END

IF OBJECT_ID('tempdb..#siteContacts') IS NOT NULL
	BEGIN
		DROP TABLE #siteContacts
	END

SELECT c.Id, c.Shorthorn_Id__c ContactId, ISNULL(c1.siteId, c2.siteId) SiteId
INTO #siteContacts
FROM Salesforce..Contact c
left outer join Salesforce..Account a ON c.AccountId = a.Id
left outer join Salesforce..Site_Junction__c sj ON c.Id = sj.Contact_Junction__c
left outer join [database].shorthorn.dbo.cit_sh_contacts c1 ON c.Shorthorn_Id__c = c1.contactId
left outer join [database].shorthorn.dbo.cit_sh_contacts c2 ON c.Id = c2.SFDC_ContactId
WHERE sj.Id is null and (c1.ContactId is not null or c2.ContactId is not null)

SELECT
--Verification Fields Not for Inserting 
a.Name AccountName, c.Name ContactName, c.Active__c Contact_Active, s.Name SiteName, s.Active__c Site_Active,
--Actual DBAmp Insert Fields
CAST('' as NCHAR(18)) Id,
a.Id Account__c,
sc.Id Contact_Junction__c, 
s.Id Site_Junction__c, 
case when c.Active__c = 'true' and s.Active__c = 'true' then 1 else 0 end IsActive__c,
sc.ContactId SH_Contact_Id__c,
case when shs.mainContactHS = sc.ContactId then 1 else 0 end Main_H_S_Contact__c,
case when shs.secContactHS = sc.ContactId then 1 else 0 end Secondary_H_S_Contact__c,
case when shs.mainContactPEL = sc.ContactId then 1 else 0 end Main_PEL_Contact__c,
case when shs.secContactPEL = sc.ContactId then 1 else 0 end Secondary_PEL_Contact__c,
case when shs.genContact = sc.ContactId then 1 else 0 end Main_Site_Contact__c,
case when shs.SecContact = sc.ContactId then 1 else 0 end Secondary_Site_Contact__c,
case when shs.citManSuper = sc.ContactId then 1 else 0 end Citweb_Super_User__c,
CAST('' as NVarChar(255)) Error

--INTO
--Salesforce..Site_Junction__c_Load

FROM 
#siteContacts sc
inner join Salesforce..Site__c s ON sc.SiteId = s.SHsiteID__c
inner join [database].shorthorn.dbo.cit_sh_sites shs ON sc.SiteId = shs.siteID
inner join Salesforce..Contact c ON sc.Id = c.Id
inner join Salesforce..Account a ON c.AccountId = a.Id
									and s.Account__c = a.Id
									
ORDER BY 
a.Name, c.Name, s.Name --Account, Contact, Site

--exec Salesforce..SF_BulkOps 'Insert:batchsize(100)','Salesforce','Site_Junction__c_Load'