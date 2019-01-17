DECLARE @SQL NVarChar(MAX) = N'SELECT *
INTO LeadChangeReview..Lead_SnapShot' + DATENAME(Month, DATEADD(month,-1,GETDATE())) + CONVERT(VarChar, YEAR(DATEADD(month,-1,GETDATE()))) + '
FROM LeadChangeReview..Lead_SnapShot
WHERE DATENAME(Month, DATEADD(month,-1,SnapShotDate())) + CONVERT(VarChar, YEAR(DATEADD(month,-1,SnapShotDate())) = ''' +
DATENAME(Month, DATEADD(month,-1,GETDATE())) + CONVERT(VarChar, YEAR(DATEADD(month,-1,GETDATE()))) + ''''

print @SQL

--exec sp_executeSQL @SQL