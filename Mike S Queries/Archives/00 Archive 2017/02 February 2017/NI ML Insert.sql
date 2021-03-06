
	/*	IF OBJECT_ID('Salesforce..Lead_Load') IS NOT NULL 
            BEGIN
                DROP TABLE Salesforce..Lead_Load
            END*/

-- Create and Populate Table

		SELECT
		CAST('' as NCHAR(18)) Id,
		URN [Market_Location_URN__c],
		[Business Name] [Company],
		[Address Line 1] + ' ' + [Address Line 2] [Street],
		Town [City],
		County [State],
		Postcode [Postalcode],
		[Telephone Number] [Phone],
		case when Feb_CTPSFlag = 1 then 'Yes' else 'No' end [IsTPS__c],
		[Contact title] [Salutation],
		[Contact forename] [FirstName],
		case when [Contact surname] = '' then 'BLANK' else [Contact surname] end LastName,
		[Contact position] [Position__c],
		[web address] [Website],
		[Nat Employees] [FT_Employees__c],
		[UK 07 Sic Code] [SIC2007_Code3__c],
		[UK 07 Sic Desc] [SIC2007_Description3__c],
		case when [Contact email address] = '' then [company email address] else [Contact email address] end [Email],
		cro_number [Co_Reg__c],
		'ML_New_NI_Feb17' Source__c,
		'ML' Data_Supplier__c,
		CONVERT(datetime, CONVERT(date, GETDATE())) Completed_Date__c,
		Feb_BDM,
		Feb_BadCompEvents,
		Feb_BadCompExact,
		Feb_BadCompNear,
		Feb_BadDomain,
		Feb_BadDomainEvents,
		Feb_BadPositionEvents,
		Feb_BadSectorEvents,
		Feb_CTPSFlag,
		Feb_CitationSector,
		Feb_Country,
		Feb_Dupe_Account,
		Feb_Dupe_Lead,
		Feb_Dupe_Site,
		Feb_MajorSectorDesc,
		Feb_NatFTE_Banding,
		Feb_PostcodeArea,
		Feb_SFDC_ID,
		Feb_ToxicData,
		Feb_ToxicSIC,
		Feb_WiredSuppression,
		Feb_WorkingLeads
		
		--INTO
		--Salesforce..Lead_Load
		--SalesforceReporting..InsertMLNews
		
		FROM 
		MarketLocation..MainDataSet
		
		WHERE
		-- Normal Exclusions
		ISNULL(CONVERT(int, Feb_Dupe_Lead),0) + ISNULL(CONVERT(int, Feb_Dupe_Account),0) + ISNULL(CONVERT(int, Feb_Dupe_Site),0) +
		ISNULL(CONVERT(int, Feb_BadDomain),0) + ISNULL(CONVERT(int, Feb_BadCompNear),0) +
		-- CC Exclusions
		ISNULL(CONVERT(int, Feb_ToxicData),0) + ISNULL(CONVERT(int, Feb_BadCompExact),0) + 
		+ ISNULL(CONVERT(int, Feb_BadDomainEvents),0) + ISNULL(CONVERT(int, Feb_ToxicSIC),0) = 0
		and Feb_Country = 'Northern Ireland'
			
		-- Upload to Salesforce	

		--exec Salesforce..SF_BulkOps 'Insert:batchsize(5)','Salesforce','Lead_Load','AssignmentRuleHeader,useDefaultRule,true'
