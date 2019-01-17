-- Market Location and Leads Join and Comparison

IF OBJECT_ID('Salesforce..Lead_Update') IS NOT NULL
	BEGIN
		DROP TABLE Salesforce..Lead_Update
	END

SELECT 
CAST(Id as NCHAR(18)) Id, 
ML_URN Market_Location_URN__c,
CAST('' as NVarChar(255)) Error

INTO
Salesforce..Lead_Update

FROM
(
SELECT ROW_NUMBER () OVER (PARTITION BY l.Id ORDER BY (SELECT NULL)) rn, l.Id, ml.ML_URN
FROM SalesforceReporting..Lead_ML_CRO ml
inner join Salesforce..Lead l ON ml.Id = l.Id and IsConverted = 'false' and ISNULL(l.Market_Location_URN__c,'') = ''
WHERE JoinTable in ('Market Location','Market Location/Companies House')
) detail

WHERE 
rn = 1

exec Salesforce..SF_BulkOps 'Update:batchsize(100)','Salesforce','Lead_Update'

-- All available CRO

IF OBJECT_ID('Salesforce..Lead_Update') IS NOT NULL
	BEGIN
		DROP TABLE Salesforce..Lead_Update
	END
	
SELECT 
CAST(l.Id as NCHAR(18)) Id,
CH_CRO Co_Reg__c,
CAST('' as NVarChar(255)) Error

INTO
Salesforce..Lead_Update

FROM 
SalesforceReporting..Lead_ML_CRO ml
inner join Salesforce..Lead l ON ml.Id = l.Id and IsConverted = 'false' and ISNULL(l.Co_Reg__c,'') = ''

WHERE 
ISNULL(CH_CRO,'') <> ''

exec Salesforce..SF_BulkOps 'Update:batchsize(100)','Salesforce','Lead_Update'

-- Companies House SIC Codes

IF OBJECT_ID('Salesforce..Lead_Update') IS NOT NULL
	BEGIN
		DROP TABLE Salesforce..Lead_Update
	END
	
SELECT 
CAST(l.Id as NCHAR(18)) Id, 
LEFT(ch.[SICCode SicText_1], 5) SIC2007_Code3__c,
CAST('' as NVarChar(255)) Error

INTO
Salesforce..Lead_Update

FROM 
Salesforce..Lead l
inner join SalesforceReporting..CompaniesHouse ch ON l.Co_Reg__c = ch.[ CompanyNumber]

WHERE 
ISNULL(l.SIC2007_Code3__c, 0) = 0 
and 
LEFT(ch.[SICCode SicText_1], 5) not like 'None%'

exec Salesforce..SF_BulkOps 'Update:batchsize(100)','Salesforce','Lead_Update'

-- Companies House Year Established

IF OBJECT_ID('Salesforce..Lead_Update') IS NOT NULL
	BEGIN
		DROP TABLE Salesforce..Lead_Update
	END

SELECT 
CAST(l.Id as NCHAR(18)) Id, 
YEAR(CONVERT(Date, IncorporationDate, 103)) Year_Established__c,
CAST('' as NVarChar(255)) Error

INTO
Salesforce..Lead_Update

FROM 
Salesforce..Lead l
inner join SalesforceReporting..CompaniesHouse ch ON l.Co_Reg__c = ch.[ CompanyNumber]

WHERE 
ISNULL(IncorporationDate,'') <> ''

exec Salesforce..SF_BulkOps 'Update:batchsize(100)','Salesforce','Lead_Update'