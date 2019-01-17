IF OBJECT_ID('NewVoiceMedia..LeadSuppression_Sept2017') IS NOT NULL
	BEGIN
		DROP TABLE NewVoiceMedia..LeadSuppression_Sept2017
	END

SELECT 
SalesforceID_18char__c, 
Co_Reg__c, 
Market_Location_URN__c,
Data_Supplier__c, 
Source__c, 
Company, 
Street, 
PostalCode, 
Phone, 
FirstName, 
LastName, 
Email,
Website,
Status,
Suspended_Closed_Reason__c,
RecordTypeId,
Callback_Date_Time__c, 
Toxic_SIC__c, 
IsTPS__c, 
LeadSource, 
Affinity_Cold__c,
FT_Employees__c, 
Affinity_Industry_Type__c, 
SIC2007_Code3__c, 
SIC2007_Description3__c, 
CitationSector__c, 
TEXT_BDM__c, 

case when 
REPLACE(case when Phone like '0%' then Phone else '0'+Phone end,' ','') in
(
SELECT REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
FROM SalesforceReporting..toxicdata l
) and ISNULL(Phone,'') <> ''
or
REPLACE(case when Phone like '0%' then Phone else '0'+Phone end,' ','') in
(
SELECT REPLACE(case when l.Mobile like '0%' then l.Mobile else '0'+l.Mobile end,' ','')
FROM SalesforceReporting..toxicdata l
) and ISNULL(Phone,'') <> ''
or 
REPLACE(case when Phone like '0%' then Phone else '0'+Phone end,' ','') in
(
SELECT REPLACE(case when l.[Other Phone] like '0%' then l.[Other Phone] else '0'+l.[Other Phone] end,' ','')
FROM SalesforceReporting..toxicdata l 
) and ISNULL(Phone,'') <> ''
or
REPLACE(REPLACE(Company,'Ltd',''),'Limited','')+REPLACE(PostalCode,' ','') in
(
SELECT REPLACE(REPLACE([Company   Account],'Ltd',''),'Limited','')+REPLACE([Post Code],' ','')
FROM SalesforceReporting..toxicdata
WHERE ISNULL(Company,'') <> '' and ISNULL(PostalCode,'') <> ''
)
then 1 else 0 end Dupe_Toxic,

case when 
REPLACE(case when Phone like '0%' then Phone else '0'+Phone end,' ','') in
(
SELECT REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
FROM Salesforce..Account l
) and ISNULL(Phone,'') <> ''
or
REPLACE(REPLACE(Company,'Ltd',''),'Limited','')+REPLACE(PostalCode,' ','') in
(
SELECT REPLACE(REPLACE(Name,'Ltd',''),'Limited','')+REPLACE(BillingPostalCode,' ','')
FROM Salesforce..Account
WHERE ISNULL(Name,'') <> '' and ISNULL(BillingPostalCode,'') <> ''
)
then 1 else 0 end  Dupe_Account,

case when 
REPLACE(case when Phone like '0%' then Phone else '0'+Phone end,' ','') in
(
SELECT REPLACE(case when l.Phone__c like '0%' then l.Phone__c else '0'+l.Phone__c end,' ','')
FROM Salesforce..Site__c l
) and ISNULL(Phone,'') <> ''
or
REPLACE(REPLACE(Company,'Ltd',''),'Limited','')+REPLACE(PostalCode,' ','') in
(
SELECT REPLACE(REPLACE(a.Name,'Ltd',''),'Limited','')+REPLACE(s.Postcode__c,' ','')
FROM Salesforce..Site__c s
inner join Salesforce..Account a ON s.Account__c = a.Id
WHERE ISNULL(a.Name,'') <> '' and ISNULL(s.Postcode__c,'') <> ''
)
then 1 else 0 end Dupe_Site,

case when 
SIC2007_Code3__c in
	(
	SELECT SIC3_Code
	FROM SalesforceReporting..SIC2007Codes
	WHERE ToxicSIC = 1
	) then 1 else 0 end ToxicSIC,

case when
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Company,'Ltd',''),'Limited',''),'&',''),'and',''),'plc','') in 
	(
	SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Company,'Ltd',''),'Limited',''),'&',''),'and',''),'plc','')
	FROM SalesforceReporting..BadCompanies
	) then 1 else 0 end BadCompany_Exact,

case when wc.Wildcard is not null then 1 else 0 end BadCompany_Near,

case when wc1.WildCard is not null or wc3.WildCard is not null then 1 else 0 end BadDomain,

case when Email like '%nhs.uk%' or Website like '%nhs.uk%' then 1 else 0 end BadDomain_NHS

INTO
NewVoiceMedia..LeadSuppression_Sept2017

FROM
NewVoiceMedia..LeadSuppression_NEW l
left outer join SalesforceReporting..BadCompanies_WildCards wc ON l.Company collate latin1_general_CI_AS like wc.WildCard  collate latin1_general_CI_AS
left outer join SalesforceReporting..BadDomains_WildCards wc1 ON l.Email collate latin1_general_CI_AS like wc1.WildCard collate latin1_general_CI_AS
left outer join SalesforceReporting..BadDomains_WildCards wc3 ON l.Website collate latin1_general_CI_AS like wc3.WildCard collate latin1_general_CI_AS