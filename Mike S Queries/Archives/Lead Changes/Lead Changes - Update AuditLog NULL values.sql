-- Duplicates

-- Old Crit

UPDATE d
SET OldCrit = 'No', OldReason = oc.LeadId
FROM LeadChangeReview..AuditLog d
inner join LeadChangeReview..LPhones oc ON REPLACE(case when d.OldValue like '0%' then d.OldValue else '0'+d.OldValue end,' ','') =
											REPLACE(case when oc.Phone like '0%' then oc.Phone else '0'+oc.Phone end,' ','')
											and d.CreatedDate between oc.StartDate and oc.EndDate
WHERE OldCrit is null and SFDC_Id <> oc.LeadId and d.OldValue <> '0' and d.OldValue <> ''

UPDATE d
SET OldCrit = 'No', OldReason =  oc.LeadId
FROM LeadChangeReview..AuditLog d
inner join LeadChangeReview..LMobiles oc ON REPLACE(case when d.OldValue like '0%' then d.OldValue else '0'+d.OldValue end,' ','') =
											REPLACE(case when oc.Mobile like '0%' then oc.Mobile else '0'+oc.Mobile end,' ','')
											and d.CreatedDate between oc.StartDate and oc.EndDate
WHERE OldCrit is null and SFDC_Id <> oc.LeadId and d.OldValue <> '0' and d.OldValue <> ''

UPDATE d
SET OldCrit = 'No', OldReason = oc.LeadId
FROM LeadChangeReview..AuditLog d
inner join LeadChangeReview..LCompany oc ON d.OldValue = oc.Company
											and d.CreatedDate between oc.StartDate and oc.EndDate
WHERE OldCrit is null and SFDC_Id <> oc.LeadId and d.OldValue <> ''

UPDATE d
SET OldCrit = 'No', OldReason = oc.[Prospect ID]
FROM LeadChangeReview..AuditLog d
inner join SalesforceReporting..toxicdata oc ON d.OldValue = oc.[Company   Account]
WHERE OldCrit is null and d.OldValue <> ''

UPDATE d
SET OldCrit = 'No', OldReason = oc.[Prospect ID]
FROM LeadChangeReview..AuditLog d
inner join SalesforceReporting..toxicdata oc ON d.OldValue = oc.[Post Code]
WHERE OldCrit is null and d.OldValue <> ''

UPDATE d
SET OldCrit = 'No', OldReason = oc.[Prospect ID]
FROM LeadChangeReview..AuditLog d
inner join SalesforceReporting..toxicdata oc ON REPLACE(case when d.OldValue like '0%' then d.OldValue else '0'+d.OldValue end,' ','') =
												REPLACE(case when oc.Phone like '0%' then oc.Phone else '0'+oc.Phone end,' ','')
WHERE OldCrit is null and d.OldValue <> ''

UPDATE d
SET OldCrit = 'No', OldReason = oc.[Prospect ID]
FROM LeadChangeReview..AuditLog d
inner join SalesforceReporting..toxicdata oc ON REPLACE(case when d.OldValue like '0%' then d.OldValue else '0'+d.OldValue end,' ','') =
												REPLACE(case when oc.Mobile like '0%' then oc.Mobile else '0'+oc.Mobile end,' ','')
WHERE OldCrit is null and d.OldValue <> ''

UPDATE d
SET OldCrit = 'No', OldReason = oc.[Prospect ID]
FROM LeadChangeReview..AuditLog d
inner join SalesforceReporting..toxicdata oc ON REPLACE(case when d.OldValue like '0%' then d.OldValue else '0'+d.OldValue end,' ','') =
												REPLACE(case when oc.[Other Phone] like '0%' then oc.[Other Phone] else '0'+oc.[Other Phone] end,' ','')
WHERE OldCrit is null and d.OldValue <> ''

UPDATE d
SET OldCrit = 'No', OldReason = oc.AccountId
FROM LeadChangeReview..AuditLog d
inner join LeadChangeReview..APhones oc ON REPLACE(case when d.OldValue like '0%' then d.OldValue else '0'+d.OldValue end,' ','') =
											REPLACE(case when oc.Phone like '0%' then oc.Phone else '0'+oc.Phone end,' ','')
											and d.CreatedDate between oc.StartDate and oc.EndDate
