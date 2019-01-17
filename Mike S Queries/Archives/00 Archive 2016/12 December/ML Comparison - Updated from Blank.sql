SELECT '01' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE (l.Company = '' or Company is null) and ml.[Business Name] <> ''
UNION
SELECT '02' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE (l.Street = '' or Street is null) and ml.[Address Line 1] + ml.[Address Line 2] + ml.Locality <> ''
UNION
SELECT '03' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE (l.City = '' or City is null) and ml.Town <> ''
UNION
SELECT '04' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE (l.State = '' or State is null) and ml.County <> ''
UNION
SELECT '05' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE (l.PostalCode = '' or PostalCode is null) and ml.Postcode <> ''
UNION
SELECT '06' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE (l.Salutation = '' or Salutation is null) and ml.[Contact title] <> ''
UNION
SELECT '07' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE (l.FirstName = '' or FirstName is null) and ml.[Contact forename] <> ''
UNION
SELECT '08' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE (l.LastName = '' or LastName is null) and ml.[Contact surname] <> ''
UNION
SELECT '09' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE (l.Position__c = '' or Position__c is null) and ml.[Contact position] <> ''
UNION
SELECT '10' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE (l.Phone = '' or l.Phone = '0' or Phone is null) and ml.[Telephone Number] <> ''
UNION
SELECT '11' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE (l.Email = '' or Email is null) and case when ml.[Contact email address] = '' then ml.[company email address] else ml.[Contact email address] end <> ''
UNION
SELECT '12' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE (l.Website = '' or Website is null) and ml.[web address] <> ''
UNION
SELECT '13' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE (l.SIC2007_Code3__c = 0 or SIC2007_Code3__c is null) and ml.[UK 07 Sic Code] <> ''
UNION
SELECT '14' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE (l.FT_Employees__c = 0 or FT_Employees__c is null) and ml.[Nat Employees] <> ''
UNION
SELECT '15' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE (l.Co_Reg__c = '' or Co_Reg__c is null) and ml.cro_number <> ''
UNION
SELECT '16' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE (l.IsTPS__c = '' or IsTPS__c is null) and ml.ctps <> ''
ORDER BY Field