SELECT '01' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Company <> ml.[Business Name]
UNION
SELECT '02' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Street <> ml.[Address Line 1] + ' ' + [Address Line 2] + ' ' + Locality
UNION
SELECT '03' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.City <> ml.Town
UNION
SELECT '04' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.State <> ml.County
UNION
SELECT '05' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.PostalCode <> ml.Postcode
UNION
SELECT '06' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Salutation <> ml.[Contact title]
UNION
SELECT '07' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.FirstName <> ml.[Contact forename]
UNION
SELECT '08' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.LastName <> ml.[Contact surname]
UNION
SELECT '09' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Position__c <> ml.[Contact position]
UNION
SELECT '10' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ' ,'') <> REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','')
UNION
SELECT '11' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Email <> case when ml.[Contact email address] = '' then ml.[company email address] else ml.[Contact email address] end
UNION
SELECT '12' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Website <> ml.[web address]
UNION
SELECT '13' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.SIC2007_Code3__c <> CONVERT(int, ml.[UK 07 Sic Code])
UNION
SELECT '14' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.FT_Employees__c <> CONVERT(int, ml.[Nat Employees])
UNION
SELECT '15' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Co_Reg__c <> ml.cro_number
UNION
SELECT '16' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.IsTPS__c <> case when ml.ctps = 'Y' then 'Yes' else 'No' end
ORDER BY Field