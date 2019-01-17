SELECT '01' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Business Name] <> ml.[Business Name]
UNION
SELECT '02' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Address Line 1] <> ml.[Address Line 1] 
UNION
SELECT '03' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Address Line 2]  <> ml.[Address Line 2]
UNION
SELECT '04' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.Locality <> ml.Locality
UNION
SELECT '05' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.Town <> ml.Town
UNION
SELECT '06' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.County <> ml.County
UNION
SELECT '07' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.Postcode <> ml.Postcode
UNION
SELECT '08' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Contact title] <> ml.[Contact title]
UNION
SELECT '09' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Contact forename] <> ml.[Contact forename]
UNION
SELECT '10' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Contact surname] <> ml.[Contact surname]
UNION
SELECT '11' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Contact position] <> ml.[Contact position]
UNION
SELECT '12' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE REPLACE(case when l.[Telephone Number] like '0%' then l.[Telephone Number] else '0'+l.[Telephone Number] end,' ' ,'') <> REPLACE(case when ml.[Telephone Number] like '0%' then ml.[Telephone Number] else '0'+ml.[Telephone Number] end,' ','')
UNION
SELECT '13' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Contact email address] <> ml.[Contact email address]
UNION
SELECT '14' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[company email address] <> ml.[company email address]
UNION
SELECT '15' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[web address] <> ml.[web address]
UNION
SELECT '16' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[UK 07 Sic Code] <> ml.[UK 07 Sic Code]
UNION
SELECT '17' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.[Nat Employees] <> ml.[Nat Employees]
UNION
SELECT '18' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE l.cro_number <> ml.cro_number
UNION
SELECT '19' Field, COUNT(*)
FROM MarketLocation..MainDataSet l
inner join MarketLocation..MainDataSet_NEW ml ON l.URN = ml.URN
WHERE case when l.ctps = 'Y' then 'Yes' else 'No' end <> case when ml.ctps = 'Y' then 'Yes' else 'No' end
ORDER BY Field