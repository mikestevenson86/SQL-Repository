Use SalesforceReporting

DECLARE @columnname nvarchar(100), @sql nvarchar(500), @rn int, @ref nvarchar(20), @dued date, @row int

SET @row = 1

While @row < 486

BEGIN

	SELECT @ref = RefNo FROM QMSAuditData_Audit_B WHERE RefNo = @row
	SELECT @dued = '2015-05-01'

	SET @rn = 6

	While @rn <157

	BEGIN

		SELECT @columnname = COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
					WHERE TABLE_NAME = 'QMSAuditData_Audit_B' AND ORDINAL_POSITION = @rn

		SET @sql = 'INSERT INTO NEWQMSAuditB (DueDate, ContractNo, AccountNo, Narrative, DayNumber, Value) ' +
		'SELECT ' + CHAR(39) + CONVERT(varchar,@dued) + CHAR(39) + ', [ContractNo], ' +
		'[AccountNo], [Product], DayNumber, ' + @columnname +
		' FROM QMSAuditData_Audit_B WHERE [RefNo] = ' + @ref

		EXEC sp_executesql @sql
		
		SET @rn = @rn + 1
		SET @dued = DATEADD(month,1,@dued)

	END

	SET @row = @row+1

END

--DELETE FROM SalesforceReporting..NEWQMSAuditB