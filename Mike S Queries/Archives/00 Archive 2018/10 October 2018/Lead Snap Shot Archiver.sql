DECLARE @RunDate as date
DECLARE @Table as NVarChar(255)
DECLARE @Query as NVarChar(MAX)

SET @RunDate = DATEADD(mm, DATEDIFF(mm, 0, GETDATE())-1, 0)
SET @Table = 'Lead_SnapShots_' + DATENAME(Month, @RunDate) + CONVERT(VarChar, YEAR(@RunDate))

SET @Query = 'SELECT * INTO LeadChangeReview.dbo.' + @Table + ' FROM LeadChangeReview..Lead_SnapShots WHERE SSDate = ''' + CONVERT(VarChar, @RunDate) + ''''
EXEC sp_executesql @Query

DELETE FROM LeadChangeReview..Lead_SnapShots WHERE SSDate = @RunDate

SET @Query = N'CREATE INDEX IDX_PROSPECT_ID ON LeadChangeReview.dbo.' + @Table + ' (Id)
CREATE INDEX IDX_SNAPSHOT_DATE ON LeadChangeReview.dbo.' + @Table + '(SSDate)'
EXEC sp_executesql @Query

DBCC SHRINKDATABASE (LeadChangeReview, 10)

SET @RunDate = DATEADD(day,1,@RunDate)

WHILE @RunDate < DATEADD(mm, DATEDIFF(mm, 0, GETDATE()), 0)
BEGIN
	
	SET @Query = N'INSERT INTO LeadChangeReview.dbo.' + @Table + ' SELECT * FROM LeadChangeReview..Lead_SnapShots WHERE SSDate = ''' + CONVERT(VarChar, @RunDate) + ''''
	EXEC sp_executesql @Query
	
	DELETE FROM LeadChangeReview..Lead_SnapShots WHERE SSDate = @RunDate
	
	DBCC SHRINKDATABASE (LeadChangeReview, 10)
	
	SET @RunDate = DATEADD(day,1,@RunDate)
END

SET @Query = N'ALTER INDEX ALL ON LeadChangeReview.dbo.' + @Table + ' REBUILD'
EXEC sp_executesql @Query

ALTER INDEX ALL ON LeadChangeReview..Lead_SnapShots REBUILD

DBCC SHRINKDATABASE (LeadChangeReview, 10)