/*
UPDATE  SalesforceReporting..GI_Matches
SET
ML_COMPANY = ml.[Business Name],
ML_CO_REG = ml.cro_number,
ML_EASYSECTORDESC = ml.[Easy Sector Desc],
ML_LOCATIONTYPE = ml.location_type,
ML_NATEMP = ml.[Nat Employees],
ML_NATEMPBAND = case when ml.[Nat Employees] = 0 then '0'
when ml.[Nat Employees] between 1 and 2 then '1 TO 2'
when ml.[Nat Employees] between 3 and 5 then '3 TO 5'
when ml.[Nat Employees] between 6 and 10 then '6 TO 10'
when ml.[Nat Employees] between 11 and 25 then '11 TO 25'
when ml.[Nat Employees] between 26 and 50 then '26 TO 50'
when ml.[Nat Employees] between 51 and 100 then '51 TO 100'
when ml.[Nat Employees] between 101 and 225 then '101 TO 225'
when ml.[Nat Employees] > 225 then '226+' else 'UNKNOWN' end,
ML_PHONE = ml.[Telephone Number],
ML_POSTCODE = ml.Postcode,
ML_RECORDTYPE = ml.record_type,
ML_SICCODE = ml.[UK 07 Sic Code],
ML_UPDATEBAND = ml.update_band

FROM 
SalesforceReporting..GI_Matches gi
left outer join MarketLocation..MainDataSet ml ON gi.ML_URN = ml.URN

WHERE ml.URN is not null

UPDATE  SalesforceReporting..GI_Matches
SET
[SFDC_Id] = l.Id,
[SFDC_COMPANY] = l.Company,
[SFDC_POSTCODE] = l.PostalCode,
[SFDC_PHONE] = l.Phone,
[SFDC_MOBILE] = l.MobilePhone,
[SFDC_OTHER_PHONE] = l.Other_Phone__c,
[SFDC_CO_REG] = l.Co_reg__c,
[SF_FTE] = l.FT_Employees__c,
[SF_FTBAND] = 
case when l.FT_Employees__c = 0 then '0'
when l.FT_Employees__c between 1 and 2 then '1 TO 2'
when l.FT_Employees__c between 3 and 5 then '3 TO 5'
when l.FT_Employees__c between 6 and 10 then '6 TO 10'
when l.FT_Employees__c between 11 and 25 then '11 TO 25'
when l.FT_Employees__c between 26 and 50 then '26 TO 50'
when l.FT_Employees__c between 51 and 100 then '51 TO 100'
when l.FT_Employees__c between 101 and 225 then '101 TO 225'
when l.FT_Employees__c > 225 then '226+' else 'UNKNOWN' end,
[SF_OUTCODE] = l.OutCode__c,
[SF_CITATIONSECTOR] = l.CitationSector__c,
[SF_DATEMADE] = l.Date_Made__c,
[SF_RECORDTYPE] = rt.Name,
[SF_STATUS] = l.Status,
[SF_SUSPENDEDCLOSEDREASON] = l.Suspended_Closed_Reason__c,
[SF_ISTPS] = l.IsTPS__c,
[SF_CALLBACKDATETIME] = l.Callback_Date_Time__c,
[SF_TOXICSIC] = l.Toxic_Sic__c,
[SF_SOURCE] = Source__c,
[SF_DATASUPPLIER] = Data_Supplier__c

FROM 
SalesforceReporting..GI_Matches gi
left outer join Salesforce..Lead l ON LEFT(gi.SFDC_Id, 15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS
left outer join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id

WHERE l.Id is not null

SELECT gi.GI_Id, COUNT(ch.seqno)
FROM SalesforceReporting..GI_Matches gi
inner join SalesforceReporting..call_history ch ON LEFT(gi.SFDC_Id, 15) collate latin1_general_CS_AS 
													= LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS
WHERE call_type in (0,2,4)
GROUP BY gi.GI_Id

SELECT gi.GI_Id, case when l.Date_made__c is not null and (Status = 'Approved' or l.IsConverted = 'true') then 1 else 0 end APPBOOKED
FROM SalesforceReporting..GI_Matches gi
left outer join Salesforce..Lead l ON LEFT(gi.SFDC_Id, 15) collate latin1_general_CS_AS  = LEFT(l.Id, 15) collate latin1_general_CS_AS
*/

-- Dupe Leads

