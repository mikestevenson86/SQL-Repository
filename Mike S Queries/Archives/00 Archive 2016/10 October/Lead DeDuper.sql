UPDATE SalesforceReporting..LeadDupe
SET Dupe = 1
FROM SalesforceReporting..LeadDupe ld
left outer join Salesforce..Lead l ON ld.Id = l.ID
WHERE 
l.Id is null
and
REPLACE(case when ld.Phone like '0%' then ld.Phone else '0'+ld.Phone end,' ','') in
(
SELECT REPLACE(case when Phone like '0%' then Phone else '0'+Phone end,' ','')
FROM Salesforce..Lead
WHERE RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KKTvIAO') or RecordTypeId is null
)

UPDATE SalesforceReporting..LeadDupe
SET Dupe = 1
FROM SalesforceReporting..LeadDupe ld
left outer join Salesforce..Lead l ON ld.Id = l.ID
WHERE 
l.Id is null
and
REPLACE(case when ld.MobilePhone like '0%' then ld.MobilePhone else '0'+ld.MobilePhone end,' ','') in
(
SELECT REPLACE(case when Phone like '0%' then Phone else '0'+Phone end,' ','')
FROM Salesforce..Lead
WHERE RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KKTvIAO') or RecordTypeId is null
)

UPDATE SalesforceReporting..LeadDupe
SET Dupe = 1
FROM SalesforceReporting..LeadDupe ld
left outer join Salesforce..Lead l ON ld.Id = l.ID
WHERE 
l.Id is null
and
REPLACE(case when ld.Other_Phone__c like '0%' then ld.Other_Phone__c else '0'+ld.Other_Phone__c end,' ','') in
(
SELECT REPLACE(case when Phone like '0%' then Phone else '0'+Phone end,' ','')
FROM Salesforce..Lead
WHERE RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KKTvIAO') or RecordTypeId is null
)
------------------------------------------------------------------------------------------------------------
UPDATE SalesforceReporting..LeadDupe
SET Dupe = 1
FROM SalesforceReporting..LeadDupe ld
left outer join Salesforce..Lead l ON ld.Id = l.ID
WHERE 
l.Id is null
and
REPLACE(case when ld.Phone like '0%' then ld.Phone else '0'+ld.Phone end,' ','') in
(
SELECT REPLACE(case when MobilePhone like '0%' then MobilePhone else '0'+MobilePhone end,' ','')
FROM Salesforce..Lead
WHERE RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KKTvIAO') or RecordTypeId is null
)

UPDATE SalesforceReporting..LeadDupe
SET Dupe = 1
FROM SalesforceReporting..LeadDupe ld
left outer join Salesforce..Lead l ON ld.Id = l.ID
WHERE 
l.Id is null
and
REPLACE(case when ld.MobilePhone like '0%' then ld.MobilePhone else '0'+ld.MobilePhone end,' ','') in
(
SELECT REPLACE(case when MobilePhone like '0%' then MobilePhone else '0'+MobilePhone end,' ','')
FROM Salesforce..Lead
WHERE RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KKTvIAO') or RecordTypeId is null
)

UPDATE SalesforceReporting..LeadDupe
SET Dupe = 1
FROM SalesforceReporting..LeadDupe ld
left outer join Salesforce..Lead l ON ld.Id = l.ID
WHERE 
l.Id is null
and
REPLACE(case when ld.Other_Phone__c like '0%' then ld.Other_Phone__c else '0'+ld.Other_Phone__c end,' ','') in
(
SELECT REPLACE(case when MobilePhone like '0%' then MobilePhone else '0'+MobilePhone end,' ','')
FROM Salesforce..Lead
WHERE RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KKTvIAO') or RecordTypeId is null
)
--------------------------------------------------------------------------------------------------------------------------------
UPDATE SalesforceReporting..LeadDupe
SET Dupe = 1
FROM SalesforceReporting..LeadDupe ld
left outer join Salesforce..Lead l ON ld.Id = l.ID
WHERE 
l.Id is null
and
REPLACE(case when ld.Phone like '0%' then ld.Phone else '0'+ld.Phone end,' ','') in
(
SELECT REPLACE(case when Other_Phone__c like '0%' then Other_Phone__c else '0'+Other_Phone__c end,' ','')
FROM Salesforce..Lead
WHERE RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KKTvIAO') or RecordTypeId is null
)

UPDATE SalesforceReporting..LeadDupe
SET Dupe = 1
FROM SalesforceReporting..LeadDupe ld
left outer join Salesforce..Lead l ON ld.Id = l.ID
WHERE 
l.Id is null
and
REPLACE(case when ld.MobilePhone like '0%' then ld.MobilePhone else '0'+ld.MobilePhone end,' ','') in
(
SELECT REPLACE(case when Other_Phone__c like '0%' then Other_Phone__c else '0'+Other_Phone__c end,' ','')
FROM Salesforce..Lead
WHERE RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KKTvIAO') or RecordTypeId is null
)

UPDATE SalesforceReporting..LeadDupe
SET Dupe = 1
FROM SalesforceReporting..LeadDupe ld
left outer join Salesforce..Lead l ON ld.Id = l.ID
WHERE 
l.Id is null
and
REPLACE(case when ld.Other_Phone__c like '0%' then ld.Other_Phone__c else '0'+ld.Other_Phone__c end,' ','') in
(
SELECT REPLACE(case when Other_Phone__c like '0%' then Other_Phone__c else '0'+Other_Phone__c end,' ','')
FROM Salesforce..Lead
WHERE RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KKTvIAO') or RecordTypeId is null
)
-----------------------------------------------------------------------------------------------------------------
UPDATE SalesforceReporting..LeadDupe
SET Dupe = 1
FROM SalesforceReporting..LeadDupe ld
left outer join Salesforce..Lead l ON ld.Id = l.ID
inner join Salesforce..Lead l2 ON REPLACE(REPLACE(ld.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(l2.Company,'Ltd',''),'Limited','')
									and REPLACE(ld.PostalCode,' ','') = REPLACE(l2.PostalCode,' ','')
WHERE 
l.Id is null