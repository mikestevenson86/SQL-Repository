IF OBJECT_ID('Salesforce..Lead_Load') IS NOT NULL
BEGIN
	DROP TABLE Salesforce..Lead_Load
END

-- Create and Populate Table

		SELECT
		CAST('' as NCHAR(18)) Id,
		ML_URN [Market_Location_URN__c],
		[Company],
		[Street],
		[City],
		[State],
		[Postalcode],
		[Phone],
		[FirstName],
		case when [LastName] = '' then 'BLANK' else [LastName] end LastName,
		[Website],
		[FT_Employees__c],
		ML_SIC [SIC2007_Code3__c],
		'ML_' + DATENAME(month, GETDATE()) + '_' + CONVERT(VarChar,DATEPART(Year,GETDATE())) Source__c,
		'ML' Data_Supplier__c,
		CONVERT(datetime, CONVERT(date, GETDATE())) Completed_Date__c,
		CAST('' as nvarchar(255)) Error
		
		--INTO
		--Salesforce..Lead_Load
		
		FROM 
		SalesforceReporting..Shropshire_Chambers_June2017
		
		WHERE
		-- Normal Exclusions
		ISNULL(CONVERT(int, Dupe_Lead),0) + ISNULL(CONVERT(int, Dupe_Account),0) + ISNULL(CONVERT(int, Dupe_Site),0) +
		ISNULL(CONVERT(int, BadDomain),0) + ISNULL(CONVERT(int, BadCompany_Near),0) +
		-- CC Exclusions
		ISNULL(CONVERT(int, Dupe_Toxic),0) + ISNULL(CONVERT(int, BadCompany_Exact),0) + 
		ISNULL(CONVERT(int, BadDomain_NHS),0) + ISNULL(CONVERT(int, ToxicSIC),0) = 0
			
		-- Upload to Salesforce	

		--exec Salesforce..SF_BulkOps 'Insert:batchsize(5)','Salesforce','Lead_Load','AssignmentRuleHeader,useDefaultRule,true'