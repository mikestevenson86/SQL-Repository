SELECT 
u.Name, 
ch.act_date [Call Date], 
case when LEN(ch.act_time) = 5 then
'0'+LEFT(ch.act_time,1) + ':' + LEFT(RIGHT(ch.act_time,4),2) + ':' + RIGHT(ch.act_time, 2)
else LEFT(ch.act_time,2) + ':' + LEFT(RIGHT(ch.act_time,4),2) + ':' + RIGHT(ch.act_time, 2) end [Call Time], 
ch.time_connect,
case when LEN(CONVERT(VarChar, FLOOR(ch.time_connect/60))) = 1 
then 
'0' + CONVERT(VarChar, FLOOR(ch.time_connect/60)) 
else 
CONVERT(VarChar, FLOOR(ch.time_connect/60)) 
end
+ ':' + 
case when LEN(CONVERT(VarChar, ch.time_connect - (FLOOR(ch.time_connect/60)*60))) = 1 
then 
'0' + CONVERT(VarChar, ch.time_connect - (FLOOR(ch.time_connect/60)*60)) 
else 
CONVERT(VarChar, ch.time_connect - (FLOOR(ch.time_connect/60)*60)) 
end [Call Length], 
'0' + CONVERT(VarChar,ch.areacode)+CONVERT(VarChar,ch.phone) [Phone Number], 
l.PostalCode
FROM Salesforce..[User] u
inner join SalesforceReporting..call_history ch ON u.DiallerFK__c = ch.tsr
inner join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS
WHERE u.Name in
(
'Laura McEvoy',
'Michael Weir',
'Gordon Watt',
'Billy Spence'
) and act_date >= DATEADD(week,-6,GETDATE()) and l.PostalCode not like 'BT%'
ORDER BY act_date, act_time