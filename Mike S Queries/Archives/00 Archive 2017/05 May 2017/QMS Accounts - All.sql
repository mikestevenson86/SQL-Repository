DELETE FROM SalesforceReporting..QMS_Accounts_May2017
WHERE QMSId in
(
SELECT QMSId
FROM SalesforceReporting..QMS_Accounts_May2017 qms
inner join Salesforce..Account a ON REPLACE(case when Phone1A like '0%' then Phone1A else '0'+Phone1A end,' ','')
									= REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','')
inner join Salesforce..Opportunity o ON a.Id = o.AccountId
WHERE Phone1A <> '' and o.CreatedDate > DATEADD(Year,-1,GETDATE())
UNION
SELECT QMSId
FROM SalesforceReporting..QMS_Accounts_May2017 qms
inner join Salesforce..Account a ON REPLACE(case when Phone1B like '0%' then Phone1B else '0'+Phone1B end,' ','')
									= REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','')
inner join Salesforce..Opportunity o ON a.Id = o.AccountId
WHERE Phone1B <> '' and o.CreatedDate > DATEADD(Year,-1,GETDATE())
UNION
SELECT QMSId
FROM SalesforceReporting..QMS_Accounts_May2017 qms
inner join Salesforce..Account a ON REPLACE(REPLACE(qms.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(a.Name,'Ltd',''),'Limited','')
									and REPLACE(qms.Postal_Code1,' ','') = REPLACE(a.BillingPostalCode,' ','')
inner join Salesforce..Opportunity o ON a.Id = o.AccountId
WHERE Company <> '' and Postal_Code1 <> '' and o.CreatedDate > DATEADD(Year,-1,GETDATE())
)
