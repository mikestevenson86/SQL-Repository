-- Duplicates

IF OBJECT_ID('LeadChangeReview..Duplicates_AuditLog') IS NOT NULL
	BEGIN
		DROP TABLE LeadChangeReview..Duplicates_AuditLog
	END

CREATE TABLE LeadChangeReview..Duplicates_AuditLog
(
CreatedDate datetime,
[Source] VarChar(20),
Source_Id VarChar(20),
SFDC_Id VarChar(20),
Field VarChar(50),
AuditType VarChar(50),
LoadType VarChar(10),
OldValue VarChar(255),
NewValue VarChar(255),
OldCrit VarChar(10),
NewCrit VarChar(10),
OldReason VarChar(255),
NewReason VarChar(255)
)

-- New Dupes

-- Lead Phones

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Phone', 'Duplicate - Lead', 'Update'
, ml.OldValue, ml.NewValue, NULL, 'No', NULL, h.LeadId
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c 
left outer join LeadChangeReview..LPhones h ON REPLACE(case when ml.NewValue like '0%' then ml.NewValue else '0'+ml.NewValue end,' ','') collate latin1_general_CI_AS 
												= REPLACE(case when h.Phone like '0%' then h.Phone else '0'+h.Phone end,' ','')  
												and ml.CreatedDate between h.StartDate and h.EndDate
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and
ml.Field = 'Telephone Number'
and 
REPLACE(case when ml.NewValue like '0%' then ml.NewValue else '0'+ml.NewValue end,' ','') <> REPLACE(case when ml.OldValue like '0%' then ml.OldValue else '0'+ml.OldValue end,' ','') 
and
h.LeadId is not null 
and 
h.LeadId <> ISNULL(l.Id, '')

-- Lead Mobiles

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Mobile Phone', 'Duplicate - Lead', 'Update'
, ml.OldValue, ml.NewValue, NULL, 'No', NULL, h.LeadId
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c 
left outer join LeadChangeReview..LMobiles h ON REPLACE(case when ml.NewValue like '0%' then ml.NewValue else '0'+ml.NewValue end,' ','') collate latin1_general_CI_AS 
												= REPLACE(case when h.Mobile like '0%' then h.Mobile else '0'+h.Mobile end,' ','')   
												and ml.CreatedDate between h.StartDate and h.EndDate
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Telephone Number' 
and 
REPLACE(case when ml.NewValue like '0%' then ml.NewValue else '0'+ml.NewValue end,' ','') <> REPLACE(case when ml.OldValue like '0%' then ml.OldValue else '0'+ml.OldValue end,' ','') 
and
h.LeadId is not null 
and 
h.LeadId <> ISNULL(l.Id, '')

-- Lead Company

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Company', 'Duplicate - Lead', 'Update'
, ml.OldValue, ml.NewValue, NULL, 'No', NULL, h.LeadId
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c 
left outer join LeadChangeReview..LCompany h ON LeadChangeReview.dbo.CleanName(ml.NewValue) collate latin1_general_CI_AS = LeadChangeReview.dbo.CleanName(h.Company) 
								and ml.CreatedDate between h.StartDate and h.EndDate
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Business Name'
and 
ml.NewValue <> ml.OldValue
and
h.LeadId is not null
and 
h.LeadId <> ISNULL(l.Id, '')

-- Toxic Phones

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Phone', 'Duplicate - Toxic Data', 'Update'
, ml.OldValue, ml.NewValue, NULL, 'No', NULL, h.[Prospect Id]
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c 
left outer join SalesforceReporting..toxicdata h ON REPLACE(case when ml.NewValue like '0%' then ml.NewValue else '0'+ml.NewValue end,' ','') collate latin1_general_CI_AS 
													= REPLACE(case when h.Phone like '0%' then h.Phone else '0'+h.Phone end,' ','') 
													and h.Phone <> '' and h.Phone <> '0'
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and  
ml.Field = 'Telephone Number' 
and 
REPLACE(case when ml.NewValue like '0%' then ml.NewValue else '0'+ml.NewValue end,' ','') <> REPLACE(case when ml.OldValue like '0%' then ml.OldValue else '0'+ml.OldValue end,' ','') 
and
h.[Prospect Id] is not null

