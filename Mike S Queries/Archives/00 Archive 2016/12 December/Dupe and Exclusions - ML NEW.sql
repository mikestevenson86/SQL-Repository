-- Dupe Leads

UPDATE MarketLocation..MainDataSet_NEW_Analysis
SET Dupe_Lead = 1
WHERE REPLACE(case when [Telephone Number] like '0%' then [Telephone Number] else '0'+[Telephone Number] end,' ','') in
(
SELECT REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
FROM Salesforce..Lead l
WHERE (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG') or RecordTypeId is null) and LeadSource not like '%cross%sell%'
)
and [Telephone Number] <> '0' and [Telephone Number] <> ''

UPDATE MarketLocation..MainDataSet_NEW_Analysis
SET Dupe_Lead = 1
WHERE REPLACE(case when [Telephone Number] like '0%' then [Telephone Number] else '0'+[Telephone Number] end,' ','') in
(
SELECT REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
FROM Salesforce..Lead l
WHERE (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG') or RecordTypeId is null) and LeadSource not like '%cross%sell%'
)
and [Telephone Number] <> '0' and [Telephone Number] <> ''

UPDATE MarketLocation..MainDataSet_NEW_Analysis
SET Dupe_Lead = 1
WHERE REPLACE(case when [Telephone Number] like '0%' then [Telephone Number] else '0'+[Telephone Number] end,' ','') in
(
SELECT REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
FROM Salesforce..Lead l
WHERE (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG') or RecordTypeId is null) and LeadSource not like '%cross%sell%'
)
and [Telephone Number] <> '0' and [Telephone Number] <> ''

UPDATE MarketLocation..MainDataSet_NEW_Analysis
SET Dupe_Lead = 1
FROM MarketLocation..MainDataSet_NEW_Analysis ml
inner join Salesforce..Lead l ON REPLACE(REPLACE(ml.[Business Name],'Ltd',''),'Limited','') = REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','')
								and REPLACE(ml.Postcode,' ','') = REPLACE(l.PostalCode,' ','') 
								and (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG') or RecordTypeId is null) and LeadSource not like '%cross%sell%'
								
UPDATE MarketLocation..MainDataSet_NEW_Analysis
SET Dupe_Lead = 1
FROM MarketLocation..MainDataSet_NEW_Analysis ml
inner join Salesforce..Lead l ON ml.URN = l.Market_Location_URN__c
								and (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG') or RecordTypeId is null) and LeadSource not like '%cross%sell%'

-- Dupe Toxic Data
							
UPDATE MarketLocation..MainDataSet_NEW_Analysis
SET Dupe_Toxic = 1
WHERE REPLACE(case when [Telephone Number] like '0%' then [Telephone Number] else '0'+[Telephone Number] end,' ','') in
(
SELECT REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
FROM SalesforceReporting..toxicdata l
)
and [Telephone Number] <> '0' and [Telephone Number] <> ''

UPDATE MarketLocation..MainDataSet_NEW_Analysis
SET Dupe_Toxic = 1
WHERE REPLACE(case when [Telephone Number] like '0%' then [Telephone Number] else '0'+[Telephone Number] end,' ','') in
(
SELECT REPLACE(case when l.Mobile like '0%' then l.Mobile else '0'+l.Mobile end,' ','')
FROM SalesforceReporting..toxicdata l
)
and [Telephone Number] <> '0' and [Telephone Number] <> ''

UPDATE MarketLocation..MainDataSet_NEW_Analysis
SET Dupe_Toxic = 1
WHERE REPLACE(case when [Telephone Number] like '0%' then [Telephone Number] else '0'+[Telephone Number] end,' ','') in
(
SELECT REPLACE(case when l.[Other Phone] like '0%' then l.[Other Phone] else '0'+l.[Other Phone] end,' ','')
FROM SalesforceReporting..toxicdata l
)
and [Telephone Number] <> '0' and [Telephone Number] <> ''

UPDATE MarketLocation..MainDataSet_NEW_Analysis
SET Dupe_Toxic = 1
FROM MarketLocation..MainDataSet_NEW_Analysis ml
inner join SalesforceReporting..toxicdata l ON REPLACE(REPLACE(ml.[Business Name],'Ltd',''),'Limited','') = REPLACE(REPLACE(l.[Company   Account],'Ltd',''),'Limited','')
								and REPLACE(ml.Postcode,' ','') = REPLACE(l.[Post Code],' ','')
								
-- Dupe Accounts

UPDATE MarketLocation..MainDataSet_NEW_Analysis
SET Dupe_Account = 1
WHERE REPLACE(case when [Telephone Number] like '0%' then [Telephone Number] else '0'+[Telephone Number] end,' ','') in
(
SELECT REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
FROM Salesforce..Account l
)
and [Telephone Number] <> '0' and [Telephone Number] <> ''

UPDATE MarketLocation..MainDataSet_NEW_Analysis
SET Dupe_Account = 1
FROM MarketLocation..MainDataSet_NEW_Analysis ml
inner join Salesforce..Account l ON REPLACE(REPLACE(ml.[Business Name],'Ltd',''),'Limited','') = REPLACE(REPLACE(l.Name,'Ltd',''),'Limited','')
								and REPLACE(ml.Postcode,' ','') = REPLACE(l.BillingPostalCode,' ','')
								
-- Dupe Account Sites

UPDATE MarketLocation..MainDataSet_NEW_Analysis
SET Dupe_Site = 1
WHERE REPLACE(case when [Telephone Number] like '0%' then [Telephone Number] else '0'+[Telephone Number] end,' ','') in
(
SELECT REPLACE(case when l.Phone__c like '0%' then l.Phone__c else '0'+l.Phone__c end,' ','')
FROM Salesforce..Site__c l
)
and [Telephone Number] <> '0' and [Telephone Number] <> ''

UPDATE MarketLocation..MainDataSet_NEW_Analysis
SET Dupe_Site = 1
FROM MarketLocation..MainDataSet_NEW_Analysis ml
inner join Salesforce..Site__c l ON REPLACE(ml.Postcode,' ','') = REPLACE(l.Postcode__c,' ','')
inner join Salesforce..Account a ON l.Account__c = a.Id
								and REPLACE(REPLACE(ml.[Business Name],'Ltd',''),'Limited','') = REPLACE(REPLACE(a.Name,'Ltd',''),'Limited','')

-- General Exclusions

UPDATE MarketLocation..MainDataSet_NEW_Analysis
SET BadCompany_Near = 1
WHERE 
[Business Name] like '%NHS%' or
[Business Name] like '%CHARITY%' or
[Business Name] like '%HOSPICE%' or
[Business Name] like '%Bupa%' or
[Business Name] like '%gov.uk%' or
[Business Name] like '%mencap%' or
[Business Name] like '%Barnardo%' or
[Business Name] like '%fire brigade%' or
[Business Name] like '%Four seasons%' or
[Business Name] like '%Barchester%' or
[Business Name] like '%Sunrise%' or
[Business Name] like '%council%' or
[Business Name] like '%costa coffee%' or
[Business Name] like '%costa at%' or
[Business Name] like '%escort%' or
[Business Name] like '%police%' or
[Business Name] like '%ambulance%' or
[Business Name] like '%Citizen%s Advice%' or
[Business Name] like '%Housing Association%'

UPDATE MarketLocation..MainDataSet_NEW_Analysis
SET BadDomain = 1
WHERE 
[Contact email address] like '%gov.uk%' or [Contact email address] like '%royalmail.co%' or [Contact email address] like '%hpcha.org%' or [Contact email address] like '%o2.co%' or [Contact email address] like '%.coop' 
or [Contact email address] like '%bupa.co%' or [Contact email address] like '%costa.co%' or [Contact email address] like '%costacoffe.co%' or [Contact email address] like '%escort%' or [Contact email address] like '%johnlewis.co%'
or [Contact email address] like '%monarch.co%' or [Contact email address] like '%accordgroup.org%' or [Contact email address] like '%thelegendalliance.co%' or [Contact email address] like '%betway.com%'
or [Contact email address] like '%fujitsu.com%' or [Contact email address] like '%hc-one.co%'
or
[company email address] like '%gov.uk%' or [company email address] like '%royalmail.co%' or [company email address] like '%hpcha.org%' or [company email address] like '%o2.co%' or [company email address] like '%.coop' 
or [company email address] like '%bupa.co%' or [company email address] like '%costa.co%' or [company email address] like '%costacoffe.co%' or [company email address] like '%escort%' or [company email address] like '%johnlewis.co%'
or [company email address] like '%monarch.co%' or [company email address] like '%accordgroup.org%' or [company email address] like '%thelegendalliance.co%' or [company email address] like '%betway.com%'
or [company email address] like '%fujitsu.com%' or [company email address] like '%hc-one.co%'
or
[web address] like '%gov.uk%' or [web address] like '%royalmail.co%' or [web address] like '%hpcha.org%' or [web address] like '%o2.co%' or [web address] like '%.coop' 
or [web address] like '%bupa.co%' or [web address] like '%costa.co%' or [web address] like '%costacoffe.co%' or [web address] like '%escort%' or [web address] like '%johnlewis.co%'
or [web address] like '%monarch.co%' or [web address] like '%accordgroup.org%' or [web address] like '%thelegendalliance.co%' or [web address] like '%betway.com%'
or [web address] like '%fujitsu.com%' or [web address] like '%hc-one.co%'

-- Contact Centre Exclusions

UPDATE MarketLocation..MainDataSet_NEW_Analysis
SET BadDomain_NHS = 1
WHERE [Contact email address] like '%nhs.uk%' or [company email address] like '%nhs.uk%' or [web address] like '%nhs.uk%'

UPDATE MarketLocation..MainDataSet_NEW_Analysis
SET BadCompany_Exact = 1
WHERE REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([Business Name],'Ltd',''),'Limited',''),'&',''),'and',''),'plc','') in 
	(
	SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Company,'Ltd',''),'Limited',''),'&',''),'and',''),'plc','')
	FROM SalesforceReporting..BadCompanies
	)
	
UPDATE MarketLocation..MainDataSet_NEW_Analysis
SET ToxicSIC = 1
WHERE [UK 07 Sic Code] in
	(
	SELECT SIC3_Code
	FROM SalesforceReporting..SIC2007Codes
	WHERE ToxicSIC = 1
	)
	
-- Events Exclusions

UPDATE MarketLocation..MainDataSet_NEW_Analysis
SET ToxicSIC_Events = 1
WHERE [UK 07 Sic Code] in
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
	
UPDATE MarketLocation..MainDataSet_NEW_Analysis
SET BadPosition_Events = 1
WHERE [Contact position] not in
	(
	SELECT Position
	FROM SalesforceReporting..PositionsEvents
	)
	
UPDATE MarketLocation..MainDataSet_NEW_Analysis
SET BadSector_Events = 1
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
		
UPDATE MarketLocation..MainDataSet_NEW_Analysis
SET BadCompany_Events = 1
WHERE [Business Name] in
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