SELECT Id
FROM
(
SELECT ID
FROM Salesforce..Lead l
inner join SalesforceReporting..GrowthIntelJuly2 g ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
													= REPLACE(case when g.Phone like '0%' then g.Phone else '0'+g.Phone end,' ','')
WHERE RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KKTvIAO') or RecordTypeId is null
UNION
SELECT ID
FROM Salesforce..Lead l
inner join SalesforceReporting..GrowthIntelJuly2 g ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
													= REPLACE(case when g.Phone like '0%' then g.Phone else '0'+g.Phone end,' ','')
WHERE RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KKTvIAO') or RecordTypeId is null
UNION
SELECT ID
FROM Salesforce..Lead l
inner join SalesforceReporting..GrowthIntelJuly2 g ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
													= REPLACE(case when g.Phone like '0%' then g.Phone else '0'+g.Phone end,' ','')
WHERE RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KKTvIAO') or RecordTypeId is null
UNION
SELECT ID
FROM Salesforce..Lead l
inner join SalesforceReporting..GrowthIntelJuly2 g ON REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(g.Company,'Ltd',''),'Limited','')
													and REPLACE(l.PostalCode,' ','') = REPLACE(g.PostalCode,' ','')
WHERE RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KKTvIAO') or RecordTypeId is null
) detail