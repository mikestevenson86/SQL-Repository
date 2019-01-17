CREATE TABLE SalesforceReporting..MLUpdateDONOTTOUCH_2
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
[Email] VarChar(255),
[Co_Reg__c] VarChar(255)
)

	INSERT INTO 
	SalesforceReporting..MLUpdateDONOTTOUCH_2
	(
	ID,[Market_Location_URN__c],[Company],[Street],[City],[State],[Postalcode],[Phone],[IsTPS__c],[Salutation],[FirstName],
	[LastName],[Position__c],[Website],[FT_Employees__c],[SIC2007_Code3__c],[SIC2007_Description3__c],[Email],[Co_Reg__c]
	)
	(
	SELECT
	ID,g.[Market_Location_URN__c],g.[Company],g.[Street],g.[City],g.[State],g.[Postalcode],g.[Phone],g.[IsTPS__c],g.[Salutation],g.[FirstName],
	g.[LastName],g.[Position__c],g.[Website],g.[FT_Employees__c],g.[SIC2007_Code3__c],g.[SIC2007_Description3__c],g.[Email],g.[Co_Reg__c]
	
	FROM 
	Salesforce..Lead l
	inner join SalesforceReporting..ML_Amends g ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
														= REPLACE(case when g.Phone like '0%' then g.Phone else '0'+g.Phone end,' ','')
	WHERE 
	(RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG') or RecordTypeId is null) and (LeadSource not like '%cross%sell%' or LeadSource is null)
	and g.Phone <> '0'  and g.Phone <> ''
	and Status not in ('Approved','Data Quality','Pended','Callback Requested')
	and (Source__c not like '%Growth%Intel%' or Source__c is null)
	and
	-- Normal Exclusions
	ISNULL(CONVERT(int, BadDomain),0) + ISNULL(CONVERT(int, BadCompany_Near),0) +
	-- CC Exclusions
	ISNULL(CONVERT(int, BadCompany_Exact),0) + 
	ISNULL(CONVERT(int, BadDomain_NHS),0) + ISNULL(CONVERT(int, ToxicSIC),0) = 0
	-- Actual Updates
	and
		(
		REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') <> REPLACE(REPLACE(g.Company,'Ltd',''),'Limited','') or
		REPLACE(REPLACE(l.Street,' ',''),',','') <> REPLACE(REPLACE(g.Street,' ',''),',','') or
		ISNULL(l.City,'') <> g.City or
		ISNULL(l.State,'') <> g.State or
		ISNULL(l.PostalCode,'') <> g.Postalcode or
		ISNULL(l.IsTPS__c,'') <> g.IsTPS__c or
		ISNULL(l.Salutation,'') <> g.Salutation or
		ISNULL(l.FirstName,'') <> g.FirstName or
		ISNULL(l.LastName,'') <> g.LastName or
		ISNULL(l.Position__c,'') <> g.Position__c or
		ISNULL(l.Website,'') <> g.Website or
		ISNULL(CONVERT(VarChar, l.FT_Employees__c),'') <> g.FT_Employees__c or
		ISNULL(CONVERT(VarChar, l.SIC2007_Code3__c),'') <> g.SIC2007_Code3__c or
		ISNULL(l.Email,'') <> g.Email or
		ISNULL(l.Co_Reg__c,'') <> g.Co_Reg__c
		)
	)
	
	INSERT INTO 
	SalesforceReporting..MLUpdateDONOTTOUCH_2
	(
	ID,[Market_Location_URN__c],[Company],[Street],[City],[State],[Postalcode],[Phone],[IsTPS__c],[Salutation],[FirstName],
	[LastName],[Position__c],[Website],[FT_Employees__c],[SIC2007_Code3__c],[SIC2007_Description3__c],[Email],[Co_Reg__c]
	)
	(
	SELECT
	ID,g.[Market_Location_URN__c],g.[Company],g.[Street],g.[City],g.[State],g.[Postalcode],g.[Phone],g.[IsTPS__c],g.[Salutation],g.[FirstName],
	g.[LastName],g.[Position__c],g.[Website],g.[FT_Employees__c],g.[SIC2007_Code3__c],g.[SIC2007_Description3__c],g.[Email],g.[Co_Reg__c]
	
	FROM 
	Salesforce..Lead l
	inner join SalesforceReporting..ML_Amends g ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
														= REPLACE(case when g.Phone like '0%' then g.Phone else '0'+g.Phone end,' ','')
	WHERE 
	(RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG') or RecordTypeId is null) and (LeadSource not like '%cross%sell%' or LeadSource is null)
	and g.Phone <> '0'  and g.Phone <> ''
	and Status not in ('Approved','Data Quality','Pended','Callback Requested') 
	and (Source__c not like '%Growth%Intel%' or Source__c is null)
	and
	-- Normal Exclusions
	ISNULL(CONVERT(int, BadDomain),0) + ISNULL(CONVERT(int, BadCompany_Near),0) +
	-- CC Exclusions
	ISNULL(CONVERT(int, BadCompany_Exact),0) + 
	ISNULL(CONVERT(int, BadDomain_NHS),0) + ISNULL(CONVERT(int, ToxicSIC),0) = 0
	-- Actual Updates
	and
		(
		REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') <> REPLACE(REPLACE(g.Company,'Ltd',''),'Limited','') or
		REPLACE(REPLACE(l.Street,' ',''),',','') <> REPLACE(REPLACE(g.Street,' ',''),',','') or
		ISNULL(l.City,'') <> g.City or
		ISNULL(l.State,'') <> g.State or
		ISNULL(l.PostalCode,'') <> g.Postalcode or
		ISNULL(l.IsTPS__c,'') <> g.IsTPS__c or
		ISNULL(l.Salutation,'') <> g.Salutation or
		ISNULL(l.FirstName,'') <> g.FirstName or
		ISNULL(l.LastName,'') <> g.LastName or
		ISNULL(l.Position__c,'') <> g.Position__c or
		ISNULL(l.Website,'') <> g.Website or
		ISNULL(CONVERT(VarChar, l.FT_Employees__c),'') <> g.FT_Employees__c or
		ISNULL(CONVERT(VarChar, l.SIC2007_Code3__c),'') <> g.SIC2007_Code3__c or
		ISNULL(l.Email,'') <> g.Email or
		ISNULL(l.Co_Reg__c,'') <> g.Co_Reg__c
		)
	)

	INSERT INTO 
	SalesforceReporting..MLUpdateDONOTTOUCH_2
	(
	ID,[Market_Location_URN__c],[Company],[Street],[City],[State],[Postalcode],[Phone],[IsTPS__c],[Salutation],[FirstName],
	[LastName],[Position__c],[Website],[FT_Employees__c],[SIC2007_Code3__c],[SIC2007_Description3__c],[Email],[Co_Reg__c]
	)
	(
	SELECT
	ID,g.[Market_Location_URN__c],g.[Company],g.[Street],g.[City],g.[State],g.[Postalcode],g.[Phone],g.[IsTPS__c],g.[Salutation],g.[FirstName],
	g.[LastName],g.[Position__c],g.[Website],g.[FT_Employees__c],g.[SIC2007_Code3__c],g.[SIC2007_Description3__c],g.[Email],g.[Co_Reg__c]
	
	FROM 
	Salesforce..Lead l
	inner join SalesforceReporting..ML_Amends g ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
														= REPLACE(case when g.Phone like '0%' then g.Phone else '0'+g.Phone end,' ','')
	WHERE 
	(RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG') or RecordTypeId is null) and (LeadSource not like '%cross%sell%' or LeadSource is null)
	and g.Phone <> '0'  and g.Phone <> ''
	and Status not in ('Approved','Data Quality','Pended','Callback Requested') 
	and (Source__c not like '%Growth%Intel%' or Source__c is null)
	and
	-- Normal Exclusions
	ISNULL(CONVERT(int, BadDomain),0) + ISNULL(CONVERT(int, BadCompany_Near),0) +
	-- CC Exclusions
	ISNULL(CONVERT(int, BadCompany_Exact),0) + 
	ISNULL(CONVERT(int, BadDomain_NHS),0) + ISNULL(CONVERT(int, ToxicSIC),0) = 0
	-- Actual Updates
	and
		(
		REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') <> REPLACE(REPLACE(g.Company,'Ltd',''),'Limited','') or
		REPLACE(REPLACE(l.Street,' ',''),',','') <> REPLACE(REPLACE(g.Street,' ',''),',','') or
		ISNULL(l.City,'') <> g.City or
		ISNULL(l.State,'') <> g.State or
		ISNULL(l.PostalCode,'') <> g.Postalcode or
		ISNULL(l.IsTPS__c,'') <> g.IsTPS__c or
		ISNULL(l.Salutation,'') <> g.Salutation or
		ISNULL(l.FirstName,'') <> g.FirstName or
		ISNULL(l.LastName,'') <> g.LastName or
		ISNULL(l.Position__c,'') <> g.Position__c or
		ISNULL(l.Website,'') <> g.Website or
		ISNULL(CONVERT(VarChar, l.FT_Employees__c),'') <> g.FT_Employees__c or
		ISNULL(CONVERT(VarChar, l.SIC2007_Code3__c),'') <> g.SIC2007_Code3__c or
		ISNULL(l.Email,'') <> g.Email or
		ISNULL(l.Co_Reg__c,'') <> g.Co_Reg__c
		)
	)

	INSERT INTO 
	SalesforceReporting..MLUpdateDONOTTOUCH_2
	(
	ID,[Market_Location_URN__c],[Company],[Street],[City],[State],[Postalcode],[Phone],[IsTPS__c],[Salutation],[FirstName],
	[LastName],[Position__c],[Website],[FT_Employees__c],[SIC2007_Code3__c],[SIC2007_Description3__c],[Email],[Co_Reg__c]
	)
	(
	SELECT
	ID,g.[Market_Location_URN__c],g.[Company],g.[Street],g.[City],g.[State],g.[Postalcode],g.[Phone],g.[IsTPS__c],g.[Salutation],g.[FirstName],
	g.[LastName],g.[Position__c],g.[Website],g.[FT_Employees__c],g.[SIC2007_Code3__c],g.[SIC2007_Description3__c],g.[Email],g.[Co_Reg__c]
	
	FROM 
	Salesforce..Lead l
	inner join SalesforceReporting..ML_Amends g ON REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(g.Company,'Ltd',''),'Limited','')
														and REPLACE(l.PostalCode,' ','') = REPLACE(g.Postalcode,' ','')
	WHERE 
	(RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG') or RecordTypeId is null) and (LeadSource not like '%cross%sell%' or LeadSource is null)
	and g.Company <> '' and g.PostalCode <> ''
	and Status not in ('Approved','Data Quality','Pended','Callback Requested')  
	and (Source__c not like '%Growth%Intel%' or Source__c is null)
	and
	-- Normal Exclusions
	ISNULL(CONVERT(int, BadDomain),0) + ISNULL(CONVERT(int, BadCompany_Near),0) +
	-- CC Exclusions
	ISNULL(CONVERT(int, BadCompany_Exact),0) + 
	ISNULL(CONVERT(int, BadDomain_NHS),0) + ISNULL(CONVERT(int, ToxicSIC),0) = 0
	-- Actual Updates
	and
		(
		REPLACE(REPLACE(l.Street,' ',''),',','') <> REPLACE(REPLACE(g.Street,' ',''),',','') or
		ISNULL(l.City,'') <> g.City or
		ISNULL(l.State,'') <> g.State or
		ISNULL(l.IsTPS__c,'') <> g.IsTPS__c or
		REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') <> REPLACE(case when g.Phone like '0%' then g.Phone else '0'+g.Phone end,' ','') or
		ISNULL(l.Salutation,'') <> g.Salutation or
		ISNULL(l.FirstName,'') <> g.FirstName or
		ISNULL(l.LastName,'') <> g.LastName or
		ISNULL(l.Position__c,'') <> g.Position__c or
		ISNULL(l.Website,'') <> g.Website or
		ISNULL(CONVERT(VarChar, l.FT_Employees__c),'') <> g.FT_Employees__c or
		ISNULL(CONVERT(VarChar, l.SIC2007_Code3__c),'') <> g.SIC2007_Code3__c or
		ISNULL(l.Email,'') <> g.Email or
		ISNULL(l.Co_Reg__c,'') <> g.Co_Reg__c
		)
	)
	
	INSERT INTO 
	SalesforceReporting..MLUpdateDONOTTOUCH_2
	(
	ID,[Market_Location_URN__c],[Company],[Street],[City],[State],[Postalcode],[Phone],[IsTPS__c],[Salutation],[FirstName],
	[LastName],[Position__c],[Website],[FT_Employees__c],[SIC2007_Code3__c],[SIC2007_Description3__c],[Email],[Co_Reg__c]
	)
	(
	SELECT
	ID,g.[Market_Location_URN__c],g.[Company],g.[Street],g.[City],g.[State],g.[Postalcode],g.[Phone],g.[IsTPS__c],g.[Salutation],g.[FirstName],
	g.[LastName],g.[Position__c],g.[Website],g.[FT_Employees__c],g.[SIC2007_Code3__c],g.[SIC2007_Description3__c],g.[Email],g.[Co_Reg__c]
	
	FROM 
	Salesforce..Lead l
	inner join SalesforceReporting..ML_Amends g ON l.Market_Location_URN__c = g.Market_Location_URN__c
	WHERE 
	(RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG') or RecordTypeId is null) and (LeadSource not like '%cross%sell%' or LeadSource is null)
	and g.Company <> '' and g.PostalCode <> ''
	and Status not in ('Approved','Data Quality','Pended','Callback Requested')  
	and (Source__c not like '%Growth%Intel%' or Source__c is null)
	and
	-- Normal Exclusions
	ISNULL(CONVERT(int, BadDomain),0) + ISNULL(CONVERT(int, BadCompany_Near),0) +
	-- CC Exclusions
	ISNULL(CONVERT(int, BadCompany_Exact),0) + 
	ISNULL(CONVERT(int, BadDomain_NHS),0) + ISNULL(CONVERT(int, ToxicSIC),0) = 0
	-- Actual Updates
	and
		(
		REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') <> REPLACE(REPLACE(g.Company,'Ltd',''),'Limited','') or
		REPLACE(REPLACE(l.Street,' ',''),',','') <> REPLACE(REPLACE(g.Street,' ',''),',','') or
		ISNULL(l.City,'') <> g.City or
		ISNULL(l.State,'') <> g.State or
		ISNULL(l.PostalCode,'') <> g.Postalcode or
		ISNULL(l.IsTPS__c,'') <> g.IsTPS__c or
		REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') <> REPLACE(case when g.Phone like '0%' then g.Phone else '0'+g.Phone end,' ','') or
		ISNULL(l.Salutation,'') <> g.Salutation or
		ISNULL(l.FirstName,'') <> g.FirstName or
		ISNULL(l.LastName,'') <> g.LastName or
		ISNULL(l.Position__c,'') <> g.Position__c or
		ISNULL(l.Website,'') <> g.Website or
		ISNULL(CONVERT(VarChar, l.FT_Employees__c),'') <> g.FT_Employees__c or
		ISNULL(CONVERT(VarChar, l.SIC2007_Code3__c),'') <> g.SIC2007_Code3__c or
		ISNULL(l.Email,'') <> g.Email or
		ISNULL(l.Co_Reg__c,'') <> g.Co_Reg__c
		)
	)
			
	SELECT
	CAST(Id as NCHAR(18)) Id,
	[Market_Location_URN__c],
	[Company],
	[Street],
	[City],
	[State],
	[Postalcode],
	[Phone],
	[IsTPS__c],
	[Salutation],
	[FirstName],
	case when [LastName] = '' then 'BLANK' else [LastName] end LastName,
	[Position__c],
	[Website],
	[FT_Employees__c],
	[SIC2007_Code3__c],
	[SIC2007_Description3__c],
	[Email],
	[Co_Reg__c],
	'ML_' + DATENAME(Month, GETDATE()) + '_' + CONVERT(VarChar, DATEPART(Year, GETDATE())) Source__c,
	CAST('' as nvarchar(255)) Error
	
	FROM
	SalesforceReporting..MLUpdateDONOTTOUCH_2
	
	GROUP BY
	Id,
	[Market_Location_URN__c],
	[Company],
	[Street],
	[City],
	[State],
	[Postalcode],
	[Phone],
	[IsTPS__c],
	[Salutation],
	[FirstName],
	case when [LastName] = '' then 'BLANK' else [LastName] end,
	[Position__c],
	[Website],
	[FT_Employees__c],
	[SIC2007_Code3__c],
	[SIC2007_Description3__c],
	[Email],
	[Co_Reg__c]

DROP TABLE SalesforceReporting..MLUpdateDONOTTOUCH_2