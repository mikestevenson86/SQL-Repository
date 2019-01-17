SELECT *
INTO #Joins
FROM
(
SELECT l.Id, qms.QMSId
FROM SalesforceReporting..QMS_Account_April2017 qms
inner join Salesforce..Lead l ON REPLACE(case when qms.Contact_Phone1A like '0%' then qms.Contact_Phone1A else '0'+qms.Contact_Phone1A end,' ','')
								= REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
WHERE ISNULL(Contact_Phone1A,'') not in ('','0','NULL')
UNION
SELECT l.Id, qms.QMSId
FROM SalesforceReporting..QMS_Account_April2017 qms
inner join Salesforce..Lead l ON REPLACE(case when qms.Contact_Phone1A like '0%' then qms.Contact_Phone1A else '0'+qms.Contact_Phone1A end,' ','')
								=  REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
WHERE ISNULL(Contact_Phone1A,'') not in ('','0','NULL')
UNION
SELECT l.Id, qms.QMSId
FROM SalesforceReporting..QMS_Account_April2017 qms
inner join Salesforce..Lead l ON REPLACE(case when qms.Contact_Phone1A like '0%' then qms.Contact_Phone1A else '0'+qms.Contact_Phone1A end,' ','')
								= REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
WHERE ISNULL(Contact_Phone1A,'') not in ('','0','NULL')
UNION
SELECT l.Id, qms.QMSId
FROM SalesforceReporting..QMS_Account_April2017 qms
inner join Salesforce..Lead l ON REPLACE(REPLACE(qms.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','')
								and REPLACE(qms.Contact_Postal_Code1,' ','') = REPLACE(l.PostalCode,' ','')
WHERE ISNULL(qms.Company,'') <> '' and ISNULL(qms.Contact_postal_Code1,'') <> ''
UNION
SELECT l.Id, qms.QMSId
FROM SalesforceReporting..QMS_Account_April2017 qms
inner join Salesforce..Lead l ON qms.client_company_registration = l.Co_Reg__c
WHERE ISNULL(qms.client_company_registration,'') <> ''
) detail
GROUP BY Id, QMSId

SELECT qms.*,j.Id, u.Name BDC, Status
FROM SalesforceReporting..QMS_Account_April2017 qms
left outer join #Joins j ON qms.QMSId = j.QmsId
left outer join Salesforce..Lead l ON j.Id = l.Id
left outer join Salesforce..[User] u ON l.BDC__c = u.Id
WHERE l.Status = 'Callback Requested'
ORDER BY CONVERT(int, qms.QMSId)

DROP TABLE #Joins