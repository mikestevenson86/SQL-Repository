SELECT detail.DayName, detail.CallDate, detail.CallTime, exl.[Description] Agent, CiscoPhone, ExternalNumber, detail.TalkTime, CallType, Id SFDC_Id
FROM
(
SELECT 
DATENAME(weekday,CONVERT(date, StartDateTime, 103)) [DayName],
CONVERT(date, StartDateTime, 103)CallDate,
CONVERT(time, StartDateTime, 103)CallTime,
CallingPhone CiscoPhone, 
CalledPhone ExternalNumber,
CONVERT(time, DATEADD(ss,TalkTime_secs,'1899-12-31 00:00:00')) TalkTime,
'Outbound' CallType,
cs.Id
FROM 
SalesforceReporting..Contact_Centre cc
left outer join SalesforceReporting..Cisco_SFDC_Bridge cs ON cc.CalledPhone = cs.Phone
WHERE 
[TYPE] = 'Ext/Out' 
and 
DATENAME(weekday,CONVERT(date, StartDateTime, 103)) not in ('Saturday','Sunday')

	UNION ALL

SELECT 
DATENAME(weekday,CONVERT(date, StartDateTime, 103)) [DayName],
CONVERT(date, StartDateTime, 103)CallDate,
CONVERT(time, StartDateTime, 103)CallTime,
CalledPhone,
CallingPhone,
CONVERT(time, DATEADD(ss,TalkTime_secs,'1899-12-31 00:00:00')) TalkTime,
'Inbound' CallType,
cs.Id
FROM 
SalesforceReporting..Contact_Centre cc
left outer join SalesforceReporting..Cisco_SFDC_Bridge cs ON cc.CalledPhone = cs.Phone
WHERE 
[TYPE] = 'Ext/In' 
and 
DATENAME(weekday,CONVERT(date, StartDateTime, 103)) not in ('Saturday','Sunday')
) detail
left outer join SalesforceReporting..Extension_List exl ON detail.CiscoPhone = exl.Device

WHERE 
MONTH(CallDate) = MONTH(GETDATE())
and
IsTelemarketing = 1

ORDER BY
CallDate desc