-- Toxic Mobiles

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Mobile Phone', 'Duplicate - Toxic Data', 'Update'
, ml.OldValue, ml.NewValue, NULL, 'No', NULL, h.[Prospect Id]
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..toxicdata h ON REPLACE(case when ml.NewValue like '0%' then ml.NewValue else '0'+ml.NewValue end,' ','') collate latin1_general_CI_AS 
													= REPLACE(case when h.Mobile like '0%' then h.Mobile else '0'+h.Mobile end,' ','')  
													and h.Mobile <> '' and h.Mobile <> '0'

WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and  
ml.Field = 'Telephone Number' 
and 
REPLACE(case when ml.NewValue like '0%' then ml.NewValue else '0'+ml.NewValue end,' ','') <> REPLACE(case when ml.OldValue like '0%' then ml.OldValue else '0'+ml.OldValue end,' ','') 
and
h.[Prospect Id] is not null

-- Toxic Other Phones

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Other Phone', 'Duplicate - Toxic Data', 'Update'
, ml.OldValue, ml.NewValue, NULL, 'No', NULL, h.[Prospect Id]
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join SalesforceReporting..toxicdata h ON REPLACE(case when ml.NewValue like '0%' then ml.NewValue else '0'+ml.NewValue end,' ','') collate latin1_general_CI_AS 
													= REPLACE(case when h.[Other Phone] like '0%' then h.[Other Phone] else '0'+h.[Other Phone] end,' ','') 
													and h.[Other Phone] <> '' and h.[Other Phone] <> '0'
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and  
ml.Field = 'Telephone Number' 
and  
REPLACE(case when ml.NewValue like '0%' then ml.NewValue else '0'+ml.NewValue end,' ','') <> REPLACE(case when ml.OldValue like '0%' then ml.OldValue else '0'+ml.OldValue end,' ','') 
and
h.[Prospect Id] is not null

-- Toxic Company

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Company', 'Duplicate - Toxic Data', 'Update'
, ml.OldValue, ml.NewValue, NULL, 'No', NULL, h.[Prospect ID]
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c 
left outer join SalesforceReporting..toxicdata h ON LeadChangeReview.dbo.CleanName(ml.NewValue) collate latin1_general_CI_AS = LeadChangeReview.dbo.CleanName(h.[Company   Account]) 
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Business Name'
and 
ml.NewValue <> ml.OldValue
and
h.[Prospect ID] is not null

-- Toxic Postcode

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Postcode', 'Duplicate - Toxic Data', 'Update'
, ml.OldValue, ml.NewValue, NULL, 'No', NULL, h.[Prospect Id]
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c 
left outer join SalesforceReporting..toxicdata h ON REPLACE(ml.NewValue,' ','') collate latin1_general_CI_AS = REPLACE(h.[Post Code],' ','')
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Postcode'
and 
ml.NewValue <> ml.OldValue
and
h.[Prospect ID] is not null

-- Account Phones

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Phone', 'Duplicate - Account', 'Update'
, ml.OldValue, ml.NewValue, NULL, 'No', NULL, h.AccountId
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join LeadChangeReview..APhones h ON REPLACE(case when ml.NewValue like '0%' then ml.NewValue else '0'+ml.NewValue end,' ','') collate latin1_general_CI_AS 
												= REPLACE(case when h.Phone like '0%' then h.Phone else '0'+h.Phone end,' ','')
												and ml.CreatedDate between h.StartDate and h.EndDate
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and  
ml.Field = 'Telephone Number' 
and
REPLACE(case when ml.NewValue like '0%' then ml.NewValue else '0'+ml.NewValue end,' ','') <> REPLACE(case when ml.OldValue like '0%' then ml.OldValue else '0'+ml.OldValue end,' ','') 
and
h.AccountId is not null

