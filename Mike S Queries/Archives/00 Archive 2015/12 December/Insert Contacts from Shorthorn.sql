SELECT c.contactId
INTO #Fuzzy
FROM [database].shorthorn.dbo.cit_sh_contacts c
inner join Salesforce..Contact sf ON
c.fName = sf.FirstName and c.sName = sf.LastName and c.Email = sf.Email
WHERE sf.Shorthorn_Id__c is null

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
WHERE s1.siteId is not null or s2.siteId is not null or s3.siteId is not null or s4.siteId is not null

SELECT c.*, r.MainContactHS, r.MainContactPEL, r.OnlineSuperUser, t.title, s.address1 + ' ' + s.address2 MailingStreet, s.town mailingCity, s.postcode MailingPostalcode
FROM [database].shorthorn.dbo.cit_sh_contacts c
inner join #Roles r ON c.contactId = r.contactId
left outer join Salesforce..Contact sf ON LEFT(c.contactId, 15) collate latin1_general_CS_AS = LEFT(sf.Shorthorn_Id__c, 15) collate latin1_general_CS_AS
left outer join #Fuzzy f ON c.contactId = f.contactId
left outer join [database].Shorthorn.dbo.cit_sh_titles t ON c.title = t.titleId
left outer join [database].shorthorn.dbo.cit_sh_sites s ON c.siteId = s.siteId
WHERE sf.Id is null and f.contactId is null

DROP TABLE #Fuzzy
DROP TABLE #Roles