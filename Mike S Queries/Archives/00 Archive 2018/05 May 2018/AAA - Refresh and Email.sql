USE Salesforce

exec Salesforce..SF_Refresh 'Salesforce','Lead'

DECLARE @MessageSubject VARCHAR(50)
SELECT @MessageSubject = 'Lead Refreshed!!!'

EXEC msdb.dbo.sp_send_dbmail 

@profile_name = 'DB01 Email',
@recipients = 'mikestevenson@citation.co.uk',
@subject = @MessageSubject