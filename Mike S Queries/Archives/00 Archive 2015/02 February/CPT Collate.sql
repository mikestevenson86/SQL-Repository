SELECT *
FROM SalesforceReporting..CPT
WHERE
Phone not in
(
SELECT REPLACE(case when phone like '0%' then Phone else '0'+Phone end,' ','')
FROM Salesforce..Lead
) and
Phone not in
(
SELECT REPLACE(case when MobilePhone like '0%' then MobilePhone else '0'+MobilePhone end,' ','')
FROM Salesforce..Lead
) and
Phone not in
(
SELECT REPLACE(case when Other_Phone__c like '0%' then Other_Phone__c else '0'+Other_Phone__c end,' ','')
FROM Salesforce..Lead
) and
Phone not in
(
SELECT REPLACE(case when phone like '0%' then Phone else '0'+Phone end,' ','')
FROM Salesforce..Account
WHERE Type = 'Client'
) and
Phone not in
(
SELECT REPLACE(case when phone like '0%' then Phone else '0'+Phone end,' ','')
FROM Salesforce..Account
WHERE Type = 'Past Client'
)