IF OBJECT_ID('SalesforceReporting..GIUpdateDONOTTOUCH') IS NOT NULL 
	BEGIN
		DROP TABLE SalesforceReporting..GIUpdateDONOTTOUCH
	END

CREATE TABLE SalesforceReporting..GIUpdateDONOTTOUCH
(
Id VarChar(255),
[Market_Location_URN__c] VarChar(255),
[Company] VarChar(255),
[Street] VarChar(255),
[Postalcode] VarChar(255),
[Phone] VarChar(255),
[Salutation] VarChar(255),
[FirstName] VarChar(255),
[LastName] VarChar(255),
[Position__c] VarChar(255),
[FT_Employees__c] VarChar(255),
[Website] VarChar(255),
[SIC Code] VarChar(255),
[Co_Reg__c] VarChar(255)
)

	INSERT INTO 
	SalesforceReporting..GIUpdateDONOTTOUCH
	(
	ID,[Market_Location_URN__c],[Company],[Street],[Postalcode],[Phone],[Salutation],[FirstName],
	[LastName],[Position__c],FT_Employees__c,[Website],[SIC Code],[Co_Reg__c]
	)
	(
	SELECT
	ID,g.ML_URN,g.[Company Name],g.[Address Line 1]+' '+g.[Address Line 2],g.[Postcode],g.[Phone Number],g.Title,g.[First Name],
	g.[Surname],g.[Role],g.[No Employees],g.[Website],g.SICCode2007,g.[Company Registration]
	
	FROM 
	Salesforce..Lead l
	inner join SalesforceReporting..GI_February_2017 g ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
														= REPLACE(case when g.[Phone Number] like '0%' then g.[Phone Number] else '0'+g.[Phone Number] end,' ','')
	WHERE 
	(RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG') or RecordTypeId is null) and (l.LeadSource not like '%cross%sell%' or l.LeadSource is null)
	and g.[Phone Number] <> '0'  and g.[Phone Number] <> ''
	and Status not in ('Approved','Data Quality','Pended','Callback Requested') 
	and (Source__c not like '%Growth%Intel%' or Source__c is null) and (Data_Supplier__c not like '%Growth%Intel%' or Data_Supplier__c is null)
	and (Source__c not like 'LB_%' or Source__c is null) and (Data_Supplier__c not like 'LB_%' or Data_Supplier__c is null)
	and (Source__c not like 'ML_New_MktWelcome%' or Source__c is null) and (Data_Supplier__c not like 'ML_New_MktWelcome%' or Data_Supplier__c is null)
	-- Actual Updates
	and
		(
		REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') <> REPLACE(REPLACE(g.[Company Name],'Ltd',''),'Limited','') or
		REPLACE(REPLACE(l.Street,' ',''),',','') <> REPLACE(REPLACE(g.[Address Line 1]+g.[Address Line 2],' ',''),',','') or
		ISNULL(l.PostalCode,'') <> g.Postcode or
		ISNULL(l.Salutation,'') <> g.Title or
		ISNULL(l.FirstName,'') <> g.[First Name] or
		ISNULL(l.LastName,'') <> g.Surname or
		ISNULL(l.Position__c,'') <> g.[Role] or
		ISNULL(l.Website,'') <> g.Website or
		ISNULL(CONVERT(VarChar, l.FT_Employees__c),'') <> g.[No Employees] or
		ISNULL(CONVERT(VarChar, l.SIC2007_Code3__c),'') <> g.SICCode2007 or
		ISNULL(l.Co_Reg__c,'') <> g.[Company Registration]
		)
	)
	
	INSERT INTO 
	SalesforceReporting..GIUpdateDONOTTOUCH
	(
	ID,[Market_Location_URN__c],[Company],[Street],[Postalcode],[Phone],[Salutation],[FirstName],
	[LastName],[Position__c],FT_Employees__c,[Website],[SIC Code],[Co_Reg__c]
	)
	(
	SELECT
	ID,g.ML_URN,g.[Company Name],g.[Address Line 1]+' '+g.[Address Line 2],g.[Postcode],g.[Phone Number],g.Title,g.[First Name],
	g.[Surname],g.[Role],g.[No Employees],g.[Website],g.SICCode2007,g.[Company Registration]
	
	FROM 
	Salesforce..Lead l
	inner join SalesforceReporting..GI_February_2017 g ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
														= REPLACE(case when g.[Phone Number] like '0%' then g.[Phone Number] else '0'+g.[Phone Number] end,' ','')
	WHERE 
	(RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG') or RecordTypeId is null) and (l.LeadSource not like '%cross%sell%' or l.LeadSource is null)
	and g.[Phone Number] <> '0'  and g.[Phone Number] <> ''
	and Status not in ('Approved','Data Quality','Pended','Callback Requested') 
	and (Source__c not like '%Growth%Intel%' or Source__c is null) and (Data_Supplier__c not like '%Growth%Intel%' or Data_Supplier__c is null)
	and (Source__c not like 'LB_%' or Source__c is null) and (Data_Supplier__c not like 'LB_%' or Data_Supplier__c is null)
	and (Source__c not like 'ML_New_MktWelcome%' or Source__c is null) and (Data_Supplier__c not like 'ML_New_MktWelcome%' or Data_Supplier__c is null)
	-- Actual Updates
	and
		(
		REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') <> REPLACE(REPLACE(g.[Company Name],'Ltd',''),'Limited','') or
		REPLACE(REPLACE(l.Street,' ',''),',','') <> REPLACE(REPLACE(g.[Address Line 1]+g.[Address Line 2],' ',''),',','') or
		ISNULL(l.PostalCode,'') <> g.Postcode or
		ISNULL(l.Salutation,'') <> g.Title or
		ISNULL(l.FirstName,'') <> g.[First Name] or
		ISNULL(l.LastName,'') <> g.Surname or
		ISNULL(l.Position__c,'') <> g.[Role] or
		ISNULL(l.Website,'') <> g.Website or
		ISNULL(CONVERT(VarChar, l.FT_Employees__c),'') <> g.[No Employees] or
		ISNULL(CONVERT(VarChar, l.SIC2007_Code3__c),'') <> g.SICCode2007 or
		ISNULL(l.Co_Reg__c,'') <> g.[Company Registration]
		)
	)

	INSERT INTO 
	SalesforceReporting..GIUpdateDONOTTOUCH
	(
	ID,[Market_Location_URN__c],[Company],[Street],[Postalcode],[Phone],[Salutation],[FirstName],
	[LastName],[Position__c],FT_Employees__c,[Website],[SIC Code],[Co_Reg__c]
	)
	(
	SELECT
	ID,g.ML_URN,g.[Company Name],g.[Address Line 1]+' '+g.[Address Line 2],g.[Postcode],g.[Phone Number],g.Title,g.[First Name],
	g.[Surname],g.[Role],g.[No Employees],g.[Website],g.SICCode2007,g.[Company Registration]
	
	FROM 
	Salesforce..Lead l
	inner join SalesforceReporting..GI_February_2017 g ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
														= REPLACE(case when g.[Phone Number] like '0%' then g.[Phone Number] else '0'+g.[Phone Number] end,' ','')
	WHERE 
	(RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG') or RecordTypeId is null) and (l.LeadSource not like '%cross%sell%' or l.LeadSource is null)
	and g.[Phone Number] <> '0'  and g.[Phone Number] <> ''
	and Status not in ('Approved','Data Quality','Pended','Callback Requested') 
	and (Source__c not like '%Growth%Intel%' or Source__c is null) and (Data_Supplier__c not like '%Growth%Intel%' or Data_Supplier__c is null)
	and (Source__c not like 'LB_%' or Source__c is null) and (Data_Supplier__c not like 'LB_%' or Data_Supplier__c is null)
	and (Source__c not like 'ML_New_MktWelcome%' or Source__c is null) and (Data_Supplier__c not like 'ML_New_MktWelcome%' or Data_Supplier__c is null)
	-- Actual Updates
	and
		(
		REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') <> REPLACE(REPLACE(g.[Company Name],'Ltd',''),'Limited','') or
		REPLACE(REPLACE(l.Street,' ',''),',','') <> REPLACE(REPLACE(g.[Address Line 1]+g.[Address Line 2],' ',''),',','') or
		ISNULL(l.PostalCode,'') <> g.Postcode or
		ISNULL(l.Salutation,'') <> g.Title or
		ISNULL(l.FirstName,'') <> g.[First Name] or
		ISNULL(l.LastName,'') <> g.Surname or
		ISNULL(l.Position__c,'') <> g.[Role] or
		ISNULL(l.Website,'') <> g.Website or
		ISNULL(CONVERT(VarChar, l.FT_Employees__c),'') <> g.[No Employees] or
		ISNULL(CONVERT(VarChar, l.SIC2007_Code3__c),'') <> g.SICCode2007 or
		ISNULL(l.Co_Reg__c,'') <> g.[Company Registration]
		)
	)

	INSERT INTO 
	SalesforceReporting..GIUpdateDONOTTOUCH
	(
	ID,[Market_Location_URN__c],[Company],[Street],[Postalcode],[Phone],[Salutation],[FirstName],
	[LastName],[Position__c],FT_Employees__c,[Website],[SIC Code],[Co_Reg__c]
	)
	(
	SELECT
	ID,g.ML_URN,g.[Company Name],g.[Address Line 1]+' '+g.[Address Line 2],g.[Postcode],g.[Phone Number],g.Title,g.[First Name],
	g.[Surname],g.[Role],g.[No Employees],g.[Website],g.SICCode2007,g.[Company Registration]
	
	FROM 
	Salesforce..Lead l
	inner join SalesforceReporting..GI_February_2017 g ON REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(g.[Company Name],'Ltd',''),'Limited','')
														and REPLACE(l.PostalCode,' ','') = REPLACE(g.Postcode,' ','')
	WHERE 
	(RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG') or RecordTypeId is null) and (l.LeadSource not like '%cross%sell%' or l.LeadSource is null)
	and Status not in ('Approved','Data Quality','Pended','Callback Requested') 
	and (Source__c not like '%Growth%Intel%' or Source__c is null) and (Data_Supplier__c not like '%Growth%Intel%' or Data_Supplier__c is null)
	and (Source__c not like 'LB_%' or Source__c is null) and (Data_Supplier__c not like 'LB_%' or Data_Supplier__c is null)
	and (Source__c not like 'ML_New_MktWelcome%' or Source__c is null) and (Data_Supplier__c not like 'ML_New_MktWelcome%' or Data_Supplier__c is null)
	-- Actual Updates
	and
		(
		REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') <> REPLACE(REPLACE(g.[Company Name],'Ltd',''),'Limited','') or
		REPLACE(REPLACE(l.Street,' ',''),',','') <> REPLACE(REPLACE(g.[Address Line 1]+g.[Address Line 2],' ',''),',','') or
		ISNULL(l.PostalCode,'') <> g.Postcode or
		ISNULL(l.Salutation,'') <> g.Title or
		ISNULL(l.FirstName,'') <> g.[First Name] or
		ISNULL(l.LastName,'') <> g.Surname or
		ISNULL(l.Position__c,'') <> g.[Role] or
		ISNULL(l.Website,'') <> g.Website or
		ISNULL(CONVERT(VarChar, l.FT_Employees__c),'') <> g.[No Employees] or
		ISNULL(CONVERT(VarChar, l.SIC2007_Code3__c),'') <> g.SICCode2007 or
		ISNULL(l.Co_Reg__c,'') <> g.[Company Registration]
		)
	)
	
	INSERT INTO 
	SalesforceReporting..GIUpdateDONOTTOUCH
	(
	ID,[Market_Location_URN__c],[Company],[Street],[Postalcode],[Phone],[Salutation],[FirstName],
	[LastName],[Position__c],FT_Employees__c,[Website],[SIC Code],[Co_Reg__c]
	)
	(
	SELECT
	ID,g.ML_URN,g.[Company Name],g.[Address Line 1]+' '+g.[Address Line 2],g.[Postcode],g.[Phone Number],g.Title,g.[First Name],
	g.[Surname],g.[Role],g.[No Employees],g.[Website],g.SICCode2007,g.[Company Registration]
	
	FROM 
	Salesforce..Lead l
	inner join SalesforceReporting..GI_February_2017 g ON l.Market_Location_URN__c = g.ML_URN
	WHERE 
	(RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG') or RecordTypeId is null) and (l.LeadSource not like '%cross%sell%' or l.LeadSource is null)
	and Status not in ('Approved','Data Quality','Pended','Callback Requested') 
	and (Source__c not like '%Growth%Intel%' or Source__c is null) and (Data_Supplier__c not like '%Growth%Intel%' or Data_Supplier__c is null)
	and (Source__c not like 'LB_%' or Source__c is null) and (Data_Supplier__c not like 'LB_%' or Data_Supplier__c is null)
	and (Source__c not like 'ML_New_MktWelcome%' or Source__c is null) and (Data_Supplier__c not like 'ML_New_MktWelcome%' or Data_Supplier__c is null)
	-- Actual Updates
	and
		(
		REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') <> REPLACE(REPLACE(g.[Company Name],'Ltd',''),'Limited','') or
		REPLACE(REPLACE(l.Street,' ',''),',','') <> REPLACE(REPLACE(g.[Address Line 1]+g.[Address Line 2],' ',''),',','') or
		ISNULL(l.PostalCode,'') <> g.Postcode or
		ISNULL(l.Salutation,'') <> g.Title or
		ISNULL(l.FirstName,'') <> g.[First Name] or
		ISNULL(l.LastName,'') <> g.Surname or
		ISNULL(l.Position__c,'') <> g.[Role] or
		ISNULL(l.Website,'') <> g.Website or
		ISNULL(CONVERT(VarChar, l.FT_Employees__c),'') <> g.[No Employees] or
		ISNULL(CONVERT(VarChar, l.SIC2007_Code3__c),'') <> g.SICCode2007 or
		ISNULL(l.Co_Reg__c,'') <> g.[Company Registration]
		)
	)
	
	INSERT INTO 
	SalesforceReporting..GIUpdateDONOTTOUCH
	(
	ID,[Market_Location_URN__c],[Company],[Street],[Postalcode],[Phone],[Salutation],[FirstName],
	[LastName],[Position__c],FT_Employees__c,[Website],[SIC Code],[Co_Reg__c]
	)
	(
	SELECT
	ID,g.ML_URN,g.[Company Name],g.[Address Line 1]+' '+g.[Address Line 2],g.[Postcode],g.[Phone Number],g.Title,g.[First Name],
	g.[Surname],g.[Role],g.[No Employees],g.[Website],g.SICCode2007,g.[Company Registration]
	
	FROM 
	Salesforce..Lead l
	inner join SalesforceReporting..GI_February_2017 g ON l.Co_Reg__c = g.[Company Registration]
	WHERE 
	(RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG') or RecordTypeId is null) and (l.LeadSource not like '%cross%sell%' or l.LeadSource is null)
	and Status not in ('Approved','Data Quality','Pended','Callback Requested') 
	and (Source__c not like '%Growth%Intel%' or Source__c is null) and (Data_Supplier__c not like '%Growth%Intel%' or Data_Supplier__c is null)
	and (Source__c not like 'LB_%' or Source__c is null) and (Data_Supplier__c not like 'LB_%' or Data_Supplier__c is null)
	and (Source__c not like 'ML_New_MktWelcome%' or Source__c is null) and (Data_Supplier__c not like 'ML_New_MktWelcome%' or Data_Supplier__c is null)
	-- Actual Updates
	and
		(
		REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') <> REPLACE(REPLACE(g.[Company Name],'Ltd',''),'Limited','') or
		REPLACE(REPLACE(l.Street,' ',''),',','') <> REPLACE(REPLACE(g.[Address Line 1]+g.[Address Line 2],' ',''),',','') or
		ISNULL(l.PostalCode,'') <> g.Postcode or
		ISNULL(l.Salutation,'') <> g.Title or
		ISNULL(l.FirstName,'') <> g.[First Name] or
		ISNULL(l.LastName,'') <> g.Surname or
		ISNULL(l.Position__c,'') <> g.[Role] or
		ISNULL(l.Website,'') <> g.Website or
		ISNULL(CONVERT(VarChar, l.FT_Employees__c),'') <> g.[No Employees] or
		ISNULL(CONVERT(VarChar, l.SIC2007_Code3__c),'') <> g.SICCode2007 or
		ISNULL(l.Co_Reg__c,'') <> g.[Company Registration]
		)
	)
			
	SELECT
	CAST(Id as NCHAR(18)) Id,
	[Market_Location_URN__c],
	[Company],
	[Street],
	[Postalcode],
	[Phone],
	[Salutation],
	[FirstName],
	case when [LastName] = '' then 'BLANK' else [LastName] end LastName,
	[Position__c],
	[Website],
	[FT_Employees__c],
	[SIC Code],
	[Co_Reg__c],
	'GI_February_2017' Source__c,
	CAST('' as nvarchar(255)) Error
	
	FROM
	SalesforceReporting..GIUpdateDONOTTOUCH
	
	GROUP BY
	Id,
	[Market_Location_URN__c],
	[Company],
	[Street],
	[Postalcode],
	[Phone],
	[Salutation],
	[FirstName],
	case when [LastName] = '' then 'BLANK' else [LastName] end,
	[Position__c],
	[Website],
	[FT_Employees__c],
	[SIC Code],
	[Co_Reg__c]