UPDATE SalesforceReporting..GI_Matches
SET Dupe_Lead = 1
WHERE REPLACE(case when GI_PHONE like '0%' then GI_PHONE else '0'+GI_PHONE end,' ','') in
(
SELECT REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
FROM Salesforce..Lead l
WHERE (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG','012D0000000KKTvIAO') or RecordTypeId is null) and (LeadSource not like '%cross%sell%' or LeadSource is null)
) and ISNULL(GI_PHONE,'') <> ''

UPDATE SalesforceReporting..GI_Matches
SET Dupe_Lead = 1
WHERE REPLACE(case when GI_PHONE like '0%' then GI_PHONE else '0'+GI_PHONE end,' ','') in
(
SELECT REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
FROM Salesforce..Lead l
WHERE (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG','012D0000000KKTvIAO') or RecordTypeId is null) and (LeadSource not like '%cross%sell%' or LeadSource is null)
) and ISNULL(GI_PHONE,'') <> ''

UPDATE SalesforceReporting..GI_Matches
SET Dupe_Lead = 1
WHERE REPLACE(case when GI_PHONE like '0%' then GI_PHONE else '0'+GI_PHONE end,' ','') in
(
SELECT REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
FROM Salesforce..Lead l
WHERE (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG','012D0000000KKTvIAO') or RecordTypeId is null) and (LeadSource not like '%cross%sell%' or LeadSource is null)
) and ISNULL(GI_PHONE,'') <> ''

UPDATE SalesforceReporting..GI_Matches
SET Dupe_Lead = 1
FROM SalesforceReporting..GI_Matches ml
inner join Salesforce..Lead l ON REPLACE(REPLACE(ml.GI_COMPANY,'Ltd',''),'Limited','') = REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','')
								and REPLACE(ml.GI_POSTCODE,' ','') = REPLACE(l.PostalCode,' ','') 
								and (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG','012D0000000KKTvIAO') or RecordTypeId is null) and (LeadSource not like '%cross%sell%' or LeadSource is null)
WHERE ISNULL(ml.GI_COMPANY,'') <> '' and ISNULL(ml.GI_POSTCODE,'') <> ''
							
UPDATE SalesforceReporting..GI_Matches
SET Dupe_Lead = 1
FROM SalesforceReporting..GI_Matches ml
inner join Salesforce..Lead l ON ml.ML_URN = l.Market_Location_URN__c
								and (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KJv8IAG','012D0000000KKTvIAO') or RecordTypeId is null) and (LeadSource not like '%cross%sell%' or LeadSource is null)
WHERE ISNULL(ml.ML_URN,'') <> ''

-- Dupe Toxic Data
							
UPDATE SalesforceReporting..GI_Matches
SET Dupe_Toxic = 1
WHERE REPLACE(case when GI_PHONE like '0%' then GI_PHONE else '0'+GI_PHONE end,' ','') in
(
SELECT REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
FROM SalesforceReporting..toxicdata l
) and ISNULL(GI_PHONE,'') <> ''

UPDATE SalesforceReporting..GI_Matches
SET Dupe_Toxic = 1
WHERE REPLACE(case when GI_PHONE like '0%' then GI_PHONE else '0'+GI_PHONE end,' ','') in
(
SELECT REPLACE(case when l.Mobile like '0%' then l.Mobile else '0'+l.Mobile end,' ','')
FROM SalesforceReporting..toxicdata l
) and ISNULL(GI_PHONE,'') <> ''

UPDATE SalesforceReporting..GI_Matches
SET Dupe_Toxic = 1
WHERE REPLACE(case when GI_PHONE like '0%' then GI_PHONE else '0'+GI_PHONE end,' ','') in
(
SELECT REPLACE(case when l.[Other Phone] like '0%' then l.[Other Phone] else '0'+l.[Other Phone] end,' ','')
FROM SalesforceReporting..toxicdata l
) and ISNULL(GI_PHONE,'') <> ''

UPDATE SalesforceReporting..GI_Matches
SET Dupe_Toxic = 1
FROM SalesforceReporting..GI_Matches ml
inner join SalesforceReporting..toxicdata l ON REPLACE(REPLACE(ml.GI_COMPANY,'Ltd',''),'Limited','') = REPLACE(REPLACE(l.[Company   Account],'Ltd',''),'Limited','')
								and REPLACE(ml.GI_POSTCODE,' ','') = REPLACE(l.[Post Code],' ','')
WHERE ISNULL(ml.GI_COMPANY,'') <> '' and ISNULL(ml.GI_POSTCODE,'') <> ''
								
-- Dupe Accounts

UPDATE SalesforceReporting..GI_Matches
SET Dupe_Account = 1
WHERE REPLACE(case when GI_PHONE like '0%' then GI_PHONE else '0'+GI_PHONE end,' ','') in
(
SELECT REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
FROM Salesforce..Account l
) and ISNULL(GI_PHONE,'') <> ''

UPDATE SalesforceReporting..GI_Matches
SET Dupe_Account = 1
FROM SalesforceReporting..GI_Matches ml
inner join Salesforce..Account l ON REPLACE(REPLACE(ml.GI_COMPANY,'Ltd',''),'Limited','') = REPLACE(REPLACE(l.Name,'Ltd',''),'Limited','')
								and REPLACE(ml.GI_POSTCODE,' ','') = REPLACE(l.BillingPostalCode,' ','')
WHERE ISNULL(ml.GI_COMPANY,'') <> '' and ISNULL(ml.GI_POSTCODE,'') <> ''
								
-- Dupe Account Sites

UPDATE SalesforceReporting..GI_Matches
SET Dupe_Site = 1
WHERE REPLACE(case when GI_PHONE like '0%' then GI_PHONE else '0'+GI_PHONE end,' ','') in
(
SELECT REPLACE(case when l.Phone__c like '0%' then l.Phone__c else '0'+l.Phone__c end,' ','')
FROM Salesforce..Site__c l
) and ISNULL(GI_PHONE,'') <> ''

UPDATE SalesforceReporting..GI_Matches
SET Dupe_Site = 1
FROM SalesforceReporting..GI_Matches ml
inner join Salesforce..Site__c l ON REPLACE(ml.GI_POSTCODE,' ','') = REPLACE(l.Postcode__c,' ','')
inner join Salesforce..Account a ON l.Account__c = a.Id
								and REPLACE(REPLACE(ml.GI_COMPANY,'Ltd',''),'Limited','') = REPLACE(REPLACE(a.Name,'Ltd',''),'Limited','')
WHERE ISNULL(ml.GI_COMPANY,'') <> '' and ISNULL(ml.GI_POSTCODE,'') <> ''

-- General Exclusions

UPDATE SalesforceReporting..GI_Matches
SET BadCompany_Near = 1
WHERE 
GI_COMPANY like '%NHS%' or
GI_COMPANY like '%CHARITY%' or
GI_COMPANY like '%HOSPICE%' or
GI_COMPANY like '%Bupa%' or
GI_COMPANY like '%gov.uk%' or
GI_COMPANY like '%mencap%' or
GI_COMPANY like '%Barnardo%' or
GI_COMPANY like '%fire brigade%' or
GI_COMPANY like '%Four seasons%' or
GI_COMPANY like '%Barchester%' or
GI_COMPANY like '%Sunrise%' or
GI_COMPANY like '%council%' or
GI_COMPANY like '%costa coffee%' or
GI_COMPANY like '%costa at%' or
GI_COMPANY like '%escort%' or
GI_COMPANY like '%police%' or
GI_COMPANY like '%ambulance%' or
GI_COMPANY like '%Citizen%s Advice%' or
GI_COMPANY like '%Housing Association%' or
GI_COMPANY like '%sodexo%'

UPDATE SalesforceReporting..GI_Matches
SET BadDomain = 1
FROM SalesforceReporting..GI_Matches gi
left outer join MarketLocation..MainDataSet ml ON gi.ML_URN = ml.URN
left outer join Salesforce..Lead l ON gi.SFDC_Id = l.Id
WHERE 
Email like '%gov.uk%' or Email like '%royalmail.co%' or Email like '%hpcha.org%' or Email like '%o2.co%' or Email like '%.coop' 
or Email like '%bupa.co%' or Email like '%costa.co%' or Email like '%costacoffe.co%' or Email like '%escort%' or Email like '%johnlewis.co%'
or Email like '%monarch.co%' or Email like '%accordgroup.org%' or Email like '%thelegendalliance.co%' or Email like '%betway.com%'
or Email like '%fujitsu.com%' or Email like '%hc-one.co%' or Email like '%sodexo%'
or
Website like '%gov.uk%' or Website like '%royalmail.co%' or Website like '%hpcha.org%' or Website like '%o2.co%' or Website like '%.coop' 
or Website like '%bupa.co%' or Website like '%costa.co%' or Website like '%costacoffe.co%' or Website like '%escort%' or Website like '%johnlewis.co%'
or Website like '%monarch.co%' or Website like '%accordgroup.org%' or Website like '%thelegendalliance.co%' or Website like '%betway.com%'
or Website like '%fujitsu.com%' or Website like '%hc-one.co%' or Website like '%sodexo%'

-- Contact Centre Exclusions

UPDATE SalesforceReporting..GI_Matches
SET BadDomain_NHS = 1
FROM SalesforceReporting..GI_Matches gi
left outer join MarketLocation..MainDataSet ml ON gi.ML_URN = ml.URN
left outer join Salesforce..Lead l ON gi.SFDC_Id = l.Id
WHERE Email like '%nhs.uk%' or Website like '%nhs.uk%'
	
UPDATE SalesforceReporting..GI_Matches
SET ToxicSIC = 1
WHERE ML_SICCODE in
	(
	SELECT SIC3_Code
	FROM SalesforceReporting..SIC2007Codes
	WHERE ToxicSIC = 1
	)

UPDATE SalesforceReporting..GI_Matches
SET BadSector_Events = 1
FROM SalesforceReporting..GI_Matches
WHERE	ML_EASYSECTORDESC like '%Mining%' or
		ML_EASYSECTORDESC like '%Gas%' or
		ML_EASYSECTORDESC like '%Offshore%' or
		ML_EASYSECTORDESC like '%Solicitors%' or
		ML_EASYSECTORDESC like '%Legal services%' or
		ML_EASYSECTORDESC like '%Employment law%' or
		ML_EASYSECTORDESC like '%HR services%' or
		ML_EASYSECTORDESC like '%HR consultant%' or
		ML_EASYSECTORDESC like '%H R consultant%' or
		ML_EASYSECTORDESC like '%HR consultancy%' or
		ML_EASYSECTORDESC like '%H R consultancy%' or
		ML_EASYSECTORDESC like '%Health & safety%' or
		ML_EASYSECTORDESC like '%Members of parliament%'
		
UPDATE SalesforceReporting..GI_Matches
SET BadCompany_Events = 1
WHERE GI_COMPANY in
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