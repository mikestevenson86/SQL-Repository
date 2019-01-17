-- Exclusions

IF OBJECT_ID('LeadChangeReview..Exclusions_AuditLog') IS NOT NULL
	BEGIN
		DROP TABLE LeadChangeReview..Exclusions_AuditLog
	END

CREATE TABLE LeadChangeReview..Exclusions_AuditLog
(
CreatedDate datetime,
[Source] VarChar(20),
Source_Id VarChar(20),
SFDC_Id VarChar(20),
Field VarChar(50),
AuditType VarChar(50),
LoadType VarChar(10),
OldValue VarChar(500),
NewValue VarChar(500),
OldCrit VarChar(10),
NewCrit VarChar(10),
OldReason VarChar(255),
NewReason VarChar(255)
)

-- New Exclusions

-- Toxic SIC

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'SIC Code 3', 'Exclusion', 'Update', 
ml.OldValue, ml.NewValue, NULL, 'No', NULL, 'Toxic SIC'
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..SIC2007Codes nc ON ml.NewValue collate latin1_general_CI_AS = nc.SIC3_Code
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and
ml.Field = 'UK 07 Sic Code' 
and
ml.NewValue <> ml.OldValue
and
nc.ToxicSIC = 1

-- Toxic SIC - Events

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'SIC Code 3', 'Exclusion',  'Update',
ml.OldValue, ml.NewValue, NULL, 'No', NULL, 'Toxic SIC - Events'
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..SIC2007Codes nc ON ml.NewValue collate latin1_general_CI_AS = nc.SIC3_Code
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'UK 07 Sic Code' 
and
ml.NewValue <> ml.OldValue
and
nc.ToxicSIC_Events = 1

-- Bad Company - Exact

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Company', 'Exclusion',  'Update',
ml.OldValue, ml.NewValue, NULL, 'No', NULL, 'Bad Company - Exact'
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..BadCompanies nc ON LeadChangeReview.dbo.CleanName(ml.NewValue) collate latin1_general_CI_AS = LeadChangeReview.dbo.CleanName(nc.Company)
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Business Name' 
and
ml.NewValue <> ml.OldValue
and
nc.Company is not null

-- Bad Company - Near

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Company', 'Exclusion',  'Update',
ml.OldValue, ml.NewValue, NULL, 'No', NULL, 'Bad Company - Near'
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..BadCompanies_WildCards nc ON LeadChangeReview.dbo.CleanName(ml.NewValue) collate latin1_general_CI_AS like nc.WildCard
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Business Name' 
and
ml.NewValue <> ml.OldValue
and
nc.Wildcard is not null

-- Bad Company - Events

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Company', 'Exclusion', 'Update', 
ml.OldValue, ml.NewValue, NULL, 'No', NULL, 'Bad Company - Events'
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Business Name'
and
ml.NewValue <> ml.OldValue 
and 
LeadChangeReview.dbo.CleanName(ml.NewValue) in
	(
		 'Peninsula Business Services'	,	'Peninsula Group'		,	'Employsure'			,	 'Taxwise'				,	'Taxwise Reward'				,
		 'Taxwise Rewards'				,	'Graphite HRM'			,	'Graphite UK'			,	 'Graphite Ireland'		,	'Graphite NI'					, 
		 'Graphite Northern Ireland'	,	'Bright HR'				,	'Bright H R'			,	 'BrightHR'				,	'Health Assured LTD'			, 
		 'Health Assured'				,	'Croner'				,	'Croner Solutions'		,	 'Croner Tax'			,	'Croner Group Ltd'				,  
		 'Croner Simply Personnel'		,	'Simply Personnel'		,	'Croner-I'				,	 'Portfolio payroll'	,	'Moorepay'						, 
		 'Northgate'					,	'Avensure'				,	'Ellis Whittham'		,	 'Bibi'					,	'Peter Swift'	
	)

-- Bad Domain

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, ml.Field, 'Exclusion',  'Update',
ml.OldValue, ml.NewValue, NULL, 'No', NULL, 'Bad Domain'
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..BadDomains_WildCards nc ON ml.NewValue collate latin1_general_CI_AS like nc.WildCard
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field in 
(
	'Company email address',
	'Contact email address',
	'Web address'
)
and
ml.NewValue <> ml.OldValue
and
nc.WildCard is not null

-- Bad Domain - NHS

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, ml.Field, 'Exclusion',  'Update',
ml.OldValue, ml.NewValue, NULL, 'No', NULL, 'Bad Domain - NHS'
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field in 
(
	'Company email address',
	'Contact email address',
	'Web address'
)
and
ml.NewValue <> ml.OldValue
and
ml.NewValue like '%nhs.uk%' 

-- Bad Position - Events

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Position', 'Exclusion',  'Update',
ml.OldValue, ml.NewValue, NULL, 'No', NULL, 'Bad Position - Events'
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..PositionsEvents nc ON ml.NewValue collate latin1_general_CI_AS = nc.Position
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Contact position'
and
ml.NewValue <> ml.OldValue 
and
nc.Position is not null

