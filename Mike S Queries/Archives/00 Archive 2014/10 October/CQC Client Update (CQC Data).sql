
SELECT distinct(c.clientId), cqc.*, a.Id
INTO #Temp
FROM [database].shorthorn.dbo.cit_sh_sites c
inner join SalesforceReporting..[CQC Data] cqc ON c.postcode = cqc.PostalCode and REPLACE(c.genTel,' ','') = REPLACE(cqc.Phone,' ','')
inner join Salesforce..Account a ON c.clientID = a.Shorthorn_Id__c
left outer join Salesforce..Contract con ON a.Id collate latin1_general_CS_AS = con.AccountId collate latin1_general_CS_AS and con.StartDate <=GETDATE() and con.EndDate > GETDATE() and con.Cancellation_Date__c is null
inner join [database].shorthorn.dbo.cit_sh_deals d ON c.clientID = d.clientID
WHERE d.dealStatus not in (2,5,10,18) and d.renewDate >= GETDATE() and c.headoffice = 1

SELECT 
t.Id AccountId, 
t.Street MailingStreet, 
t.City MailingCity, 
t.State MailingState, 
t.PostalCode MailingPostalCode, 
t.Country MailingCountry, 
t.Phone, 
t.mobilephone__c MobilePhone, 
t.title, 
t.Title Salutation,
t.FirstName, 
t.Surname LastName, 
t.Position__c
FROM #Temp t
left outer join Salesforce..Contact c ON t.Id collate latin1_general_CS_AS = c.AccountId collate latin1_general_CS_AS
WHERE c.AccountId is null

DROP TABLE #Temp