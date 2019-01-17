IF OBJECT_ID('SalesforceReporting.dbo.QMS_Bridge') IS NOT NULL
	BEGIN
		DROP TABLE SalesforceReporting.dbo.QMS_Bridge
	END

IF OBJECT_ID('SalesforceReporting.dbo.QMS_Lead_Bridge') IS NOT NULL
	BEGIN
		DROP TABLE SalesforceReporting.dbo.QMS_Lead_Bridge
	END

CREATE TABLE SalesforceReporting.dbo.QMS_Bridge
(
QMS_ID VarChar(20),
SFDC_ID VarChar(20)
)

	INSERT INTO SalesforceReporting.dbo.QMS_Bridge
	SELECT qms.QmsId, l.Id
	FROM Salesforce..Lead l
	inner join SalesforceReporting..QMS_Accounts_April17 qms ON l.Previous_Account__c = qms.sf_ID_account
	inner join Salesforce..Account a ON qms.sf_ID_account = a.Id
	WHERE ISNULL(qms.sf_ID_account,'') <> '' and a.Citation_Client__c = 'false'

	INSERT INTO SalesforceReporting.dbo.QMS_Bridge
	SELECT qms.QmsId, l.Id
	FROM Salesforce..Lead l
	inner join SalesforceReporting..QMS_Accounts_April17 qms ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
																= REPLACE(case when qms.Phone1A like '0%' then qms.Phone1A else '0'+qms.Phone1A end,' ','')
	WHERE ISNULL(qms.Phone1A,'') not in ('','0','0NULL')

	INSERT INTO SalesforceReporting.dbo.QMS_Bridge
	SELECT qms.QmsId, l.Id
	FROM Salesforce..Lead l
	inner join SalesforceReporting..QMS_Accounts_April17 qms ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
																= REPLACE(case when qms.Phone1A like '0%' then qms.Phone1A else '0'+qms.Phone1A end,' ','')
	WHERE ISNULL(qms.Phone1A,'') not in ('','0','0NULL')

	INSERT INTO SalesforceReporting.dbo.QMS_Bridge
	SELECT qms.QmsId, l.Id
	FROM Salesforce..Lead l
	inner join SalesforceReporting..QMS_Accounts_April17 qms ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
																= REPLACE(case when qms.Phone1A like '0%' then qms.Phone1A else '0'+qms.Phone1A end,' ','')
	WHERE ISNULL(qms.Phone1A,'') not in ('','0','0NULL')

	INSERT INTO SalesforceReporting.dbo.QMS_Bridge
	SELECT qms.QmsId, l.Id
	FROM Salesforce..Lead l
	inner join SalesforceReporting..QMS_Accounts_April17 qms ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
																= REPLACE(case when qms.Phone1B like '0%' then qms.Phone1B else '0'+qms.Phone1B end,' ','')
																
	WHERE ISNULL(qms.Phone1B,'') not in ('','0','0NULL')

	INSERT INTO SalesforceReporting.dbo.QMS_Bridge
	SELECT qms.QmsId, l.Id
	FROM Salesforce..Lead l
	inner join SalesforceReporting..QMS_Accounts_April17 qms ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
																= REPLACE(case when qms.Phone1B like '0%' then qms.Phone1B else '0'+qms.Phone1B end,' ','')
	
	WHERE ISNULL(qms.Phone1B,'') not in ('','0','0NULL')

	INSERT INTO SalesforceReporting.dbo.QMS_Bridge
	SELECT qms.QmsId, l.Id
	FROM Salesforce..Lead l
	inner join SalesforceReporting..QMS_Accounts_April17 qms ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
																= REPLACE(case when qms.Phone1B like '0%' then qms.Phone1B else '0'+qms.Phone1B end,' ','')
	WHERE ISNULL(qms.Phone1B,'') not in ('','0','0NULL')

	INSERT INTO SalesforceReporting.dbo.QMS_Bridge
	SELECT qms.QmsId, l.Id
	FROM Salesforce..Lead l
	inner join SalesforceReporting..QMS_Accounts_April17 qms ON REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(qms.Company,'Ltd',''),'Limited','')
															and REPLACE(l.Postalcode,' ','') = REPLACE(qms.Postal_Code1,' ','')
	WHERE ISNULL(qms.Company,'') <> '' and ISNULL(qms.Postal_Code1,'') <> ''

SELECT QMS_ID, SFDC_ID
INTO SalesforceReporting..QMS_Lead_Bridge
FROM
	(
		SELECT *, ROW_NUMBER () OVER (PARTITION BY QMS_ID, SFDC_ID ORDER BY QMS_ID) rn
		FROM SalesforceReporting..QMS_Bridge
	) detail
WHERE rn = 1
ORDER BY CONVERT(int, QMS_ID)

SELECT 
lk.QMS_ID, 
lk.SFDC_ID, 
qms.Company, 
qms.Add_1, 
qms.Add_2, 
qms.Add_3, 
qms.Postal_Code1, 
qms.Country1, 
qms.client_company_registration, 
qms.client_company_vat,
qms.Phone1A, 
qms.Phone1B, 
qms.Email, 
qms.k_ID_Contact, 
qms.sf_ID_account, 
qms.SF_Prospect_ID, 
rt.Name [Record Type], 
l.Source__c [Source], 
l.LeadSource [Prospect Source]

FROM 
SalesforceReporting.dbo.QMS_Lead_Bridge lk

inner join Salesforce..Lead l ON lk.SFDC_ID = l.Id
inner join SalesforceReporting..QMS_Accounts_April17 qms ON lk.QMS_ID = qms.QmsId
inner join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id

WHERE l.RecordTypeId not in ('012D0000000KKTvIAO','012D0000000NbJtIAK')

ORDER BY CONVERT(int, QMS_ID)

DROP TABLE SalesforceReporting..QMS_Bridge