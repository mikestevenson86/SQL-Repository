IF OBJECT_ID('tempdb..#ML') IS NOT NULL
	BEGIN
		DROP TABLE #ML
	END

CREATE TABLE #ML
(
ID NChar(18)
)

SELECT CONVERT(VarChar,COUNT(ID)) + ' missing potential Company Registration Number'
FROM Salesforce..Lead l
inner join SalesforceReporting..CompaniesHouse ch ON 
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(l.Company,'Ltd',''),'Limited',''),'plc',''),',',''),' ','') 
= 
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(ch.CompanyName,'Ltd',''),'Limited',''),'plc',''),',',''),' ','')
AND
REPLACE(l.PostalCode,' ','') = REPLACE(ch.[RegAddress PostCode],' ','')
WHERE ISNULL(l.Co_Reg__c,'') = '' and ISNULL(l.Company,'') <> '' and ISNULL(l.PostalCode,'') <> ''

INSERT INTO #ML
SELECT l.Id
FROM
Salesforce..Lead l
inner join MarketLocation..MainDataSet ml ON 
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(l.Company,'Ltd',''),'Limited',''),'plc',''),',',''),' ','') 
= 
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(ml.[Business Name],'Ltd',''),'Limited',''),'plc',''),',',''),' ','')
AND
REPLACE(l.PostalCode,' ','') = REPLACE(ml.Postcode,' ','')
WHERE ISNULL(l.Market_Location_URN__c,'') = '' and ISNULL(l.Company,'') <> '' and ISNULL(l.PostalCode,'') <> ''

INSERT INTO #ML
SELECT l.Id
FROM
Salesforce..Lead l
inner join MarketLocation..MainDataSet ml ON 
REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
=
REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','')
WHERE ISNULL(l.Market_Location_URN__c,'') = '' and l.Id not in (SELECT Id FROM #ML) and ISNULL(l.Phone,'') <> ''

INSERT INTO #ML
SELECT l.Id
FROM
Salesforce..Lead l
inner join MarketLocation..MainDataSet ml ON 
REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
=
REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','')
WHERE ISNULL(l.Market_Location_URN__c,'') = '' and l.Id not in (SELECT Id FROM #ML) and ISNULL(l.MobilePhone,'') <> ''

INSERT INTO #ML
SELECT l.Id
FROM
Salesforce..Lead l
inner join MarketLocation..MainDataSet ml ON 
REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
=
REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','')
WHERE ISNULL(l.Market_Location_URN__c,'') = '' and l.Id not in (SELECT Id FROM #ML) and ISNULL(l.Other_Phone__c,'') <> ''

SELECT CONVERT(VarChar, COUNT(Id)) + ' missing potential Market Location URN'
FROM #ML