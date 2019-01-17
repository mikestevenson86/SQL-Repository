-- Collate Appointment Data

SELECT 
CONVERT(date,lh.createddate) CallDate,
u.Name Agent,
ISNULL(s2.[description], 'No Sector') [Description],
COUNT(distinct(lh.leadid)) Appts

INTO 
#Apps

FROM 
Salesforce..LeadHistory lh
inner join Salesforce..Lead l on lh.LeadId collate latin1_general_CS_AS = l.id collate latin1_general_CS_AS
inner join Salesforce..[User] u on lh.CreatedById collate latin1_general_CS_AS = u.Id collate latin1_general_CS_AS
left outer join SalesforceReporting..SIC2 s2 on l.SIC2007_Code2__c = s2.[SIC Code 2]

WHERE 
NewValue = 'Data Quality'
and 
CONVERT(date,lh.CreatedDate) >= '2014-01-01'

GROUP BY
CONVERT(date,lh.createddate),
u.Name,
ISNULL(s2.[description],'No Sector') 

-- Collate Call Count Data

SELECT 
CONVERT(date,ch.act_date) CallDate,
u.Name Agent,
ISNULL(s2.[description],'No Sector') [Description],
COUNT(seqno) Calls

INTO 
#CallCounts

FROM Enterprise..call_history ch
inner join Salesforce..Lead l on ch.lm_filler2 collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS
inner join Salesforce..[User] u on ch.tsr = u.DiallerFK__c
left outer join SalesforceReporting..SIC2 s2 on l.SIC2007_Code2__c = s2.[SIC Code 2]

WHERE 
ch.call_type in (0,2,4)
and 
CONVERT(date,ch.act_date) >= '2014-01-01'

GROUP BY
CONVERT(date,ch.act_date),
u.Name,
ISNULL(s2.[description],'No Sector') 

-- Collate Call Time Data

SELECT 
CONVERT(date,ch.act_date) CallDate,
u.Name Agent,
ISNULL(s2.[description],'No Sector') [Description],
SUM(ch.time_connect) TalkTime

INTO 
#CallTime

FROM Enterprise..call_history ch
inner join Salesforce..Lead l on ch.lm_filler2 collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS
inner join Salesforce..[User] u on ch.tsr = u.DiallerFK__c
left outer join SalesforceReporting..SIC2 s2 on l.SIC2007_Code2__c = s2.[SIC Code 2]

WHERE 
ch.call_type in (0,2,4)
and 
CONVERT(date,ch.act_date) >= '2014-01-01'

GROUP BY
CONVERT(date,ch.act_date),
u.Name,
ISNULL(s2.[description],'No Sector') 

-- Build Temporary Table from Prospect History

SELECT 
CONVERT(date,lh.CreatedDate) CallDate,
u.Name Agent,
ISNULL(s2.[description],'No Sector') [Description]

INTO
#Temp

FROM
Salesforce..LeadHistory lh
inner join Salesforce..Lead l on lh.LeadId collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS
inner join Salesforce..[User] u on lh.CreatedById collate latin1_general_CS_AS = u.Id collate latin1_general_CS_AS
inner join Salesforce..[Profile] p on u.ProfileId collate latin1_general_CS_AS = p.Id collate latin1_general_CS_AS
left outer join SalesforceReporting..SIC2 s2 on l.SIC2007_Code2__c = s2.[SIC Code 2]

WHERE
CONVERT(date,lh.CreatedDate) >= '2014-01-01'
and 
p.Name = 'Citation BDC'

GROUP BY 
CONVERT(date,lh.CreatedDate),
u.Name,
ISNULL(s2.[description],'No Sector')

-- Output

SELECT 
t.CallDate,
t.Agent,
t.[Description],
ISNULL(ct.TalkTime,0) TalkTime,
ISNULL(ap.Appts,0) Appts,
ISNULL(cc.Calls,0) Calls

FROM
#Temp t

left outer join #Apps ap on t.CallDate = ap.CallDate
and 
t.Agent = ap.Agent
and 
t.[Description] = ap.[Description]

left outer join #CallCounts cc on t.CallDate = cc.CallDate
and 
t.Agent = cc.Agent
and 
t.[Description] = cc.[Description]

left outer join #CallTime ct on t.CallDate = ct.CallDate
and 
t.Agent = ct.Agent
and 
t.[Description] = ct.[Description]

ORDER BY
t.CallDate,
t.Agent,
t.[Description]

DROP TABLE #Apps
DROP TABLE #CallCounts
DROP TABLE #CallTime
DROP TABLE #Temp