USE Salesforce

DECLARE @MessageSubject VARCHAR(50)
SELECT @MessageSubject = 'Daily Inserts Today ' + CONVERT(VarChar, CONVERT(date, GETDATE(), 103))

DECLARE @FileName VarChar(50)
SELECT @FileName = 'Daily Inserts - ' + CONVERT(VarChar, CONVERT(date, GETDATE(), 103)) + '.csv'

EXEC msdb.dbo.sp_send_dbmail 

@profile_name = 'DB01 Email'
,@recipients = 'mikestevenson@citation.co.uk'
,@query = 'SELECT * FROM SalesforceReporting..DailySFInserts WHERE InsertDate = CONVERT(date, GETDATE())'
,@attach_query_result_as_file = 1
,@query_attachment_filename = @FileName
,@query_result_separator = '	'
,@subject = @MessageSubject
--,@copy_recipients = 'mikestevenson@citation.co.uk'