WHERE OldCrit is null and d.OldValue <> '0' and d.OldValue <> ''

UPDATE d
SET OldCrit = 'No', OldReason = oc.AccountId
FROM LeadChangeReview..AuditLog d
inner join LeadChangeReview..ACompany oc ON d.OldValue = oc.Company
											and d.CreatedDate between oc.StartDate and oc.EndDate
WHERE OldCrit is null and d.OldValue <> ''

UPDATE d
SET OldCrit = 'No', OldReason = oc.AccountId
FROM LeadChangeReview..AuditLog d
inner join LeadChangeReview..APostcode oc ON d.OldValue = oc.Postcode
											and d.CreatedDate between oc.StartDate and oc.EndDate
WHERE OldCrit is null and d.OldValue <> ''

UPDATE d
SET OldCrit = 'No', OldReason = oc.ParentId
FROM LeadChangeReview..AuditLog d
inner join LeadChangeReview..SPhones oc ON REPLACE(case when d.OldValue like '0%' then d.OldValue else '0'+d.OldValue end,' ','') =
											REPLACE(case when oc.Phone like '0%' then oc.Phone else '0'+oc.Phone end,' ','')
											and d.CreatedDate between oc.StartDate and oc.EndDate
WHERE OldCrit is null

UPDATE d
SET OldCrit = 'No', OldReason = oc.ParentId
FROM LeadChangeReview..AuditLog d
inner join LeadChangeReview..SPostcode oc ON d.OldValue = oc.Postcode
											and d.CreatedDate between oc.StartDate and oc.EndDate
WHERE OldCrit is null and d.OldValue <> ''

-- New Crit

UPDATE d
SET NewCrit = 'No', NewReason = oc.LeadId
FROM LeadChangeReview..AuditLog d
inner join LeadChangeReview..LPhones oc ON REPLACE(case when d.NewValue like '0%' then d.NewValue else '0'+d.NewValue end,' ','') =
											REPLACE(case when oc.Phone like '0%' then oc.Phone else '0'+oc.Phone end,' ','')
											and d.CreatedDate between oc.StartDate and oc.EndDate
WHERE NewCrit is null and SFDC_Id <> oc.LeadId and d.NewValue <> '0' and d.NewValue <> ''

UPDATE d
SET NewCrit = 'No', NewReason = oc.LeadId
FROM LeadChangeReview..AuditLog d
inner join LeadChangeReview..LMobiles oc ON REPLACE(case when d.NewValue like '0%' then d.NewValue else '0'+d.NewValue end,' ','') =
											REPLACE(case when oc.Mobile like '0%' then oc.Mobile else '0'+oc.Mobile end,' ','')
											and d.CreatedDate between oc.StartDate and oc.EndDate
WHERE NewCrit is null and SFDC_Id <> oc.LeadId and d.NewValue <> '0' and d.NewValue <> ''

UPDATE d
SET NewCrit = 'No', NewReason = oc.LeadId
FROM LeadChangeReview..AuditLog d
inner join LeadChangeReview..LCompany oc ON d.NewValue = oc.Company
											and d.CreatedDate between oc.StartDate and oc.EndDate
WHERE NewCrit is null and SFDC_Id <> oc.LeadId and d.NewValue <> ''

UPDATE d
SET NewCrit = 'No', NewReason = oc.AccountId
FROM LeadChangeReview..AuditLog d
inner join LeadChangeReview..APhones oc ON REPLACE(case when d.NewValue like '0%' then d.NewValue else '0'+d.NewValue end,' ','') =
											REPLACE(case when oc.Phone like '0%' then oc.Phone else '0'+oc.Phone end,' ','')
											and d.CreatedDate between oc.StartDate and oc.EndDate
WHERE NewCrit is null and d.NewValue <> '0' and d.NewValue <> ''

UPDATE d
SET NewCrit = 'No', NewReason = oc.AccountId
FROM LeadChangeReview..AuditLog d
inner join LeadChangeReview..ACompany oc ON d.NewValue = oc.Company
											and d.CreatedDate between oc.StartDate and oc.EndDate
