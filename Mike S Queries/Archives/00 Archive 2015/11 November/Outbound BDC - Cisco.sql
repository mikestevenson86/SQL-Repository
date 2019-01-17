SELECT 
CONVERT(date, RIGHT(LEFT(CallDate,10),4)+'-'+RIGHT(LEFT(CallDate,5),2)+'-'+LEFT(CallDate, 2)) CallDate,
RIGHT(CallDate,5)+':00' CallTime,
ag.Agent Agent,
'0'+bdc.Agent InternalNo,
'0'+bdc.Called ExternalNo,
bdc.RingTime,
bdc.TalkTime,
bdc.Ans,
ISNULL(l.Id, l2.Id) Id,
ISNULL(l.Company, l2.Company) CompanyName
FROM SalesforceReporting..Outbound_BDC_Call_List bdc
left outer join Salesforce..Lead l ON REPLACE(case when bdc.Called like '0%' then bdc.Called else '0'+bdc.Called end,' ','') = 
										REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') 
left outer join Salesforce..Lead l2 ON REPLACE(case when bdc.Called like '0%' then bdc.Called else '0'+bdc.Called end,' ','') = 
										REPLACE(case when l2.MobilePhone like '0%' then l2.MobilePhone else '0'+l2.MobilePhone end,' ','')
left outer join SalesforceReporting..AgentNumbers ag ON '0'+bdc.Agent = ag.Number
ORDER BY 
CONVERT(date, RIGHT(LEFT(CallDate,10),4)+'-'+RIGHT(LEFT(CallDate,5),2)+'-'+LEFT(CallDate, 2)),
CONVERT(time, RIGHT(CallDate,5)+':00')