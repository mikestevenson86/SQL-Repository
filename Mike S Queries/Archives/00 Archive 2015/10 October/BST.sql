SELECT 
u.Name Agent
, act_date CallDate
, case when LEN(act_time) = 5 then '0'+LEFT(CONVERT(varchar, act_time),1)+':'+LEFT(RIGHT(CONVERT(varchar, act_time),4),2)+':'+RIGHT(CONVERT(varchar, act_time),2)
else LEFT(CONVERT(varchar, act_time),2)+':'+LEFT(RIGHT(CONVERT(varchar, act_time),4),2)+':'+RIGHT(CONVERT(varchar, act_time),2) end CallTime
, l.Id [Prospect ID]
, RIGHT('0' + CAST(FLOOR(time_connect / 3600) AS VARCHAR),2) + ':' +
RIGHT('0' + CAST(FLOOR(time_connect / 60) % 60 AS VARCHAR),2)  + ':' +
RIGHT('0' + CAST(time_connect % 60 AS VARCHAR),2) Duration
, ISNULL(LeadSource, 'No Source') [Prospect Source]
, Prospect_Channel__c ProspectChannel
FROM SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON ch.lm_filler2 = l.Id
inner join Salesforce..[User] u ON ch.tsr = u.DiallerFK__c
inner join Salesforce..UserRole ur ON u.UserRoleId = ur.Id
WHERE ur.Name = 'Business Solutions Team' and act_date between '2015-09-01' and '2015-09-30' and call_type in (0,2,4)