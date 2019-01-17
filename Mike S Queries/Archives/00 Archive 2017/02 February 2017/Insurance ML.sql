SELECT *
FROM MarketLocation..MainDataSet
WHERE [UK 07 Sic Code] in
(
'66110',
'66120',
'66190',
'66210',
'66220',
'66290',
'66300',
'65110',
'65120',
'65201',
'65202',
'65300'
) or [Easy Sector Desc] like '%insurance%' or Feb_MajorSectorDesc like '%insurance%'