IF OBJECT_ID('SalesforceReporting..DupeBin') IS NOT NULL 
	BEGIN
		DROP TABLE SalesforceReporting..DupeBin
	END

SELECT *
INTO SalesforceReporting..DupeBin
FROM
	(
	SELECT detail.Id, detail.OtherID, l.CreatedDate, ol.CreatedDate OtherCreatedDate
	FROM
		(
		SELECT l.Id, ll.Id OtherID
		FROM Salesforce..Lead l
		inner join Salesforce..Lead ll ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') =
											REPLACE(case when ll.Phone like '0%' then ll.Phone else '0'+ll.Phone end,' ','')
											and l.Id <> ll.Id
		WHERE ISNULL(l.Phone,'') <> '' and ll.Data_Supplier__c = 'CI_July_2016' and l.CreatedDate < ll.CreatedDate
		UNION
		SELECT l.Id, ll.Id OtherID
		FROM Salesforce..Lead l
		inner join Salesforce..Lead ll ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') =
											REPLACE(case when ll.MobilePhone like '0%' then ll.MobilePhone else '0'+ll.MobilePhone end,' ','')
											and l.Id <> ll.Id
		WHERE ISNULL(l.Phone,'') <> '' and ll.Data_Supplier__c = 'CI_July_2016' and l.CreatedDate < ll.CreatedDate
		UNION
		SELECT l.Id, ll.Id OtherID
		FROM Salesforce..Lead l
		inner join Salesforce..Lead ll ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') =
											REPLACE(case when ll.Other_Phone__c like '0%' then ll.Other_Phone__c else '0'+ll.Other_Phone__c end,' ','')
											and l.Id <> ll.Id
		WHERE ISNULL(l.Phone,'') <> '' and ll.Data_Supplier__c = 'CI_July_2016' and l.CreatedDate < ll.CreatedDate
		UNION
		SELECT l.Id, ll.Id OtherID
		FROM Salesforce..Lead l
		inner join Salesforce..Lead ll ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','') =
											REPLACE(case when ll.Phone like '0%' then ll.Phone else '0'+ll.Phone end,' ','')
											and l.Id <> ll.Id

		WHERE ISNULL(l.MobilePhone,'') <> '' and ll.Data_Supplier__c = 'CI_July_2016' and l.CreatedDate < ll.CreatedDate
		UNION
		SELECT l.Id, ll.Id OtherID
		FROM Salesforce..Lead l
		inner join Salesforce..Lead ll ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','') =
											REPLACE(case when ll.MobilePhone like '0%' then ll.MobilePhone else '0'+ll.MobilePhone end,' ','')
											and l.Id <> ll.Id

		WHERE ISNULL(l.MobilePhone,'') <> '' and ll.Data_Supplier__c = 'CI_July_2016' and l.CreatedDate < ll.CreatedDate
		UNION
		SELECT l.Id, ll.Id OtherID
		FROM Salesforce..Lead l
		inner join Salesforce..Lead ll ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','') =
											REPLACE(case when ll.Other_Phone__c like '0%' then ll.Other_Phone__c else '0'+ll.Other_Phone__c end,' ','')
											and l.Id <> ll.Id

		WHERE ISNULL(l.MobilePhone,'') <> '' and ll.Data_Supplier__c = 'CI_July_2016' and l.CreatedDate < ll.CreatedDate
		UNION
		SELECT l.Id, ll.Id OtherID
		FROM Salesforce..Lead l
		inner join Salesforce..Lead ll ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','') =
											REPLACE(case when ll.Phone like '0%' then ll.Phone else '0'+ll.Phone end,' ','')
											and l.Id <> ll.Id

		WHERE ISNULL(l.Other_Phone__c,'') <> '' and ll.Data_Supplier__c = 'CI_July_2016' and l.CreatedDate < ll.CreatedDate
		UNION
		SELECT l.Id, ll.Id OtherID
		FROM Salesforce..Lead l
		inner join Salesforce..Lead ll ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','') =
											REPLACE(case when ll.MobilePhone like '0%' then ll.MobilePhone else '0'+ll.MobilePhone end,' ','')
											and l.Id <> ll.Id

		WHERE ISNULL(l.Other_Phone__c,'') <> '' and ll.Data_Supplier__c = 'CI_July_2016' and l.CreatedDate < ll.CreatedDate
		UNION
		SELECT l.Id, ll.Id OtherID
		FROM Salesforce..Lead l
		inner join Salesforce..Lead ll ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','') =
											REPLACE(case when ll.Other_Phone__c like '0%' then ll.Other_Phone__c else '0'+ll.Other_Phone__c end,' ','')
											and l.Id <> ll.Id

		WHERE ISNULL(l.Other_Phone__c,'') <> '' and ll.Data_Supplier__c = 'CI_July_2016' and l.CreatedDate < ll.CreatedDate
		UNION
		SELECT l.Id, ll.Id OtherID
		FROM Salesforce..Lead l
		inner join Salesforce..Lead ll ON REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(ll.Company,'Ltd',''),'Limited','')
											and REPLACE(l.PostalCode,' ','') = REPLACE(ll.PostalCode,' ','')
											and l.Id <> ll.Id

		WHERE  ll.Data_Supplier__c = 'CI_July_2016' and l.CreatedDate < ll.CreatedDate
		UNION
		SELECT l.Id, ll.Id OtherID
		FROM Salesforce..Lead l
		inner join Salesforce..Lead ll ON l.Market_Location_URN__c = ll.Market_Location_URN__c
											and l.Id <> ll.Id

		WHERE  ll.Data_Supplier__c = 'CI_July_2016' and l.CreatedDate < ll.CreatedDate
		) detail
	inner join Salesforce..Lead l ON detail.Id = l.Id
	inner join Salesforce..Lead ol ON detail.OtherID = ol.Id

	GROUP BY detail.Id, detail.OtherID, l.CreatedDate, ol.CreatedDate
	) detail
