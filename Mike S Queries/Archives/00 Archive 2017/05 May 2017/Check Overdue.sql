IF OBJECT_ID('tempdb..#LastCallback') IS NOT NULL
	BEGIN
		DROP TABLE #LastCallback
	END
	
IF OBJECT_ID('tempdb..#Results') IS NOT NULL
	BEGIN
		DROP TABLE #Results
	END

DECLARE @LastRefresh as datetime

SET @LastRefresh = (
		SELECT LastRefreshTime
		FROM Salesforce..TableRefreshTime
		WHERE TblName = 'LeadHistory'	
	)

IF	@LastRefresh < CONVERT(datetime,CONVERT(date, GETDATE()))

	BEGIN
		print 'Refreshed Recently'
	END

ELSE

	BEGIN
		print 'Refreshed '+ CONVERT(VarChar,@LastRefresh,25) + CHAR(13) + ''
		
		exec Salesforce..SF_Refresh 'Salesforce','LeadHistory'
	END

SELECT MAX(Id) Id
INTO #LastCallback
FROM Salesforce..LeadHistory lh
inner join
(
SELECT LeadId, MAX(CreatedDate) LastC
FROM Salesforce..LeadHistory
WHERE Field = 'Callback_Date_Time__c' and NewValue is not null
GROUP BY LeadId
) lc ON lh.LeadId = lc.LeadId and lh.CreatedDate = lc.LastC
WHERE lh.Field = 'Callback_Date_Time__c'
GROUP BY lh.LeadId, CreatedDate

SELECT 
lor.Id, 
u.Name BDC,
CONVERT(VarChar,
DATEADD(hh,-1, 
REPLACE(lor.Callback_Date_Time__c,'.0000000',''))
,25) RemovedCallback, 
CONVERT(VarChar,REPLACE(REPLACE(lh.NewValue,'T',' '),'.000Z',''))
+'.000'
LastCallback

INTO
#Results

FROM 
SalesforceReporting..LastOverdueRun lor
left outer join Salesforce..[User] u ON lor.BDC__c = u.Id
left outer join Salesforce..LeadHistory lh ON lor.Id = lh.LeadId 
inner join #LastCallback lc ON lh.Id = lc.Id

WHERE 
CONVERT(date, RunDate) = '2017-04-28'
and
CONVERT(VarChar,
DATEADD(hh,-1, 
REPLACE(lor.Callback_Date_Time__c,'.0000000',''))
,25) <> 
CONVERT(VarChar,REPLACE(REPLACE(lh.NewValue,'T',' '),'.000Z',''))
+'.000'

IF EXISTS(SELECT * FROM #Results)

	SELECT * FROM #Results

ELSE
	
	print 'No Errors Found'

DROP TABLE #LastCallback
DROP TABLE #Results