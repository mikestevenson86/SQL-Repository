SELECT
l.SIC2007_Code__c [SIC Code],
SUM(case when MADE_Criteria__c in ('Outbound - 1','Outbound - 2','Outbound - 4') then 1 else 0 end) Appointments

INTO
#Appts

FROM 
Salesforce..Lead l
inner join Salesforce..[User] u ON l.BDC__c collate latin1_general_CS_AS = u.Id collate latin1_general_CS_AS and u.Department = 'Telemarketing'

WHERE 
Date_Made__c between GETDATE()-8 and GETDATE()-2

GROUP BY
l.SIC2007_Code__c

SELECT
l.SIC2007_Code__c [SIC Code],
COUNT(*) LiveCalls

INTO
#Calls

FROM
Salesforce..Lead l
left outer join SalesforceReporting..call_history ch ON l.Id collate latin1_general_CS_AS = ch.lm_filler2 collate latin1_general_CS_AS
inner join Salesforce..[User] u ON ch.tsr = u.DiallerFK__c and u.Department = 'Telemarketing'
inner join Salesforce..[User] u2 ON u.ManagerId collate latin1_general_CS_AS = u2.Id collate latin1_general_CS_AS

WHERE 
act_date between GETDATE()-8 and GETDATE()-2
and
u2.Name <> 'Jo Wood'

GROUP BY
l.SIC2007_Code__c

SELECT
c.[SIC Code],
c.LiveCalls,
ISNULL(a.Appointments, 0) Appointments

FROM
#Calls c
left outer join #Appts a ON c.[SIC Code] = a.[SIC Code]

ORDER BY
[SIC Code]

DROP TABLE #Appts
DROP TABLE #Calls