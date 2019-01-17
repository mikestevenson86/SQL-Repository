SELECT 
l.Id, 
MAX(CONVERT(time, case when LEN(ch.act_time) = 5 then '0'+LEFT(ch.act_time,1)+':'+LEFT(RIGHT(ch.act_time,4),2)+':'+RIGHT(ch.act_time,2)
else LEFT(ch.act_time,2)+':'+LEFT(RIGHT(ch.act_time,4),2)+':'+RIGHT(ch.act_time,2) end)) CallTime,
l.Date_Made__c DateMade,
c.Name Campaign
INTO #SemBooked
FROM SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON ch.lm_filler2 = l.Id
inner join Salesforce..Campaign c ON ch.listid = c.noblesys__listId__c and ch.act_date = l.Date_Made__c and c.Name like '%SEM%'
GROUP BY l.Id, l.Date_Made__c, c.Name

SELECT sb.Id, sb.Campaign, MIN(act_date) FirstCallDate, sb.DateMade, sb.CallTime, COUNT(seqno) Calls 
FROM SalesforceReporting..call_history ch
inner join #SemBooked sb ON ch.lm_filler2 = sb.Id
inner join Salesforce..Campaign c ON ch.listid = c.noblesys__listId__c
WHERE c.Name like '%SEM%'
GROUP BY sb.Id,sb.DateMade, sb.Campaign, sb.CallTime
ORDER BY sb.DateMade, sb.CallTime

DROP TABLE #SemBooked
