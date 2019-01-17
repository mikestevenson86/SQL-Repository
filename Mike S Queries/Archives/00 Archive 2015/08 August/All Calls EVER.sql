SELECT 
ROW_NUMBER () OVER (ORDER BY CallDate) rn,
*
INTO SalesforceReporting..AllCallHistory
FROM
(
SELECT 
CONVERT(date, act_date) CallDate, 
'0'+CONVERT(varchar,areacode)+CONVERT(varchar,phone) Phone, 

case when LEN(CONVERT(varchar,CONVERT(int, (time_connect/60)))) = 2 then CONVERT(varchar,CONVERT(int, (time_connect/60))) else '0'+CONVERT(varchar,CONVERT(int, (time_connect/60))) end
+ ':' + 
case when LEN(CONVERT(varchar, time_connect-CONVERT(int,(time_connect/60)*60))) = 2 then CONVERT(varchar, time_connect-CONVERT(int,(time_connect/60)*60)) else '0'+CONVERT(varchar, time_connect-CONVERT(int,(time_connect/60)*60)) end Duration, 
s.status_description [Status]
FROM Enterprise..call_history ch
inner join Enterprise..status s ON ch.status = s.status

UNION

SELECT
CONVERT(date, act_date) CallDate, 
'0'+CONVERT(varchar,areacode)+CONVERT(varchar,phone) Phone, 

case when LEN(CONVERT(varchar,CONVERT(int, (time_connect/60)))) = 2 then CONVERT(varchar,CONVERT(int, (time_connect/60))) else '0'+CONVERT(varchar,CONVERT(int, (time_connect/60))) end
+ ':' + 
case when LEN(CONVERT(varchar, time_connect-CONVERT(int,(time_connect/60)*60))) = 2 then CONVERT(varchar, time_connect-CONVERT(int,(time_connect/60)*60)) else '0'+CONVERT(varchar, time_connect-CONVERT(int,(time_connect/60)*60)) end Duration, 
s.status_description [Status]
FROM SalesforceReporting..call_history ch
inner join Enterprise..status s ON ch.status = s.status
) detail