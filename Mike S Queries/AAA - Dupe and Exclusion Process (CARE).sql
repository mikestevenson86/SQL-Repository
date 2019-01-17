/*
ALTER TABLE CQC..CARE_SINGLE_VIEW ADD Dupe_Lead bit
ALTER TABLE CQC..CARE_SINGLE_VIEW ADD Dupe_Account bit
ALTER TABLE CQC..CARE_SINGLE_VIEW ADD Dupe_Site bit
ALTER TABLE CQC..CARE_SINGLE_VIEW ADD BadCompany_Near bit
ALTER TABLE CQC..CARE_SINGLE_VIEW ADD BadDomain bit
ALTER TABLE CQC..CARE_SINGLE_VIEW ADD BadDomain_NHS bit
*/

-- Dupe Leads

UPDATE CQC..CARE_SINGLE_VIEW
SET Dupe_Lead = 1
WHERE REPLACE(case when Telephone like '0%' then Telephone else '0'+Telephone end,' ','') collate latin1_general_CI_AS in
(
SELECT REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') collate latin1_general_CI_AS 
FROM SalesforceReporting..Lead l
WHERE (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG','012D0000000KKTvIAO') or RecordTypeId is null) and (LeadSource not like '%cross%sell%' or LeadSource is null)
)

UPDATE CQC..CARE_SINGLE_VIEW
SET Dupe_Lead = 1
WHERE REPLACE(case when Telephone like '0%' then Telephone else '0'+Telephone end,' ','') collate latin1_general_CI_AS  in
(
SELECT REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','') collate latin1_general_CI_AS 
FROM SalesforceReporting..Lead l
WHERE (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG','012D0000000KKTvIAO') or RecordTypeId is null) and (LeadSource not like '%cross%sell%' or LeadSource is null)
)

UPDATE CQC..CARE_SINGLE_VIEW
SET Dupe_Lead = 1
WHERE REPLACE(case when Telephone like '0%' then Telephone else '0'+Telephone end,' ','') collate latin1_general_CI_AS  in
(
SELECT REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','') collate latin1_general_CI_AS 
FROM SalesforceReporting..Lead l
WHERE (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG','012D0000000KKTvIAO') or RecordTypeId is null) and (LeadSource not like '%cross%sell%' or LeadSource is null)
)

UPDATE CQC..CARE_SINGLE_VIEW
SET Dupe_Lead = 1
FROM CQC..CARE_SINGLE_VIEW ml
inner join SalesforceReporting..Lead l ON REPLACE(REPLACE(ml.Name,'Ltd',''),'Limited','') collate latin1_general_CI_AS  = REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') collate latin1_general_CI_AS 
								and REPLACE(ml.PostCode,' ','') collate latin1_general_CI_AS  = REPLACE(l.PostalCode,' ','')  collate latin1_general_CI_AS 
								and (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG','012D0000000KKTvIAO') or RecordTypeId is null) and (LeadSource not like '%cross%sell%' or LeadSource is null)
								
-- Dupe Accounts

UPDATE CQC..CARE_SINGLE_VIEW
SET Dupe_Account = 1
WHERE REPLACE(case when Telephone like '0%' then Telephone else '0'+Telephone end,' ','')  collate latin1_general_CI_AS in
(
SELECT REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') collate latin1_general_CI_AS 
FROM SalesforceReporting..Account l
)

UPDATE CQC..CARE_SINGLE_VIEW
SET Dupe_Account = 1
FROM CQC..CARE_SINGLE_VIEW ml
inner join SalesforceReporting..Account l ON REPLACE(REPLACE(ml.Name,'Ltd',''),'Limited','') collate latin1_general_CI_AS  = REPLACE(REPLACE(l.Name,'Ltd',''),'Limited','') collate latin1_general_CI_AS 
								and REPLACE(ml.PostCode,' ','') collate latin1_general_CI_AS  = REPLACE(l.BillingPostalCode,' ','') collate latin1_general_CI_AS 
								
-- Dupe Account Sites

UPDATE CQC..CARE_SINGLE_VIEW
SET Dupe_Site = 1
WHERE REPLACE(case when Telephone like '0%' then Telephone else '0'+Telephone end,' ','') collate latin1_general_CI_AS  in
(
SELECT REPLACE(case when l.Phone__c like '0%' then l.Phone__c else '0'+l.Phone__c end,' ','') collate latin1_general_CI_AS 
FROM SalesforceReporting..Site__c l
)

UPDATE CQC..CARE_SINGLE_VIEW
SET Dupe_Site = 1
FROM CQC..CARE_SINGLE_VIEW ml
inner join SalesforceReporting..Site__c l ON REPLACE(ml.PostCode,' ','') collate latin1_general_CI_AS  = REPLACE(l.Postcode__c,' ','') collate latin1_general_CI_AS 
inner join SalesforceReporting..Account a ON l.Account__c collate latin1_general_CI_AS  = a.Id collate latin1_general_CI_AS 
								and REPLACE(REPLACE(ml.Name,'Ltd',''),'Limited','')  collate latin1_general_CI_AS = REPLACE(REPLACE(a.Name,'Ltd',''),'Limited','') collate latin1_general_CI_AS 

-- Care Specific Exclusions

UPDATE CQC..CARE_SINGLE_VIEW
SET BadCompany_Near = 1
FROM CQC..CARE_SINGLE_VIEW cqc
inner join SalesforceReporting..BadCompanies_WildCards wc ON cqc.Name  collate latin1_general_CI_AS like wc.WildCard  collate latin1_general_CI_AS
WHERE ISNULL(BadCompany_Near,0)=0  

UPDATE CQC..CARE_SINGLE_VIEW
SET BadDomain = 1
FROM CQC..CARE_SINGLE_VIEW cqc
left outer join SalesforceReporting..BadDomains_WildCards wc1 ON cqc.SF_Email collate latin1_general_CI_AS like wc1.WildCard collate latin1_general_CI_AS
left outer join SalesforceReporting..BadDomains_WildCards wc3 ON cqc.WebAddress collate latin1_general_CI_AS like wc3.WildCard collate latin1_general_CI_AS
WHERE ISNULL(BadDomain,0)=0 and (wc1.WildCard is not null or wc3.WildCard is not null)

UPDATE CQC..CARE_SINGLE_VIEW
SET BadDomain_NHS = 1
WHERE 
WebAddress like '%nhs.uk%' or SF_Email like '%nhs.uk%'