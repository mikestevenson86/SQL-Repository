SELECT Id
INTO #Temp
FROM Salesforce..Lead l
WHERE l.SIC2007_Code3__c is null or SIC2007_Code3__c = 0 or l.FT_Employees__c = 0 or l.FT_Employees__c is null

SELECT lm_filler2, MAX(act_date) LastCall
INTO #LastCalls
FROM SalesforceReporting..call_history
WHERE lm_filler2 in (SELECT ID FROM #Temp)
GROUP BY lm_filler2

SELECT lm_filler2, MAX(act_date) LastCall
INTO #LastCallsOld
FROM Enterprise..call_history
WHERE lm_filler2 in (SELECT ID FROM #Temp)
GROUP BY lm_filler2

SELECT l.Id, CONVERT(date, ISNULL(lc.LastCall, lco.LastCall)) LastCall, CONVERT(date, l.CreatedDate) DateAdded,
case when (l.SIC2007_Code3__c is null or SIC2007_Code3__c = 0) and (l.FT_Employees__c = 0 or l.FT_Employees__c is null) then 'Yes' Else 'No' end NoFTEandSIC,
case when (l.SIC2007_Code3__c is null or SIC2007_Code3__c = 0) and l.FT_Employees__c > 0 then 'Yes' else 'No' end NoSIC,
case when SIC2007_Code3__c > 0 and (l.FT_Employees__c = 0 or l.FT_Employees__c is null) then 'Yes' else 'No' end NoFTE
FROM Salesforce..Lead l
inner join #Temp t ON l.Id = t.Id
left outer join #LastCalls lc ON l.Id = lc.lm_filler2
left outer join #LastCallsOld lco ON l.Id = lco.lm_filler2

DROP TABLE #Temp
DROP TABLE #LastCalls
DROP TABLE #LastCallsOld