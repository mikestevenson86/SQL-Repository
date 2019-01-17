IF OBJECT_ID('tempdb..#BICSc') IS NOT NULL
	BEGIN
		DROP TABLE #BICSc
	END

CREATE TABLE #BICSc
(
SFDC_Id NCHAR(18),
BICSc_Id int
)

INSERT INTO #BICSc 
SELECT l.Id, b.ID
FROM SalesforceReporting..BICSc_PartnerMatch b
inner join Salesforce..Lead l ON REPLACE(case when b.Phone like '0%' then b.Phone else '0'+b.Phone end,' ','')
								= REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
WHERE ISNULL(b.Phone,'') <> ''

INSERT INTO #BICSc 
SELECT l.Id, b.ID
FROM SalesforceReporting..BICSc_PartnerMatch b
inner join Salesforce..Lead l ON REPLACE(case when b.Phone like '0%' then b.Phone else '0'+b.Phone end,' ','')
								= REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
WHERE ISNULL(b.Phone,'') <> ''

INSERT INTO #BICSc 
SELECT l.Id, b.ID
FROM SalesforceReporting..BICSc_PartnerMatch b
inner join Salesforce..Lead l ON REPLACE(case when b.Phone like '0%' then b.Phone else '0'+b.Phone end,' ','')
								= REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
WHERE ISNULL(b.Phone,'') <> ''

INSERT INTO #BICSc								
SELECT l.Id, b.ID
FROM SalesforceReporting..BICSc_PartnerMatch b
inner join Salesforce..Lead l ON REPLACE(REPLACE(b.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','')
								and REPLACE(b.Postcode,' ','') = REPLACE(l.PostalCode,' ','')
WHERE ISNULL(b.Company,'') <> '' and ISNULL(b.PostCode,'') <> ''
								
SELECT SFDC_Id, BICSc_Id FROM #BICSc GROUP BY SFDC_Id, BICSc_Id

SELECT * FROM SalesforceReporting..BICSc_PartnerMatch WHERE Id not in (SELECT BICSc_Id FROM #BICSc)