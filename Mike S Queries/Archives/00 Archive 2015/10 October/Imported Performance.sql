SELECT lm_filler2 LeadID, MIN(act_date) MinDate
INTO #FirstCall
FROM SalesforceReporting..call_history
GROUP BY lm_filler2

SELECT DATEPART(Year, CreatedDate), DATEPART(Month, CreatedDate), DATENAME(Month, CreatedDate), COUNT(l.Id), SUM(case when fc.MinDate < DATEADD(Year,1,CreatedDate) then 1 else 0 end)
FROM Salesforce..Lead l
left outer join #FirstCall fc ON LEFT(l.Id, 15) collate latin1_general_CS_AS = LEFT(fc.LeadID, 15) collate latin1_general_CS_AS
WHERE CreatedDate > DATEADD(YEAR,-1,GETDATE())
GROUP BY DATEPART(Year, CreatedDate), DATEPART(Month, CreatedDate),DATENAME(Month, CreatedDate)
ORDER BY DATEPART(Year, CreatedDate), DATEPART(Month, CreatedDate)

DROP TABLE #FirstCall