WHERE CreatedDate < OtherCreatedDate
ORDER BY CreatedDate, OtherCreatedDate
----------------------------------------------------------------------------------------------------------------------------------------
SELECT OtherId Id, l.Data_Supplier__c, l.Source__c
FROM SalesforceReporting..DupeBin db
inner join Salesforce..Lead l ON db.OtherId = l.Id
WHERE Status not in ('Callback Requested','Data Quality','Pended','Approved')
and (Source__c not like '%Growth%Intel%' or Source__c is null) and (Data_Supplier__c not like '%Growth%Intel%' or Data_Supplier__c is null)
	and (Source__c not like 'LB_%' or Source__c is null) and (Data_Supplier__c not like 'LB_%' or Data_Supplier__c is null)
	and (Source__c not like 'ML_New_MktWelcome%' or Source__c is null) and (Data_Supplier__c not like 'ML_New_MktWelcome%' or Data_Supplier__c is null)
	and (Source__c not like '%Closed Lost%' or Source__c is null) and (Data_Supplier__c not like '%Closed Lost%' or Data_Supplier__c is null)
	and (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG','012D0000000KKTvIAO') or RecordTypeId is null) and (LeadSource not like '%cross%sell%' or LeadSource is null)

SELECT l.Id, l.Data_Supplier__c, l.Source__c
FROM SalesforceReporting..BadCIData ci
inner join Salesforce..Lead l ON ci.SFID = l.Id
WHERE Status not in ('Callback Requested','Data Quality','Pended','Approved')
and (Source__c not like '%Growth%Intel%' or Source__c is null) and (Data_Supplier__c not like '%Growth%Intel%' or Data_Supplier__c is null)
	and (Source__c not like 'LB_%' or Source__c is null) and (Data_Supplier__c not like 'LB_%' or Data_Supplier__c is null)
	and (Source__c not like 'ML_New_MktWelcome%' or Source__c is null) and (Data_Supplier__c not like 'ML_New_MktWelcome%' or Data_Supplier__c is null)
	and (Source__c not like '%Closed Lost%' or Source__c is null) and (Data_Supplier__c not like '%Closed Lost%' or Data_Supplier__c is null)
	and (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG','012D0000000KKTvIAO') or RecordTypeId is null) and (LeadSource not like '%cross%sell%' or LeadSource is null)

SELECT Id, Phone, MobilePhone, Other_Phone__c, Company, PostalCode
FROM
(
SELECT Id, Phone, MobilePhone, Other_Phone__c, Company, PostalCode, ROW_NUMBER () OVER (PARTITION BY Phone ORDER BY CreatedDate) rn
FROM Salesforce..Lead
WHERE Data_Supplier__c = 'CI_July_2016' and ISNULL(Phone,'') <> ''
UNION
SELECT Id, Phone, MobilePhone, Other_Phone__c, Company, PostalCode, ROW_NUMBER () OVER (PARTITION BY MobilePhone ORDER BY CreatedDate) rn
FROM Salesforce..Lead
WHERE Data_Supplier__c = 'CI_July_2016' and ISNULL(MobilePhone,'') <> ''
UNION
SELECT Id, Phone, MobilePhone, Other_Phone__c, Company, PostalCode, ROW_NUMBER () OVER (PARTITION BY Other_Phone__c ORDER BY CreatedDate) rn
FROM Salesforce..Lead
WHERE Data_Supplier__c = 'CI_July_2016' and ISNULL(Other_Phone__c,'') <> ''
UNION
SELECT Id, Phone, MobilePhone, Other_Phone__c, Company, PostalCode, ROW_NUMBER () OVER (PARTITION BY Company, PostalCode ORDER BY CreatedDate) rn
FROM Salesforce..Lead
WHERE Data_Supplier__c = 'CI_July_2016'
) detail
WHERE rn > 1
GROUP BY Id, Phone, MobilePhone, Other_Phone__c, Company, PostalCode

SELECT Id, Phone
FROM Salesforce..Lead
WHERE Data_Supplier__c = 'CI_July_2016' and ISNULL(Phone,'') = ''