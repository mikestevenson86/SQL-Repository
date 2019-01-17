SELECT '01' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE ml.[Business Name] = ''
UNION
SELECT '02' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE ml.[Address Line 1] = ''
UNION
SELECT '03' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE ml.[Address Line 2] = ''
UNION
SELECT '04' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE ml.Locality = ''
UNION
SELECT '05' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE ml.Town = ''
UNION
SELECT '06' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE ml.County = ''
UNION
SELECT '07' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE ml.PostCode = ''
UNION
SELECT '08' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE ml.[Contact title] = ''
UNION
SELECT '09' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE ml.[Contact forename] = ''
UNION
SELECT '10' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE ml.[Contact surname] = ''
UNION
SELECT '11' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE ml.[Contact position] = ''
UNION
SELECT '12' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE ml.[Telephone Number] = '' or ml.[Telephone Number] = '0'
UNION
SELECT '13' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE ml.[Contact email address] = ''
UNION
SELECT '14' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE ml.[company email address] = ''
UNION
SELECT '15' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE ml.[web address] = ''
UNION
SELECT '16' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE ml.[UK 07 Sic Code] = ''
UNION
SELECT '17' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE ml.[Nat Employees] = ''
UNION
SELECT '18' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE ml.cro_number = ''
UNION
SELECT '19' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE ml.ctps = ''
ORDER BY Field