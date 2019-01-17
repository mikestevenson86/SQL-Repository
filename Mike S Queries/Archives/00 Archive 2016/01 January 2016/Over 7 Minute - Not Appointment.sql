SELECT CONVERT(date, act_date) CallDate, 
case when LEN(CONVERT(VarChar, act_time)) < 6 then 
'0'+LEFT(CONVERT(VarChar, act_time),1) + ':' + LEFT(RIGHT(CONVERT(VarChar, act_time),4),2) + ':' + RIGHT(CONVERT(VarChar, act_time),2) else 
LEFT(CONVERT(VarChar, act_time),2) + ':' + LEFT(RIGHT(CONVERT(VarChar, act_time),4),2) + ':' + RIGHT(CONVERT(VarChar, act_time),2) end CallTime, u.Name Agent, ch.status CallDisp, 
case when LEN(CONVERT(VarChar,CONVERT(int,time_connect/60))) > 1 then CONVERT(VarChar,CONVERT(int,time_connect/60)) else 
'0'+CONVERT(VarChar,CONVERT(int,time_connect/60)) end + ':' + 
case when LEN(CONVERT(VarChar, time_connect-(CONVERT(int,time_connect/60)*60))) > 1 then CONVERT(VarChar, time_connect-(CONVERT(int,time_connect/60)*60))
else '0'+CONVERT(VarChar, time_connect-(CONVERT(int,time_connect/60)*60)) end CallLength, 
l.Company, l.Status
FROM SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS =  LEFT(l.Id, 15) collate latin1_general_CS_AS
inner join Salesforce..[User] u ON ch.tsr = u.DiallerFK__c
WHERE ch.status not in ('A','AP') and time_connect > 420 and call_type in (0,2,4)
ORDER BY act_date DESC, act_time