-- Dupe Leads

UPDATE SalesforceReporting..ML_NI_20170217
SET Dupe_Lead = 1
WHERE REPLACE(case when Phone like '0%' then Phone else '0'+Phone end,' ','') in
(
SELECT REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
FROM Salesforce..Lead l
WHERE (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG','012D0000000KKTvIAO') or RecordTypeId is null) and (LeadSource not like '%cross%sell%' or LeadSource is null)
) and ISNULL(Phone,'') <> ''

UPDATE SalesforceReporting..ML_NI_20170217
SET Dupe_Lead = 1
WHERE REPLACE(case when Phone like '0%' then Phone else '0'+Phone end,' ','') in
(
SELECT REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
FROM Salesforce..Lead l
WHERE (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG','012D0000000KKTvIAO') or RecordTypeId is null) and (LeadSource not like '%cross%sell%' or LeadSource is null)
) and ISNULL(Phone,'') <> ''

UPDATE SalesforceReporting..ML_NI_20170217
SET Dupe_Lead = 1
WHERE REPLACE(case when Phone like '0%' then Phone else '0'+Phone end,' ','') in
(
SELECT REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
FROM Salesforce..Lead l
WHERE (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG','012D0000000KKTvIAO') or RecordTypeId is null) and (LeadSource not like '%cross%sell%' or LeadSource is null)
) and ISNULL(Phone,'') <> ''

UPDATE SalesforceReporting..ML_NI_20170217
SET Dupe_Lead = 1
FROM SalesforceReporting..ML_NI_20170217 ml
inner join Salesforce..Lead l ON REPLACE(REPLACE(ml.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','')
								and REPLACE(ml.PostalCode,' ','') = REPLACE(l.PostalCode,' ','') 
								and (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG','012D0000000KKTvIAO') or RecordTypeId is null) and (LeadSource not like '%cross%sell%' or LeadSource is null)
WHERE ISNULL(ml.Company,'') <> '' and ISNULL(ml.PostalCode,'') <> ''
							
UPDATE SalesforceReporting..ML_NI_20170217
SET Dupe_Lead = 1
FROM SalesforceReporting..ML_NI_20170217 ml
inner join Salesforce..Lead l ON ml.Market_Location_URN__c = l.Market_Location_URN__c
								and (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG','012D0000000KKTvIAO') or RecordTypeId is null) and (LeadSource not like '%cross%sell%' or LeadSource is null)
WHERE ISNULL(ml.Market_Location_URN__c,'') <> ''

-- Dupe Toxic Data
							
UPDATE SalesforceReporting..ML_NI_20170217
SET Dupe_Toxic = 1
WHERE REPLACE(case when Phone like '0%' then Phone else '0'+Phone end,' ','') in
(
SELECT REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
FROM SalesforceReporting..toxicdata l
) and ISNULL(Phone,'') <> ''

UPDATE SalesforceReporting..ML_NI_20170217
SET Dupe_Toxic = 1
WHERE REPLACE(case when Phone like '0%' then Phone else '0'+Phone end,' ','') in
(
SELECT REPLACE(case when l.Mobile like '0%' then l.Mobile else '0'+l.Mobile end,' ','')
FROM SalesforceReporting..toxicdata l
) and ISNULL(Phone,'') <> ''

UPDATE SalesforceReporting..ML_NI_20170217
SET Dupe_Toxic = 1
WHERE REPLACE(case when Phone like '0%' then Phone else '0'+Phone end,' ','') in
(
SELECT REPLACE(case when l.[Other Phone] like '0%' then l.[Other Phone] else '0'+l.[Other Phone] end,' ','')
FROM SalesforceReporting..toxicdata l
) and ISNULL(Phone,'') <> ''

UPDATE SalesforceReporting..ML_NI_20170217
SET Dupe_Toxic = 1
FROM SalesforceReporting..ML_NI_20170217 ml
inner join SalesforceReporting..toxicdata l ON REPLACE(REPLACE(ml.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(l.[Company   Account],'Ltd',''),'Limited','')
								and REPLACE(ml.PostalCode,' ','') = REPLACE(l.[Post Code],' ','')
WHERE ISNULL(ml.Company,'') <> '' and ISNULL(ml.PostalCode,'') <> ''
								
-- Dupe Accounts

UPDATE SalesforceReporting..ML_NI_20170217
SET Dupe_Account = 1
WHERE REPLACE(case when Phone like '0%' then Phone else '0'+Phone end,' ','') in
(
SELECT REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
FROM Salesforce..Account l
) and ISNULL(Phone,'') <> ''

UPDATE SalesforceReporting..ML_NI_20170217
SET Dupe_Account = 1
FROM SalesforceReporting..ML_NI_20170217 ml
inner join Salesforce..Account l ON REPLACE(REPLACE(ml.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(l.Name,'Ltd',''),'Limited','')
								and REPLACE(ml.PostalCode,' ','') = REPLACE(l.BillingPostalCode,' ','')
WHERE ISNULL(ml.Company,'') <> '' and ISNULL(ml.PostalCode,'') <> ''
								
-- Dupe Account Sites

UPDATE SalesforceReporting..ML_NI_20170217
SET Dupe_Site = 1
WHERE REPLACE(case when Phone like '0%' then Phone else '0'+Phone end,' ','') in
(
SELECT REPLACE(case when l.Phone__c like '0%' then l.Phone__c else '0'+l.Phone__c end,' ','')
FROM Salesforce..Site__c l
) and ISNULL(Phone,'') <> ''

UPDATE SalesforceReporting..ML_NI_20170217
SET Dupe_Site = 1
FROM SalesforceReporting..ML_NI_20170217 ml
inner join Salesforce..Site__c l ON REPLACE(ml.PostalCode,' ','') = REPLACE(l.Postcode__c,' ','')
inner join Salesforce..Account a ON l.Account__c = a.Id
								and REPLACE(REPLACE(ml.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(a.Name,'Ltd',''),'Limited','')
WHERE ISNULL(ml.Company,'') <> '' and ISNULL(ml.PostalCode,'') <> ''

-- General Exclusions

UPDATE SalesforceReporting..ML_NI_20170217
SET BadCompany_Near = 1
FROM SalesforceReporting..ML_NI_20170217 lsv
inner join SalesforceReporting..BadCompanies_WildCards wc ON lsv.Company  collate latin1_general_CI_AS like wc.WildCard  collate latin1_general_CI_AS
WHERE ISNULL(BadCompany_Near,0)=0  

UPDATE SalesforceReporting..ML_NI_20170217
SET BadDomain = 1
FROM SalesforceReporting..ML_NI_20170217 lsv
left outer join SalesforceReporting..BadDomains_WildCards wc1 ON lsv.Email collate latin1_general_CI_AS like wc1.WildCard collate latin1_general_CI_AS
left outer join SalesforceReporting..BadDomains_WildCards wc3 ON lsv.Website collate latin1_general_CI_AS like wc3.WildCard collate latin1_general_CI_AS
WHERE ISNULL(BadDomain,0)=0 and (wc1.WildCard is not null or wc3.WildCard is not null)

-- Contact Centre Exclusions

UPDATE SalesforceReporting..ML_NI_20170217
SET BadDomain_NHS = 1
WHERE Email like '%nhs.uk%' or Website like '%nhs.uk%'

UPDATE SalesforceReporting..ML_NI_20170217
SET BadCompany_Exact = 1
WHERE REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Company,'Ltd',''),'Limited',''),'&',''),'and',''),'plc','') in 
	(
	SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Company,'Ltd',''),'Limited',''),'&',''),'and',''),'plc','')
	FROM SalesforceReporting..BadCompanies
	)
	
