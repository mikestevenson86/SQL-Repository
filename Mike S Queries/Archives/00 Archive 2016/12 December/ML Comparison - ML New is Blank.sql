SELECT '01' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE ml.[Business Name] = ''
UNION
SELECT '02' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE ml.[Address Line 1] + ml.[Address Line 2] + ml.Locality = ''
UNION
SELECT '03' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE ml.Town = ''
UNION
SELECT '04' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE ml.County = ''
UNION
SELECT '05' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE ml.Postcode = ''
UNION
SELECT '06' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE ml.[Contact title] = ''
UNION
SELECT '07' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE ml.[Contact forename] = ''
UNION
SELECT '08' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE ml.[Contact surname] = ''
UNION
SELECT '09' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE ml.[Contact position] = ''
UNION
SELECT '10' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE ml.[Telephone Number] = '' or ml.[Telephone Number] = '0'
UNION
SELECT '11' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE case when ml.[Contact email address] = '' then ml.[company email address] else ml.[Contact email address] end = ''
UNION
SELECT '12' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE ml.[web address] = ''
UNION
SELECT '13' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE ml.[UK 07 Sic Code] = ''
UNION
SELECT '14' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE ml.[Nat Employees] = ''
UNION
SELECT '15' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE ml.cro_number = ''
UNION
SELECT '16' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE ml.ctps = ''
ORDER BY Field