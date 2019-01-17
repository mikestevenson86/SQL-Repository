SELECT clientId, COUNT(siteId) sites
INTO #Sites
FROM [database].Shorthorn.dbo.cit_sh_sites
GROUP BY clientId

SELECT s.clientId, companyname, postcode, s.address1 + ' ' + s.address2 BillingStreet, s.town BillingCity, s.postcode BillingPostalCode
, s.genTelNoSpaces Phone, totEmployees FT_Employees__c, cl.sageCode Sage_Id__c
INTO #Clients
FROM [database].Shorthorn.dbo.cit_sh_sites s
inner join #Sites ss ON s.clientId = ss.clientId
inner join [database].Shorthorn.dbo.cit_sh_clients cl ON s.clientId = cl.clientId
WHERE ss.sites = 1 and cl.SFDC_AccountID is null
UNION
SELECT s.clientId, companyname, postcode, s.address1 + ' ' + s.address2 BillingStreet, s.town BillingCity, s.postcode BillingPostalCode
, s.genTelNoSpaces Phone, totEmployees FT_Employees__c, cl.sageCode Sage_Id__
FROM [database].Shorthorn.dbo.cit_sh_sites s
inner join [database].Shorthorn.dbo.cit_sh_clients cl ON s.clientId = cl.clientId
WHERE HeadOffice = 1 and cl.SFDC_AccountID is null

SELECT a.Id, cl.clientId
FROM Salesforce..Account a
inner join #Clients cl ON REPLACE(REPLACE(REPLACE(a.Name,'Ltd',''),'Limited',''),' ','') = REPLACE(REPLACE(REPLACE(cl.companyName,'Ltd',''),'Limited',''),' ','')
						and REPLACE(a.BillingPostalCode,' ','') = REPLACE(cl.postcode,' ','')
WHERE a.Shorthorn_Id__c is null

SELECT cl.clientId [Shorthorn_Id__c], cl.companyName, cl.BillingStreet, cl.BillingCity, cl.BillingPostalCode, cl.FT_Employees__c, 
cl.Sage_Id__c, cl.Phone
FROM #Clients cl
left outer join Salesforce..Account a ON REPLACE(REPLACE(REPLACE(cl.companyName,'Ltd',''),'Limited',''),' ','') = REPLACE(REPLACE(REPLACE(a.Name,'Ltd',''),'Limited',''),' ','')
						and REPLACE(cl.postcode,' ','') = REPLACE(a.BillingPostalCode,' ','')
WHERE a.Id is null

--SELECT *
--FROM #Clients

DROP TABLE #Sites
DROP TABLE #Clients