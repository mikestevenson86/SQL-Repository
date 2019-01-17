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
											and l.RecordTypeId = ll.RecordTypeId
		inner join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
		WHERE ISNULL(l.Phone,'') <> '' and rt.Name = 'Default Citation Record Type'
		UNION
		SELECT l.Id, ll.Id OtherID
		FROM Salesforce..Lead l
		inner join Salesforce..Lead ll ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') =
											REPLACE(case when ll.MobilePhone like '0%' then ll.MobilePhone else '0'+ll.MobilePhone end,' ','')
											and l.Id <> ll.Id
											and l.RecordTypeId = ll.RecordTypeId
		inner join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
		WHERE ISNULL(l.Phone,'') <> '' and rt.Name = 'Default Citation Record Type'
		UNION
		SELECT l.Id, ll.Id OtherID
		FROM Salesforce..Lead l
		inner join Salesforce..Lead ll ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') =
											REPLACE(case when ll.Other_Phone__c like '0%' then ll.Other_Phone__c else '0'+ll.Other_Phone__c end,' ','')
											and l.Id <> ll.Id
											and l.RecordTypeId = ll.RecordTypeId
		inner join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
		WHERE ISNULL(l.Phone,'') <> '' and rt.Name = 'Default Citation Record Type'
		UNION
		SELECT l.Id, ll.Id OtherID
		FROM Salesforce..Lead l
		inner join Salesforce..Lead ll ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','') =
											REPLACE(case when ll.Phone like '0%' then ll.Phone else '0'+ll.Phone end,' ','')
											and l.Id <> ll.Id
											and l.RecordTypeId = ll.RecordTypeId
		inner join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
		WHERE ISNULL(l.MobilePhone,'') <> '' and rt.Name = 'Default Citation Record Type'
		UNION
		SELECT l.Id, ll.Id OtherID
		FROM Salesforce..Lead l
		inner join Salesforce..Lead ll ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','') =
											REPLACE(case when ll.MobilePhone like '0%' then ll.MobilePhone else '0'+ll.MobilePhone end,' ','')
											and l.Id <> ll.Id
											and l.RecordTypeId = ll.RecordTypeId
		inner join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
		WHERE ISNULL(l.MobilePhone,'') <> '' and rt.Name = 'Default Citation Record Type'
		UNION
		SELECT l.Id, ll.Id OtherID
		FROM Salesforce..Lead l
		inner join Salesforce..Lead ll ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','') =
											REPLACE(case when ll.Other_Phone__c like '0%' then ll.Other_Phone__c else '0'+ll.Other_Phone__c end,' ','')
											and l.Id <> ll.Id
											and l.RecordTypeId = ll.RecordTypeId
		inner join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
		WHERE ISNULL(l.MobilePhone,'') <> '' and rt.Name = 'Default Citation Record Type'
		UNION
		SELECT l.Id, ll.Id OtherID
		FROM Salesforce..Lead l
		inner join Salesforce..Lead ll ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','') =
											REPLACE(case when ll.Phone like '0%' then ll.Phone else '0'+ll.Phone end,' ','')
											and l.Id <> ll.Id
											and l.RecordTypeId = ll.RecordTypeId
		inner join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
		WHERE ISNULL(l.Other_Phone__c,'') <> '' and rt.Name = 'Default Citation Record Type'
		UNION
		SELECT l.Id, ll.Id OtherID
		FROM Salesforce..Lead l
		inner join Salesforce..Lead ll ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','') =
											REPLACE(case when ll.MobilePhone like '0%' then ll.MobilePhone else '0'+ll.MobilePhone end,' ','')
											and l.Id <> ll.Id
											and l.RecordTypeId = ll.RecordTypeId
		inner join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
		WHERE ISNULL(l.Other_Phone__c,'') <> '' and rt.Name = 'Default Citation Record Type'
		UNION
		SELECT l.Id, ll.Id OtherID
		FROM Salesforce..Lead l
		inner join Salesforce..Lead ll ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','') =
											REPLACE(case when ll.Other_Phone__c like '0%' then ll.Other_Phone__c else '0'+ll.Other_Phone__c end,' ','')
											and l.Id <> ll.Id
											and l.RecordTypeId = ll.RecordTypeId
		inner join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
		WHERE ISNULL(l.Other_Phone__c,'') <> '' and rt.Name = 'Default Citation Record Type'
		UNION
		SELECT l.Id, ll.Id OtherID
		FROM Salesforce..Lead l
		inner join Salesforce..Lead ll ON REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(ll.Company,'Ltd',''),'Limited','')
											and REPLACE(l.PostalCode,' ','') = REPLACE(ll.PostalCode,' ','')
											and l.Id <> ll.Id
											and l.RecordTypeId = ll.RecordTypeId
		inner join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
		WHERE rt.Name = 'Default Citation Record Type'
		UNION
		SELECT l.Id, ll.Id OtherID
		FROM Salesforce..Lead l
		inner join Salesforce..Lead ll ON l.Market_Location_URN__c = ll.Market_Location_URN__c
											and l.Id <> ll.Id
											and l.RecordTypeId = ll.RecordTypeId
		inner join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
		WHERE ISNULL(l.Market_Location_URN__c,'') <> '' and rt.Name = 'Default Citation Record Type'
		) detail
	inner join Salesforce..Lead l ON detail.Id = l.Id
	inner join Salesforce..Lead ol ON detail.OtherID = ol.Id

	GROUP BY detail.Id, detail.OtherID, l.CreatedDate, ol.CreatedDate
	) detail
WHERE CreatedDate < OtherCreatedDate
ORDER BY CreatedDate, OtherCreatedDate

-- Earliest Records (originals)

SELECT Id
FROM SalesforceReporting..DupeBin
GROUP BY Id

-- Later Records (Dupes)

SELECT OtherId
FROM SalesforceReporting..DupeBin
GROUP BY OtherId

-- Both

SELECT Id, OtherId
FROM SalesforceReporting..DupeBin
ORDER BY Id