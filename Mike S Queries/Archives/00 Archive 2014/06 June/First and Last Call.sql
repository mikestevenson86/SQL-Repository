SELECT u.Name Agent, CONVERT(date,act_date) CallDate, 
case when LEN(MIN(ch.act_time))=5 then '0'+CONVERT(varchar,MIN(ch.act_time)) else CONVERT(varchar,MIN(ch.act_time)) end [First Call], 
case when LEN(MAX(ch.act_time))=5 then '0'+CONVERT(varchar,MAX(ch.act_time)) else CONVERT(varchar,MAX(ch.act_time)) end [Last Call]
FROM Enterprise..call_history ch
INNER JOIN Salesforce..[User] u ON ch.tsr = u.DiallerFK__c
WHERE CONVERT(date,act_date) >= DATEADD(week,-1,GETDATE())
GROUP BY u.Name, CONVERT(date,act_date)
ORDER BY CONVERT(date,act_date), u.Name