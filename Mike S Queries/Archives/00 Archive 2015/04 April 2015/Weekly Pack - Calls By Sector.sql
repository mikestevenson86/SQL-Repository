SELECT
DATEADD(dd, -(DATEPART(dw, Date_Made__c)-2), Date_Made__c) [Week No],
af.Sector,
COUNT(Id) Appts
INTO #Appts
FROM
Salesforce..Lead l
inner join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code 2007]
WHERE
Date_Made__c >= GETDATE()-43 and (l.RecordTypeId = '012D0000000NbJsIAK' or l.RecordTypeId is null)
GROUP BY
DATEADD(dd, -(DATEPART(dw, Date_Made__c)-2), Date_Made__c),
af.Sector

SELECT
DATEADD(dd, -(DATEPART(dw, act_date)-2), act_date) [Week No],
af.Sector,
SUM(case when call_type in (0,2,4) then 1 else 0 end) Calls,
ISNULL(ap.Appts, 0) Appts
FROM
SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON ch.lm_filler2 = l.Id
inner join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code 2007]
left outer join #Appts ap ON af.Sector = ap.Sector
				AND DATEADD(dd, -(DATEPART(dw, act_date)-2), act_date) = ap.[Week No]
WHERE act_date >= GETDATE()-43 and appl <> 'NBS1'
GROUP BY
DATEADD(dd, -(DATEPART(dw, act_date)-2), act_date),
af.Sector,
ap.Appts
ORDER BY
DATEADD(dd, -(DATEPART(dw, act_date)-2), act_date),
af.Sector

DROP TABLE #Appts