WHERE NewCrit is null and d.NewValue <> ''

UPDATE d
SET NewCrit = 'No', NewReason = oc.AccountId
FROM LeadChangeReview..AuditLog d
inner join LeadChangeReview..APostcode oc ON d.NewValue = oc.Postcode
											and d.CreatedDate between oc.StartDate and oc.EndDate
WHERE NewCrit is null and d.NewValue <> ''

UPDATE d
SET NewCrit = 'No', NewReason = oc.ParentId
FROM LeadChangeReview..AuditLog d
inner join LeadChangeReview..SPhones oc ON REPLACE(case when d.NewValue like '0%' then d.NewValue else '0'+d.NewValue end,' ','') =
											REPLACE(case when oc.Phone like '0%' then oc.Phone else '0'+oc.Phone end,' ','')
											and d.CreatedDate between oc.StartDate and oc.EndDate
WHERE NewCrit is null

UPDATE d
SET NewCrit = 'No', NewReason = oc.ParentId
FROM LeadChangeReview..AuditLog d
inner join LeadChangeReview..SPostcode oc ON d.NewValue = oc.Postcode
											and d.CreatedDate between oc.StartDate and oc.EndDate
WHERE NewCrit is null and d.NewValue <> ''

--UPDATE LeadChangeReview..AuditLog SET NewCrit = 'Yes' WHERE NewCrit is null

-- Exclusions

-- Old Crit

UPDATE e
SET OldCrit = 'No', OldReason = 'Toxic SIC'
FROM LeadChangeReview..AuditLog e
left outer join Salesforce..Lead l ON e.Source_Id = l.Market_Location_URN__c
left outer join SalesforceReporting..SIC2007Codes sc ON e.OldValue = sc.SIC3_Code
WHERE l.Id is not null and e.OldValue <> '' and e.OldValue <> '0' and OldCrit is null and ToxicSIC = 1

UPDATE e
SET OldCrit = 'No', OldReason = 'Toxic SIC - Events'
FROM LeadChangeReview..AuditLog e
left outer join Salesforce..Lead l ON e.Source_Id = l.Market_Location_URN__c
left outer join SalesforceReporting..SIC2007Codes sc ON e.OldValue = sc.SIC3_Code
WHERE l.Id is not null and e.OldValue <> '' and e.OldValue <> '0' and OldCrit is null and ToxicSIC_Events = 1

UPDATE e
SET OldCrit = 'No', OldReason = 'Bad Company - Exact'
FROM LeadChangeReview..AuditLog e
left outer join Salesforce..Lead l ON e.Source_Id = l.Market_Location_URN__c
left outer join SalesforceReporting..BadCompanies nc ON LeadChangeReview.dbo.CleanName(e.OldValue) collate latin1_general_CI_AS = LeadChangeReview.dbo.CleanName(nc.Company)
WHERE l.Id is not null and OldValue <> '' and OldCrit is null and nc.Company is not null

UPDATE e
SET OldCrit = 'No', OldReason = 'Bad Company - Near'
FROM LeadChangeReview..AuditLog e
left outer join Salesforce..Lead l ON e.Source_Id = l.Market_Location_URN__c
left outer join SalesforceReporting..BadCompanies_WildCards nc ON LeadChangeReview.dbo.CleanName(e.OldValue) collate latin1_general_CI_AS like nc.WildCard
WHERE l.Id is not null and OldValue <> '' and OldCrit is null and nc.Wildcard is not null

UPDATE e
SET OldCrit = 'No', OldReason = 'Bad Company - Events'
FROM LeadChangeReview..AuditLog e
left outer join Salesforce..Lead l ON e.Source_Id = l.Market_Location_URN__c
WHERE l.Id is not null and OldValue <> '' and OldCrit is null
and 
LeadChangeReview.dbo.CleanName(e.OldValue) in
	(
		 'Peninsula Business Services'	,	'Peninsula Group'		,	'Employsure'			,	 'Taxwise'				,	'Taxwise Reward'				,
		 'Taxwise Rewards'				,	'Graphite HRM'			,	'Graphite UK'			,	 'Graphite Ireland'		,	'Graphite NI'					, 
		 'Graphite Northern Ireland'	,	'Bright HR'				,	'Bright H R'			,	 'BrightHR'				,	'Health Assured LTD'			, 
		 'Health Assured'				,	'Croner'				,	'Croner Solutions'		,	 'Croner Tax'			,	'Croner Group Ltd'				,  
		 'Croner Simply Personnel'		,	'Simply Personnel'		,	'Croner-I'				,	 'Portfolio payroll'	,	'Moorepay'						, 
		 'Northgate'					,	'Avensure'				,	'Ellis Whittham'		,	 'Bibi'					,	'Peter Swift'	
	)

