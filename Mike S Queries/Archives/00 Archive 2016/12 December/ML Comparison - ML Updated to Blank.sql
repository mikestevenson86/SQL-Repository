SELECT '01' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Business Name] <> '' and ml.[Business Name] = ''
UNION
SELECT '02' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Address Line 1] <> '' and ml.[Address Line 1] = ''
UNION
SELECT '03' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Address Line 2] <> '' and ml.[Address Line 2] = ''
UNION
SELECT '04' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.Locality <> '' and ml.Locality = ''
UNION
SELECT '05' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.Town <> '' and ml.Town = ''
UNION
SELECT '06' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.County <> '' and ml.County = ''
UNION
SELECT '07' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.Postcode <> '' and ml.Postcode = ''
UNION
SELECT '08' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Contact title] <> '' and ml.[Contact title] = ''
UNION
SELECT '09' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Contact forename] <> '' and ml.[Contact forename] = ''
UNION
SELECT '10' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Contact surname] <> '' and ml.[Contact surname] = ''
UNION
SELECT '11' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Contact position] <> '' and ml.[Contact position] = ''
UNION
SELECT '12' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Telephone Number] <> '' and ml.[Telephone Number] = ''
UNION
SELECT '13' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Contact email address] <> '' and ml.[Contact email address] = ''
UNION
SELECT '14' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[company email address] <> '' and ml.[company email address] = ''
UNION
SELECT '15' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[web address] <> '' and ml.[web address] = ''
UNION
SELECT '16' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[UK 07 Sic Code] <> '' and ml.[UK 07 Sic Code] = ''
UNION
SELECT '17' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Nat Employees] <> '' and ml.[Nat Employees] = ''
UNION
SELECT '18' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.cro_number <> '' and ml.cro_number = ''
UNION
SELECT '19' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.ctps <> '' and ml.ctps = ''
ORDER BY Field