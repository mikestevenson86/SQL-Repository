SELECT CallDate, Agent, SUM(Calls) Calls,SUM(OverThreeMinutes) OverThreeMinutes
FROM
(
SELECT 
CONVERT(date, act_Date) CallDate, u.Name Agent, 
SUM(case when call_type in (0,2,4) then 1 else 0 end) Calls, SUM(case when time_connect > 180 then 1 else 0 end) OverThreeMinutes
FROM SalesforceReporting..call_history ch
inner join Salesforce..[User] u ON ch.tsr = u.DiallerFK__c
WHERE act_date between '2014-01-01' and '2015-02-28'
GROUP BY act_date, u.Name
UNION
SELECT 
CONVERT(date, act_Date) CallDate, u.Name Agent, 
SUM(case when call_type in (0,2,4) then 1 else 0 end) Calls, SUM(case when time_connect > 180 then 1 else 0 end) OverThreeMinutes
FROM Enterprise..call_history ch
inner join Salesforce..[User] u ON ch.tsr = u.DiallerFK__c
WHERE act_date between '2014-01-01' and '2015-02-28'
GROUP BY act_date, u.Name
) detail
GROUP BY CallDate, Agent
ORDER BY CallDate, Agent