/*
IF OBJECT_ID('Salesforce..Lead_Update') IS NOT NULL 
	BEGIN
		DROP TABLE Salesforce..Lead_Update
	END*/

IF OBJECT_ID('SalesforceReporting..MLUpdateDONOTTOUCH') IS NOT NULL 
	BEGIN
		DROP TABLE SalesforceReporting..MLUpdateDONOTTOUCH
	END

CREATE TABLE SalesforceReporting..MLUpdateDONOTTOUCH
(
Id VarChar(255),
[Market_Location_URN__c] VarChar(255),
[Company] VarChar(255),
[Street] VarChar(255),
[City] VarChar(255),
[State] VarChar(255),
[Postalcode] VarChar(255),
[Phone] VarChar(255),
[IsTPS__c] VarChar(255),
[Salutation] VarChar(255),
[FirstName] VarChar(255),
[LastName] VarChar(255),
[Position__c] VarChar(255),
[Website] VarChar(255),
[FT_Employees__c] VarChar(255),
[SIC2007_Code3__c] VarChar(255),
[SIC2007_Description3__c] VarChar(255),
[Email] VarChar(255)
)

	INSERT INTO 
	SalesforceReporting..MLUpdateDONOTTOUCH 
	(
	ID,[Market_Location_URN__c],[Company],[Street],[City],[State],[Postalcode],[Phone],[IsTPS__c],[Salutation],[FirstName],
	[LastName],[Position__c],[Website],[FT_Employees__c],[SIC2007_Code3__c],[SIC2007_Description3__c],[Email]
	)
	(
	SELECT
	ID,g.[Market_Location_URN__c],g.[Company],g.[Street],g.[City],g.[State],g.[Postalcode],g.[Phone],g.[IsTPS__c],g.[Salutation],g.[FirstName],
	g.[LastName],g.[Position__c],g.[Website],g.[FT_Employees__c],g.[SIC2007_Code3__c],g.[SIC2007_Description3__c],g.[Email]
	
	FROM 
	Salesforce..Lead l
	inner join SalesforceReporting..ML_20161124 g ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
														= REPLACE(case when g.Phone like '0%' then g.Phone else '0'+g.Phone end,' ','')
	WHERE 
	(RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG') or RecordTypeId is null) and LeadSource not like '%cross%sell%'
	and g.Phone <> '0' 
	and Status not in ('Approved','Data Quality','Pended','Callback Requested')
	and (Source__c not like '%GrowthIntel%' or Source__c is null)
	and
	-- Normal Exclusions
	ISNULL(CONVERT(int, BadDomain),0) + ISNULL(CONVERT(int, BadCompany_Near),0) +
	-- CC Exclusions
	ISNULL(CONVERT(int, ToxicSIC_Events),0) + ISNULL(CONVERT(int, BadCompany_Events), 0) + ISNULL(CONVERT(int, BadPosition_Events),0) +
		ISNULL(CONVERT(int,BadSector_Events),0) = 0
	)
	
	INSERT INTO 
	SalesforceReporting..MLUpdateDONOTTOUCH 
	(
	ID,[Market_Location_URN__c],[Company],[Street],[City],[State],[Postalcode],[Phone],[IsTPS__c],[Salutation],[FirstName],
	[LastName],[Position__c],[Website],[FT_Employees__c],[SIC2007_Code3__c],[SIC2007_Description3__c],[Email]
	)
	(
	SELECT
	ID,g.[Market_Location_URN__c],g.[Company],g.[Street],g.[City],g.[State],g.[Postalcode],g.[Phone],g.[IsTPS__c],g.[Salutation],g.[FirstName],
	g.[LastName],g.[Position__c],g.[Website],g.[FT_Employees__c],g.[SIC2007_Code3__c],g.[SIC2007_Description3__c],g.[Email]
	
	FROM 
	Salesforce..Lead l
	inner join SalesforceReporting..ML_20161124 g ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
														= REPLACE(case when g.Phone like '0%' then g.Phone else '0'+g.Phone end,' ','')
	WHERE 
	(RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG') or RecordTypeId is null) and LeadSource not like '%cross%sell%'
	and g.Phone <> '0' 
	and Status not in ('Approved','Data Quality','Pended','Callback Requested') 
	and (Source__c not like '%GrowthIntel%' or Source__c is null)
	and
	-- Normal Exclusions
	ISNULL(CONVERT(int, BadDomain),0) + ISNULL(CONVERT(int, BadCompany_Near),0) +
	-- CC Exclusions
	ISNULL(CONVERT(int, ToxicSIC_Events),0) + ISNULL(CONVERT(int, BadCompany_Events), 0) + ISNULL(CONVERT(int, BadPosition_Events),0) +
		ISNULL(CONVERT(int,BadSector_Events),0) = 0
	)

	INSERT INTO 
	SalesforceReporting..MLUpdateDONOTTOUCH 
	(
	ID,[Market_Location_URN__c],[Company],[Street],[City],[State],[Postalcode],[Phone],[IsTPS__c],[Salutation],[FirstName],
	[LastName],[Position__c],[Website],[FT_Employees__c],[SIC2007_Code3__c],[SIC2007_Description3__c],[Email]
	)
	(
	SELECT
	ID,g.[Market_Location_URN__c],g.[Company],g.[Street],g.[City],g.[State],g.[Postalcode],g.[Phone],g.[IsTPS__c],g.[Salutation],g.[FirstName],
	g.[LastName],g.[Position__c],g.[Website],g.[FT_Employees__c],g.[SIC2007_Code3__c],g.[SIC2007_Description3__c],g.[Email]
	
	FROM 
	Salesforce..Lead l
	inner join SalesforceReporting..ML_20161124 g ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
														= REPLACE(case when g.Phone like '0%' then g.Phone else '0'+g.Phone end,' ','')
	WHERE 
	(RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG') or RecordTypeId is null) and LeadSource not like '%cross%sell%'
	and g.Phone <> '0' 
	and Status not in ('Approved','Data Quality','Pended','Callback Requested') 
	and (Source__c not like '%GrowthIntel%' or Source__c is null)
	and
	-- Normal Exclusions
	ISNULL(CONVERT(int, BadDomain),0) + ISNULL(CONVERT(int, BadCompany_Near),0) +
	-- CC Exclusions
	ISNULL(CONVERT(int, ToxicSIC_Events),0) + ISNULL(CONVERT(int, BadCompany_Events), 0) + ISNULL(CONVERT(int, BadPosition_Events),0) +
		ISNULL(CONVERT(int,BadSector_Events),0) = 0
	)

	INSERT INTO 
	SalesforceReporting..MLUpdateDONOTTOUCH 
	(
	ID,[Market_Location_URN__c],[Company],[Street],[City],[State],[Postalcode],[Phone],[IsTPS__c],[Salutation],[FirstName],
	[LastName],[Position__c],[Website],[FT_Employees__c],[SIC2007_Code3__c],[SIC2007_Description3__c],[Email]
	)
	(
	SELECT
	ID,g.[Market_Location_URN__c],g.[Company],g.[Street],g.[City],g.[State],g.[Postalcode],g.[Phone],g.[IsTPS__c],g.[Salutation],g.[FirstName],
	g.[LastName],g.[Position__c],g.[Website],g.[FT_Employees__c],g.[SIC2007_Code3__c],g.[SIC2007_Description3__c],g.[Email]
	
	FROM 
	Salesforce..Lead l
	inner join SalesforceReporting..ML_20161124 g ON REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(g.Company,'Ltd',''),'Limited','')
														and REPLACE(l.PostalCode,' ','') = REPLACE(g.Postalcode,' ','')
	WHERE 
	(RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG') or RecordTypeId is null) and LeadSource not like '%cross%sell%'
	and g.Company <> '' and g.PostalCode <> ''
	and Status not in ('Approved','Data Quality','Pended','Callback Requested')  
	and (Source__c not like '%GrowthIntel%' or Source__c is null)
	and
	-- Normal Exclusions
	ISNULL(CONVERT(int, BadDomain),0) + ISNULL(CONVERT(int, BadCompany_Near),0) +
	ISNULL(CONVERT(int, ToxicSIC_Events),0) + ISNULL(CONVERT(int, BadCompany_Events), 0) + ISNULL(CONVERT(int, BadPosition_Events),0) +
		ISNULL(CONVERT(int,BadSector_Events),0) = 0
	)
	
	INSERT INTO 
	SalesforceReporting..MLUpdateDONOTTOUCH 
	(
	ID,[Market_Location_URN__c],[Company],[Street],[City],[State],[Postalcode],[Phone],[IsTPS__c],[Salutation],[FirstName],
	[LastName],[Position__c],[Website],[FT_Employees__c],[SIC2007_Code3__c],[SIC2007_Description3__c],[Email]
	)
	(
	SELECT
	ID,g.[Market_Location_URN__c],g.[Company],g.[Street],g.[City],g.[State],g.[Postalcode],g.[Phone],g.[IsTPS__c],g.[Salutation],g.[FirstName],
	g.[LastName],g.[Position__c],g.[Website],g.[FT_Employees__c],g.[SIC2007_Code3__c],g.[SIC2007_Description3__c],g.[Email]
	
	FROM 
	Salesforce..Lead l
	inner join SalesforceReporting..ML_20161124 g ON l.Market_Location_URN__c = g.Market_Location_URN__c
	WHERE 
	(RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG') or RecordTypeId is null) and LeadSource not like '%cross%sell%'
	and g.Company <> '' and g.PostalCode <> ''
	and Status not in ('Approved','Data Quality','Pended','Callback Requested')  
	and (Source__c not like '%GrowthIntel%' or Source__c is null)
	and
	-- Normal Exclusions
	ISNULL(CONVERT(int, BadDomain),0) + ISNULL(CONVERT(int, BadCompany_Near),0) +
	-- CC Exclusions
	ISNULL(CONVERT(int, ToxicSIC_Events),0) + ISNULL(CONVERT(int, BadCompany_Events), 0) + ISNULL(CONVERT(int, BadPosition_Events),0) +
		ISNULL(CONVERT(int,BadSector_Events),0) = 0
	)
			
	SELECT
	CAST(Id as NCHAR(18)) Id,
	ma.[Market_Location_URN__c],
	ma.[Company],
	ma.[Street],
	ma.[City],
	ma.[State],
	ma.[Postalcode],
	ma.[Phone],
	ma.[IsTPS__c],
	ma.[Salutation],
	case when ma.[LastName] = '' then 'BLANK' else ma.[LastName] end LastName,
	ma.[Position__c],
	ma.[Website],
	ma.[FT_Employees__c],
	ma.[SIC2007_Code3__c],
	ma.[SIC2007_Description3__c],
	ma.[Email],
	ml2.Area,
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(ml.cro_number,'A',''),'B',''),'C',''),'D',''),'E',''),',','') Co_Reg__c,
	'ML_Events_20161124' Source__c,
	CAST('' as nvarchar(255)) Error
	
	--INTO
	--Salesforce..Lead_Update
	--SalesforceReporting..UpdateMLAmends
	
	FROM
	SalesforceReporting..MLUpdateDONOTTOUCH ma
	left outer join MarketLocation..MainDataSet ml ON ma.Market_Location_URN__c = ml.URN
	left outer join SalesforceReporting..ML_20161124 ml2 ON ma.Market_Location_URN__c = ml2.Market_Location_URN__c
	
	GROUP BY
	Id,
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
	case when ma.[LastName] = '' then 'BLANK' else ma.[LastName] end,
	ma.[Position__c],
	ma.[Website],
	ma.[FT_Employees__c],
	ma.[SIC2007_Code3__c],
	ma.[SIC2007_Description3__c],
	ma.[Email],
	ml2.Area,
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(ml.cro_number,'A',''),'B',''),'C',''),'D',''),'E',''),',','')
	
	-- Upload to Salesforce	

	--exec Salesforce..SF_BulkOps 'Update:batchsize(200)','Salesforce','Lead_Update'