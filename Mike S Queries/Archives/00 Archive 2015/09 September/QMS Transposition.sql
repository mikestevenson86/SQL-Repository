Use SalesforceReporting

DECLARE @columnname nvarchar(100), @sql nvarchar(500), @rn int, @ref nvarchar(20), @dued date, @row int

SET @row = 1

While @row < 9656

BEGIN

	SELECT @ref = [Ref No] FROM QMSAuditData WHERE ROWN = @row
	SELECT @dued = '2015-05-01'

	SET @rn = 4

	While @rn <132

	BEGIN

		SELECT @columnname = COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
					WHERE TABLE_NAME = 'QMSAuditData' AND ORDINAL_POSITION = @rn

		SET @sql = 'INSERT INTO NEWQMSAudit ([DueDate], [ContractNo], [SalesLedgerAccountRef], [NominalAccount], [Value]) ' +
		'SELECT ' + CHAR(39) + CONVERT(varchar,@dued) + CHAR(39) + ', [Ref No], [Account Number], [Nominal Code], ' + @columnname + 
		' FROM QMSAuditData WHERE [Ref No] = ' + CHAR(39) + @ref + CHAR(39)

		EXEC sp_executesql @sql
		
		SET @rn = @rn + 1
		SET @dued = DATEADD(month,1,@dued)

	END

	SET @row = @row+1

END