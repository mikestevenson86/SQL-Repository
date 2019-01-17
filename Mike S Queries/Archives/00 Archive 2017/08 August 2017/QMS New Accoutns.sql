IF OBJECT_ID('SalesforceReporting..QMSJoins') IS NOT NULL
	BEGIN
		DROP TABLE SalesforceReporting..QMSJoins
	END
	
CREATE TABLE SalesforceReporting..QMSJoins
(
Lead_Id NCHAR(18),
QMS_Id int
)

INSERT INTO SalesforceReporting..QMSJoins
SELECT l.Id, qms.Id
FROM SalesforceReporting..QMS_Account_August2017 qms 
inner join Salesforce..Lead l ON REPLACE(case when qms.Phone like '0%' then qms.Phone else '0'+qms.Phone end,' ','')
								= REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
WHERE qms.CitationClient is null and qms.LastYearsOpps is null and ISNULL(qms.Phone,'') <> ''

INSERT INTO SalesforceReporting..QMSJoins
SELECT l.Id, qms.Id
FROM SalesforceReporting..QMS_Account_August2017 qms 
inner join Salesforce..Lead l ON REPLACE(case when qms.Phone like '0%' then qms.Phone else '0'+qms.Phone end,' ','')
								= REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
WHERE qms.CitationClient is null and qms.LastYearsOpps is null and ISNULL(qms.Phone,'') <> ''

INSERT INTO SalesforceReporting..QMSJoins
SELECT l.Id, qms.Id
FROM SalesforceReporting..QMS_Account_August2017 qms 
inner join Salesforce..Lead l ON REPLACE(case when qms.Phone like '0%' then qms.Phone else '0'+qms.Phone end,' ','')
								= REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
WHERE qms.CitationClient is null and qms.LastYearsOpps is null and ISNULL(qms.Phone,'') <> ''

INSERT INTO SalesforceReporting..QMSJoins
SELECT l.Id, qms.Id
FROM SalesforceReporting..QMS_Account_August2017 qms 
inner join Salesforce..Lead l ON REPLACE(REPLACE(qms.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','')
								and REPLACE(qms.PostalCode,' ','') = REPLACE(l.PostalCode,' ','')
WHERE qms.CitationClient is null and qms.LastYearsOpps is null and ISNULL(qms.Company,'') <> '' and ISNULL(qms.PostalCode,'') <> ''

INSERT INTO SalesforceReporting..QMSJoins
SELECT l.Id, qms.Id
FROM SalesforceReporting..QMS_Account_August2017 qms 
inner join Salesforce..Lead l ON REPLACE(qms.Co_Reg__c,' ','') = REPLACE(l.Co_Reg__c,' ','')
WHERE qms.CitationClient is null and qms.LastYearsOpps is null and ISNULL(qms.Co_Reg__c,'') <> ''