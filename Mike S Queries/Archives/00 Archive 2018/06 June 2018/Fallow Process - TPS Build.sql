IF OBJECT_ID('SalesforceReporting..TPS_June2018') IS NOT NULL
	BEGIN
		DROP TABLE SalesforceReporting..TPS_June2018
	END

	CREATE TABLE SalesforceReporting..TPS_June2018
	(
		ID NCHAR(18),
		Phone NVarChar(100),
		TPS_Phone bit,
		Mobile NVarChar(100),
		TPS_Mobile bit,
		Other NVarChar(100),
		TPS_Other bit
	)

	-- Insert Current TPS

	INSERT INTO
	SalesforceReporting..TPS_June2018
	(Id, Phone, Mobile, Other)

	SELECT 
	l.Id,
	REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ',''),
	REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ',''),
	REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')

	FROM 
	Salesforce..Lead l
	inner join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id

	WHERE 
	rt.Name = 'Default Citation Record Type' 
	and 
	l.IsConverted = 'false' 
	and 
	l.Status not in ('Approved','Data Quality','Pended')
	and 
	IsTPS__c = 'Yes'

	-- Update TPS Flags

	UPDATE SalesforceReporting..TPS_June2018
	SET TPS_Phone = 1
	WHERE Phone in
			(
				SELECT Phone
				FROM SalesforceReporting..ctps_ns
			)
	
	UPDATE SalesforceReporting..TPS_June2018
	SET TPS_Mobile = 1
	WHERE Mobile in
			(
				SELECT Phone
				FROM SalesforceReporting..ctps_ns
			)
	
	UPDATE SalesforceReporting..TPS_June2018
	SET TPS_Other = 1
	WHERE Other in
			(
				SELECT Phone
				FROM SalesforceReporting..ctps_ns
			)