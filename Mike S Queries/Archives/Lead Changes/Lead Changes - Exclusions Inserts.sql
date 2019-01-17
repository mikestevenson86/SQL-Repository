-- New Exclusions

-- Toxic SIC

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'SIC Code 3', 'Exclusion', 'Insert' LoadType,
NULL, ml.[UK 07 Sic Code], NULL, 'No', NULL, 'Toxic SIC'
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..SIC2007Codes nc ON ml.[UK 07 Sic Code] collate latin1_general_CI_AS = nc.SIC3_Code
WHERE 
CONVERT(date, ml.DateCreated) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.[UK 07 Sic Code] <> '' and ml.[UK 07 Sic Code] <> '0'
and
nc.ToxicSIC = 1

-- Toxic SIC - Events

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'SIC Code 3', 'Exclusion',  'Insert' LoadType,
NULL, ml.[UK 07 Sic Code], NULL, 'No', NULL, 'Toxic SIC - Events'
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..SIC2007Codes nc ON ml.[UK 07 Sic Code] collate latin1_general_CI_AS = nc.SIC3_Code
WHERE 
CONVERT(date, ml.DateCreated) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and  
ml.[UK 07 Sic Code] <> '' and ml.[UK 07 Sic Code] <> '0'
and
nc.ToxicSIC_Events = 1

-- Bad Company - Exact

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Company', 'Exclusion',  'Insert' LoadType,
NULL, ml.[Business Name], NULL, 'No', NULL, 'Bad Company - Exact'
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..BadCompanies nc ON LeadChangeReview.dbo.CleanName(ml.[Business Name]) collate latin1_general_CI_AS = LeadChangeReview.dbo.CleanName(nc.Company)
WHERE 
CONVERT(date, ml.DateCreated) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and  
ml.[Business Name] <> ''
and
nc.Company is not null

-- Bad Company - Near

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Company', 'Exclusion',  'Insert' LoadType,
NULL, ml.[Business Name], NULL, 'No', NULL, 'Bad Company - Near'
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..BadCompanies_WildCards nc ON LeadChangeReview.dbo.CleanName(ml.[Business Name]) collate latin1_general_CI_AS like nc.WildCard collate latin1_general_CI_AS
WHERE 
CONVERT(date, ml.DateCreated) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and  
ml.[Business Name] <> ''
and
nc.Wildcard is not null

-- Bad Company - Events

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Company', 'Exclusion',  'Insert' LoadType,
NULL, ml.[Business Name], NULL, 'No', NULL, 'Bad Company - Events'
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
WHERE 
CONVERT(date, ml.DateCreated) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and  
LeadChangeReview.dbo.CleanName(ml.[Business Name]) in
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
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Web Address', 'Exclusion',  'Insert' LoadType,
NULL, ml.[web address], NULL, 'No', NULL, 'Bad Domain'
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..BadDomains_WildCards nc ON ml.[web address] collate latin1_general_CI_AS like nc.WildCard
WHERE 
CONVERT(date, ml.DateCreated) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and  
ml.[Business Name] <> ''
and
nc.WildCard is not null

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Contact Email Address', 'Exclusion',  'Insert' LoadType,
NULL, ml.[Contact email address], NULL, 'No', NULL, 'Bad Domain'
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..BadDomains_WildCards nc ON ml.[Contact email address] collate latin1_general_CI_AS like nc.WildCard
WHERE 
CONVERT(date, ml.DateCreated) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and  
ml.[Contact email address] <> ''
and
nc.WildCard is not null

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Company Email Address', 'Exclusion',  'Insert' LoadType,
NULL, ml.[company email address], NULL, 'No', NULL, 'Bad Domain'
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..BadDomains_WildCards nc ON ml.[company email address] collate latin1_general_CI_AS like nc.WildCard
WHERE 
CONVERT(date, ml.DateCreated) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and  
ml.[company email address] <> ''
and
nc.WildCard is not null

-- Bad Domain - NHS

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Web Address', 'Exclusion',  'Insert' LoadType,
NULL, ml.[web address], NULL, 'No', NULL, 'Bad Domain - NHS'
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
WHERE 
CONVERT(date, ml.DateCreated) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and
ml.[web address] like '%nhs.uk%' 

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Contact Email Address', 'Exclusion',  'Insert' LoadType,
NULL, ml.[Contact email address], NULL, 'No', NULL, 'Bad Domain - NHS'
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
WHERE 
CONVERT(date, ml.DateCreated) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and  
ml.[Contact email address] like '%nhs.uk%'

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Company Email Address', 'Exclusion',  'Insert' LoadType,
NULL, ml.[company email address], NULL, 'No', NULL, 'Bad Domain - NHS'
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
WHERE 
CONVERT(date, ml.DateCreated) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and  
ml.[company email address] like '%nhs.uk%'

-- Bad Position - Events

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Position', 'Exclusion',  'Insert' LoadType,
NULL, ml.[Contact position], NULL, 'No', NULL, 'Bad Position - Events'
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..PositionsEvents nc ON ml.[Contact position] collate latin1_general_CI_AS = nc.Position
WHERE 
CONVERT(date, ml.DateCreated) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and  
nc.Position is not null

-- Bad Sector - Events

INSERT INTO LeadChangeReview..Exclusions_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Company', 'Exclusion',  'Insert' LoadType,
NULL, ml.[Business Name], NULL, 'No', NULL, 'Bad Sector - Events'
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join LeadChangeReview..SuppReviewBadSector nc ON LeadChangeReview.dbo.CleanName(ml.[Business Name]) collate latin1_general_CI_AS = LeadChangeReview.dbo.CleanName(nc.company_name) collate latin1_general_CI_AS
WHERE 
CONVERT(date, ml.DateCreated) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and  
ISNULL(nc.company_name, '') <> ''