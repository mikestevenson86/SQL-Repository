SELECT o.Id, o.CreatedDate, SAT_Date__c, StageName
FROM Salesforce..Opportunity o
inner join Salesforce..Account a ON o.AccountId = a.Id
inner join SalesforceReporting..QMS_Account_August2017 qms ON REPLACE(REPLACE(a.Name,'Ltd',''),'Limited','') = REPLACE(REPLACE(qms.Company,'Ltd',''),'Limited','')
															and REPLACE(a.BillingPostalCode,' ','') = REPLACE(qms.PostalCode,' ','')
WHERE CONVERT(date, DATEADD(Year,1,o.CreatedDate)) >= CONVERT(date, GETDATE()) and
ISNULL(qms.Company,'') <> '' and ISNULL(qms.PostalCode,'') <> '' and qms.CitationClient is null
UNION
SELECT o.Id, o.CreatedDate, SAT_Date__c, StageName
FROM Salesforce..Opportunity o
inner join Salesforce..Account a ON o.AccountId = a.Id
inner join SalesforceReporting..QMS_Account_August2017 qms ON REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','')
															= REPLACE(case when qms.Phone like '0%' then qms.Phone else '0'+qms.Phone end,' ','')
WHERE CONVERT(date, DATEADD(Year,1,o.CreatedDate)) >= CONVERT(date, GETDATE()) and 
ISNULL(qms.Phone,'') <> '' and qms.CitationClient is null
GROUP BY o.Id, o.CreatedDate, SAT_Date__c, StageName

SELECT a.Id, a.Name, a.CreatedDate, a.Type
FROM Salesforce..Account a
inner join SalesforceReporting..QMS_Account_August2017 qms ON REPLACE(REPLACE(a.Name,'Ltd',''),'Limited','') = REPLACE(REPLACE(qms.Company,'Ltd',''),'Limited','')
															and REPLACE(a.BillingPostalCode,' ','') = REPLACE(qms.PostalCode,' ','')
WHERE 
ISNULL(qms.Company,'') <> '' and ISNULL(qms.PostalCode,'') <> '' and qms.CitationClient is not null
UNION
SELECT a.Id, a.Name, a.CreatedDate, a.Type
FROM Salesforce..Account a
inner join SalesforceReporting..QMS_Account_August2017 qms ON REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','')
															= REPLACE(case when qms.Phone like '0%' then qms.Phone else '0'+qms.Phone end,' ','')
WHERE 
ISNULL(qms.Phone,'') <> '' and qms.CitationClient is not null
GROUP BY a.Id, a.Name, a.CreatedDate, a.Type