-- Bad Sector - Events

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Company', 'Exclusion',  'Update',
ml.OldValue, ml.NewValue, NULL, 'No', NULL, 'Bad Sector - Events'
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join LeadChangeReview..SuppReviewBadSector nc ON LeadChangeReview.dbo.CleanName(ml.NewValue) collate latin1_general_CI_AS = LeadChangeReview.dbo.CleanName(nc.company_name) collate latin1_general_CI_AS
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Business Name' 
and
ml.NewValue <> ml.OldValue
and 
ISNULL(nc.company_name, '') <> ''

-- Old Exclusions

-- Toxic SIC

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'SIC Code 3', 'Exclusion',  'Update',
ml.OldValue, ml.NewValue, 'No', NULL, 'Toxic SIC', NULL
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..SIC2007Codes nc ON ml.OldValue collate latin1_general_CI_AS = nc.SIC3_Code
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'UK 07 Sic Code' 
and
ml.NewValue <> ml.OldValue
and 
ml.OldValue <> '' and ml.OldValue <> '0'
and
nc.ToxicSIC = 1

-- Toxic SIC - Events

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'SIC Code 3', 'Exclusion',  'Update',
ml.OldValue, ml.NewValue, 'No', NULL, 'Toxic SIC - Events', NULL
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..SIC2007Codes nc ON ml.OldValue collate latin1_general_CI_AS = nc.SIC3_Code
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'UK 07 Sic Code' 
and
ml.NewValue <> ml.OldValue
and
nc.ToxicSIC_Events = 1

-- Bad Company - Exact

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Company', 'Exclusion',  'Update',
ml.OldValue, ml.NewValue, 'No', NULL, 'Bad Company - Exact', NULL
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..BadCompanies nc ON LeadChangeReview.dbo.CleanName(ml.OldValue) collate latin1_general_CI_AS = LeadChangeReview.dbo.CleanName(nc.Company)
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
l.Id is not null 
and 
ml.Field = 'Business Name' 
and
ml.NewValue <> ml.OldValue
and
nc.Company is not null

-- Bad Company - Near

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Company', 'Exclusion',  'Update',
ml.OldValue, ml.NewValue, 'No', NULL, 'Bad Company - Near', NULL
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..BadCompanies_WildCards nc ON LeadChangeReview.dbo.CleanName(ml.OldValue) collate latin1_general_CI_AS like nc.WildCard
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Business Name' 
and
ml.NewValue <> ml.OldValue
and
nc.Wildcard is not null

-- Bad Company - Events

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Company', 'Exclusion', 'Update', 
ml.OldValue, ml.NewValue, 'No', NULL, 'Bad Company - Events', NULL
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Business Name' 
and
ml.NewValue <> ml.OldValue
and 
LeadChangeReview.dbo.CleanName(ml.OldValue) in
	(
		 'Peninsula Business Services'	,	'Peninsula Group'		,	'Employsure'			,	 'Taxwise'				,	'Taxwise Reward'				,
		 'Taxwise Rewards'				,	'Graphite HRM'			,	'Graphite UK'			,	 'Graphite Ireland'		,	'Graphite NI'					, 
		 'Graphite Northern Ireland'	,	'Bright HR'				,	'Bright H R'			,	 'BrightHR'				,	'Health Assured LTD'			, 
		 'Health Assured'				,	'Croner'				,	'Croner Solutions'		,	 'Croner Tax'			,	'Croner Group Ltd'				,  
		 'Croner Simply Personnel'		,	'Simply Personnel'		,	'Croner-I'				,	 'Portfolio payroll'	,	'Moorepay'						, 
		 'Northgate'					,	'Avensure'				,	'Ellis Whittham'		,	 'Bibi'					,	'Peter Swift'	
	)

-- Bad Domain

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, ml.Field, 'Exclusion',  'Update',
ml.OldValue, ml.NewValue, 'No', NULL, 'Bad Domain', NULL
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..BadDomains_WildCards nc ON ml.OldValue collate latin1_general_CI_AS like nc.WildCard
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field in 
(
	'Company email address',
	'Contact email address',
	'Web address'
)
and
ml.NewValue <> ml.OldValue
and
nc.WildCard is not null

-- Bad Domain - NHS

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, ml.Field, 'Exclusion',  'Update',
ml.OldValue, ml.NewValue, 'No', NULL, 'Bad Domain - NHS', NULL
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field in 
(
	'Company email address',
	'Contact email address',
	'Web address'
)
and
ml.NewValue <> ml.OldValue
and
ml.OldValue like '%nhs.uk%' 

-- Bad Position - Events

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Position', 'Exclusion',  'Update',
ml.OldValue, ml.NewValue, 'No', NULL, 'Bad Position - Events', NULL
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..PositionsEvents nc ON ml.OldValue collate latin1_general_CI_AS = nc.Position
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and  
ml.Field = 'Contact position' 
and
ml.NewValue <> ml.OldValue
and
nc.Position is not null

-- Bad Sector - Events

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Company', 'Exclusion',  'Update',
ml.OldValue, ml.NewValue, 'No', NULL, 'Bad Sector - Events', NULL
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join LeadChangeReview..SuppReviewBadSector nc ON LeadChangeReview.dbo.CleanName(ml.OldValue) collate latin1_general_CI_AS = LeadChangeReview.dbo.CleanName(nc.company_name) collate latin1_general_CI_AS
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Business Name' 
and
ml.NewValue <> ml.OldValue
and 
ISNULL(nc.company_name, '') <> ''