SELECT 
ch.act_date CallDate, 
case when LEN(act_time) = 5 then
'0'+LEFT(act_time, 1) + ':' + LEFT(RIGHT(act_time, 4),2) + ':' + RIGHT(act_time, 2)
else
LEFT(act_time, 2) + ':' + LEFT(RIGHT(act_time, 4),2) + ':' + RIGHT(act_time, 2)
end CallTime,
CONVERT(VarChar,FLOOR(ch.time_connect/60)) + ':' + CONVERT(VarChar, ch.time_connect - (FLOOR(ch.time_connect/60)*60)) CallLength,
case when call_type in (0,2,4) then 'Connected' else 'NotConnected' end DialConnection,
'0'+CONVERT(VarChar, ch.areacode)+CONVERT(VarChar, ch.phone) PhoneNumber, 
l.Id, 
l.Company,
l.Status,
l.Callback_Date_Time__c

FROM 
SalesforceReporting..call_history ch
left outer join Salesforce..[User] u ON ch.tsr = u.DiallerFK__c
left outer join Salesforce..Lead l ON LEFT(ch.lm_Filler2, 15) collate latin1_general_CS_AS = LEFT(l.ID, 15) collate latin1_general_CS_AS

WHERE
u.Name = 'Leon Weate'
and
DATEPART(week, act_date) = DATEPART(week, GETDATE()) and YEAR(act_date) = YEAR(GETDATE())

ORDER BY 
act_date, act_time