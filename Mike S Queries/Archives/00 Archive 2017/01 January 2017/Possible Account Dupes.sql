SELECT Id
FROM
(
SELECT l.Id
FROM Salesforce..Lead l
inner join Salesforce..Account a ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') = 
									REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','') 
WHERE l.Previous_Account__c <> a.Id and l.LeadSource not like '%cross%sell%' and l.Status <> 'Approved'
and l.RecordTypeId not in ('012D0000000KJv8IAG','012D0000000Ncc7IAC','012D0000000NckpIAC')
and l.Phone <> '' and l.Phone <> '0'
UNION
SELECT l.Id
FROM Salesforce..Lead l
inner join Salesforce..Account a ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','') = 
									REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','') 
WHERE l.Previous_Account__c <> a.Id and l.LeadSource not like '%cross%sell%' and l.Status <> 'Approved'
and l.RecordTypeId not in ('012D0000000KJv8IAG','012D0000000Ncc7IAC','012D0000000NckpIAC')
and l.MobilePhone <> '' and l.MobilePhone <> '0'
UNION
SELECT l.Id
FROM Salesforce..Lead l
inner join Salesforce..Account a ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','') = 
									REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','') 
WHERE l.Previous_Account__c <> a.Id and l.LeadSource not like '%cross%sell%' and l.Status <> 'Approved'
and l.RecordTypeId not in ('012D0000000KJv8IAG','012D0000000Ncc7IAC','012D0000000NckpIAC')
and l.Other_Phone__c <> '' and l.Other_Phone__c <> '0'
UNION
SELECT l.Id
FROM Salesforce..Lead l
inner join Salesforce..Account a ON REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(a.Name,'Ltd',''),'Limited','')
									and REPLACE(l.PostalCode,' ','') = REPLACE(a.BillingPostalCode,' ','')
WHERE l.Previous_Account__c <> a.Id and l.LeadSource not like '%cross%sell%' and l.Status <> 'Approved'
and l.RecordTypeId not in ('012D0000000KJv8IAG','012D0000000Ncc7IAC','012D0000000NckpIAC')
) detail
GROUP BY Id