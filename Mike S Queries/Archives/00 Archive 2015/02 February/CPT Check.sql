SELECT Company
INTO #Prospects
FROM SalesforceReporting..CPT
WHERE
Phone in
(
SELECT REPLACE(case when phone like '0%' then Phone else '0'+Phone end,' ','')
FROM Salesforce..Lead
) or
Phone in
(
SELECT REPLACE(case when MobilePhone like '0%' then MobilePhone else '0'+MobilePhone end,' ','')
FROM Salesforce..Lead
) or
Phone in
(
SELECT REPLACE(case when Other_Phone__c like '0%' then Other_Phone__c else '0'+Other_Phone__c end,' ','')
FROM Salesforce..Lead
)

SELECT Company
INTO #Clients
FROM SalesforceReporting..CPT
WHERE
Phone in
(
SELECT REPLACE(case when phone like '0%' then Phone else '0'+Phone end,' ','')
FROM Salesforce..Account
WHERE Type = 'Client'
)

SELECT Company
INTO #PastClients
FROM SalesforceReporting..CPT
WHERE
Phone in
(
SELECT REPLACE(case when phone like '0%' then Phone else '0'+Phone end,' ','')
FROM Salesforce..Account
WHERE Type = 'Past Client'
)

SELECT cpt.*,
Case when p.Company is not null then 'Yes' else 'No' end Prospect,
Case when c.Company is not null then 'Yes' else 'No' end Client,
Case when pc.Company is not null then 'Yes' else 'No' end [Past Client]
FROM SalesforceReporting..CPT cpt
left outer join #Clients c ON cpt.Company = c.Company
left outer join #PastClients pc ON cpt.Company = pc.Company
left outer join #Prospects p ON cpt.Company = pc.Company

DROP TABLE #Clients
DROP TABLE #PastClients
DROP TABLE #Prospects