-- Account Company

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Company', 'Duplicate - Account', 'Update'
, ml.OldValue, ml.NewValue, NULL, 'No', NULL, h.AccountId
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c 
left outer join LeadChangeReview..ACompany h ON LeadChangeReview.dbo.CleanName(ml.NewValue) collate latin1_general_CI_AS = LeadChangeReview.dbo.CleanName(h.Company)
												and ml.CreatedDate between h.StartDate and h.EndDate
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Business Name'
and 
ml.NewValue <> ml.OldValue
and
h.AccountId is not null

-- Account Postcode

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Postcode', 'Duplicate - Account', 'Update'
, ml.OldValue, ml.NewValue, NULL, 'No', NULL, h.AccountId
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c 
left outer join LeadChangeReview..APostcode h ON REPLACE(ml.NewValue,' ','') collate latin1_general_CI_AS = REPLACE(h.Postcode,' ','')
												and ml.CreatedDate between h.StartDate and h.EndDate
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and  
ml.Field = 'Postcode'
and 
ml.NewValue <> ml.OldValue
and
h.AccountId is not null

-- Site Phones

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Phone', 'Duplicate - Site', 'Update'
, ml.OldValue, ml.NewValue, NULL, 'No', NULL, h.ParentId
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join LeadChangeReview..SPhones h ON REPLACE(case when ml.NewValue like '0%' then ml.NewValue else '0'+ml.NewValue end,' ','') collate latin1_general_CI_AS 
												= REPLACE(case when h.Phone like '0%' then h.Phone else '0'+h.Phone end,' ','')
												and ml.CreatedDate between h.StartDate and h.EndDate
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and  
ml.Field = 'Telephone Number' 
and
REPLACE(case when ml.NewValue like '0%' then ml.NewValue else '0'+ml.NewValue end,' ','') <> REPLACE(case when ml.OldValue like '0%' then ml.OldValue else '0'+ml.OldValue end,' ','') 
and
h.ParentId is not null

-- Site Postcode

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Postcode', 'Duplicate - Site', 'Update'
, ml.OldValue, ml.NewValue, NULL, 'No', NULL, h.ParentId
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
left outer join LeadChangeReview..SPostcode h ON REPLACE(ml.NewValue,' ','') collate latin1_general_CI_AS = REPLACE(h.Postcode,' ','')
												and ml.CreatedDate between h.StartDate and h.EndDate
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Postcode'
and 
ml.NewValue <> ml.OldValue
and
h.ParentId is not null

-- Old Dupes

-- Lead Phones

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Phone', 'Duplicate - Lead', 'Update'
, ml.OldValue, ml.NewValue, 'No', NULL, h.LeadId, NULL
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c  
left outer join LeadChangeReview..LPhones h ON REPLACE(case when ml.OldValue like '0%' then ml.OldValue else '0'+ml.OldValue end,' ','') collate latin1_general_CI_AS 
												= REPLACE(case when h.Phone like '0%' then h.Phone else '0'+h.Phone end,' ','')   
												and ml.CreatedDate between h.StartDate and h.EndDate

WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Telephone Number' 
and 
REPLACE(case when ml.NewValue like '0%' then ml.NewValue else '0'+ml.NewValue end,' ','') <> REPLACE(case when ml.OldValue like '0%' then ml.OldValue else '0'+ml.OldValue end,' ','') 
and
h.LeadId is not null
and 
h.LeadId collate latin1_general_CI_AS <> ISNULL(l.Id, '')

-- Lead Mobiles

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Mobile Phone', 'Duplicate - Lead', 'Update'
, ml.OldValue, ml.NewValue, 'No', NULL, h.LeadId, NULL
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c  
left outer join LeadChangeReview..LMobiles h ON REPLACE(case when ml.OldValue like '0%' then ml.OldValue else '0'+ml.OldValue end,' ','') collate latin1_general_CI_AS 
												= REPLACE(case when h.Mobile like '0%' then h.Mobile else '0'+h.Mobile end,' ','')   
												and ml.CreatedDate between h.StartDate and h.EndDate
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Telephone Number' 
and 
REPLACE(case when ml.NewValue like '0%' then ml.NewValue else '0'+ml.NewValue end,' ','') <> REPLACE(case when ml.OldValue like '0%' then ml.OldValue else '0'+ml.OldValue end,' ','') 
and
h.LeadId is not null
and 
h.LeadId collate latin1_general_CI_AS <> ISNULL(l.Id, '') 

