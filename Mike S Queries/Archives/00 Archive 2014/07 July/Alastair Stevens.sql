SELECT 
u.Name BDC, 
CONVERT(date,ch.act_date) [Call Date],
case when LEN(ch.act_time) = 5 then '0'+LEFT(ch.act_time, 1)+':'+LEFT(RIGHT(act_time,4),2)+':'+RIGHT(ch.act_time, 2) else LEFT(ch.act_time, 2)+':'+LEFT(RIGHT(act_time,4),2)+':'+RIGHT(ch.act_time, 2) end [Call Time],
l.SIC2007_Description__c [SIC Code 1], 
l.SIC2007_Description2__c [SIC Code 2], 
l.SIC2007_Description3__c [SIC Code 3],
ch.status [Noble Status], 
a.description [Additional Status], 
l.[status] [SF Status],
case when ch. call_type in (0,2,4) then 'Connected' else 'Not Connected' end Connection,
ch.time_connect 'Call Length'
FROM Enterprise..call_history ch
inner join Salesforce..[User] u ON ch.tsr = u.DiallerFK__c
inner join Salesforce..Lead l ON ch.lm_filler2 collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS
left outer join Enterprise..addistats a ON ch.addi_status = a.addistatus and ch.appl = a.pappl
WHERE l.OwnerId = '005D000000377NfIAI' and CONVERT(date, act_date) >= CONVERT(date, '2014-06-01')
ORDER BY act_date, act_time