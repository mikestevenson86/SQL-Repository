SELECT 
distinct(c.ClientID), 
s.address1+' '+s.address2 street, 
s.town, 
ct.county, 
s.postcode, 
a.Id, 
tt.title, 
con.fName,
con.sName,
con.position,
con.tel,
con.mob,
con.email,
ct.Country
INTO #Temp2
FROM [database].Shorthorn.dbo.cit_sh_clients c
inner join [database].shorthorn.dbo.cit_sh_deals d ON c.clientID = d.clientID
left outer join [database].shorthorn.dbo.cit_sh_sites s ON c.clientId = s.clientID and s.headoffice = 1
left outer join SalesforceReporting..[CQC Data] cqc ON s.postcode = cqc.PostalCode and REPLACE(s.genTel,' ','') = REPLACE(cqc.Phone,' ','')
left outer join Salesforce..Account a ON c.clientID = a.Shorthorn_Id__c
left outer join [database].shorthorn.dbo.cit_sh_contacts con ON s.genContact = con.contactId
left outer join [database].shorthorn.dbo.cit_sh_county ct ON s.county = ct.countyId
left outer join [database].shorthorn.dbo.cit_sh_titles tt ON con.title = tt.titleID
WHERE SectorTypeID = 1 and d.dealStatus not in (2,5,10,18) and d.renewDate >= GETDATE() and cqc.REFKEY is null
ORDER BY a.Id

SELECT 

t.Id AccountId, 
t.Street MailingStreet, 
t.town MailingCity, 
t.county MailingState, 
t.Country,
t.PostCode MailingPostalCode, 
t.tel phone, 
t.mob MobilePhone, 
t.title, 
t.Title Salutation,
t.FName FirstName, 
t.Sname LastName,
t.email Email,
t.Position Position__c
FROM #Temp2 t
left outer join Salesforce..Contact c ON t.Id collate latin1_general_CS_AS = c.AccountId collate latin1_general_CS_AS
WHERE c.AccountId is null

DROP TABLE #Temp2