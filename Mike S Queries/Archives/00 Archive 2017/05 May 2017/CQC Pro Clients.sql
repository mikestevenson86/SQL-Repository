CREATE TABLE #Temp
(
Id int Identity,
CQC_Id VarChar(20),
AccountId VarChar(20)
)

INSERT INTO #Temp
SELECT cqc.Id, a.Id
FROM SalesforceReporting..CQCProClients cqc
inner join Salesforce..Account a ON REPLACE(case when cqc.Phone like '0%' then cqc.Phone else '0'+cqc.Phone end,' ','')
									= REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','')
WHERE ISNULL(cqc.Phone,'') <> ''

INSERT INTO #Temp
SELECT cqc.Id, a.Id
FROM SalesforceReporting..CQCProClients cqc
inner join Salesforce..Account a ON REPLACE(case when cqc.Mobile like '0%' then cqc.Mobile else '0'+cqc.Mobile end,' ','')
									= REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','')
WHERE ISNULL(cqc.Mobile,'') <> ''

INSERT INTO #Temp
SELECT cqc.Id, a.Id
FROM SalesforceReporting..CQCProClients cqc
inner join Salesforce..Account a ON REPLACE(case when cqc.Other_Phone__c like '0%' then cqc.Other_Phone__c else '0'+cqc.Other_Phone__c end,' ','')
									= REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','')
WHERE ISNULL(cqc.Other_Phone__c,'') <> ''

INSERT INTO #Temp
SELECT cqc.Id, a.Id
FROM SalesforceReporting..CQCProClients cqc
inner join Salesforce..Account a ON REPLACE(REPLACE(cqc.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(a.Name,'Ltd',''),'Limited','')
									and REPLACE(cqc.PostalCode,' ','') = REPLACE(a.BillingPostalCode,' ','')
WHERE ISNULL(cqc.Company,'') <> '' and ISNULL(cqc.PostalCode,'') <> ''

DELETE FROM #Temp
WHERE Id in
(
	SELECT Id
	FROM
	(
		SELECT Id, ROW_NUMBER() OVER (PARTITION BY CQC_Id, AccountId ORDER BY (SELECT NULL)) rn
		FROM #Temp
	) detail
	WHERE rn > 1
)

SELECT cqc.*
FROM #Temp t
inner join SalesforceReporting..CQCProClients cqc ON t.CQC_Id = cqc.ID
inner join Salesforce..Account a ON t.AccountId = a.Id
WHERE Citation_Client__c = 'false'

SELECT cqc.*
FROM SalesforceReporting..CQCProClients cqc
left outer join #Temp t ON cqc.ID = t.CQC_Id
WHERE t.Id is null

SELECT *
FROM #Temp

DROP TABLE #Temp