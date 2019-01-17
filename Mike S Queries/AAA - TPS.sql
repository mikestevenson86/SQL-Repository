IF OBJECT_ID('Salesforce..Lead_Update') IS NOT NULL
BEGIN
	DROP TABLE Salesforce..Lead_Update
END

	SELECT 
	CAST(Id as NCHAR(18)) Id, 
	IsTPS__c,
	CAST('' as NVarChar(255)) Error

	INTO
	Salesforce..Lead_Update

	FROM 
	(
		SELECT 
		Id, 
		'Yes' IsTPS__c

		FROM 
		Salesforce..Lead l

		WHERE 
		(IsTPS__c is null or IsTPS__c = 'No') 
		and
		(
			REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') in
			(
			SELECT Phone
			FROM SalesforceReporting..ctps_ns
			)
			OR
			REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','') in
			(
			SELECT Phone
			FROM SalesforceReporting..ctps_ns
			)
			OR
			REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','') in
			(
			SELECT Phone
			FROM SalesforceReporting..ctps_ns
			)
		)
		and
		Status <> 'Approved'

			UNION

		SELECT 
		Id,
		'No' IsTPS__c

		FROM

		Salesforce..Lead l
		left outer join SalesforceReporting..ctps_ns c1 ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') = c1.Phone
		left outer join SalesforceReporting..ctps_ns c2 ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','') = c2.Phone
		left outer join SalesforceReporting..ctps_ns c3 ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','') = c3.Phone
		WHERE 
		Status <> 'Approved' and IsTPS__c = 'Yes'
		and c1.Phone is null and c2.Phone is null and c3.Phone is null
	) detail

	-- Upload to Salesforce

	exec Salesforce..SF_BulkOps 'Update:batchsize(100)','Salesforce','Lead_Update'