-- Lead Company

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Company', 'Duplicate - Lead', 'Update'
, ml.OldValue, ml.NewValue, 'No', NULL, h.LeadId, NULL
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c 
left outer join LeadChangeReview..LCompany h ON LeadChangeReview.dbo.CleanName(ml.OldValue) collate latin1_general_CI_AS = LeadChangeReview.dbo.CleanName(h.Company  )
												and ml.CreatedDate between h.StartDate and h.EndDate
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and  
ml.Field = 'Business Name'
and 
ml.NewValue <> ml.OldValue
and
h.LeadId is not null
and 
h.LeadId collate latin1_general_CI_AS <> ISNULL(l.Id, '')

-- Toxic Phones

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Phone', 'Duplicate - Toxic Data', 'Update'
, ml.OldValue, ml.NewValue, 'No', NULL, h.[Prospect Id], NULL
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c 
left outer join SalesforceReporting..toxicdata h ON REPLACE(case when ml.OldValue like '0%' then ml.OldValue else '0'+ml.OldValue end,' ','') collate latin1_general_CI_AS 
													= REPLACE(case when h.Phone like '0%' then h.Phone else '0'+h.Phone end,' ','') 
													and h.Phone <> '' and h.Phone <> '0'
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Telephone Number' 
and 
REPLACE(case when ml.NewValue like '0%' then ml.NewValue else '0'+ml.NewValue end,' ','') <> REPLACE(case when ml.OldValue like '0%' then ml.OldValue else '0'+ml.OldValue end,' ','') 
and
h.[Prospect Id] is not null

-- Toxic Mobile Phones

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Mobile Phone', 'Duplicate - Toxic Data', 'Update'
, ml.OldValue, ml.NewValue, 'No', NULL, h.[Prospect Id], NULL
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c  
left outer join SalesforceReporting..toxicdata h ON REPLACE(case when ml.OldValue like '0%' then ml.OldValue else '0'+ml.OldValue end,' ','') collate latin1_general_CI_AS 
													= REPLACE(case when h.Mobile like '0%' then h.Mobile else '0'+h.Mobile end,' ','')   
													and h.Mobile <> '' and h.Mobile <> '0'
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Telephone Number' 
and 
REPLACE(case when ml.NewValue like '0%' then ml.NewValue else '0'+ml.NewValue end,' ','') <> REPLACE(case when ml.OldValue like '0%' then ml.OldValue else '0'+ml.OldValue end,' ','') 
and
h.[Prospect Id] is not null

-- Toxic Other Phones

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Other Phone', 'Duplicate - Toxic Data', 'Update'
, ml.OldValue, ml.NewValue, 'No', NULL, h.[Prospect Id], NULL
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c  
left outer join SalesforceReporting..toxicdata h ON REPLACE(case when ml.OldValue like '0%' then ml.OldValue else '0'+ml.OldValue end,' ','') collate latin1_general_CI_AS 
													= REPLACE(case when h.[Other Phone] like '0%' then h.[Other Phone] else '0'+h.[Other Phone] end,' ','')   
													and h.[Other Phone] <> '' and h.[Other Phone] <> '0'
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Telephone Number' 
and 
REPLACE(case when ml.NewValue like '0%' then ml.NewValue else '0'+ml.NewValue end,' ','') <> REPLACE(case when ml.OldValue like '0%' then ml.OldValue else '0'+ml.OldValue end,' ','') 
and
h.[Prospect Id] is not null

-- Toxic Company

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Company', 'Duplicate - Toxic Data', 'Update'
, ml.OldValue, ml.NewValue, 'No', NULL, h.[Prospect ID], NULL
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c 
left outer join SalesforceReporting..toxicdata h ON LeadChangeReview.dbo.CleanName(ml.OldValue) collate latin1_general_CI_AS = LeadChangeReview.dbo.CleanName(h.[Company   Account]) 
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Business Name'
and 
ml.NewValue <> ml.OldValue
and
h.[Prospect ID] is not null

