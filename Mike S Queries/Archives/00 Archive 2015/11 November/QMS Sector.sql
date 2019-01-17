SELECT AccountId
INTO #NBS
FROM Salesforce..Contract
WHERE RecordTypeId = '012D0000000Nav7IAC'

SELECT AccountId, FirstName, LastName, Position__c, Email, Phone
INTO #TopContact
FROM
(
SELECT AccountId, FirstName, LastName, Position__c, Email, Phone, ROW_NUMBER () OVER (PARTITION BY AccountId ORDER BY Id) rn
FROM Salesforce..Contact c
WHERE Email is not null and Phone is not null
) detail
WHERE detail.rn = 1

SELECT l.Id
INTO #Temp
FROM Salesforce..Account l
left outer join SalesforceReporting..QMSClients cl ON REPLACE(case when Phone like '0%' then Phone else '0'+Phone end,' ','') = REPLACE(case when cl.Phone1 like '0%' then cl.Phone1 else '0'+cl.Phone1 end,' ','')
WHERE cl.Id is null

SELECT l.Id, l.Name Company, FirstName, LastName, Position__c, l.BillingStreet, l.BillingCity, l.BillingState, l.BillingPostalCode, l.Phone, tc.Email,
SIC2007_Code__c, SIC2007_Description__c, SIC2007_Code2__c, SIC2007_Description2__c, SIC2007_Code3__c, SIC2007_Description3__c, Website
FROM Salesforce..Account l
inner join #Temp t ON l.Id = t.Id
left outer join SalesforceReporting..QMSClients cl ON REPLACE(BillingPostalCode,' ','') = REPLACE(PostCode,' ','')
													and REPLACE(REPLACE(l.Name,'Ltd',''),'Limited','') = REPLACE(REPLACE(cl.Company,'Ltd',''),'Limited','')
inner join Salesforce..Contract c ON l.Id = c.AccountId
left outer join #NBS n ON l.Id = n.AccountId
left outer join #TopContact tc ON l.Id = tc.AccountId
WHERE cl.Id is null and l.Phone is not null and l.Phone <> '' and c.StartDate <= GETDATE() and c.EndDate > DATEADD(month,18,GETDATE())
 and n.AccountId is null and CitationSector__c = 'Manufacturing'

DROP TABLE #Temp
DROP TABLE #NBS
DROP TABLE #TopContact