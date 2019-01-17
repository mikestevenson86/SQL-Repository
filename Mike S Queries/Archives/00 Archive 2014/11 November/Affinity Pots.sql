SELECT 
CONVERT(date, act_date) CallDate, 
CONVERT(time, case when LEN(act_time) = 5 then '0'+LEFT(act_time,1)+':'+LEFT(RIGHT(act_time,4),2)+':'+RIGHT(act_time,2) 
else LEFT(act_time,2)+':'+LEFT(RIGHT(act_time,4),2)+':'+RIGHT(act_time,2) end) CallTime, 
ISNULL(ISNULL(u.Name, ch.tsr),'No Agent') Agent, 
ISNULL(l.Id, 'No SFDC Id') LeadId, 
ca.Name Pot, 
ch.time_connect CallTime, 
case when ch.call_type in (0,2,4) then 'Connected' else 'Not Connected' end CallType,
ISNULL(RTRIM(st.description) + ' - ' + ad.description, 'No Disposition') [Disposition]

FROM 
SalesforceReporting..call_history ch
inner join Salesforce..Campaign ca ON ch.listid = ca.noblesys__listId__c
left outer join Salesforce..[User] u ON ch.tsr = u.DiallerFK__c
left outer join Salesforce..Lead l ON ch.lm_filler2 collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS
left outer join SalesforceReporting..addistats ad ON ch.status = ad.pstatus and ch.addi_status = ad.addistatus and ch.appl = ad.pappl
left outer join Enterprise..appl_status st ON ch.status = st.status and ch.appl = st.appl

WHERE 
act_date between '2014-10-27' and '2014-10-31' 
and 
ch.appl = 'AFF1'

ORDER BY 
act_date, 
act_time