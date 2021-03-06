SELECT [SIC Code 3], [Description 3]
FROM SalesforceReporting..SICCodes2007
WHERE [SIC Code 3] in
(
SELECT af.[SIC Code 2007]
FROM SalesforceReporting..AffinitySICCodes af
WHERE Sector in ('Vets','Education','Pharmacies','Dentists')
)
or [SIC Code 3] in ('56101','56102','47730','55100','97000')
or [SIC Code 2] = '47'
GROUP BY [SIC Code 3], [Description 3]