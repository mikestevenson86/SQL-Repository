SELECT '01' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Business Name] = ''
UNION
SELECT '02' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Address Line 1] = ''
UNION
SELECT '03' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Address Line 2] = ''
UNION
SELECT '04' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.Locality = ''
UNION
SELECT '05' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.Town = ''
UNION
SELECT '06' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.County = ''
UNION
SELECT '07' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.PostCode = ''
UNION
SELECT '08' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Contact title] = ''
UNION
SELECT '09' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Contact forename] = ''
UNION
SELECT '10' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Contact surname] = ''
UNION
SELECT '11' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Contact position] = ''
UNION
SELECT '12' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Telephone Number] = '' or l.[Telephone Number] = '0'
UNION
SELECT '13' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Contact email address] = ''
UNION
SELECT '14' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[company email address] = ''
UNION
SELECT '15' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[web address] = ''
UNION
SELECT '16' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[UK 07 Sic Code] = ''
UNION
SELECT '17' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Nat Employees] = ''
UNION
SELECT '18' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.cro_number = ''
UNION
SELECT '19' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.ctps = ''
ORDER BY Field