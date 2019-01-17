SELECT c.contactId, 
CASE WHEN s2.maincontactHS = c.contactid THEN 'Yes' ELSE 'No' END As MainContactHS,
CASE WHEN s3.maincontactPEL = c.contactid THEN 'Yes' ELSE 'No' END As MainContactPEL,
CASE WHEN s1.citManSuper = c.contactid THEN 'Yes' ELSE 'No' END As OnlineSuperUser
INTO #Roles
FROM [database].shorthorn.dbo.cit_sh_contacts c
left outer join [database].shorthorn.dbo.cit_sh_sites s1 ON c.siteID = s1.siteID and c.contactId = s1.genContact
left outer join [database].shorthorn.dbo.cit_sh_sites s2 ON c.siteID = s2.siteID and c.contactId = s2.mainContactHS
left outer join [database].shorthorn.dbo.cit_sh_sites s3 ON c.siteID = s3.siteID and c.contactId = s3.maincontactPEL
left outer join [database].shorthorn.dbo.cit_sh_sites s4 ON c.siteID = s4.siteID and c.contactId = s4.citManSuper

SELECT c.contactId, sf.Id
INTO #Temp
FROM [database].shorthorn.dbo.cit_sh_contacts c
inner join Salesforce..Contact sf ON
c.fName = sf.FirstName and c.sName = sf.LastName and c.Email = sf.Email
WHERE sf.Shorthorn_Id__c is null

SELECT t.Id SFDC_ContactId ,c.contactID Shorthorn_Id__c, r.MainContactHS, r.MainContactPEL, r.OnlineSuperUser
FROM [database].shorthorn.dbo.cit_sh_contacts c
left outer join #Temp t ON c.contactId = t.contactId
left outer join #Roles r ON c.contactId = r.contactId
WHERE t.contactId is not null

DROP TABLE #Roles
DROP TABLE #Temp