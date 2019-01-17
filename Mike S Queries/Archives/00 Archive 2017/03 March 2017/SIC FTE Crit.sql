SELECT *
FROM SalesforceReporting..GI_160317 gi
inner join SalesforceReporting..SIC2007Codes sc ON gi.ML_SIC = sc.SIC3_Code
WHERE 
(
ML_FTE between 6 and 225 
or
(CitationSector = 'CLEANING' and ML_FTE between 4 and 225)
or
(CitationSector = 'DENTAL PRACTICE' and ML_FTE between 3 and 225)
or
(CitationSector = 'HORTICULTURE' and ML_FTE between 4 and 225)
or
(CitationSector = 'DAY NURSERY' and ML_FTE between 3 and 225)
or
(CitationSector like '%FUNERAL%' and ML_FTE between 3 and 225)
or
(CitationSector = 'PHARMACY' and ML_FTE between 3 and 225) 
or 
(
CitationSector not in ('CLEANING','DENTAL PRACTICE','HORTICULTURE','DAY NURSERY','FUNERAL SERVICES','PHARMACY') 
and (ML_FTE < 6 or ML_FTE > 225)
and [No Employees] between 6 and 225
)
or
(
CitationSector in ('CLEANING') 
and (ML_FTE < 4 or ML_FTE > 225)
and [No Employees] between 4 and 225
)
or
(
CitationSector in ('DENTAL PRACTICE') 
and (ML_FTE < 3 or ML_FTE > 225)
and [No Employees] between 3 and 225
)
or
(
CitationSector in ('HORTICULTURE') 
and (ML_FTE < 4 or ML_FTE > 225)
and [No Employees] between 4 and 225
)
or
(
CitationSector in ('DAY NURSERY') 
and (ML_FTE < 3 or ML_FTE > 225)
and [No Employees] between 3 and 225
)
or
(
CitationSector in ('FUNERAL SERVICES') 
and (ML_FTE < 3 or ML_FTE > 225)
and [No Employees] between 3 and 225
)
or
(
CitationSector in ('PHARMACY') 
and (ML_FTE < 3 or ML_FTE > 225)
and [No Employees] between 3 and 225
)
)
and 
SF_ID is null

UNION

SELECT *
FROM SalesforceReporting..GI_160317 gi
inner join SalesforceReporting..SIC2007Codes sc ON gi.ML_SIC = sc.SIC3_Code
WHERE ML_FTE is null and
(
[No Employees] between 6 and 225 
or
(CitationSector = 'CLEANING' and [No Employees] between 4 and 225)
or
(CitationSector = 'DENTAL PRACTICE' and [No Employees] between 3 and 225)
or
(CitationSector = 'HORTICULTURE' and [No Employees] between 4 and 225)
or
(CitationSector = 'DAY NURSERY' and [No Employees] between 3 and 225)
or
(CitationSector like '%FUNERAL%' and [No Employees] between 3 and 225)
or
(CitationSector = 'PHARMACY' and [No Employees] between 3 and 225)
)  
and 
SF_ID is null