UPDATE SalesforceReporting..ML_NI_20170217
SET ToxicSIC = 1
WHERE SIC2007_Code3__c in
	(
	SELECT SIC3_Code
	FROM SalesforceReporting..SIC2007Codes
	WHERE ToxicSIC = 1
	)
	
-- Events Exclusions

UPDATE SalesforceReporting..ML_NI_20170217
SET ToxicSIC_Events = 1
WHERE SIC2007_Code3__c in
	(
	'1629',
	'20130',
	'20140',
	'20150',
	'20160',
	'20200',
	'35110',
	'35120',
	'35130',
	'35140',
	'35210',
	'35220',
	'35230',
	'35300',
	'36000',
	'37000',
	'38110',
	'38120',
	'38220',
	'38310',
	'38320',
	'39000',
	'42120',
	'43110',
	'47300',
	'49100',
	'49200',
	'49311',
	'49319',
	'49320',
	'50100',
	'50200',
	'50300',
	'50400',
	'51220',
	'52211',
	'55202',
	'55209',
	'55300'
	)
	
UPDATE SalesforceReporting..ML_NI_20170217
SET BadPosition_Events = 1
WHERE Position__c not in
	(
	SELECT Position
	FROM SalesforceReporting..PositionsEvents
	)
	
UPDATE SalesforceReporting..ML_NI_20170217
SET BadSector_Events = 1
FROM SalesforceReporting..ML_NI_20170217 ml
inner join MarketLocation..MainDataSet md ON ml.Market_Location_URN__c = md.URN
WHERE	[Easy Sector Desc] like '%Mining%' or
		[Easy Sector Desc] like '%Gas%' or
		[Easy Sector Desc] like '%Offshore%' or
		[Easy Sector Desc] like '%Solicitors%' or
		[Easy Sector Desc] like '%Legal services%' or
		[Easy Sector Desc] like '%Employment law%' or
		[Easy Sector Desc] like '%HR services%' or
		[Easy Sector Desc] like '%HR consultant%' or
		[Easy Sector Desc] like '%H R consultant%' or
		[Easy Sector Desc] like '%HR consultancy%' or
		[Easy Sector Desc] like '%H R consultancy%' or
		[Easy Sector Desc] like '%Health & safety%' or
		[Easy Sector Desc] like '%Members of parliament%'
		
UPDATE SalesforceReporting..ML_NI_20170217
SET BadCompany_Events = 1
WHERE Company in
	(
	'Peninsula Business Services',
	'Peninsula Group',
	'Employsure',
	'Taxwise',
	'Taxwise Reward',
	'Taxwise Rewards',
	'Graphite HRM',
	'Graphite UK',
	'Graphite Ireland',
	'Graphite NI',
	'Graphite Northern Ireland',
	'Bright HR',
	'Bright H R',
	'BrightHR',
	'Health Assured LTD',
	'Health Assured',
	'Croner',
	'Croner Solutions',
	'Croner Tax',
	'Croner Group Ltd',
	'Croner Simply Personnel',
	'Simply Personnel',
	'Croner-I',
	'Portfolio payroll',
	'Moorepay',
	'Northgate',
	'Avensure',
	'Ellis Whittham',
	'Bibi',
	'Peter Swift'
	)