UPDATE e
SET OldCrit = 'No', OldReason = 'Bad Domain'
FROM LeadChangeReview..AuditLog e
left outer join Salesforce..Lead l ON e.Source_Id = l.Market_Location_URN__c	
left outer join SalesforceReporting..BadDomains_WildCards nc ON e.OldValue collate latin1_general_CI_AS like nc.WildCard
WHERE 
l.Id is not null 
and 
e.Field in 
(
	'Company email address',
	'Contact email address',
	'Web address'
)
and
nc.WildCard is not null

UPDATE e
SET OldCrit = 'No', OldReason = 'Bad Domain - NHS'
FROM LeadChangeReview..AuditLog e
left outer join Salesforce..Lead l ON e.Source_Id = l.Market_Location_URN__c	
WHERE 
l.Id is not null 
and 
e.Field in 
(
	'Company email address',
	'Contact email address',
	'Web address'
)
and
e.OldValue like '%nhs.uk%'

UPDATE e
SET OldCrit = 'No', OldReason = 'Bad Position - Events'
FROM LeadChangeReview..AuditLog e
left outer join Salesforce..Lead l ON e.Source_Id = l.Market_Location_URN__c
left outer join SalesforceReporting..PositionsEvents nc ON e.OldValue collate latin1_general_CI_AS = nc.Position
WHERE 
l.Id is not null 
and 
e.Field = 'Position' 
and
nc.Position is not null

UPDATE e
SET OldCrit = 'No', OldReason = 'Bad Sector - Events'
FROM LeadChangeReview..AuditLog e
left outer join Salesforce..Lead l ON e.Source_Id = l.Market_Location_URN__c
left outer join LeadChangeReview..SuppReviewBadSector nc ON LeadChangeReview.dbo.CleanName(e.OldValue) collate latin1_general_CI_AS = LeadChangeReview.dbo.CleanName(nc.company_name) collate latin1_general_CI_AS
WHERE 
l.Id is not null 
and 
e.Field = 'Business Name' 
and 
nc.company_name is not null

UPDATE LeadChangeReview..AuditLog SET OldCrit = 'Yes' WHERE OldCrit is null

-- New Crit

UPDATE e
SET NewCrit = 'No', NewReason = 'Toxic SIC'
FROM LeadChangeReview..AuditLog e
left outer join Salesforce..Lead l ON e.Source_Id = l.Market_Location_URN__c
left outer join SalesforceReporting..SIC2007Codes sc ON e.NewValue = sc.SIC3_Code
WHERE l.Id is not null and e.NewValue <> '' and e.NewValue <> '0' and NewCrit is null and ToxicSIC = 1

UPDATE e
SET NewCrit = 'No', NewReason = 'Toxic SIC - Events'
FROM LeadChangeReview..AuditLog e
left outer join Salesforce..Lead l ON e.Source_Id = l.Market_Location_URN__c
left outer join SalesforceReporting..SIC2007Codes sc ON e.NewValue = sc.SIC3_Code
WHERE l.Id is not null and e.NewValue <> '' and e.NewValue <> '0' and NewCrit is null and ToxicSIC_Events = 1

UPDATE e
SET NewCrit = 'No', NewReason = 'Bad Company - Exact'
FROM LeadChangeReview..AuditLog e
left outer join Salesforce..Lead l ON e.Source_Id = l.Market_Location_URN__c
left outer join SalesforceReporting..BadCompanies nc ON LeadChangeReview.dbo.CleanName(e.NewValue) collate latin1_general_CI_AS = LeadChangeReview.dbo.CleanName(nc.Company)
WHERE l.Id is not null and NewValue <> '' and NewCrit is null and nc.Company is not null

