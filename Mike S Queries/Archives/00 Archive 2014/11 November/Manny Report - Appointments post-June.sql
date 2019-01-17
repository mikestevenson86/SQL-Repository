SELECT 
l.Id, 
l.Date_Made__c

INTO 
#Apps

FROM 
Salesforce..Lead l

WHERE
l.Date_Made__c > '2014-06-01'

SELECT 
lm_filler2,
SUM(CallBefore) CallsBefore,
SUM(CallAfter) CallsAfter

INTO 
#Calls

FROM
(
	SELECT lm_filler2,
	SUM(case when act_date <= ap.Date_Made__c then 1 else 0 end) CallBefore,
	SUM(case when act_date > ap.Date_Made__c then 1 else 0 end) CallAfter
	FROM SalesforceReporting..call_history ch
	inner join #Apps ap ON ch.lm_filler2 = ap.Id
	GROUP BY lm_filler2
	
	UNION

	SELECT lm_filler2,
	SUM(case when act_date < ap.Date_Made__c then 1 else 0 end) CallBefore,
	SUM(case when act_date > ap.Date_Made__c then 1 else 0 end) CallAfter
	FROM Enterprise..call_history ch
	inner join #Apps ap ON ch.lm_filler2 = ap.Id
	GROUP BY lm_filler2
) detail

GROUP BY lm_filler2

SELECT 
bdc.Name BDC,
tm.Name TeamManager, 
bdm.Name BDM, 
l.Company [Company Name], 
l.Phone,
CONVERT(date, l.Date_Made__c) [Date Booked], 
c.CallsBefore [Calls made Before Appointment], 
c.CallsAfter [Calls Made After Appointment], 
CONVERT(date, l.Approved_Date__c) [Approved Date]

FROM 
Salesforce..Lead l

inner join #Apps ap ON l.Id = ap.Id
left outer join Salesforce..[User] bdc ON l.BDC__c = bdc.Id
left outer join Salesforce..[User] bdm on l.OwnerId = bdm.Id
left outer join Salesforce..[User] tm ON bdc.ManagerId = tm.Id
left outer join #Calls c ON l.Id = c.lm_filler2

ORDER BY
[Date Booked]

DROP TABLE #Apps
DROP TABLE #Calls