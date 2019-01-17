SELECT 
a.Id, 
a.Name Client, 
a.Serivces_Taken__c [Services],
case when ubt.[Company Name] is not null then 'true' else 'false' end OnList,
ISNULL(Citation_Client__c,'false') IsClient,
MAX(c.StartDate) LatestContractStartDate
FROM Salesforce..Account a
left outer join SalesforceReporting..UBT_June2017 ubt ON REPLACE(REPLACE(a.Name,'Ltd',''),'Limited','') = REPLACE(REPLACE(ubt.[Company Name],'Ltd',''),'Limited','')
													and REPLACE(a.BillingPostalCode,' ','') = REPLACE(ubt.PostCode,' ','')
left outer join Salesforce..[Contract] c ON a.Id = c.AccountId
WHERE UBT_Client__c = 'true' and IsActive__c = 'true' and
CONVERT(date, StartDate) < CONVERT(date, GETDATE()) and CONVERT(date, EndDate) > CONVERT(date, GETDATE())
GROUP BY
a.Id, 
a.Name , 
a.Serivces_Taken__c ,
case when ubt.[Company Name] is not null then 'true' else 'false' end ,
ISNULL(Citation_Client__c,'false') 

SELECT ubt.[Company Name], ubt.Postcode, ubt.Grade
FROM SalesforceReporting..UBT_June2017 ubt 
left outer join Salesforce..Account a ON REPLACE(REPLACE(ubt.[Company Name],'Ltd',''),'Limited','') = REPLACE(REPLACE(a.Name,'Ltd',''),'Limited','')
										and REPLACE(ubt.PostCode,' ','') = REPLACE(a.BillingPostalCode,' ','')

WHERE a.Citation_Client__c = 'false'
ORDER BY [Company Name]

SELECT ubt.[Company Name], ubt.Postcode, ubt.Grade
FROM SalesforceReporting..UBT_June2017 ubt 
left outer join Salesforce..Account a ON REPLACE(REPLACE(ubt.[Company Name],'Ltd',''),'Limited','') = REPLACE(REPLACE(a.Name,'Ltd',''),'Limited','')
										and REPLACE(ubt.PostCode,' ','') = REPLACE(a.BillingPostalCode,' ','')

WHERE a.Id is null
ORDER BY [Company Name]

SELECT l.Id, l.Company Prospect, rt.Name RecordType
FROM Salesforce..Lead l
inner join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
inner join SalesforceReporting..UBT_June2017 ubt ON REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(ubt.[Company Name],'Ltd',''),'Limited','')
													and REPLACE(l.PostalCode,' ','') = REPLACE(ubt.PostCode,' ','')