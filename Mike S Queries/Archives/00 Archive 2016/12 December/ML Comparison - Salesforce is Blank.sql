SELECT '01' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Company = '' or l.Company is null
UNION
SELECT '02' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Street = '' or l.Street is null
UNION
SELECT '03' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.City = '' or l.City is null
UNION
SELECT '04' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.State = '' or l.State is null
UNION
SELECT '05' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.PostalCode = '' or l.PostalCode is null
UNION
SELECT '06' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Salutation = '' or l.Salutation is null
UNION
SELECT '07' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.FirstName = '' or l.FirstName is null
UNION
SELECT '08' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.LastName = '' or l.LastName is null
UNION
SELECT '09' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Position__c = '' or l.Position__c is null
UNION
SELECT '10' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Phone = '' or l.Phone = '0' or l.Phone is null
UNION
SELECT '11' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Email = '' or l.Email is null
UNION
SELECT '12' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Website = '' or l.Website is null
UNION
SELECT '13' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.SIC2007_Code3__c = 0 or l.SIC2007_Code3__c is null
UNION
SELECT '14' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.FT_Employees__c = 0 or l.FT_Employees__c is null
UNION
SELECT '15' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.Co_Reg__c = '' or l.Co_Reg__c is null
UNION
SELECT '16' Field, COUNT(*)
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet_NEW ml ON l.Market_Location_URN__c = ml.URN
WHERE l.IsTPS__c = '' or l.IsTPS__c is null
ORDER BY Field