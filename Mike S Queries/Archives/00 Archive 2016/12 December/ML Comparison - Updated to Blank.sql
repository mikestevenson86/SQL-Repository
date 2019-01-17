SELECT '01' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Company <> '' and ml.[Business Name] = ''
UNION
SELECT '02' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Street <> '' and ml.[Address Line 1] + ml.[Address Line 2] + ml.Locality = ''
UNION
SELECT '03' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.City <> '' and ml.Town = ''
UNION
SELECT '04' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.State <> '' and ml.County = ''
UNION
SELECT '05' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.PostalCode <> '' and ml.Postcode = ''
UNION
SELECT '06' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Salutation <> '' and ml.[Contact title] = ''
UNION
SELECT '07' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.FirstName <> '' and ml.[Contact forename] = ''
UNION
SELECT '08' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.LastName <> '' and ml.[Contact surname] = ''
UNION
SELECT '09' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Position__c <> '' and ml.[Contact position] = ''
UNION
SELECT '10' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Phone <> '' and l.Phone <> '0' and ml.[Telephone Number] = ''
UNION
SELECT '11' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Email <> '' and case when ml.[Contact email address] = '' then ml.[company email address] else ml.[Contact email address] end = ''
UNION
SELECT '12' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Website <> '' and ml.[web address] = ''
UNION
SELECT '13' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.SIC2007_Code3__c <> 0 and ml.[UK 07 Sic Code] = ''
UNION
SELECT '14' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.FT_Employees__c <> 0 and ml.[Nat Employees] = ''
UNION
SELECT '15' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Co_Reg__c <> '' and ml.cro_number = ''
UNION
SELECT '16' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.IsTPS__c <> '' and ml.ctps = ''
ORDER BY Field