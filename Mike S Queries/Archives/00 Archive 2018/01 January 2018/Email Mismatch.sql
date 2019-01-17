SELECT *
FROM
(
SELECT c.Id, contactId, s.clientId, c.Name SFDC_Name, con.fName + ' ' + con.sName SH_Name, c.Email SFDC_Email, con.Email SH_Email
FROM Salesforce..Contact c
inner join [database].shorthorn.dbo.cit_sh_contacts con ON c.Id = con.SFDC_ContactId
inner join [database].shorthorn.dbo.cit_sh_sites s ON con.siteId = s.siteId
WHERE ISNULL(c.Email, '') <> ISNULL(con.Email, '')
UNION
SELECT c.Id, contactId, s.clientId, c.Name SFDC_Name, con.fName + ' ' + con.sName SH_Name, c.Email SFDC_Email, con.Email SH_Email
FROM Salesforce..Contact c
inner join [database].shorthorn.dbo.cit_sh_contacts con ON c.Id = con.SFDC_ContactId
inner join [database].shorthorn.dbo.cit_sh_sites s ON con.siteId = s.siteId
WHERE ISNULL(c.Email, '') <> ISNULL(con.Email, '')
UNION
SELECT c.Id, contactId, s.clientId, c.Name SFDC_Name, con.fName + ' ' + con.sName SH_Name, c.Email SFDC_Email, con.Email SH_Email
FROM Salesforce..Contact c
inner join Salesforce..Account a ON c.AccountId = a.Id
inner join [database].shorthorn.dbo.cit_sh_clients cl ON a.Shorthorn_Id__c = cl.clientId
inner join [database].shorthorn.dbo.cit_sh_sites s ON cl.clientId = s.clientId
inner join [database].shorthorn.dbo.cit_sh_contacts con ON s.siteId = con.siteId 
															and ISNULL(c.FirstName, '') + ISNULL(c.LastName, '') + CONVERT(VarChar, cl.ClientId) 
															= ISNULL(con.fName, '') + ISNULL(con.sName, '') + CONVERT(VarChar, cl.clientId)
WHERE ISNULL(c.Email, '') <> ISNULL(con.Email, '')
) detail
GROUP BY Id, contactId, clientId, SFDC_Name, SH_Name, SFDC_Email, SH_Email