SELECT Phone
INTO #phone
FROM Salesforce..Lead
WHERE Phone is not null or Phone <> ''
UNION
SELECT MobilePhone Phone
FROM Salesforce..Lead
WHERE MobilePhone is not null or MobilePhone <> ''
UNION
SELECT Other_Phone__c Phone
FROM Salesforce..Lead
WHERE Other_Phone__c is not null or Other_Phone__c <> ''

SELECT COUNT(*)Leads, REPLACE(case when Phone not like '0%' then '0'+Phone else Phone end,' ','') Phone
INTO #PhoneCount
FROM #phone
GROUP BY REPLACE(case when Phone not like '0%' then '0'+Phone else Phone end,' ','')

SELECT Id, 'Open' Status, '' Suspended_Closed_Reason__c
FROM Salesforce..Lead l
WHERE Completed_Date__c = '2015-02-14' and Source__c = 'ML Update' and Suspended_Closed_Reason__c = 'Duplicate' and
(
REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') in
(
SELECT p.Phone
FROM #PhoneCount p
WHERE Leads = 1
)
and REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','') in
(
SELECT p.Phone
FROM #PhoneCount p
WHERE Leads = 1
)
and REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','') in
(
SELECT p.Phone
FROM #PhoneCount p
WHERE Leads = 1
)
)

DROP TABLE #Phone
DROP TABLE #PhoneCount