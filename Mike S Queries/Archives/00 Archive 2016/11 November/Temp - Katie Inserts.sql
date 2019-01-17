		/*IF OBJECT_ID('Salesforce..Lead_Load') IS NOT NULL 
            BEGIN
                DROP TABLE Salesforce..Lead_Load
            END*/

-- Create and Populate Table

		SELECT
		CAST('' as NCHAR(18)) Id,
		ma.[Market_Location_URN__c],
		ma.[Company],
		ma.[Street],
		ma.[City],
		ma.[State],
		ma.[Postalcode],
		ma.[Phone],
		ma.[IsTPS__c],
		ma.[Salutation],
		ma.[FirstName],
		case when ma.[LastName] = '' then 'BLANK' else ma.[LastName] end LastName,
		ma.[Position__c],
		ma.[Website],
		ma.[FT_Employees__c],
		ma.[SIC2007_Code3__c],
		ma.[SIC2007_Description3__c],
		ma.[Email],
		'ML_Events_20161124' Source__c,
		'ML_Events_20161124' Data_Supplier__c,
		ml2.Area,
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(ml.cro_number,'A',''),'B',''),'C',''),'D',''),'E',''),',','') Co_Reg__c,
		CONVERT(datetime, CONVERT(date, GETDATE())) Completed_Date__c,
		CAST('' as nvarchar(255)) Error
		
		--INTO
		--Salesforce..Lead_Load
		--SalesforceReporting..InsertMLNews
		
		FROM 
		SalesforceReporting..ML_20161124 ma
		left outer join MarketLocation..MainDataSet ml ON ma.Market_Location_URN__c = ml.URN
		left outer join SalesforceReporting..ML_20161124 ml2 ON ma.Market_Location_URN__c = ml2.Market_Location_URN__c
		
		WHERE
		-- Normal Exclusions
		ISNULL(CONVERT(int, ma.Dupe_Lead),0) + ISNULL(CONVERT(int, ma.Dupe_Account),0) + ISNULL(CONVERT(int, ma.Dupe_Site),0) +
		ISNULL(CONVERT(int, ma.BadDomain),0) + ISNULL(CONVERT(int, ma.BadCompany_Near),0) +
		-- CC Exclusions
		ISNULL(CONVERT(int, ma.ToxicSIC_Events),0) + ISNULL(CONVERT(int, ma.BadCompany_Events), 0) + ISNULL(CONVERT(int, ma.BadPosition_Events),0) +
		ISNULL(CONVERT(int,ma.BadSector_Events),0) = 0
			
		-- Upload to Salesforce	

		--exec Salesforce..SF_BulkOps 'Insert:batchsize(100)','Salesforce','Lead_Load','AssignmentRuleHeader,useDefaultRule,true'