UPDATE e
SET NewCrit = 'No', NewReason = 'Bad Company - Near'
FROM LeadChangeReview..AuditLog e
left outer join Salesforce..Lead l ON e.Source_Id = l.Market_Location_URN__c
left outer join SalesforceReporting..BadCompanies_WildCards nc ON LeadChangeReview.dbo.CleanName(e.NewValue) collate latin1_general_CI_AS like nc.WildCard
WHERE l.Id is not null and NewValue <> '' and NewCrit is null and nc.Wildcard is not null

UPDATE e
SET NewCrit = 'No', NewReason = 'Bad Company - Events'
FROM LeadChangeReview..AuditLog e
left outer join Salesforce..Lead l ON e.Source_Id = l.Market_Location_URN__c
WHERE l.Id is not null and NewValue <> '' and NewCrit is null
and 
LeadChangeReview.dbo.CleanName(e.NewValue) in
	(
		 'Peninsula Business Services'	,	'Peninsula Group'		,	'Employsure'			,	 'Taxwise'				,	'Taxwise Reward'				,
		 'Taxwise Rewards'				,	'Graphite HRM'			,	'Graphite UK'			,	 'Graphite Ireland'		,	'Graphite NI'					, 
		 'Graphite Northern Ireland'	,	'Bright HR'				,	'Bright H R'			,	 'BrightHR'				,	'Health Assured LTD'			, 
		 'Health Assured'				,	'Croner'				,	'Croner Solutions'		,	 'Croner Tax'			,	'Croner Group Ltd'				,  
		 'Croner Simply Personnel'		,	'Simply Personnel'		,	'Croner-I'				,	 'Portfolio payroll'	,	'Moorepay'						, 
		 'Northgate'					,	'Avensure'				,	'Ellis Whittham'		,	 'Bibi'					,	'Peter Swift'	
	)

UPDATE e
SET NewCrit = 'No', NewReason = 'Bad Domain'
FROM LeadChangeReview..AuditLog e
left outer join Salesforce..Lead l ON e.Source_Id = l.Market_Location_URN__c	
left outer join SalesforceReporting..BadDomains_WildCards nc ON e.NewValue collate latin1_general_CI_AS like nc.WildCard
WHERE 
l.Id is not null 
and 
e.Field in 
(
	'Company email address',
	'Contact email address',
	'Web address'
)
and
nc.WildCard is not null

UPDATE e
SET NewCrit = 'No', NewReason = 'Bad Domain - NHS'
FROM LeadChangeReview..AuditLog e
left outer join Salesforce..Lead l ON e.Source_Id = l.Market_Location_URN__c	
WHERE 
l.Id is not null 
and 
e.Field in 
(
	'Company email address',
	'Contact email address',
	'Web address'
)
and
e.NewValue like '%nhs.uk%'

UPDATE e
SET NewCrit = 'No', NewReason = 'Bad Position - Events'
FROM LeadChangeReview..AuditLog e
left outer join Salesforce..Lead l ON e.Source_Id = l.Market_Location_URN__c
left outer join SalesforceReporting..PositionsEvents nc ON e.NewValue collate latin1_general_CI_AS = nc.Position
WHERE 
l.Id is not null 
and 
e.Field = 'Position' 
and
nc.Position is not null

UPDATE e
SET NewCrit = 'No', NewReason = 'Bad Sector - Events'
FROM LeadChangeReview..AuditLog e
left outer join Salesforce..Lead l ON e.Source_Id = l.Market_Location_URN__c
left outer join [LSAUTOMATION].SalesforceReporting.dbo.SuppReviewBadSector nc ON LeadChangeReview.dbo.CleanName(e.NewValue) collate latin1_general_CI_AS = LeadChangeReview.dbo.CleanName(nc.company_name) collate latin1_general_CI_AS
WHERE 
l.Id is not null 
and 
e.Field = 'Business Name' 
and 
nc.company_name is not null

UPDATE LeadChangeReview..Exclusions_AuditLog SET NewCrit = 'Yes' WHERE NewCrit is null