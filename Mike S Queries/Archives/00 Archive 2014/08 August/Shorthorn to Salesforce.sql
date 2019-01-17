SELECT
a.Id,
c.clientID,
con.contactID,
con.fName + ' ' + con.sName Name,
con.position,
con.tel telephone,
con.mob,
con.email
FROM
Salesforce..Account a
inner join [database].shorthorn.dbo.cit_sh_clients c ON a.Shorthorn_Id__c = c.clientID or a.Name = c.companyName
inner join [database].shorthorn.dbo.cit_sh_sites s ON c.clientID = s.clientID and headoffice = 1
inner join [database].shorthorn.dbo.cit_sh_contacts con ON case when s.genContact = '' then s.clientID else s.genContact end = con.contactID
ORDER BY c.clientID

SELECT c.clientID, c.companyName, c.sageCode
INTO #Temp
FROM [database].shorthorn.dbo.cit_sh_clients c
inner join [database].shorthorn.dbo.cit_sh_deals d ON c.clientID = d.clientID
left outer join Salesforce..Account a ON c.clientID = a.Shorthorn_Id__c
WHERE d.dealStatus not in (2,5,10,18) and d.renewDate >= GETDATE() and Shorthorn_Id__c is null

SELECT t.clientID
INTO #Clients
FROM #Temp t
left outer join Salesforce..Account a ON t.sageCode = a.Sage_Id__c
WHERE a.Sage_Id__c is null

SELECT 
a.Id, 
c.clientID, 
s.SiteId,
s.HeadOffice,
con.contactID,
con.fName + ' ' + con.sName Name,
con.position,
con.tel telephone,
con.mob,
con.email
FROM [database].shorthorn.dbo.cit_sh_clients c
inner join [database].shorthorn.dbo.cit_sh_sites s ON c.clientID = s.clientID
inner join [database].shorthorn.dbo.cit_sh_contacts con ON s.genContact = con.contactID
inner join Salesforce..Account a ON REPLACE(con.tel,' ','') = REPLACE(a.Phone,' ','')
WHERE tel <> ''

DROP TABLE #Temp
DROP TABLE #Clients