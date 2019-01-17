SELECT * FROM msdb.dbo.sysmail_allitems ORDER BY sent_date desc

SELECT SUBSTRING(fail.subject,1,25) AS 'Subject',        
fail.mailitem_id,      LOG.description 
FROM msdb.dbo.sysmail_event_log LOG 
join msdb.dbo.sysmail_faileditems fail ON fail.mailitem_id = LOG.mailitem_id WHERE event_type = 'error'
ORDER BY mailitem_id desc