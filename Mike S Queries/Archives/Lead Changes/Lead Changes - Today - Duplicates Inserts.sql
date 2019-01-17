-- Duplicates

-- New Dupes

-- Lead Phones

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Phone', 'Duplicate - Lead', 'Insert'
, 'New Lead', ml.[Telephone Number], NULL, 'No', NULL, h.LeadId
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join LeadChangeReview..LPhones h ON REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','') collate latin1_general_CI_AS 
												= REPLACE(case when h.Phone like '0%' then h.Phone else '0'+h.Phone end,' ','')  
												and ml.DateCreated between h.StartDate and h.EndDate
WHERE 
CONVERT(date, DateCreated) = CONVERT(date, GETDATE())
and
h.LeadId is not null
and 
ISNULL(l.Id, '') <> h.LeadId collate latin1_general_CI_AS 

-- Lead Mobile Phones

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Mobile Phone', 'Duplicate - Lead', 'Insert'
, 'New Lead', ml.[Telephone Number], NULL, 'No', NULL, h.LeadId
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join LeadChangeReview..LMobiles h ON REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','') collate latin1_general_CI_AS 
												= REPLACE(case when h.Mobile like '0%' then h.Mobile else '0'+h.Mobile end,' ','') 
												and ml.DateCreated between h.StartDate and h.EndDate
WHERE 
CONVERT(date, DateCreated) = CONVERT(date, GETDATE())
and  
ISNULL(l.Id, '') <> h.LeadId collate latin1_general_CI_AS 

-- Lead Company

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Company', 'Duplicate - Lead', 'Insert'
, 'New Lead', ml.[Business Name], NULL, 'No', NULL, h.LeadId
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c 
left outer join LeadChangeReview..LCompany h ON ml.[Business Name] collate latin1_general_CI_AS = h.Company   
								and ml.DateCreated between h.StartDate and h.EndDate
WHERE 
CONVERT(date, DateCreated) = CONVERT(date, GETDATE())
and 
ISNULL(l.Id, '') <> h.LeadId collate latin1_general_CI_AS

-- Toxic Phones

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Phone', 'Duplicate - Toxic Data', 'Insert'
, 'New Lead', ml.[Telephone Number], NULL, 'No', NULL, h.[Prospect Id]
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..toxicdata h ON REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','') collate latin1_general_CI_AS
													= REPLACE(case when h.Phone like '0%' then h.Phone else '0'+h.Phone end,' ','') 
													and h.Phone <> '' and h.Phone <> '0'
WHERE 
CONVERT(date, DateCreated) = CONVERT(date, GETDATE())
and  
h.[Prospect Id] is not null

-- Toxic Mobile Phones

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Mobile Phone', 'Duplicate - Toxic Data', 'Insert'
, 'New Lead', ml.[Telephone Number], NULL, 'No', NULL, h.[Prospect Id]
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c  
left outer join SalesforceReporting..toxicdata h ON REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','') collate latin1_general_CI_AS 
													= REPLACE(case when h.Mobile like '0%' then h.Mobile else '0'+h.Mobile end,' ','')   
													and h.Mobile <> '' and h.Mobile <> '0'
WHERE 
CONVERT(date, DateCreated) = CONVERT(date, GETDATE())
and  
h.[Prospect Id] is not null

-- Toxic Other Phones

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Other Phone', 'Duplicate - Toxic Data', 'Insert'
, 'New Lead', ml.[Telephone Number], NULL, 'No', NULL, h.[Prospect Id]
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c  
left outer join SalesforceReporting..toxicdata h ON REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','') collate latin1_general_CI_AS 
													= REPLACE(case when h.[Other Phone] like '0%' then h.[Other Phone] else '0'+h.[Other Phone] end,' ','')   
													and h.[Other Phone] <> '' and h.[Other Phone] <> '0'
WHERE 
CONVERT(date, DateCreated) = CONVERT(date, GETDATE())
and
h.[Prospect Id] is not null


-- Toxic Company

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Company', 'Duplicate - Toxic Data', 'Insert'
, 'New Lead', ml.[Business Name], NULL, 'No', NULL, h.[Prospect ID]
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c  
left outer join SalesforceReporting..toxicdata h ON ml.[Business Name] collate latin1_general_CI_AS = h.[Company   Account]   
WHERE 
CONVERT(date, DateCreated) = CONVERT(date, GETDATE())
and
h.[Prospect ID] is not null

-- Toxic Postcode

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Postcode', 'Duplicate - Toxic Data', 'Insert'
, 'New Lead', ml.Postcode, NULL, 'No', NULL, h.[Prospect Id]
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c  
left outer join SalesforceReporting..toxicdata h ON ml.Postcode collate latin1_general_CI_AS = h.[Post Code]  
WHERE 
CONVERT(date, DateCreated) = CONVERT(date, GETDATE())
and 
h.[Prospect ID] is not null

-- Account Phones

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Phone', 'Duplicate - Account', 'Insert'
, 'New Lead', ml.[Telephone Number], NULL, 'No', NULL, h.AccountId
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c  
left outer join LeadChangeReview..APhones h ON REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','') collate latin1_general_CI_AS 
												= REPLACE(case when h.Phone like '0%' then h.Phone else '0'+h.Phone end,' ','')   
												and ml.DateCreated between h.StartDate and h.EndDate
WHERE 
CONVERT(date, DateCreated) = CONVERT(date, GETDATE())
and  
h.AccountId is not null

-- Account Company

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Company', 'Duplicate - Account', 'Insert'
, 'New Lead', ml.[Business Name], NULL, 'No', NULL, h.AccountId
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c  
left outer join LeadChangeReview..ACompany h ON ml.[Business Name] collate latin1_general_CI_AS = h.Company   
												and ml.DateCreated between h.StartDate and h.EndDate
WHERE 
CONVERT(date, DateCreated) = CONVERT(date, GETDATE())
and
h.AccountId is not null

-- Account Postcode

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Postcode', 'Duplicate - Account', 'Insert'
, 'New Lead', ml.Postcode, NULL, 'No', NULL, h.AccountId
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c  
left outer join LeadChangeReview..APostcode h ON ml.Postcode collate latin1_general_CI_AS = h.Postcode   
												and ml.DateCreated between h.StartDate and h.EndDate
WHERE 
CONVERT(date, DateCreated) = CONVERT(date, GETDATE())
and
h.AccountId is not null

-- Site Phones

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Phone', 'Duplicate - Site', 'Insert'
, 'New Lead', ml.[Telephone Number], NULL, 'No', NULL, h.ParentId
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c  
left outer join LeadChangeReview..SPhones h ON REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','') collate latin1_general_CI_AS 
												= REPLACE(case when h.Phone like '0%' then h.Phone else '0'+h.Phone end,' ','')   
												and ml.DateCreated between h.StartDate and h.EndDate
WHERE 
CONVERT(date, DateCreated) = CONVERT(date, GETDATE())
and  
h.ParentId is not null

-- Site Postcode

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.DateCreated, ml.[Source], ml.URN, l.Id, 'Postcode', 'Duplicate - Site', 'Insert'
, 'New Lead', ml.Postcode, NULL, 'No', NULL, h.ParentId
FROM LeadChangeReview..ML_InitialState ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c  
left outer join LeadChangeReview..SPostcode h ON ml.Postcode collate latin1_general_CI_AS = h.Postcode   
												and ml.DateCreated between h.StartDate and h.EndDate
WHERE 
CONVERT(date, DateCreated) = CONVERT(date, GETDATE())
and
h.ParentId is not null