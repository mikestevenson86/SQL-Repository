SELECT 
Name Agent, 
case when LEN(end_time) > 5 then LEFT(end_time,2)+':'+RIGHT(LEFT(end_time,4),2)+':'+RIGHT(end_time,2) else '0'+LEFT(end_time,1)+':'+RIGHT(LEFT(end_time,3),2)+':'+RIGHT(end_time,2) end [Time Call End], 
pause_time [Pause Time (Seconds)], 
CONVERT(decimal,pause_time/60) [Pause Time (Minutes)]

FROM
(
SELECT 
u.Name, 
end_time, 
pause_time, 
RANK() OVER (Partition BY tsr Order BY pause_time desc) rnk

FROM 
SalesforceReporting..tskpauday p

inner join Salesforce..[User] u ON p.tsr = u.DiallerFK__c

WHERE 
call_date = '2014-08-29'
) detail

WHERE 
rnk in (1,2,3)

ORDER BY 
agent, 
rnk