-- Toxic Postcode

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Postcode', 'Duplicate - Toxic Data', 'Update'
, ml.OldValue, ml.NewValue, 'No', NULL, h.[Prospect Id], NULL
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c  
left outer join SalesforceReporting..toxicdata h ON REPLACE(ml.OldValue,' ','') collate latin1_general_CI_AS = REPLACE(h.[Post Code],' ','') 
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Postcode'
and 
ml.NewValue <> ml.OldValue
and
h.[Prospect ID] is not null

-- Account Phones

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Phone', 'Duplicate - Account', 'Update'
, ml.OldValue, ml.NewValue, 'No', NULL, h.AccountId, NULL
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c  
left outer join LeadChangeReview..APhones h ON REPLACE(case when ml.OldValue like '0%' then ml.OldValue else '0'+ml.OldValue end,' ','') collate latin1_general_CI_AS 
												= REPLACE(case when h.Phone like '0%' then h.Phone else '0'+h.Phone end,' ','')   
												and ml.CreatedDate between h.StartDate and h.EndDate
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Telephone Number' 
and 
REPLACE(case when ml.NewValue like '0%' then ml.NewValue else '0'+ml.NewValue end,' ','') <> REPLACE(case when ml.OldValue like '0%' then ml.OldValue else '0'+ml.OldValue end,' ','') 
and
h.AccountId is not null

-- Account Company

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Company', 'Duplicate - Account', 'Update'
, ml.OldValue, ml.NewValue, 'No', NULL, h.AccountId, NULL
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c  
left outer join LeadChangeReview..ACompany h ON LeadChangeReview.dbo.CleanName(ml.OldValue) collate latin1_general_CI_AS = LeadChangeReview.dbo.CleanName(h.Company)
												and ml.CreatedDate between h.StartDate and h.EndDate
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and  
ml.Field = 'Business Name'
and 
ml.NewValue <> ml.OldValue
and
h.AccountId is not null

-- Account Postcode

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Postcode', 'Duplicate - Account', 'Update'
, ml.OldValue, ml.NewValue, 'No', NULL, h.AccountId, NULL
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c  
left outer join LeadChangeReview..APostcode h ON REPLACE(ml.OldValue,' ','') collate latin1_general_CI_AS = REPLACE(h.Postcode,' ','')
												and ml.CreatedDate between h.StartDate and h.EndDate
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Postcode'
and 
ml.NewValue <> ml.OldValue
and
h.AccountId is not null

-- Site Phones

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Phone', 'Duplicate - Site', 'Update'
, ml.OldValue, ml.NewValue, 'No', NULL, h.ParentId, NULL
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c  
left outer join LeadChangeReview..SPhones h ON REPLACE(case when ml.OldValue like '0%' then ml.OldValue else '0'+ml.OldValue end,' ','') collate latin1_general_CI_AS 
												= REPLACE(case when h.Phone like '0%' then h.Phone else '0'+h.Phone end,' ','')   
												and ml.CreatedDate between h.StartDate and h.EndDate
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and  
ml.Field = 'Telephone Number' 
and
REPLACE(case when ml.NewValue like '0%' then ml.NewValue else '0'+ml.NewValue end,' ','') <> REPLACE(case when ml.OldValue like '0%' then ml.OldValue else '0'+ml.OldValue end,' ','') 
and
h.ParentId is not null

-- Site Postcode

INSERT INTO LeadChangeReview..Duplicates_AuditLog
SELECT ml.CreatedDate, ml.[Source], ml.URN, l.Id, 'Postcode', 'Duplicate - Site', 'Update'
, ml.OldValue, ml.NewValue, 'No', NULL, h.ParentId, NULL
FROM LeadChangeReview..ML_SCDChanges_History ml
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c  
left outer join LeadChangeReview..SPostcode h ON REPLACE(ml.OldValue,' ','') collate latin1_general_CI_AS = REPLACE(h.Postcode,' ','')
												and ml.CreatedDate between h.StartDate and h.EndDate
WHERE 
CONVERT(date, ml.CreatedDate) > CONVERT(date, DATEADD(month, -2, GETDATE()))
and 
ml.Field = 'Postcode'
and 
ml.NewValue <> ml.OldValue
and
h.ParentId is not null