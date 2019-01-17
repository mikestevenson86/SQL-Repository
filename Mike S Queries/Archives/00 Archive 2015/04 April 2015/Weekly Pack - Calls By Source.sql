SELECT 
DATEADD(dd, -(DATEPART(dw, Date_Made__c)-2), Date_Made__c) [Week No],
Source__c,
COUNT(Id) Appts
INTO #Appts
FROM
Salesforce..Lead
WHERE
Date_Made__c >= GETDATE()-43 and (RecordTypeId = '012D0000000NbJsIAK' or RecordTypeId is null) and SIC2007_Code3__c <> '11111' and FT_Employees__c > 0
GROUP BY
DATEADD(dd, -(DATEPART(dw, Date_Made__c)-2), Date_Made__c),
Source__c
UNION
SELECT 
DATEADD(dd, -(DATEPART(dw, Date_Made__c)-2), Date_Made__c) [Week No],
case when SIC2007_Code3__c = '11111' then '0 SIC' else '0 FTE' end Source__c,
COUNT(Id) Appts
FROM
Salesforce..Lead
WHERE
Date_Made__c >= GETDATE()-43 and (RecordTypeId = '012D0000000NbJsIAK' or RecordTypeId is null) and (SIC2007_Code3__c = '11111' or FT_Employees__c = 0)
GROUP BY
DATEADD(dd, -(DATEPART(dw, Date_Made__c)-2), Date_Made__c),
case when SIC2007_Code3__c = '11111' then '0 SIC' else '0 FTE' end

SELECT
DATEADD(dd, -(DATEPART(dw, act_date)-2), act_date) [Week No],
l.Source__c [Source],
SUM(case when call_type in (0,2) then 1 else 0 end) Calls,
SUM(case when call_type = 4 then 1 else 0 end) Callbacks,
ISNULL(ap.Appts, 0) Appts
FROM
SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON ch.lm_filler2 = l.Id
left outer join #Appts ap ON l.Source__c = ap.Source__c
							AND DATEADD(dd, -(DATEPART(dw, act_date)-2), act_date) = ap.[Week No]
WHERE act_date >= GETDATE()-43 and appl <> 'NBS1' and SIC2007_Code3__c <> '11111' and FT_Employees__c > 0
GROUP BY
DATEADD(dd, -(DATEPART(dw, act_date)-2), act_date),
l.Source__c,
ap.Appts
UNION
SELECT
DATEADD(dd, -(DATEPART(dw, act_date)-2), act_date) [Week No],
case when SIC2007_Code3__c = '11111' then '0 SIC' else '0 FTE' end [Source],
SUM(case when call_type in (0,2) then 1 else 0 end) Calls,
SUM(case when call_type = 4 then 1 else 0 end) Callbacks,
ISNULL(ap.Appts, 0) Appts
FROM
SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON ch.lm_filler2 = l.Id
left outer join #Appts ap ON case when SIC2007_Code3__c = '11111' then '0 SIC' else '0 FTE' end = ap.Source__c
							AND DATEADD(dd, -(DATEPART(dw, act_date)-2), act_date) = ap.[Week No]
WHERE act_date >= GETDATE()-43 and appl <> 'NBS1' and (SIC2007_Code3__c = '11111' or FT_Employees__c = 0)
GROUP BY
DATEADD(dd, -(DATEPART(dw, act_date)-2), act_date),
case when SIC2007_Code3__c = '11111' then '0 SIC' else '0 FTE' end,
ap.Appts

ORDER BY
DATEADD(dd, -(DATEPART(dw, act_date)-2), act_date),
[Source]

DROP TABLE #Appts